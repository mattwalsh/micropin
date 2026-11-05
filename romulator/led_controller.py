"""Host-side transport and rendering for the ROMulator WS2812 CDC endpoint.

The Pico accepts raw RGB frames on its dedicated ``Romulator LEDs`` CDC
interface.  This module deliberately keeps that protocol separate from the
aperture/control CDC interface: a slow LED update can never be mistaken for a
game command.  ``LedTransport`` also suppresses duplicate frames, which is
important because the game loop runs much faster than most light changes.
"""

from __future__ import annotations

import colorsys
from dataclasses import dataclass
import glob
import math
import os
import platform
import select
import struct
import termios
import time


SOF = bytes((0xA5, 0x5A))
FRAME_TYPE_RGB = 0x01
# Normal playfield idle fill.  Keep this as one obvious tuning knob rather
# than baking a decorative tint into the renderer.
PLAYFIELD_BACKGROUND_RGB = (0xFF, 0xFF, 0xFF)
# Keep ordinary mapped lamps visually neutral for now.  Named effects provide
# the intentional color language; this prevents sparse amber "sprinkles" on
# an otherwise clean white playfield.
PLAYFIELD_LAMP_RGB = PLAYFIELD_BACKGROUND_RGB
WAITING_WIPE_RGB = (0x00, 0xFF, 0x00)
WAITING_WIPE_SECONDS = 0.75
WAITING_WIPE_ROWS = 10
BLACK_RGB = (0, 0, 0)
LED_EFFECT_NAMES = (
    "launch_wipe",
    "launch_flipper_pulse",
    "rollover_complete_chase",
    "rainbow",
    "rainbow_vivid",
    "warm_background",
    "blackout",
)
LAUNCH_FLIPPER_PULSE_RGB = (0x00, 0xFF, 0x00)
LAUNCH_FLIPPER_PULSE_PIXELS = 20
LAUNCH_FLIPPER_PULSE_SECONDS = 1.2
ROLLOVER_CHASE_RGB = (0xFF, 0x11, 0x11)
ROLLOVER_CHASE_PIXELS = 10
ROLLOVER_CHASE_SECONDS = 2.0
ROLLOVER_CHASE_LAPS = 3


def crc16_ccitt(data: bytes) -> int:
    crc = 0xFFFF
    for value in data:
        crc ^= value << 8
        for _ in range(8):
            crc = ((crc << 1) ^ 0x1021) & 0xFFFF if crc & 0x8000 else (crc << 1) & 0xFFFF
    return crc


def configure_raw(fd: int) -> list[object]:
    previous = termios.tcgetattr(fd)
    raw = termios.tcgetattr(fd)
    raw[0] = raw[1] = raw[3] = 0
    raw[2] |= termios.CLOCAL | termios.CREAD
    raw[4] = raw[5] = termios.B115200
    termios.tcsetattr(fd, termios.TCSANOW, raw)
    return previous


def _write_all(fd: int, payload: bytes) -> None:
    position = 0
    while position < len(payload):
        _, writable, _ = select.select([], [fd], [], 1.0)
        if not writable:
            raise TimeoutError("LED USB serial port did not become writable")
        count = os.write(fd, payload[position:])
        if count <= 0:
            raise OSError("LED USB serial port accepted no data")
        position += count


def find_led_device(explicit: str | None = None) -> str:
    """Find the ROMulator's dedicated LED CDC endpoint, or use ``explicit``.

    The composite firmware exposes control as interface 0 and LEDs as interface
    1. macOS currently gives those interfaces suffixes 1 and 3 respectively.
    """
    if explicit:
        return explicit
    if platform.system() == "Darwin":
        candidates = [
            path for path in glob.glob("/dev/cu.usbmodemEPROM5*")
            if path.endswith("3")
        ]
    elif platform.system() == "Linux":
        candidates = glob.glob("/dev/serial/by-id/*EPROM*if01*")
    else:
        raise RuntimeError("supported systems are macOS and Linux")
    candidates = sorted(set(os.path.realpath(path) for path in candidates))
    if not candidates:
        raise RuntimeError(
            "no ROMulator LED CDC device found; connect the ROMulator or pass a device path"
        )
    if len(candidates) != 1:
        raise RuntimeError("multiple LED CDC devices; pass a device path: " + ", ".join(candidates))
    return candidates[0]


