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
AY_REGISTER_COUNT = 14
AY_REGISTER_MASK = (1 << AY_REGISTER_COUNT) - 1
DEFAULT_AY_PERIOD_CONSTANT = 0x78 * 0x180
HexValue: TypeAlias = int | str | bytes | bytearray | memoryview


@dataclass(frozen=True)
class AyRegisterUpdate:
    """One packed AY-3-8912 register-diff command.

    Bits 0-13 of ``mask`` identify the registers represented by ``values``.
    Values are packed in ascending register order; R14/R15 are deliberately
    unavailable because their general-purpose I/O pins are not connected.
    """

    mask: int
    values: bytes

    def __post_init__(self) -> None:
        if not 0 <= self.mask <= AY_REGISTER_MASK:
            raise ValueError("AY mask may contain only register bits 0-13")
        if len(self.values) != self.mask.bit_count():
            raise ValueError("AY value count must equal the number of mask bits")

    def to_bytes(self) -> bytes:
        return self.mask.to_bytes(2, "little") + self.values

    @classmethod
    def from_registers(
        cls, registers: Buffer, mask: int = AY_REGISTER_MASK
    ) -> "AyRegisterUpdate":
        image = bytes(registers)
        if len(image) != AY_REGISTER_COUNT:
            raise ValueError(f"AY register image must contain {AY_REGISTER_COUNT} bytes")
        if not 0 <= mask <= AY_REGISTER_MASK:
            raise ValueError("AY mask may contain only register bits 0-13")
        return cls(mask, bytes(image[register] for register in range(AY_REGISTER_COUNT) if mask & (1 << register)))


@dataclass
class AyRegisterImage:
    """Python-side mirror of R0-R13 with acknowledgement-safe dirty bits."""

    _registers: bytearray = field(default_factory=lambda: bytearray(AY_REGISTER_COUNT))
    _dirty_mask: int = AY_REGISTER_MASK

    def __post_init__(self) -> None:
        if len(self._registers) != AY_REGISTER_COUNT:
            raise ValueError(f"AY register image must contain {AY_REGISTER_COUNT} bytes")
        self._registers = bytearray(self._registers)
        self._dirty_mask &= AY_REGISTER_MASK

    def set_register(self, register: int, value: int) -> None:
        self._validate_register_write(register, value)
        if self._registers[register] != value:
            self.write_register(register, value)

    @staticmethod
    def _validate_register_write(register: int, value: int) -> None:
        if not 0 <= register < AY_REGISTER_COUNT:
            raise ValueError("AY register must be in R0-R13")
        if not 0 <= value <= 0xff:
            raise ValueError("AY register value must fit in one byte")

    def write_register(self, register: int, value: int) -> None:
        """Schedule a write even when the mirrored value is unchanged.

        Most AY registers are plain state and benefit from diff suppression.
        R13 is different: writing its existing value retriggers the envelope.
        """
        self._validate_register_write(register, value)
        self._registers[register] = value
        self._dirty_mask |= 1 << register

    def set_tone_period(self, channel: int, period: int) -> None:
        if channel not in range(3):
            raise ValueError("AY channel must be 0, 1, or 2")
        if not 0 <= period <= 0x0fff:
            raise ValueError("AY tone period must fit in 12 bits")
        register = channel * 2
        self.set_register(register, period & 0xff)
        self.set_register(register + 1, period >> 8)

    def set_volume(self, channel: int, volume: int) -> None:
        if channel not in range(3):
            raise ValueError("AY channel must be 0, 1, or 2")
        if not 0 <= volume <= 0x1f:
            raise ValueError("AY volume must fit in five bits")
        self.set_register(8 + channel, volume)

    def set_envelope_period(self, period: int) -> None:
        if not 0 <= period <= 0xffff:
            raise ValueError("AY envelope period must fit in 16 bits")
        self.set_register(11, period & 0xff)
        self.set_register(12, period >> 8)

    def trigger_envelope(self, shape: int) -> None:
        if not 0 <= shape <= 0x0f:
            raise ValueError("AY envelope shape must fit in four bits")
        self.write_register(13, shape)

    def force_full_sync(self) -> None:
        self._dirty_mask = AY_REGISTER_MASK

    def pending_update(self) -> AyRegisterUpdate:
        return AyRegisterUpdate.from_registers(self._registers, self._dirty_mask)

    def acknowledge(self, update: AyRegisterUpdate) -> None:
        """Clear only dirty values that still equal the acknowledged snapshot."""
        values = iter(update.values)
        for register in range(AY_REGISTER_COUNT):
            bit = 1 << register
            if not update.mask & bit:
                continue
            sent = next(values)
            if self._registers[register] == sent:
                self._dirty_mask &= ~bit


def build_ay_payload(update: AyRegisterUpdate) -> bytes:
    """Build a compact AY-only command that leaves every game output alone."""
    return b"AY" + update.to_bytes()


def legacy_pitch_to_ay_period(
    pitch: int, period_constant: float = DEFAULT_AY_PERIOD_CONSTANT
) -> int:
    """Translate legacy frequency-proportional pitch into an AY divisor."""
    if not 0 <= pitch <= 0xff:
        raise ValueError("legacy pitch must fit in one byte")
    if period_constant <= 0:
        raise ValueError("AY period constant must be positive")
    if pitch == 0:
        return 0
    return min(0x0fff, max(1, round(period_constant / pitch)))


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
        """Compatibility alias for the repurposed high-score lamp."""
        self.set_high_score_led(enabled)

    def set_evens_led(self, enabled: bool) -> None:
        """Compatibility alias for the repurposed match lamp."""
        self.set_match_led(enabled)

    def set_high_score_led(self, enabled: bool) -> None:
        """Control the left extra score-area indicator (formerly odds/team 1)."""
        self._set_bit(12, 4, enabled)

    def set_match_led(self, enabled: bool) -> None:
        """Control the right extra score-area indicator (formerly evens/team 2)."""
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
        # Byte 0x1e carries the four player indicators in its high nibble;
        # the low nibble appears unused on this revision.
        self._set_bit(30, player + 3, enabled)


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
    ay_update: AyRegisterUpdate | None = None,
) -> bytes:
    """Build one signed aperture frame, optionally followed by an AY diff.

    Aperture mode is AY-only: audio is exclusively the raw R0-R13 diff and
    never a legacy 566 pitch/duration pair.
    """
    for name, value in (
        ("lamp", lamp),
        ("cup_mask", cup_mask),
    ):
        if not 0 <= value <= 0xff:
            raise ValueError(f"{name} must fit in one byte")
    payload = bytes(
        (lamp, *CONTROL_SIGNATURE, int(reflex_enabled), cup_mask & 0x3f, int(launch))
    )
    if display_window is not None:
        payload += validate_display_window(display_window)
    if lamp_bitmap is not None:
        if display_window is None:
            raise ValueError("lamp bitmap requires a display window")
        bitmap = bytes(lamp_bitmap)
        if len(bitmap) != 5:
            raise ValueError("lamp bitmap must be exactly five bytes")
        payload += bitmap
    if ay_update is not None:
        if display_window is None or lamp_bitmap is None:
            raise ValueError("AY updates require the complete display/lamp frame")
        # A zero dirty-mask means the AY image is already current. Do not make
        # the 8085 validate and scan a 14-bit no-op on every game frame.
        if ay_update.mask:
            payload += ay_update.to_bytes()
    return payload
