"""Low-level Micropin aperture payload helpers.

The display primitive intentionally mirrors the motherboard: 32 packed bytes
map directly to RAM $23c0-$23df.  Each nibble is an arbitrary 7448 input value
(0-F), except for the score-panel LED nibbles sharing offsets $0c, $16, $1e.
"""

from __future__ import annotations

from collections.abc import Buffer
from dataclasses import dataclass, field
import re
from typing import TypeAlias


CONTROL_SIGNATURE = b"MP"
CONTROL_BYTES = 8
DISPLAY_WINDOW_BYTES = 32
HexValue: TypeAlias = int | str | bytes | bytearray | memoryview


def _hex_digits(value: HexValue, width: int) -> str:
    """Normalize a display value to exactly ``width`` hexadecimal digits."""
    if isinstance(value, int):
        if value < 0 or value >= 1 << (width * 4):
            raise ValueError(f"value must fit in {width} hexadecimal digits")
        return f"{value:0{width}x}"
    if isinstance(value, str):
        digits = value.strip().lower()
        if digits.startswith("0x"):
            digits = digits[2:]
        digits = "".join(digits.split())
    else:
        digits = bytes(value).hex()
    if len(digits) > width or not re.fullmatch(r"[0-9a-f]*", digits):
        raise ValueError(f"value must contain at most {width} hexadecimal digits")
    return digits.rjust(width, "0")


@dataclass
class DisplayFrame:
    """Host-side logical view of the Micropin display/LED scan window.

    Setters only mutate this local frame. Call :meth:`to_bytes` once after all
    desired changes and attach that snapshot to one aperture transaction.
    """

    _window: bytearray = field(default_factory=lambda: DisplayFrame._blank_window())

    @staticmethod
    def _blank_window() -> bytearray:
        # F is blank on the 7448. The three mixed LED bytes need explicit zero
        # nibbles so a visually blank frame does not illuminate panel LEDs.
        window = bytearray(b"\xff" * DISPLAY_WINDOW_BYTES)
        window[0x0c] = 0x0f
        window[0x16] = 0x0f
        window[0x1e] = 0x00
        return window

    @classmethod
    def from_raw(cls, value: Buffer) -> "DisplayFrame":
        return cls(bytearray(validate_display_window(value)))

    def copy(self) -> "DisplayFrame":
        return DisplayFrame(bytearray(self._window))

    def to_bytes(self) -> bytes:
        return bytes(self._window)

    def set_raw(self, value: Buffer) -> None:
        self._window[:] = validate_display_window(value)

    def _set_pairs(self, offsets: tuple[int, ...], value: HexValue) -> None:
        digits = _hex_digits(value, len(offsets) * 2)
        for offset, index in zip(offsets, range(0, len(digits), 2)):
            self._window[offset] = int(digits[index:index + 2], 16)

    def _set_seven_digits(self, leading_offset: int, pair_offsets: tuple[int, ...], value: HexValue) -> None:
        digits = _hex_digits(value, 7)
        self._set_low_nibble(leading_offset, int(digits[0], 16))
        for offset, index in zip(pair_offsets, range(1, 7, 2)):
            self._window[offset] = int(digits[index:index + 2], 16)

    def _set_low_nibble(self, offset: int, value: int) -> None:
        self._window[offset] = (self._window[offset] & 0xf0) | (value & 0x0f)

    def _set_bit(self, offset: int, bit: int, enabled: bool) -> None:
        mask = 1 << bit
        if enabled:
            self._window[offset] |= mask
        else:
            self._window[offset] &= ~mask

    def set_bonus(self, value: HexValue) -> None:
        self._set_pairs((2, 1, 0), value)

    def set_spread(self, value: HexValue) -> None:
        self._set_pairs((25, 24, 23), value)

    def set_player_score(self, player: int, value: HexValue) -> None:
        offsets = {
            1: (8, 7, 6),
            2: (15, 14, 13),
            3: (5, 4, 3),
            4: (18, 17, 16),
        }
        try:
            player_offsets = offsets[player]
        except KeyError as error:
            raise ValueError("player must be 1, 2, 3, or 4") from error
        self._set_pairs(player_offsets, value)

    def set_team_score(self, team: int, value: HexValue) -> None:
        """Set the seven-digit 1+3 or 2+4 display."""
        if team == 1:
            self._set_seven_digits(12, (11, 10, 9), value)
        elif team == 2:
            self._set_seven_digits(22, (21, 20, 19), value)
        else:
            raise ValueError("team must be 1 (players 1+3) or 2 (players 2+4)")

    def set_credits(self, value: HexValue) -> None:
        self._set_pairs((26,), value)

    def set_ball_in_play(self, value: HexValue) -> None:
        self._set_low_nibble(27, int(_hex_digits(value, 1), 16))

    def set_bartender_cents(self, value: HexValue) -> None:
        self._set_pairs((28,), value)

    def set_bartender_dollars(self, value: HexValue) -> None:
        self._set_pairs((29,), value)

    def set_cost_per_player(self, value: HexValue) -> None:
        self._set_pairs((31,), value)

    def set_odds_led(self, enabled: bool) -> None:
        self._set_bit(12, 4, enabled)

    def set_evens_led(self, enabled: bool) -> None:
        self._set_bit(12, 5, enabled)

    def set_same_player_again_led(self, enabled: bool) -> None:
        self._set_bit(22, 4, enabled)

    def set_tilt_led(self, enabled: bool) -> None:
        self._set_bit(22, 5, enabled)

    def set_game_over_led(self, enabled: bool) -> None:
        self._set_bit(22, 6, enabled)

    def set_pay_bartender_led(self, enabled: bool) -> None:
        self._set_bit(22, 7, enabled)

    def set_player_led(self, player: int, enabled: bool) -> None:
        if player not in range(1, 5):
            raise ValueError("player must be 1, 2, 3, or 4")
        self._set_bit(30, player - 1, enabled)