@dataclass(frozen=True)
class StripGeometry:
    """Logical front-to-back rows for a strip folded at the machine back.

    The calibrated 160-pixel machine layout has 75 visually aligned rows:
    left physical pixels 0..74 and right physical pixels 154..80.  This
    intentionally leaves 75..79 and 155..159 dark.  Row 0 is therefore
    physical pair (0, 154); each successive row moves toward the back.

    A non-160-pixel strip uses the generic equal-half mapping, with ``split``
    selecting its boundary.
    """

    count: int = 160
    split: int | None = None
    ignored_pixels: frozenset[int] | None = None

    def __post_init__(self) -> None:
        split = self.count // 2 if self.split is None else self.split
        if self.count < 2 or split < 1 or split >= self.count:
            raise ValueError("LED count must be at least 2 and split must be inside the strip")
        ignored = frozenset() if self.ignored_pixels is None else self.ignored_pixels
        if any(pixel < 0 or pixel >= self.count for pixel in ignored):
            raise ValueError("ignored LED pixel is outside the strip")
        object.__setattr__(self, "split", split)
        object.__setattr__(self, "ignored_pixels", ignored)

    @property
    def rows(self) -> int:
        assert self.split is not None
        if self.count == 160 and self.split == 80:
            return 75
        return min(self.split, self.count - self.split)

    def physical_pair(self, row: int) -> tuple[int, int]:
        if not 0 <= row < self.rows:
            raise IndexError("logical LED row out of range")
        if self.count == 160 and self.split == 80:
            return row, 154 - row
        return row, self.count - 1 - row

    def logical_pixel(self, pixel: int) -> int | None:
        """Return compact physical-chain index, or ``None`` when ignored."""
        if not 0 <= pixel < self.count:
            raise IndexError("physical LED pixel out of range")
        if pixel in self.ignored_pixels:
            return None
        return pixel - sum(ignored < pixel for ignored in self.ignored_pixels)

    def rows_to_pixels(self, rows: list[tuple[int, int, int]]) -> bytes:
        if len(rows) != self.rows:
            raise ValueError(f"expected {self.rows} logical LED rows, got {len(rows)}")
        pixels = bytearray(self.count * 3)
        for row, rgb in enumerate(rows):
            if len(rgb) != 3 or any(not 0 <= value <= 255 for value in rgb):
                raise ValueError("each LED color must be an RGB tuple of bytes")
            for pixel in self.physical_pair(row):
                if pixel not in self.ignored_pixels:
                    pixels[pixel * 3 : pixel * 3 + 3] = bytes(rgb)
        return bytes(pixels)


class LedTransport:
    """One dedicated LED CDC connection, with duplicate-frame suppression."""

    def __init__(self, device: str, *, led_count: int = 160) -> None:
        self.device = device
        self.led_count = led_count
        self._fd: int | None = None
        self._previous: list[object] | None = None
        self._last_pixels: bytes | None = None
        self._sequence = 0

    def __enter__(self) -> "LedTransport":
        self._fd = os.open(self.device, os.O_RDWR | os.O_NOCTTY | os.O_NONBLOCK)
        self._previous = configure_raw(self._fd)
        # macOS takes a moment to finish bringing a just-opened CDC endpoint up.
        time.sleep(0.25)
        return self

    def __exit__(self, _type: object, _value: object, _traceback: object) -> None:
        if self._fd is not None:
            assert self._previous is not None
            termios.tcsetattr(self._fd, termios.TCSANOW, self._previous)
            os.close(self._fd)
        self._fd = None
        self._previous = None

    @property
    def frames_sent(self) -> int:
        return self._sequence

    def show(self, pixels: bytes, *, force: bool = False) -> bool:
        """Transmit pixels, returning False when they match the prior frame."""
        if len(pixels) != self.led_count * 3:
            raise ValueError(f"expected {self.led_count * 3} RGB bytes")
        if not force and pixels == self._last_pixels:
            return False
        if self._fd is None:
            raise RuntimeError("LED transport is not open")
        body = bytes((self._sequence,)) + pixels
        frame = SOF + bytes((FRAME_TYPE_RGB,)) + struct.pack("<H", len(pixels))
        frame += body + struct.pack("<H", crc16_ccitt(body))
        _write_all(self._fd, frame)
        self._last_pixels = pixels
        self._sequence = (self._sequence + 1) & 0xFF
        return True


class GameLedRenderer:
    """Translate resolved Micropin lamps and tones into folded-strip pixels.

    Two logical rows represent each of the forty lamp-driver outputs.  This
    makes existing LampController sequences (attract, bonus, flashes, etc.)
    visible immediately.  Tone arguments are accepted because they share the
    game output frame, but deliberately do not affect the lighting: music
    should not make the otherwise steady background pulse.
    """

    def __init__(self, geometry: StripGeometry) -> None:
        self.geometry = geometry

    def frame(
        self,
        lamp_bitmap: bytes | None,
        tone_pitch: int,
        tone_duration: int,
        *,
        waiting_for_launch: bool = False,
        base_rgb: tuple[int, int, int] = PLAYFIELD_BACKGROUND_RGB,
        now: float | None = None,
    ) -> bytes:
        """Render one game frame.

        ``waiting_for_launch`` blanks the strip and shows a ten-row green
        playfield sweep. Its coordinate origin is row 0: the machine
        front/bottom, moving toward the back/top in 1.5 seconds.
        """
        bitmap = lamp_bitmap or b"\x00" * 5
        if len(bitmap) != 5:
            raise ValueError("Micropin lamp bitmap must contain five bytes")
        now = time.monotonic() if now is None else now
        if waiting_for_launch:
            available_starts = max(0, self.geometry.rows - WAITING_WIPE_ROWS)
            sweep_start = int(
                (now % WAITING_WIPE_SECONDS) / WAITING_WIPE_SECONDS * (available_starts + 1)
            )
            rows = [
                WAITING_WIPE_RGB
                if sweep_start <= row < sweep_start + WAITING_WIPE_ROWS
                else BLACK_RGB
                for row in range(self.geometry.rows)
            ]
            return self.geometry.rows_to_pixels(rows)

        rows: list[tuple[int, int, int]] = []
        for row in range(self.geometry.rows):
            lamp = min(39, row // 2)
            on = bool(bitmap[lamp // 8] & (1 << (lamp % 8)))
            if on:
                color = base_rgb
            else:
                color = base_rgb
            rows.append(color)
        return self.geometry.rows_to_pixels(rows)

    def effect_frame(self, effect: str, *, now: float | None = None) -> bytes:
        """Render a named standalone effect using the same game renderer."""
        now = time.monotonic() if now is None else now
        if effect == "launch_wipe":
            return self.frame(b"\0" * 5, 0, 0, waiting_for_launch=True, now=now)
        if effect == "launch_flipper_pulse":
            # The last physical pixels sit at the right-flipper/launch end of
            # this particular folded strip.  Do not use logical rows here:
            # this is intentionally a precise, local "go ahead" affordance.
            level = round(
                0.5 * (1.0 - math.cos(math.tau * now / LAUNCH_FLIPPER_PULSE_SECONDS))
                * 255
            )
            pixels = bytearray(self.geometry.count * 3)
            start = max(0, self.geometry.count - LAUNCH_FLIPPER_PULSE_PIXELS)
            for pixel in range(start, self.geometry.count):
                offset = pixel * 3
                pixels[offset:offset + 3] = bytes(
                    component * level // 255
                    for component in LAUNCH_FLIPPER_PULSE_RGB
                )
            return bytes(pixels)
        if effect == "rollover_complete_chase":
            # Follow the logical folded path: bottom-left to top-left, then
            # logical top-right back down to bottom-right.  This deliberately
            # skips physical spacer pixels in the center of the strip.
            path = tuple(
                left for left, _right in (
                    self.geometry.physical_pair(row)
                    for row in range(self.geometry.rows)
                )
            ) + tuple(
                right for _left, right in (
                    self.geometry.physical_pair(row)
                    for row in range(self.geometry.rows - 1, -1, -1)
                )
            )
            pixels = bytearray(self.geometry.count * 3)
            phase = (now % ROLLOVER_CHASE_SECONDS) / ROLLOVER_CHASE_SECONDS
            head = int(phase * ROLLOVER_CHASE_LAPS * len(path))
            for offset in range(ROLLOVER_CHASE_PIXELS):
                pixel = path[(head - offset) % len(path)]
                level = round(255 * (ROLLOVER_CHASE_PIXELS - offset) / ROLLOVER_CHASE_PIXELS)
                start = pixel * 3
                pixels[start:start + 3] = bytes(
                    component * level // 255 for component in ROLLOVER_CHASE_RGB
                )
            return bytes(pixels)
        if effect == "rainbow":
            # This is intentionally the original, soft sine-wave palette.
            # Its three channels do not fully bottom out together, so it
            # reads as pastel rather than as primary-color bands.
            pixels = bytearray(self.geometry.count * 3)
            for pixel in range(self.geometry.count):
                hue = (pixel / self.geometry.count + now * 0.12) % 1.0
                red = round(127.5 * (1 + math.sin(math.tau * hue)))
                green = round(127.5 * (1 + math.sin(math.tau * (hue + 1 / 3))))
                blue = round(127.5 * (1 + math.sin(math.tau * (hue + 2 / 3))))
                pixels[pixel * 3:pixel * 3 + 3] = bytes((red, green, blue))
            return bytes(pixels)
        if effect == "rainbow_vivid":
            # True HSV hue sweep: saturation and value are both 1.0, so the
            # strip includes actual red, green, and blue instead of the
            # softened RGB-sine approximations used by ``rainbow``.
            pixels = bytearray(self.geometry.count * 3)
            for pixel in range(self.geometry.count):
                hue = (pixel / self.geometry.count + now * 0.12) % 1.0
                red, green, blue = colorsys.hsv_to_rgb(hue, 1.0, 1.0)
                pixels[pixel * 3:pixel * 3 + 3] = bytes(
                    round(255 * component) for component in (red, green, blue)
                )
            return bytes(pixels)
        if effect == "warm_background":
            return self.frame(b"\0" * 5, 0, 0, now=now)
        if effect == "blackout":
            return self.geometry.rows_to_pixels([BLACK_RGB] * self.geometry.rows)
        raise ValueError(f"unknown LED effect {effect!r}; choose from {', '.join(LED_EFFECT_NAMES)}")


def boot_pulse(transport: LedTransport, geometry: StripGeometry, *, seconds: float = 1.2, fps: float = 16.0) -> None:
    """A short red loading indication shown before the game starts talking."""
    deadline = time.monotonic() + seconds
    step = 0
    while time.monotonic() < deadline:
        level = round(20 + 150 * (0.5 + 0.5 * math.sin(step * math.tau / fps * 1.6)))
        transport.show(geometry.rows_to_pixels([(level, 0, 0)] * geometry.rows))
        step += 1
        time.sleep(1.0 / fps)