def display_window_from_hex(value: str) -> bytes:
    """Parse exactly 64 hexadecimal digits into the raw 32-byte window."""
    compact = "".join(value.split())
    try:
        window = bytes.fromhex(compact)
    except ValueError as error:
        raise ValueError("display window must contain hexadecimal byte values") from error
    return validate_display_window(window)


def validate_display_window(value: Buffer | DisplayFrame) -> bytes:
    """Return an immutable, validated raw display-window value."""
    window = value.to_bytes() if isinstance(value, DisplayFrame) else bytes(value)
    if len(window) != DISPLAY_WINDOW_BYTES:
        raise ValueError(
            f"display window must be exactly {DISPLAY_WINDOW_BYTES} bytes, "
            f"not {len(window)}"
        )
    return window


def build_control_payload(
    *,
    lamp: int = 0xff,
    reflex_enabled: bool = True,
    cup_mask: int = 0,
    launch: bool = False,
    display_window: Buffer | DisplayFrame | None = None,
    lamp_bitmap: Buffer | None = None,
    tone_pitch: int = 0,
    tone_duration: int = 0,
) -> bytes:
    """Build one signed output frame, including the logical sound command."""
    for name, value in (
        ("lamp", lamp),
        ("cup_mask", cup_mask),
        ("tone_pitch", tone_pitch),
        ("tone_duration", tone_duration),
    ):
        if not 0 <= value <= 0xff:
            raise ValueError(f"{name} must fit in one byte")
    payload = bytes(
        (lamp, *CONTROL_SIGNATURE, int(reflex_enabled), cup_mask & 0x3f, int(launch))
    )
    if display_window is not None:
        payload += validate_display_window(display_window)
    payload += bytes((tone_pitch, tone_duration))
    if lamp_bitmap is not None:
        if display_window is None:
            raise ValueError("lamp bitmap requires a display window")
        bitmap = bytes(lamp_bitmap)
        if len(bitmap) != 5:
            raise ValueError("lamp bitmap must be exactly five bytes")
        payload += bitmap
    return payload
