#!/usr/bin/env python3
"""Minimal host-side Micropin game built on the ROMulator aperture."""

from __future__ import annotations

import argparse
from dataclasses import dataclass, field
from enum import Enum, IntEnum
import json
import os
from pathlib import Path
import random
import signal
import time
import tomllib
from collections.abc import Callable, Iterable

from aperture_stress import SerialLines, drain_received, find_device, parse_state
from micropin_protocol import DisplayFrame, build_control_payload
from random_lamp_test import ResponseMismatch, send_and_verify


START_MASK = 0x40
RIGHT_FLIPPER_MASK = 0x10
LEFT_FLIPPER_MASK = 0x20
CREDIT_MASK = 0x04
CREDIT_LEVEL_MASK = 0x10
TILT_MASK = 0x88
OUTHOLE_DMA_INDEX = 24

# The six physical cup contacts, in host-command bit order.
CUP_DMA_INDICES = (29, 27, 25, 20, 18, 14)
OUTHOLE_CONTACT = len(CUP_DMA_INDICES)
SIDE_BONUS_CUP = 5
# Five scoring cups, left to right.  The sixth contact is the side bonus cup.
CUP_LAMPS = (36, 24, 25, 26, 13)
CUP_TARGET_LAMPS = (29, 37, 32, 33, 34)
# The four value inserts form one physical column.  Outputs 29/37 belong to
# standup targets; the upper two value lamps are outputs 27 and 18.
CUP_TIER_LAMPS = (28, 35, 27, 18)
CUP_BONUS_VALUES = (2000, 4000, 6000, 8000)
CUP_REGULAR_VALUES = (250, 500, 750, 1000)
COLLECT_BONUS_LAMP = 15
DOUBLE_BONUS_LAMP = 10
TRIPLE_BONUS_LAMP = 7
EXTRA_BALL_ROLLOVER_LAMP = 9
EXTRA_BALL_SIDE_CUP_LAMP = 14

# R-K and Q-A are physical DMA contacts 1 and 32, hence byte indices 0 and 31
# in the $23e0-$23ff switch snapshot. A clear $10 bit means the contact is shut.
INLANE_DMA_INDICES = (0, 31)
# random_lamp_test labels contacts in decimal, starting at one.
OUTLANE_DMA_INDICES = (30, 8)  # c31 and c09; physical sides not yet assigned
TEN_THOUSAND_BONUS_DMA_INDEX = 15  # c16
STANDUP_DMA_INDICES = (28, 26, 21, 22, 23)  # c29,c27,c22,c23,c24; cup order
STANDUP_BAR_MASK = 0x40
STANDUP_FLASH_HZ = 2.0
STANDUP_COINCIDENCE_FRAMES = 2
STANDUP_COMPLETE_POINTS = 10_000
GAME_OVER_FLASH_HZ = 2.0
TILT_FLASH_HZ = 4.0
ATTRACT_HOLD_SECONDS = 4.5
ATTRACT_TRANSITION_SECONDS = 0.5
ATTRACT_PLAYFIELD_HOLD_SECONDS = 5.0
ATTRACT_ANIMATION_SECONDS = 8.0
DEFAULT_HIGH_SCORES = (60000, 50000, 40000, 30000, 20000, 10000)
STANDARD_LAMP_FLASH_HZ = 2.0
CUP_COMPLETE_STEP_SECONDS = 0.10
ROLLOVER_COMPLETE_STEP_SECONDS = 0.10


def score_digits(score: int, width: int = 6) -> str:
    """Decimal score with F (hardware blank) padding; zero remains visible."""
    return str(min(max(0, score), 10 ** width - 1)).rjust(width, "f")
# The stock ROM's eight 500-point handlers are contacts 20, 10, 11, 13, 14,
# 12, 17, 18. Its lamp codes 02,2a,10,1a,01,19,21,0a decode as
# (code & 7) * 8 + (code >> 3), giving these raw output numbers.
ROLLOVER_DMA_INDICES = (19, 9, 10, 12, 13, 11, 16, 17)
ROLLOVER_LAMPS = (16, 21, 2, 19, 8, 11, 12, 17)
# Physical clockwise order: NW, N, NE, E, SE, S, SW, W.  The raw switch
# ordering above is retained for wire compatibility; this permutation is only
# for lane-change rotation of the lamp pattern.
ROLLOVER_RING_BITS = (2, 3, 4, 5, 6, 7, 0, 1)
ROLLOVER_POINTS = 500
ROLLOVER_COMPLETE_BONUS = 5000
MATCH_SEQUENCE_STEPS = 6
MATCH_DIGIT_POSITIONS = (5, 0, 1, 4, 3, 2)  # Zero-based, left to right.
MATCH_START_RATE_HZ = 5.0
MATCH_END_RATE_HZ = 0.7
SAME_PLAYER_AGAIN_SECONDS = 2.0
SAME_PLAYER_AGAIN_FLASH_HZ = 4.0
SAME_PLAYER_AGAIN_LAMP = 6
WAITING_PLAYER_FLASH_HZ = 2.0
GRACE_SECONDS = 4.0
GRACE_FLASH_EARLY_OFF_SECONDS = 0.5
DEFAULT_CONFIG_PATH = Path(__file__).with_name("micropin_game.toml")

REFLEX_EVENT_NAMES = (
    "lower_left_bumper",
    "upper_left_bumper",
    "middle_rollover_bumper",
    "lower_right_bumper",
    "right_sling",
    "left_sling",
)


class SoundMode(IntEnum):
    """The four safe, electrically distinct sound modes used by the game."""

    SILENCE = 0x00
    SHORT = 0x04
    MEDIUM = 0x08
    LONG = 0x0C


@dataclass(frozen=True)
class Tone:
    pitch: int
    mode: SoundMode

    def __post_init__(self) -> None:
        if not 0 <= self.pitch <= 0xFF:
            raise ValueError("tone pitch must fit in one byte")
        try:
            mode = SoundMode(self.mode)
        except ValueError as exc:
            raise ValueError(
                "sound mode must be silence, short, medium, or long"
            ) from exc
        object.__setattr__(self, "mode", mode)

    @property
    def duration(self) -> int:
        """Wire byte retained for compatibility with the aperture structures."""
        return int(self.mode)


@dataclass(frozen=True)
class SongNote:
    tone: Tone
    interval_seconds: float


class _Forever:
    def __repr__(self) -> str:
        return "FOREVER"


FOREVER = _Forever()


class LampMode(Enum):
    OFF = "off"
    ON = "on"
    FLASH = "flash"


@dataclass(frozen=True)
class LampStep:
    """One timed step; controlled lamps omitted from ``on`` are forced off."""

    on: frozenset[int]
    duration: float

    def __post_init__(self) -> None:
        object.__setattr__(self, "on", frozenset(self.on))
        if self.duration <= 0:
            raise ValueError("lamp step duration must be positive")


@dataclass(frozen=True)
class LampSequence:
    """A temporary lamp overlay.

    ``repeat=None`` plays once, an integer plays that many total passes, and
    ``repeat=FOREVER`` runs until its returned handle is cancelled.
    """

    name: str
    controls: frozenset[int]
    steps: tuple[LampStep, ...]
    repeat: int | _Forever | None = None
    priority: int = 0

    def __post_init__(self) -> None:
        object.__setattr__(self, "controls", frozenset(self.controls))
        object.__setattr__(self, "steps", tuple(self.steps))
        if not self.controls:
            raise ValueError("lamp sequence must control at least one lamp")
        if not self.steps:
            raise ValueError("lamp sequence must contain at least one step")
        if any(not step.on <= self.controls for step in self.steps):
            raise ValueError("lamp step turns on a lamp outside sequence controls")
        if self.repeat is not None and self.repeat is not FOREVER:
            if (
                not isinstance(self.repeat, int)
                or isinstance(self.repeat, bool)
                or self.repeat < 1
            ):
                raise ValueError(
                    "lamp sequence repeat must be a positive integer, FOREVER, or None"
                )


@dataclass
class _ActiveLampSequence:
    sequence: LampSequence
    started_at: float
    order: int
    cancelled: bool = False


class LampSequenceHandle:
    def __init__(
        self, controller: "LampController", active: _ActiveLampSequence
    ) -> None:
        self._controller = controller
        self._active = active

    def cancel(self) -> None:
        self._active.cancelled = True

    @property
    def finished(self) -> bool:
        return self._controller._finished(self._active, self._controller._clock())


class LampController:
    """Composes persistent lamp modes and temporary animations over rule state."""

    def __init__(
        self,
        *,
        clock: Callable[[], float] = time.monotonic,
        flash_hz: float = STANDARD_LAMP_FLASH_HZ,
    ) -> None:
        self._clock = clock
        self._flash_hz = flash_hz
        self._modes: dict[int, LampMode] = {}
        self._active: list[_ActiveLampSequence] = []
        self._next_order = 0

    @staticmethod
    def _lamps(value: int | Iterable[int]) -> tuple[int, ...]:
        lamps = (value,) if isinstance(value, int) else tuple(value)
        if any(lamp < 0 or lamp >= 40 for lamp in lamps):
            raise ValueError("lamp number must be in the 0..39 output range")
        return lamps

    def off(self, lamps: int | Iterable[int]) -> None:
        for lamp in self._lamps(lamps):
            self._modes[lamp] = LampMode.OFF

    def on(self, lamps: int | Iterable[int]) -> None:
        for lamp in self._lamps(lamps):
            self._modes[lamp] = LampMode.ON

    def flash(self, lamps: int | Iterable[int]) -> None:
        for lamp in self._lamps(lamps):
            self._modes[lamp] = LampMode.FLASH

    def relinquish(self, lamps: int | Iterable[int]) -> None:
        """Remove persistent overrides and reveal the supplied rule bitmap."""
        for lamp in self._lamps(lamps):
            self._modes.pop(lamp, None)

    def play(self, sequence: LampSequence) -> LampSequenceHandle:
        # A newly requested named effect replaces an older copy instead of
        # letting the old one unexpectedly resume after the new copy ends.
        for active in self._active:
            if active.sequence.name == sequence.name:
                active.cancelled = True
        active = _ActiveLampSequence(sequence, self._clock(), self._next_order)
        self._next_order += 1
        self._active.append(active)
        return LampSequenceHandle(self, active)

    def cancel_all(self) -> None:
        for active in self._active:
            active.cancelled = True

    @staticmethod
    def _duration(sequence: LampSequence) -> float:
        return sum(step.duration for step in sequence.steps)

    def _finished(self, active: _ActiveLampSequence, now: float) -> bool:
        if active.cancelled:
            return True
        repeat = active.sequence.repeat
        if repeat is FOREVER:
            return False
        passes = 1 if repeat is None else repeat
        return now - active.started_at >= self._duration(active.sequence) * passes

    def _current_step(self, active: _ActiveLampSequence, now: float) -> LampStep:
        position = max(0.0, now - active.started_at) % self._duration(active.sequence)
        elapsed = 0.0
        for step in active.sequence.steps:
            elapsed += step.duration
            if position < elapsed:
                return step
        return active.sequence.steps[-1]

    @staticmethod
    def _set(bitmap: bytearray, lamp: int, enabled: bool) -> None:
        mask = 1 << (lamp % 8)
        if enabled:
            bitmap[lamp // 8] |= mask
        else:
            bitmap[lamp // 8] &= ~mask

    def render(
        self, rule_bitmap: bytes | bytearray, *, now: float | None = None
    ) -> bytes:
        if len(rule_bitmap) != 5:
            raise ValueError("Micropin lamp bitmap must contain five bytes")
        now = self._clock() if now is None else now
        bitmap = bytearray(rule_bitmap)
        flash_on = int(now * self._flash_hz * 2) % 2 == 0
        for lamp, mode in self._modes.items():
            self._set(
                bitmap,
                lamp,
                mode is LampMode.ON or (mode is LampMode.FLASH and flash_on),
            )

        self._active = [
            active for active in self._active if not self._finished(active, now)
        ]
        for active in sorted(
            self._active, key=lambda item: (item.sequence.priority, item.order)
        ):
            step = self._current_step(active, now)
            for lamp in active.sequence.controls:
                self._set(bitmap, lamp, lamp in step.on)
        return bytes(bitmap)


CUP_COMPLETE_SEQUENCE = LampSequence(
    name="cup_complete_inward_and_down",
    controls=frozenset((*CUP_LAMPS, *CUP_TIER_LAMPS)),
    steps=(
        LampStep(
            on=frozenset((CUP_LAMPS[0], CUP_LAMPS[4])),
            duration=CUP_COMPLETE_STEP_SECONDS,
        ),
        LampStep(
            on=frozenset((CUP_LAMPS[1], CUP_LAMPS[3])),
            duration=CUP_COMPLETE_STEP_SECONDS,
        ),
        LampStep(
            on=frozenset((CUP_LAMPS[2],)),
            duration=CUP_COMPLETE_STEP_SECONDS,
        ),
        *(
            LampStep(
                on=frozenset((lamp,)),
                duration=CUP_COMPLETE_STEP_SECONDS,
            )
            for lamp in CUP_TIER_LAMPS
        ),
    ),
    priority=20,
)
ROLLOVER_COMPLETE_SEQUENCE = LampSequence(
    name="rollover_complete_chase",
    controls=frozenset(ROLLOVER_LAMPS),
    steps=tuple(
        LampStep(
            on=frozenset((ROLLOVER_LAMPS[bit],)),
            duration=ROLLOVER_COMPLETE_STEP_SECONDS,
        )
        for bit in ROLLOVER_RING_BITS
    ),
    repeat=2,
    priority=20,
)
SIDE_BONUS_LAMP_SEQUENCE = LampSequence(
    name="side_bonus_award_cycle",
    controls=frozenset(
        (DOUBLE_BONUS_LAMP, TRIPLE_BONUS_LAMP, EXTRA_BALL_SIDE_CUP_LAMP)
    ),
    steps=tuple(
        LampStep(on=frozenset((lamp,)), duration=0.10)
        for lamp in (
            DOUBLE_BONUS_LAMP,
            TRIPLE_BONUS_LAMP,
            EXTRA_BALL_SIDE_CUP_LAMP,
        )
    ),
    repeat=2,
    priority=20,
)
BALL_READY_STEPS = tuple(
    LampStep(
        on=frozenset((cup, target)),
        duration=0.10,
    )
    for cup, target in zip(CUP_LAMPS, CUP_TARGET_LAMPS, strict=True)
) + (LampStep(on=frozenset(), duration=0.25),)
BALL_READY_SEQUENCE = LampSequence(
    name="ball_ready_chase",
    controls=frozenset((*CUP_LAMPS, *CUP_TARGET_LAMPS)),
    steps=BALL_READY_STEPS,
    repeat=FOREVER,
    priority=20,
)
AUTO_RELAUNCH_SEQUENCE = LampSequence(
    name="ball_ready_chase",
    controls=BALL_READY_SEQUENCE.controls,
    steps=BALL_READY_STEPS,
    priority=20,
)

# Clockwise-ish path from the side bonus column, through the standups/cups and
# value inserts, then around the rollover ring from SW through S.
ATTRACT_MARQUEE_PATH = (
    COLLECT_BONUS_LAMP,
    EXTRA_BALL_SIDE_CUP_LAMP,
    TRIPLE_BONUS_LAMP,
    DOUBLE_BONUS_LAMP,
    *reversed(CUP_TARGET_LAMPS),
    *CUP_LAMPS,
    *CUP_TIER_LAMPS,
    EXTRA_BALL_ROLLOVER_LAMP,
    SAME_PLAYER_AGAIN_LAMP,
    *ROLLOVER_LAMPS,
)
ATTRACT_MARQUEE_PERIOD = 4
ATTRACT_MARQUEE_TICK_SECONDS = 0.25
ATTRACT_MARQUEE_SEQUENCE = LampSequence(
    name="attract_marquee_1",
    # Attract animations own the whole playfield so lamps outside the effect
    # are deliberately dark rather than leaking through from the last game.
    controls=frozenset(range(40)),
    steps=tuple(
        LampStep(
            on=frozenset(
                lamp
                for sequence_number, lamp in enumerate(ATTRACT_MARQUEE_PATH)
                if (sequence_number - phase) % ATTRACT_MARQUEE_PERIOD == 0
            ),
            duration=ATTRACT_MARQUEE_TICK_SECONDS,
        )
        for phase in range(ATTRACT_MARQUEE_PERIOD)
    ),
    repeat=round(
        ATTRACT_ANIMATION_SECONDS
        / (ATTRACT_MARQUEE_PERIOD * ATTRACT_MARQUEE_TICK_SECONDS)
    ),
    priority=30,
)
ATTRACT_CUP_COLUMN_STEPS = (
    LampStep(
        on=frozenset(
            (
                CUP_TARGET_LAMPS[0],
                CUP_TARGET_LAMPS[4],
                CUP_LAMPS[0],
                CUP_LAMPS[4],
            )
        ),
        duration=0.10,
    ),
    LampStep(
        on=frozenset(
            (
                CUP_TARGET_LAMPS[1],
                CUP_TARGET_LAMPS[3],
                CUP_LAMPS[1],
                CUP_LAMPS[3],
            )
        ),
        duration=0.10,
    ),
    LampStep(
        on=frozenset((CUP_TARGET_LAMPS[2], CUP_LAMPS[2])),
        duration=0.10,
    ),
    *(
        LampStep(on=frozenset((lamp,)), duration=0.10)
        for lamp in CUP_TIER_LAMPS
    ),
    LampStep(on=frozenset(), duration=0.30),
)
ATTRACT_CUP_COLUMN_SEQUENCE = LampSequence(
    name="attract_marquee_2",
    controls=frozenset(range(40)),
    steps=ATTRACT_CUP_COLUMN_STEPS,
    repeat=round(
        ATTRACT_ANIMATION_SECONDS
        / sum(step.duration for step in ATTRACT_CUP_COLUMN_STEPS)
    ),
    priority=30,
)
ATTRACT_LAMP_ANIMATIONS = (
    ATTRACT_MARQUEE_SEQUENCE,
    ATTRACT_CUP_COLUMN_SEQUENCE,
)


DEFAULT_MATCH_WIN_SONG = tuple(
    SongNote(Tone(pitch, SoundMode.LONG), 0.14)
    for pitch in (0xf1, 0xd6, 0xf1, 0xb4, 0x8f, 0xb4, 0x78)
)

# Hoisted from ppm/ppm.asm's Funkytown phrase; 00/00 pairs are rests.
DEFAULT_FUNKYTOWN_SONG = tuple(
    SongNote(
        Tone(pitch, SoundMode.LONG if pitch else SoundMode.SILENCE), 0.14
    )
    for pitch in (0x87, 0x87, 0x78, 0x87, 0, 0x65, 0, 0x65,
                  0x87, 0xbf, 0xaa, 0x87)
)

# Approximate semitone steps using the emulator's current pitch conversion.
# These remain configurable pending measurements of the actual oscillator.
DEFAULT_LAUNCH_SONG = tuple(
    SongNote(Tone(pitch, SoundMode.LONG), 0.07)
    for pitch in (0x78, 0x7e, 0x85, 0x8c, 0x94)
)
DEFAULT_OUTLANE_SONG = tuple(reversed(DEFAULT_LAUNCH_SONG))
DEFAULT_OUTLANE_SAVE_SONG = (
    SongNote(Tone(0x78, SoundMode.LONG), 0.07),
    SongNote(Tone(0xae, SoundMode.LONG), 0.07),
)
DEFAULT_CHARGE_SONG = tuple(
    SongNote(Tone(pitch, SoundMode.LONG), 0.09)
    for pitch in (0x78, 0x94, 0xae, 0xe4, 0xae, 0xe4)
)
DEFAULT_ADD_CREDIT_SONG = (SongNote(Tone(0x78, SoundMode.LONG), 0.14),)
DEFAULT_MUTE_ON_SONG = (
    SongNote(Tone(0x94, SoundMode.LONG), 0.10),
    SongNote(Tone(0x78, SoundMode.LONG), 0.10),
)
DEFAULT_MUTE_OFF_SONG = tuple(reversed(DEFAULT_MUTE_ON_SONG))
DEFAULT_STANDUP_COMPLETE_SONG = (
    SongNote(Tone(0xae, SoundMode.LONG), 0.14),
)
DEFAULT_BONUS_2X_SONG = (
    SongNote(Tone(0x78, SoundMode.LONG), 0.10),
    SongNote(Tone(0xae, SoundMode.LONG), 0.10),
)
DEFAULT_BONUS_3X_SONG = (
    SongNote(Tone(0x78, SoundMode.LONG), 0.08),
    SongNote(Tone(0x94, SoundMode.LONG), 0.08),
    SongNote(Tone(0xca, SoundMode.LONG), 0.08),
)
DEFAULT_SIDE_BONUS_HOLE_SONG = tuple(
    SongNote(Tone(pitch, SoundMode.LONG), 0.10)
    for pitch in (0x78, 0x94, 0xae)
)
DEFAULT_TILT_SONG = tuple(
    SongNote(Tone(pitch, SoundMode.LONG), interval)
    for pitch, interval in (
        (0x3c, 0.30), (0x3c, 0.30), (0x57, 0.70),
        (0x3c, 0.30), (0x57, 0.30), (0x6e, 0.70),
    )
)


@dataclass(frozen=True)
class GameConfig:
    balls_per_game: int = 4
    hole_settle_seconds: float = 0.5
    credit_long_press_seconds: float = 3.0
    inlane_bonus_points: int = 1000
    bonus_tick_seconds: float = 0.10
    bonus_pause_seconds: float = 0.75
    bonus_entry_pause_seconds: float = 0.5
    bonus_multiplier_pause_seconds: float = 0.5
    reflex_points: tuple[int, ...] = (25, 50, 100, 10, 5, 5)
    reflex_sounds: tuple[Tone, ...] = (
        Tone(0xca, SoundMode.LONG),
        Tone(0xaa, SoundMode.LONG),
        Tone(0x87, SoundMode.LONG),
        Tone(0x65, SoundMode.LONG),
        Tone(0x33, SoundMode.LONG),
        Tone(0x3c, SoundMode.LONG),
    )
    match_sound: Tone = Tone(0x78, SoundMode.LONG)
    bonus_add_sound: Tone = Tone(0x87, SoundMode.LONG)
    bonus_payout_sound: Tone = Tone(0x87, SoundMode.LONG)
    end_ball_sound: Tone = Tone(0x15, SoundMode.LONG)
    standup_sound: Tone = Tone(0x87, SoundMode.LONG)
    rollover_sound: Tone = Tone(0x54, SoundMode.LONG)
    rollover_complete_sound: Tone = Tone(0xf1, SoundMode.LONG)
    cup_lit_sound: Tone = Tone(0x65, SoundMode.LONG)
    cup_unlit_sound: Tone = Tone(0x33, SoundMode.LONG)
    cups_complete_sound: Tone = Tone(0xf1, SoundMode.LONG)
    match_win_song: tuple[SongNote, ...] = DEFAULT_MATCH_WIN_SONG
    boot_song: tuple[SongNote, ...] = ()
    start_song: tuple[SongNote, ...] = ()
    launch_song: tuple[SongNote, ...] = DEFAULT_LAUNCH_SONG
    outlane_song: tuple[SongNote, ...] = DEFAULT_OUTLANE_SONG
    outlane_save_song: tuple[SongNote, ...] = DEFAULT_OUTLANE_SAVE_SONG
    standup_special_song: tuple[SongNote, ...] = DEFAULT_CHARGE_SONG
    standup_complete_song: tuple[SongNote, ...] = DEFAULT_STANDUP_COMPLETE_SONG
    bonus_2x_song: tuple[SongNote, ...] = DEFAULT_BONUS_2X_SONG
    bonus_3x_song: tuple[SongNote, ...] = DEFAULT_BONUS_3X_SONG
    side_bonus_hole_song: tuple[SongNote, ...] = DEFAULT_SIDE_BONUS_HOLE_SONG
    tilt_song: tuple[SongNote, ...] = DEFAULT_TILT_SONG
    high_score_song: tuple[SongNote, ...] = DEFAULT_FUNKYTOWN_SONG
    add_credit_song: tuple[SongNote, ...] = DEFAULT_ADD_CREDIT_SONG
    mute_on_song: tuple[SongNote, ...] = DEFAULT_MUTE_ON_SONG
    mute_off_song: tuple[SongNote, ...] = DEFAULT_MUTE_OFF_SONG
    default_high_scores: tuple[int, ...] = DEFAULT_HIGH_SCORES


def load_game_config(path: Path) -> GameConfig:
    with path.open("rb") as file:
        data = tomllib.load(file)

    game = data.get("game", {})
    points = data.get("points", {})
    sounds = data.get("sounds", {})
    high_scores = data.get("high_scores", {}).get("defaults", list(DEFAULT_HIGH_SCORES))
    if (not isinstance(high_scores, list) or len(high_scores) != 6
            or any(type(score) is not int or score < 0 for score in high_scores)):
        raise ValueError("high_scores.defaults must contain six nonnegative integers")

    balls_per_game = int(game.get("balls_per_game", 4))
    if not 1 <= balls_per_game <= 9:
        raise ValueError("game.balls_per_game must be between 1 and 9")
    credit_long_press_seconds = float(game.get("credit_long_press_seconds", 3.0))
    if not 0.5 <= credit_long_press_seconds <= 10.0:
        raise ValueError("game.credit_long_press_seconds must be between 0.5 and 10 seconds")

    holes = data.get("holes", {})
    hole_settle_seconds = float(holes.get("settle_seconds", 0.5))
    if not 0 <= hole_settle_seconds <= 5.0:
        raise ValueError("holes.settle_seconds must be between 0 and 5 seconds")

    bonus_config = data.get("bonus", {})
    inlane_bonus_points = int(bonus_config.get("inlane_points", 1000))
    bonus_tick_seconds = float(bonus_config.get("tick_seconds", 0.10))
    bonus_pause_seconds = float(bonus_config.get("pause_seconds", 0.75))
    bonus_entry_pause_seconds = float(
        bonus_config.get("entry_pause_seconds", 0.5)
    )
    bonus_multiplier_pause_seconds = float(
        bonus_config.get("multiplier_pause_seconds", 0.5)
    )
    if not 0 <= bonus_pause_seconds <= 5:
        raise ValueError("bonus.pause_seconds must be between 0 and 5 seconds")
    if not 0 <= bonus_entry_pause_seconds <= 5:
        raise ValueError("bonus.entry_pause_seconds must be between 0 and 5 seconds")
    if inlane_bonus_points <= 0 or inlane_bonus_points % 1000:
        raise ValueError("bonus.inlane_points must be a positive multiple of 1000")
    if not 0.01 <= bonus_tick_seconds <= 5.0:
        raise ValueError("bonus.tick_seconds must be between 0.01 and 5 seconds")
    if not 0 <= bonus_multiplier_pause_seconds <= 5.0:
        raise ValueError(
            "bonus.multiplier_pause_seconds must be between 0 and 5 seconds"
        )

    point_values = tuple(
        int(points.get(name, default))
        for name, default in zip(
            REFLEX_EVENT_NAMES, (25, 50, 100, 10, 5, 5)
        )
    )
    if any(value < 0 for value in point_values):
        raise ValueError("reflex-switch point values cannot be negative")

    def load_sound_mode(source: dict, default: SoundMode) -> SoundMode:
        raw_mode = source.get("mode", source.get("duration", default))
        try:
            if isinstance(raw_mode, str):
                return SoundMode[raw_mode.strip().upper()]
            return SoundMode(int(raw_mode))
        except (KeyError, TypeError, ValueError) as exc:
            raise ValueError(
                "sound mode must be silence, short, medium, or long"
            ) from exc

    def load_tone(name: str, default: Tone) -> Tone:
        source = sounds.get(name, {})
        tone = Tone(
            int(source.get("pitch", default.pitch)),
            load_sound_mode(source, default.mode),
        )
        if tone.mode is SoundMode.SILENCE:
            raise ValueError(f"sounds.{name} must use short, medium, or long")
        return tone

    songs = data.get("songs", {})

    def load_song(name: str) -> tuple[SongNote, ...]:
        if name == "none":
            return ()
        source = songs.get(name)
        if source is None and name == "match_win":
            return DEFAULT_MATCH_WIN_SONG
        if source is None and name == "launch":
            return DEFAULT_LAUNCH_SONG
        if source is None and name == "outlane":
            return DEFAULT_OUTLANE_SONG
        if source is None and name == "outlane_save":
            return DEFAULT_OUTLANE_SAVE_SONG
        if source is None and name == "charge":
            return DEFAULT_CHARGE_SONG
        if source is None and name == "funkytown":
            return DEFAULT_FUNKYTOWN_SONG
        if source is None and name == "add_credit":
            return DEFAULT_ADD_CREDIT_SONG
        if source is None and name == "mute_on":
            return DEFAULT_MUTE_ON_SONG
        if source is None and name == "mute_off":
            return DEFAULT_MUTE_OFF_SONG
        if source is None and name == "standup_complete":
            return DEFAULT_STANDUP_COMPLETE_SONG
        if source is None and name == "bonus_2x":
            return DEFAULT_BONUS_2X_SONG
        if source is None and name == "bonus_3x":
            return DEFAULT_BONUS_3X_SONG
        if source is None and name == "side_bonus_hole":
            return DEFAULT_SIDE_BONUS_HOLE_SONG
        if source is None and name == "tilt":
            return DEFAULT_TILT_SONG
        if not isinstance(source, list) or not source:
            raise ValueError(f"songs.{name} must contain at least one note")
        result = tuple(
            SongNote(
                Tone(
                    int(note["pitch"]),
                    load_sound_mode(note, SoundMode.SILENCE),
                ),
                float(note["interval_seconds"]),
            )
            for note in source
        )
        if any(
            (note.tone.mode is SoundMode.SILENCE and note.tone.pitch != 0)
            or not 0.01 <= note.interval_seconds <= 5.0
            for note in result
        ):
            raise ValueError(
                f"songs.{name} requires an audible mode, or pitch 0 with "
                "silence, and a 0.01..5-second interval"
            )
        return result

    music = data.get("music", {})
    boot_song = load_song(str(music.get("boot", "none")))
    start_song = load_song(str(music.get("start", "none")))

    return GameConfig(
        default_high_scores=tuple(sorted(high_scores, reverse=True)),
        balls_per_game=balls_per_game,
        hole_settle_seconds=hole_settle_seconds,
        credit_long_press_seconds=credit_long_press_seconds,
        inlane_bonus_points=inlane_bonus_points,
        bonus_tick_seconds=bonus_tick_seconds,
        bonus_pause_seconds=bonus_pause_seconds,
        bonus_entry_pause_seconds=bonus_entry_pause_seconds,
        bonus_multiplier_pause_seconds=bonus_multiplier_pause_seconds,
        reflex_points=point_values,
        reflex_sounds=tuple(
            load_tone(name, default)
            for name, default in zip(
                REFLEX_EVENT_NAMES,
                (
                    Tone(0xca, SoundMode.LONG),
                    Tone(0xaa, SoundMode.LONG),
                    Tone(0x87, SoundMode.LONG),
                    Tone(0x65, SoundMode.LONG),
                    Tone(0x33, SoundMode.LONG),
                    Tone(0x3c, SoundMode.LONG),
                ),
            )
        ),
        match_sound=load_tone("match", Tone(0x78, SoundMode.LONG)),
        bonus_add_sound=load_tone("bonus_add", Tone(0x87, SoundMode.LONG)),
        bonus_payout_sound=load_tone(
            "bonus_payout", Tone(0x87, SoundMode.LONG)
        ),
        end_ball_sound=load_tone("end_ball", Tone(0x15, SoundMode.LONG)),
        standup_sound=load_tone("standup", Tone(0x87, SoundMode.LONG)),
        rollover_sound=load_tone("rollover", Tone(0x54, SoundMode.LONG)),
        rollover_complete_sound=load_tone(
            "rollover_complete", Tone(0xf1, SoundMode.LONG)
        ),
        cup_lit_sound=load_tone("cup_lit", Tone(0x65, SoundMode.LONG)),
        cup_unlit_sound=load_tone("cup_unlit", Tone(0x33, SoundMode.LONG)),
        cups_complete_sound=load_tone(
            "cups_complete", Tone(0xf1, SoundMode.LONG)
        ),
        match_win_song=load_song("match_win"),
        boot_song=boot_song,
        start_song=start_song,
        launch_song=load_song(str(music.get("launch", "launch"))),
        outlane_song=load_song(str(music.get("outlane", "outlane"))),
        outlane_save_song=load_song(str(music.get("outlane_save", "outlane_save"))),
        standup_special_song=load_song(str(music.get("standup_special", "charge"))),
        standup_complete_song=load_song(
            str(music.get("standup_complete", "standup_complete"))
        ),
        bonus_2x_song=load_song(str(music.get("bonus_2x", "bonus_2x"))),
        bonus_3x_song=load_song(str(music.get("bonus_3x", "bonus_3x"))),
        side_bonus_hole_song=load_song(
            str(music.get("side_bonus_hole", "side_bonus_hole"))
        ),
        tilt_song=load_song(str(music.get("tilt", "tilt"))),
        high_score_song=load_song(str(music.get("high_score", "funkytown"))),
        add_credit_song=load_song(str(music.get("add_credit", "add_credit"))),
        mute_on_song=load_song(str(music.get("mute_on", "mute_on"))),
        mute_off_song=load_song(str(music.get("mute_off", "mute_off"))),
    )


class GameState(Enum):
    GAME_OVER = "game over"
    WAITING_FOR_LAUNCH = "waiting for launch"
    GAME_PLAYING = "game playing"
    BONUS_PROCESSING = "bonus processing"
    HIGH_SCORE = "high score tributes"
    MATCH_SEQUENCE = "match sequence"


class BonusPayoutPhase(Enum):
    COUNTING = "counting"
    SIDE_CUP_LAMP_SHOW = "side cup lamp show"
    WAIT_TO_START = "waiting to begin"
    WAIT_FOR_TRIPLE = "waiting to show 3x"
    WAIT_TO_COUNT = "waiting to count"


class StandupCoincidence:
    """Pair closure edges and bar events within two frames, in either order."""

    def __init__(self) -> None:
        self.frame = 0
        self.clear()

    def clear(self) -> None:
        self.bar_frame: int | None = None
        self.target_frames: list[int | None] = [None] * 5

    def update(self, targets: int, bar: bool) -> int:
        self.frame += 1
        if self.bar_frame is not None and self.frame - self.bar_frame > STANDUP_COINCIDENCE_FRAMES:
            self.bar_frame = None
        for bit, recorded in enumerate(self.target_frames):
            if recorded is not None and self.frame - recorded > STANDUP_COINCIDENCE_FRAMES:
                self.target_frames[bit] = None
            if targets & (1 << bit):
                self.target_frames[bit] = self.frame
        if bar:
            self.bar_frame = self.frame
        if self.bar_frame is None:
            return 0
        matched = sum(1 << bit for bit, recorded in enumerate(self.target_frames)
                      if recorded is not None)
        if matched:
            # One bar event authorizes this batch only; neither side is reused.
            self.bar_frame = None
            for bit in range(5):
                if matched & (1 << bit):
                    self.target_frames[bit] = None
        return matched


class HoleDwellTimer:
    """Report each continuous closure once, after its settle time expires.

    The timer knows only contact indices. The game decides what each completed
    contact does (eject a cup, drain a ball, or some future hole behavior).
    """

    def __init__(self, contact_count: int, settle_seconds: float) -> None:
        self._since: list[float | None] = [None] * contact_count
        self._reported: list[bool] = [False] * contact_count
        self._settle_seconds = settle_seconds

    def clear(self) -> None:
        for index in range(len(self._since)):
            self._since[index] = None
            self._reported[index] = False

    def started_at(self, index: int) -> float | None:
        """First observed closure time for the current continuous contact."""
        return self._since[index]

    def update(self, closed: tuple[bool, ...], now: float) -> tuple[int, ...]:
        if len(closed) != len(self._since):
            raise ValueError("wrong number of hole contacts")
        completed: list[int] = []
        for index, is_closed in enumerate(closed):
            if not is_closed:
                self._since[index] = None
                self._reported[index] = False
            elif self._since[index] is None:
                self._since[index] = now
                if self._settle_seconds == 0:
                    self._reported[index] = True
                    completed.append(index)
            elif not self._reported[index] and now - self._since[index] >= self._settle_seconds:
                self._reported[index] = True
                completed.append(index)
        return tuple(completed)


@dataclass(frozen=True)
class HardwareSnapshot:
    """One coherent input snapshot returned by the 8085."""

    cabinet_events: int
    reflex_events: int
    cabinet_levels: int
    rollover_events: int
    dma: bytes

    @classmethod
    def from_wire(
        cls, ports: tuple[int, int, int, int], dma: bytes
    ) -> "HardwareSnapshot":
        if len(ports) != 4:
            raise ValueError("expected four returned port bytes")
        if len(dma) != 32:
            raise ValueError("expected 32 DMA switch bytes")
        return cls(ports[0], ports[1], ports[2], ports[3], bytes(dma))

    @property
    def start_pressed(self) -> bool:
        return bool(self.cabinet_events & START_MASK)

    @property
    def right_flipper_pressed(self) -> bool:
        return bool(self.cabinet_events & RIGHT_FLIPPER_MASK)

    @property
    def left_flipper_pressed(self) -> bool:
        return bool(self.cabinet_events & LEFT_FLIPPER_MASK)

    @property
    def credit_pressed(self) -> bool:
        return bool(self.cabinet_events & CREDIT_MASK)

    @property
    def credit_held(self) -> bool:
        return bool(self.cabinet_levels & CREDIT_LEVEL_MASK)

    @property
    def tilt_pressed(self) -> bool:
        return bool(self.cabinet_events & TILT_MASK)

    @property
    def outhole_closed(self) -> bool:
        return not bool(self.dma[OUTHOLE_DMA_INDEX] & 0x10)

    @property
    def closed_cup_mask(self) -> int:
        mask = 0
        for bit, index in enumerate(CUP_DMA_INDICES):
            if not self.dma[index] & 0x10:
                mask |= 1 << bit
        return mask

    @property
    def closed_inlane_mask(self) -> int:
        mask = 0
        for bit, index in enumerate(INLANE_DMA_INDICES):
            if not self.dma[index] & 0x10:
                mask |= 1 << bit
        return mask

    @property
    def closed_rollover_mask(self) -> int:
        mask = 0
        for bit, index in enumerate(ROLLOVER_DMA_INDICES):
            if not self.dma[index] & 0x10:
                mask |= 1 << bit
        return mask

    @property
    def closed_outlane_mask(self) -> int:
        return sum(1 << bit for bit, index in enumerate(OUTLANE_DMA_INDICES)
                   if not self.dma[index] & 0x10)

    @property
    def closed_standup_mask(self) -> int:
        return sum(1 << bit for bit, index in enumerate(STANDUP_DMA_INDICES)
                   if not self.dma[index] & 0x10)

    @property
    def closed_playfield_mask(self) -> int:
        return sum(1 << index for index, value in enumerate(self.dma) if not value & 0x10)


@dataclass
class GameContext:
    state: GameState = GameState.GAME_OVER
    current_player: int = 1
    # Number of players who joined the current game.  Unjoined player
    # displays remain blank; a joined player with a zero score displays 000000.
    players_in_game: int = 1
    ball_number: int = 0
    ball_in_play: bool = False
    tilted: bool = False
    credits: int = 0
    bonus: int = 0
    bonus_multiplier: int = 1
    bonus_payout_multiplier: int = 1
    bonus_payout_base: int = 0
    bonus_payout_phase: BonusPayoutPhase = BonusPayoutPhase.COUNTING
    bonus_returns_to_play: bool = False
    player_scores: list[int] = field(default_factory=lambda: [0, 0, 0, 0])
    score_at_ball_start: int = 0
    same_player_again_started: float | None = None
    grace_started: float | None = None
    grace_save_used: bool = False
    outlane_save_pending: bool = False
    ball_ending: bool = False
    previous_outlane_mask: int = 0
    previous_playfield_mask: int = 0
    previous_standup_mask: int = 0
    standup_solid_mask: int = 0x1f
    standup_flashing_mask: int = 0
    ball_has_left_outhole: bool = False
    previous_inlane_mask: int = 0
    previous_rollover_mask: int = 0
    rollover_lit_mask: int = 0xff
    cup_lit_mask: int = 0x1f
    cup_tier: int = 0
    cups_completed_this_ball: bool = False
    standups_completed_this_ball: bool = False
    extra_ball_qualified: bool = False
    extra_ball_awarded_this_ball: bool = False
    extra_ball_pending: bool = False
    previous_left_flipper: bool = False
    previous_right_flipper: bool = False
    next_bonus_time: float = 0.0
    bonus_completed_at: float | None = None
    match_step: int = 0
    match_digit: int = 0
    last_match_digit: int | None = None
    next_match_time: float = 0.0


@dataclass(frozen=True)
class OutputFrame:
    display: DisplayFrame
    reflex_enabled: bool
    cup_mask: int = 0
    launch: bool = False
    lamp: int = 0xff
    lamp_bitmap: bytes | None = None
    tone_pitch: int = 0
    tone_duration: int = 0

    def to_payload(self) -> bytes:
        return build_control_payload(
            lamp=self.lamp,
            lamp_bitmap=self.lamp_bitmap,
            reflex_enabled=self.reflex_enabled,
            cup_mask=self.cup_mask,
            launch=self.launch,
            display_window=self.display,
            tone_pitch=self.tone_pitch,
            tone_duration=self.tone_duration,
        )


@dataclass(frozen=True)
class StepResult:
    output: OutputFrame
    messages: tuple[str, ...] = ()


class MicropinGame:
    """State machine and rules, independent of the serial transport."""

    def __init__(
        self,
        config: GameConfig | None = None,
        *,
        clock: Callable[[], float] = time.monotonic,
        randomizer: random.Random | None = None,
        nvram_path: Path | None = None,
    ) -> None:
        self.config = config or GameConfig()
        self._clock = clock
        self._random = randomizer or random.Random()
        # Cosmetic randomness must not alter match digits or game-rule choices.
        self._display_random = random.Random()
        self.lamps = LampController(clock=clock)
        self._ball_ready_lamps: LampSequenceHandle | None = None
        self._side_bonus_lamps: LampSequenceHandle | None = None
        self._bonus_flash_lamp: int | None = None
        self.nvram_path = nvram_path
        self.context = GameContext()
        self.high_scores: list[int] = list(self.config.default_high_scores)
        self._attract_started = self._clock()
        self._attract_lamp_phase = "hold"
        self._attract_lamp_deadline = (
            self._attract_started + ATTRACT_PLAYFIELD_HOLD_SECONDS
        )
        self._attract_lamp_handle: LampSequenceHandle | None = None
        self._attract_animation_index = 0
        self._high_score_tributes: list[int] = []
        self._tribute_player: int | None = None
        self._tribute_until = 0.0
        self._completed_game_recorded = False
        self._new_high_score_ranks: set[int] = set()
        self._matched_players: set[int] = set()
        self.recent_games: list[int] = []
        self.muted = False
        self._credit_press_started: float | None = None
        self._credit_long_handled = False
        self._mute_feedback_active = False
        self._load_nvram()
        self._hole_timer = HoleDwellTimer(OUTHOLE_CONTACT + 1, self.config.hole_settle_seconds)
        self._song: tuple[SongNote, ...] = ()
        self._song_index = 0
        self._next_song_time = 0.0
        self._sound_until: float | None = None
        if not self.muted:
            self._start_song(self.config.boot_song)
        self._standup_coincidence = StandupCoincidence()

    def initial_output(self) -> OutputFrame:
        return self._render_output()

    def step(self, inputs: HardwareSnapshot) -> StepResult:
        messages: list[str] = []
        launch = False
        cup_mask = 0
        sound: Tone | None = None
        newly_closed_outlanes = inputs.closed_outlane_mask & ~self.context.previous_outlane_mask
        self.context.previous_outlane_mask = inputs.closed_outlane_mask
        newly_closed_playfield = inputs.closed_playfield_mask & ~self.context.previous_playfield_mask
        self.context.previous_playfield_mask = inputs.closed_playfield_mask
        standup_hits = inputs.closed_standup_mask & ~self.context.previous_standup_mask
        self.context.previous_standup_mask = inputs.closed_standup_mask
        bar_hit = bool(inputs.reflex_events & STANDUP_BAR_MASK)
        if bar_hit:
            messages.append(f"standup bar: event; same-frame targets={standup_hits:02x}")
        if standup_hits and not bar_hit:
            messages.append(f"standup: targets={standup_hits:02x}; checking two-frame bar window")

        # A ball can be left in a cup while the machine is game-over (or
        # waiting for a launch).  Those contacts must still be serviced so
        # the table is physically emptied before the next ball starts.  Keep
        # this path deliberately inert with respect to scoring and game state:
        # only the cup eject coil is requested.  The outhole is excluded.
        if self.context.state in (
            GameState.GAME_OVER,
            GameState.WAITING_FOR_LAUNCH,
        ):
            closed_inactive_cups = tuple(
                bool(inputs.closed_cup_mask & (1 << index))
                for index in range(OUTHOLE_CONTACT)
            ) + (False,)
            for hole in self._hole_timer.update(
                closed_inactive_cups, self._clock()
            ):
                cup_mask |= 1 << hole
                messages.append(f"cup eject requested: {hole + 1} (inactive-state cleanup)")

        self._handle_credit_button(
            event=inputs.credit_pressed,
            held=inputs.credit_held,
            messages=messages,
        )

        if inputs.start_pressed and self.context.state in (
            GameState.WAITING_FOR_LAUNCH, GameState.GAME_PLAYING,
            GameState.BONUS_PROCESSING,
        ):
            if self.context.ball_number >= 2:
                self._start_game()
                messages.append("game: abandoned; new one-player game")
            elif self.context.players_in_game < 4:
                self._add_player()
                messages.append(f"players: {self.context.players_in_game}")
            else:
                messages.append("players: already at four")
            # Do not launch or score stale events on the same frame as Start.
            return StepResult(self._render_output(cup_mask=cup_mask, sound=sound), tuple(messages))

        if self.context.state is GameState.GAME_OVER:
            if inputs.start_pressed:
                self._start_game()
                messages.append(self._state_message())
            else:
                self._advance_high_score_tributes()

        elif self.context.state is GameState.WAITING_FOR_LAUNCH:
            if inputs.right_flipper_pressed:
                if inputs.outhole_closed:
                    launch = True
                    self._launch_ball(new_numbered_ball=True)
                    self.context.previous_right_flipper = inputs.right_flipper_pressed
                    messages.append("launcher: firing coil 5")
                    messages.append(self._state_message())
                else:
                    messages.append("launcher: ignored; outhole is open")

        elif self.context.state is GameState.GAME_PLAYING:
            left_flipper_edge = inputs.left_flipper_pressed and not self.context.previous_left_flipper
            self.context.previous_left_flipper = inputs.left_flipper_pressed
            if left_flipper_edge and not self.context.tilted and not self.context.ball_ending:
                old_lit = self.context.rollover_lit_mask
                rotated = 0
                for ring_index, bit in enumerate(ROLLOVER_RING_BITS):
                    if old_lit & (1 << bit):
                        rotated |= 1 << ROLLOVER_RING_BITS[(ring_index - 1) % len(ROLLOVER_RING_BITS)]
                self.context.rollover_lit_mask = rotated
                self.context.cup_lit_mask = (self.context.cup_lit_mask >> 1) | ((self.context.cup_lit_mask & 1) << 4)
                messages.append(f"lane change: rollovers={rotated:02x}")
            right_flipper_edge = inputs.right_flipper_pressed and not self.context.previous_right_flipper
            self.context.previous_right_flipper = inputs.right_flipper_pressed
            if right_flipper_edge and not self.context.tilted and not self.context.ball_ending:
                old_lit = self.context.rollover_lit_mask
                rotated = 0
                for ring_index, bit in enumerate(ROLLOVER_RING_BITS):
                    if old_lit & (1 << bit):
                        rotated |= 1 << ROLLOVER_RING_BITS[(ring_index + 1) % len(ROLLOVER_RING_BITS)]
                self.context.rollover_lit_mask = rotated
                self.context.cup_lit_mask = ((self.context.cup_lit_mask << 1) & 0x1f) | (self.context.cup_lit_mask >> 4)
                messages.append(f"lane change: rollovers={rotated:02x}")
            if inputs.tilt_pressed and not self.context.tilted:
                self.context.tilted = True
                self.context.outlane_save_pending = False
                self._start_song(self.config.tilt_song)
                messages.append("TILT: local reflex and flipper coils inhibited")

            if newly_closed_outlanes and not self.context.tilted and not self.context.ball_ending:
                points = newly_closed_outlanes.bit_count() * 1000
                self.context.player_scores[self.context.current_player - 1] += points
                now = self._clock()
                grace_available = (
                    not self.context.grace_save_used
                    and self.context.grace_started is not None
                    and 0 <= now - self.context.grace_started < GRACE_SECONDS
                )
                if grace_available or self.context.outlane_save_pending:
                    self.context.outlane_save_pending = True
                    self._start_song(self.config.outlane_save_song)
                    messages.append(f"outlane: +{points}; ball save armed until outhole")
                else:
                    self.context.ball_ending = True
                    self._start_song(self.config.outlane_song)
                    messages.append(f"outlane: +{points}; flippers/reflex inhibited")

            excluded = (1 << OUTHOLE_DMA_INDEX) | sum(1 << index for index in OUTLANE_DMA_INDICES)
            if self.context.outlane_save_pending and (
                newly_closed_playfield & ~excluded or inputs.reflex_events or inputs.rollover_events
            ):
                self.context.outlane_save_pending = False
                messages.append("outlane: pending save cancelled by another playfield hit")

            scoring_allowed = not self.context.tilted and not self.context.ball_ending
            if scoring_allowed:
                sound = self._score_reflex_events(inputs.reflex_events, messages)

            closed_inlanes = inputs.closed_inlane_mask
            newly_closed_inlanes = closed_inlanes & ~self.context.previous_inlane_mask
            self.context.previous_inlane_mask = closed_inlanes
            if newly_closed_inlanes and scoring_allowed:
                gained = newly_closed_inlanes.bit_count() * self.config.inlane_bonus_points
                self.context.bonus += gained
                sound = self.config.bonus_add_sound
                messages.append(f"bonus: +{gained} = {self.context.bonus}")

            if newly_closed_playfield & (1 << TEN_THOUSAND_BONUS_DMA_INDEX) and scoring_allowed:
                if self.context.extra_ball_qualified:
                    self._award_extra_ball("10,000 rollover", messages)
                else:
                    self.context.bonus += 10_000
                    sound = self.config.bonus_add_sound
                    messages.append(f"bonus: c16 +10000 = {self.context.bonus}")

            if scoring_allowed:
                matched_standups = self._standup_coincidence.update(standup_hits, bar_hit)
            else:
                self._standup_coincidence.clear()
                matched_standups = 0
            if matched_standups:
                standup_hits = matched_standups
                solid_hits = standup_hits & self.context.standup_solid_mask
                flashing_hits = standup_hits & self.context.standup_flashing_mask
                points = solid_hits.bit_count() * 1000 + flashing_hits.bit_count() * 5000
                bonus = flashing_hits.bit_count() * 5000
                self.context.player_scores[self.context.current_player - 1] += points
                self.context.bonus += bonus
                self.context.standup_solid_mask &= ~standup_hits
                self.context.standup_flashing_mask &= ~standup_hits
                sound = self.config.standup_sound
                if (
                    (solid_hits | flashing_hits)
                    and not (
                        self.context.standup_solid_mask
                        | self.context.standup_flashing_mask
                    )
                ):
                    self.context.standup_solid_mask = 0x1f
                    self.context.player_scores[
                        self.context.current_player - 1
                    ] += STANDUP_COMPLETE_POINTS
                    points += STANDUP_COMPLETE_POINTS
                    self.context.bonus_multiplier = min(
                        3, self.context.bonus_multiplier + 1
                    )
                    self.context.standups_completed_this_ball = True
                    self._maybe_qualify_extra_ball(messages)
                    self._start_song(self.config.standup_complete_song)
                    messages.append(
                        f"standups complete: +{STANDUP_COMPLETE_POINTS} points; "
                        f"bonus {self.context.bonus_multiplier}x; reset solid"
                    )
                elif flashing_hits:
                    self._start_song(self.config.standup_special_song)
                else:
                    # Give a normal target beep priority over an older song.
                    self._song = ()
                messages.append(f"standup: targets={standup_hits:02x}; +{points} points, +{bonus} bonus")

            closed_rollovers = inputs.closed_rollover_mask
            # The 8085 samples and latches brief rollover closures between
            # host frames. Keep the raw snapshot edge as a fallback for an
            # older ROM that still returns zero in the fourth trailer byte.
            newly_closed_rollovers = (
                inputs.rollover_events
                | (closed_rollovers & ~self.context.previous_rollover_mask)
            )
            self.context.previous_rollover_mask = closed_rollovers
            if newly_closed_rollovers and scoring_allowed:
                lit_hits = newly_closed_rollovers & self.context.rollover_lit_mask
                if lit_hits:
                    points = lit_hits.bit_count() * ROLLOVER_POINTS
                    self.context.player_scores[self.context.current_player - 1] += points
                    self.context.rollover_lit_mask &= ~lit_hits
                    messages.append(f"rollovers: +{points}; remaining={self.context.rollover_lit_mask:02x}")
                    sound = self.config.rollover_sound
                    if not self.context.rollover_lit_mask:
                        self.context.rollover_lit_mask = 0xff
                        self.context.bonus += ROLLOVER_COMPLETE_BONUS
                        self.lamps.play(ROLLOVER_COMPLETE_SEQUENCE)
                        messages.append(f"rollovers complete: +{ROLLOVER_COMPLETE_BONUS} bonus")
                        sound = self.config.rollover_complete_sound

            if not inputs.outhole_closed:
                self.context.ball_has_left_outhole = True

            # Timing is independent of the actions. Opening a contact resets
            # that contact's timer, including if it briefly bounces open.
            closed_holes = tuple(
                bool(inputs.closed_cup_mask & (1 << index))
                for index in range(OUTHOLE_CONTACT)
            ) + (inputs.outhole_closed and self.context.ball_has_left_outhole,)
            for hole in self._hole_timer.update(closed_holes, self._clock()):
                if hole == OUTHOLE_CONTACT:
                    cup_mask = 0
                    self.context.ball_in_play = False
                    now = self._clock()
                    outhole_started = self._hole_timer.started_at(OUTHOLE_CONTACT)
                    grace_save = (
                        not self.context.grace_save_used
                        and self.context.grace_started is not None
                        and outhole_started is not None
                        and (self.context.outlane_save_pending
                             or outhole_started - self.context.grace_started <= GRACE_SECONDS)
                    )
                    if (
                        not self.context.tilted
                        and self.context.player_scores[self.context.current_player - 1]
                        == self.context.score_at_ball_start
                    ):
                        self._launch_ball(new_numbered_ball=False)
                        self.context.same_player_again_started = now
                        launch = True
                        messages.append("same player again: zero-score ball saved; auto-launching coil 5")
                    elif not self.context.tilted and grace_save:
                        self.context.grace_save_used = True
                        self._launch_ball(new_numbered_ball=False)
                        # The one grace save has been spent. Do not advertise
                        # another save through the zero-score relaunch flash.
                        launch = True
                        messages.append("same player again: grace save used; auto-launching coil 5")
                    elif self.context.tilted:
                        self._song = ()
                        sound = self.config.end_ball_sound
                        messages.append("bonus: skipped after tilt")
                        self._finish_ball(messages)
                    else:
                        self._song = ()
                        sound = self.config.end_ball_sound
                        self._begin_bonus_payout(
                            self.context.bonus_multiplier,
                            return_to_play=False,
                            messages=messages,
                        )
                    break
                if hole == SIDE_BONUS_CUP and scoring_allowed:
                    if self.context.extra_ball_qualified:
                        self._award_extra_ball("side bonus cup", messages)
                    self._song = ()
                    self._start_song(self.config.side_bonus_hole_song)
                    messages.append(
                        f"side bonus cup: collecting {self.context.bonus} "
                        f"at {self.context.bonus_multiplier}x"
                    )
                    self._begin_bonus_payout(
                        self.context.bonus_multiplier,
                        return_to_play=True,
                        side_cup_prelude=True,
                        messages=messages,
                    )
                    break
                cup_mask |= 1 << hole
                if hole < 5 and scoring_allowed:
                    cup_bit = 1 << hole
                    if self.context.cup_lit_mask & cup_bit:
                        # Standups are fixed physical targets.  A lit cup only
                        # promotes the target currently beneath it when that
                        # target is still lit; lane change never rotates these
                        # masks with the cup lamps.
                        if self.context.standup_solid_mask & cup_bit:
                            self.context.standup_solid_mask &= ~cup_bit
                            self.context.standup_flashing_mask |= cup_bit
                        bonus_value = CUP_BONUS_VALUES[self.context.cup_tier]
                        regular_value = CUP_REGULAR_VALUES[self.context.cup_tier]
                        player_index = self.context.current_player - 1
                        self.context.bonus += bonus_value
                        self.context.player_scores[player_index] += regular_value
                        self.context.cup_lit_mask &= ~cup_bit
                        sound = self.config.cup_lit_sound
                        messages.append(
                            f"cup {hole + 1}: +{bonus_value} bonus, +{regular_value} points; "
                            f"remaining={self.context.cup_lit_mask:02x}"
                        )
                        if not self.context.cup_lit_mask:
                            self.context.cup_lit_mask = 0x1f
                            self.context.cups_completed_this_ball = True
                            self.lamps.play(CUP_COMPLETE_SEQUENCE)
                            self._maybe_qualify_extra_ball(messages)
                            if self.context.cup_tier < len(CUP_BONUS_VALUES) - 1:
                                self.context.cup_tier += 1
                            messages.append(
                                f"cups complete: next value {CUP_BONUS_VALUES[self.context.cup_tier]}"
                            )
                            sound = self.config.cups_complete_sound
                    else:
                        self.context.player_scores[self.context.current_player - 1] += 100
                        sound = self.config.cup_unlit_sound
                        messages.append(f"cup {hole + 1}: unlit, +100 points")
                messages.append(f"cup eject requested: {hole + 1}")

        elif self.context.state is GameState.BONUS_PROCESSING:
            payout_sound, payout_cups = self._advance_bonus_payout(messages)
            if payout_sound is not None:
                sound = payout_sound
            cup_mask |= payout_cups

        elif self.context.state is GameState.HIGH_SCORE:
            if inputs.start_pressed:
                self._start_game()
                messages.append(self._state_message())
            else:
                self._advance_high_score_tributes()
                if not self._high_score_tributes and self._tribute_player is None:
                    self._enter_state(GameState.MATCH_SEQUENCE)
                    messages.append(self._state_message())

        elif self.context.state is GameState.MATCH_SEQUENCE:
            if inputs.start_pressed:
                # Settle the completed game's high scores and awards before
                # _start_game clears its scores. Match is forfeited, but the
                # high-score bookkeeping is never forfeited with pageantry.
                self._record_completed_game()
                self._start_game()
                messages.append("match: skipped; high scores settled for new game")
                messages.append(self._state_message())
            elif (now := self._clock()) >= self.context.next_match_time:
                if self.context.match_step >= MATCH_SEQUENCE_STEPS:
                    matching_players = [
                        player
                        for player, score in enumerate(
                            self.context.player_scores[:self.context.players_in_game], start=1
                        )
                        if score % 10 == self.context.match_digit
                    ]
                    if matching_players:
                        for player in matching_players:
                            self._add_credit(f"match player {player}", messages)
                        messages.append(
                            "match: digit "
                            f"{self.context.match_digit} matches player(s) "
                            + ",".join(map(str, matching_players))
                        )
                        self._start_song(self.config.match_win_song)
                    self._matched_players = set(matching_players)
                    self._record_completed_game()
                    self.context.ball_number = 0
                    self.context.ball_in_play = False
                    self.context.last_match_digit = self.context.match_digit
                    self._enter_state(GameState.GAME_OVER)
                    messages.append(self._state_message())
                else:
                    previous_digit = (
                        self.context.match_digit if self.context.match_step else None
                    )
                    digit = self._random.randrange(10)
                    while digit == previous_digit:
                        digit = self._random.randrange(10)
                    self.context.match_digit = digit
                    sound = self.config.match_sound
                    rate = self._match_rate(self.context.match_step)
                    self.context.match_step += 1
                    self.context.next_match_time = now + 1.0 / rate
                    messages.append(
                        f"match: {self.context.match_digit} ({rate:.2f} digits/s)"
                    )

        song_sound = self._advance_song(self._clock())
        if song_sound is not None:
            sound = song_sound
        if self.muted:
            if self._mute_feedback_active:
                # The mute confirmation is the only song allowed to finish
                # after mute becomes active. Ignore unrelated direct tones.
                sound = song_sound
            elif sound != Tone(0, SoundMode.SILENCE):
                sound = None
        now = self._clock()
        if sound is not None:
            self._sound_until = (
                (self._next_song_time if song_sound is not None else now + 0.14)
                if sound.mode is not SoundMode.SILENCE else None
            )
        elif self._sound_until is not None and now >= self._sound_until:
            sound = Tone(0, SoundMode.SILENCE)
            self._sound_until = None
        return StepResult(
            self._render_output(cup_mask=cup_mask, launch=launch, sound=sound),
            tuple(messages),
        )

    def _add_credit(self, source: str, messages: list[str]) -> None:
        previous = self.context.credits
        self.context.credits = min(99, previous + 1)
        if self.context.credits != previous:
            messages.append(f"credit ({source}): {self.context.credits}")
        else:
            messages.append(f"credit ({source}): already at 99")
        self._save_nvram()

    def _maybe_qualify_extra_ball(self, messages: list[str]) -> None:
        if (
            self.context.cups_completed_this_ball
            and self.context.standups_completed_this_ball
            and not self.context.extra_ball_awarded_this_ball
            and not self.context.extra_ball_qualified
        ):
            self.context.extra_ball_qualified = True
            messages.append("extra ball: qualified at rollover and side cup")

    def _award_extra_ball(self, source: str, messages: list[str]) -> None:
        if not self.context.extra_ball_qualified:
            return
        self.context.extra_ball_qualified = False
        self.context.extra_ball_awarded_this_ball = True
        self.context.extra_ball_pending = True
        messages.append(f"extra ball: awarded by {source}")

    def _reset_extra_ball_ball_state(self) -> None:
        self.context.cups_completed_this_ball = False
        self.context.standups_completed_this_ball = False
        self.context.extra_ball_qualified = False
        self.context.extra_ball_awarded_this_ball = False

    def _stop_side_bonus_lamp_effects(self) -> None:
        if self._side_bonus_lamps is not None:
            self._side_bonus_lamps.cancel()
            self._side_bonus_lamps = None
        if self._bonus_flash_lamp is not None:
            self.lamps.relinquish(self._bonus_flash_lamp)
            self._bonus_flash_lamp = None

    def _begin_bonus_payout(
        self,
        multiplier: int,
        *,
        return_to_play: bool,
        side_cup_prelude: bool = False,
        messages: list[str],
    ) -> None:
        """Start the shared outhole/side-cup bonus-counting sequence."""
        self._stop_side_bonus_lamp_effects()
        self.context.bonus_payout_multiplier = max(1, min(3, multiplier))
        self.context.bonus_payout_base = self.context.bonus
        self.context.bonus_returns_to_play = return_to_play
        self._enter_state(GameState.BONUS_PROCESSING)
        now = self._clock()
        if side_cup_prelude:
            self._side_bonus_lamps = self.lamps.play(SIDE_BONUS_LAMP_SEQUENCE)
            self.context.bonus_payout_phase = BonusPayoutPhase.SIDE_CUP_LAMP_SHOW
            self.context.next_bonus_time = now
        elif self.context.bonus:
            self.context.bonus_payout_phase = BonusPayoutPhase.WAIT_TO_START
            self.context.next_bonus_time = now + self.config.bonus_entry_pause_seconds
        else:
            self.context.bonus_payout_phase = BonusPayoutPhase.COUNTING
            self.context.next_bonus_time = now
        messages.append(self._state_message())

    def _advance_bonus_payout(
        self, messages: list[str]
    ) -> tuple[Tone | None, int]:
        """Advance one payout tick and perform the source-specific exit."""
        sound: Tone | None = None
        cup_mask = 0
        now = self._clock()
        phase = self.context.bonus_payout_phase
        if phase is BonusPayoutPhase.SIDE_CUP_LAMP_SHOW:
            if (
                self._side_bonus_lamps is not None
                and not self._side_bonus_lamps.finished
            ):
                return sound, cup_mask
            self._side_bonus_lamps = None
            if self.context.bonus_payout_multiplier == 2:
                self._bonus_flash_lamp = DOUBLE_BONUS_LAMP
            elif self.context.bonus_payout_multiplier >= 3:
                self._bonus_flash_lamp = TRIPLE_BONUS_LAMP
            if self._bonus_flash_lamp is not None:
                self.lamps.flash(self._bonus_flash_lamp)
            phase = (
                BonusPayoutPhase.WAIT_TO_START
                if self.context.bonus
                else BonusPayoutPhase.COUNTING
            )
            self.context.bonus_payout_phase = phase
            self.context.next_bonus_time = now
        if (
            phase is BonusPayoutPhase.WAIT_TO_START
            and now >= self.context.next_bonus_time
        ):
            if self.context.bonus_payout_multiplier >= 2:
                self.context.bonus = self.context.bonus_payout_base * 2
                self._start_song(self.config.bonus_2x_song)
                messages.append(f"bonus: showing 2x = {self.context.bonus}")
                self.context.bonus_payout_phase = (
                    BonusPayoutPhase.WAIT_FOR_TRIPLE
                    if self.context.bonus_payout_multiplier >= 3
                    else BonusPayoutPhase.WAIT_TO_COUNT
                )
                self.context.next_bonus_time = (
                    now + self.config.bonus_multiplier_pause_seconds
                )
            else:
                self.context.bonus_payout_phase = BonusPayoutPhase.COUNTING
                self.context.next_bonus_time = now
        elif (
            phase is BonusPayoutPhase.WAIT_FOR_TRIPLE
            and now >= self.context.next_bonus_time
        ):
            # Always multiply the saved original, never the displayed 2x
            # intermediate value.
            self.context.bonus = (
                self.context.bonus_payout_base * 3
            )
            self._start_song(self.config.bonus_3x_song)
            messages.append(f"bonus: showing 3x = {self.context.bonus}")
            self.context.bonus_payout_phase = BonusPayoutPhase.WAIT_TO_COUNT
            self.context.next_bonus_time = (
                now + self.config.bonus_multiplier_pause_seconds
            )
        elif (
            phase is BonusPayoutPhase.WAIT_TO_COUNT
            and now >= self.context.next_bonus_time
        ):
            self.context.bonus_payout_phase = BonusPayoutPhase.COUNTING
            self.context.next_bonus_time = now

        if (
            self.context.bonus_payout_phase is BonusPayoutPhase.COUNTING
            and self.context.bonus
            and now >= self.context.next_bonus_time
        ):
            payout = min(1000, self.context.bonus)
            self.context.bonus -= payout
            player_index = self.context.current_player - 1
            self.context.player_scores[player_index] += payout
            sound = self.config.bonus_payout_sound
            self.context.next_bonus_time = now + self.config.bonus_tick_seconds
            messages.append(
                f"bonus payout: player {self.context.current_player} +{payout}; "
                f"remaining {self.context.bonus}"
            )

        if not self.context.bonus:
            if self.context.bonus_completed_at is None:
                self.context.bonus_completed_at = now
            if (
                now - self.context.bonus_completed_at
                >= self.config.bonus_pause_seconds
            ):
                self._stop_side_bonus_lamp_effects()
                if self.context.bonus_returns_to_play:
                    self.context.bonus_returns_to_play = False
                    self.context.bonus_completed_at = None
                    self._enter_state(GameState.GAME_PLAYING)
                    cup_mask = 1 << SIDE_BONUS_CUP
                    messages.append("side bonus cup: payout complete; ejecting")
                    messages.append(self._state_message())
                else:
                    self._finish_ball(messages)
        return sound, cup_mask

    def _handle_credit_button(
        self,
        *,
        event: bool,
        held: bool,
        messages: list[str],
    ) -> None:
        """Distinguish a short credit press from a long mute gesture.

        The motherboard fans the physical switch into two software-visible
        paths, just as it does for the flippers: Port 0 bit $04 provides the
        interrupt event that catches a tap, while Port 4 bit $10 is the held
        level used by the stock ROM's polling path.
        """
        now = self._clock()
        if event or held:
            if self._credit_press_started is None:
                self._credit_press_started = now
            self._credit_long_handled = False
            if (
                held
                and
                not self._credit_long_handled
                and now - self._credit_press_started
                >= self.config.credit_long_press_seconds
            ):
                self._credit_long_handled = True
                self.muted = not self.muted
                self._save_nvram()
                if self.muted:
                    self._start_song(
                        self.config.mute_on_song, audible_while_muted=True
                    )
                    messages.append("sound: muted")
                else:
                    self._start_song(self.config.mute_off_song)
                    messages.append("sound: unmuted")
            return

        if self._credit_press_started is None:
            return

        if not self._credit_long_handled:
            self._add_credit("button", messages)
            self._start_song(self.config.add_credit_song)
        self._credit_press_started = None
        self._credit_long_handled = False

    def _load_nvram(self) -> None:
        if self.nvram_path is None or not self.nvram_path.exists():
            return
        try:
            data = json.loads(self.nvram_path.read_text())
            self.context.credits = max(0, min(99, int(data.get("credits", 0))))
            self.muted = data.get("muted", False) is True
            scores = data.get("high_scores")
            if isinstance(scores, list) and any(scores):
                loaded = [max(0, int(score)) for score in scores[:6]]
                loaded.extend(self.config.default_high_scores[len(loaded):])
                self.high_scores = sorted(loaded, reverse=True)
            games = data.get("recent_games", [])
            if isinstance(games, list):
                self.recent_games = [max(0, int(score)) for score in games[-20:]]
        except (OSError, ValueError, TypeError, json.JSONDecodeError):
            # A corrupt NVRAM file should not prevent the game from booting.
            self.context.credits = 0
            self.muted = False
            self.high_scores = list(self.config.default_high_scores)
            self.recent_games = []

    def _save_nvram(self) -> None:
        if self.nvram_path is None:
            return
        data = {
            "credits": self.context.credits,
            "muted": self.muted,
            "high_scores": self.high_scores,
            "recent_games": self.recent_games[-20:],
        }
        temporary = self.nvram_path.with_suffix(self.nvram_path.suffix + ".tmp")
        try:
            temporary.write_text(json.dumps(data, indent=2) + "\n")
            os.replace(temporary, self.nvram_path)
        except OSError:
            try:
                temporary.unlink()
            except OSError:
                pass

    def _record_completed_game(self) -> None:
        if self._completed_game_recorded:
            return
        self._completed_game_recorded = True
        scores = self.context.player_scores[:self.context.players_in_game]
        final_score = max(scores, default=0)
        self.recent_games.append(final_score)
        self.recent_games = self.recent_games[-20:]
        cutoff = self.high_scores[-1]
        self._high_score_tributes = [player for player, score in enumerate(scores, 1)
                                     if score > cutoff]
        for player in self._high_score_tributes:
            self.context.credits = min(99, self.context.credits + 1)
        ranked = sorted([(score, False) for score in self.high_scores]
                        + [(score, True) for score in scores],
                        key=lambda entry: entry[0], reverse=True)[:6]
        self.high_scores = [score for score, _ in ranked]
        self._new_high_score_ranks = {rank for rank, (_, new) in enumerate(ranked) if new}
        self._save_nvram()

    def reset_high_scores(self) -> None:
        self.high_scores = list(self.config.default_high_scores)
        self._new_high_score_ranks.clear()
        self._save_nvram()

    def _advance_high_score_tributes(self) -> None:
        now = self._clock()
        if self._tribute_player is not None and now < self._tribute_until:
            return
        if self._high_score_tributes:
            self._tribute_player = self._high_score_tributes.pop(0)
            self._start_song(self.config.high_score_song)
            self._tribute_until = now + sum(n.interval_seconds for n in self.config.high_score_song) + 0.5
        elif self._tribute_player is not None:
            self._tribute_player = None
            self._attract_started = now

    def _start_song(
        self,
        song: tuple[SongNote, ...],
        *,
        audible_while_muted: bool = False,
    ) -> None:
        if self.muted and not audible_while_muted:
            return
        self._song = song
        self._song_index = 0
        self._next_song_time = self._clock()
        self._mute_feedback_active = audible_while_muted and bool(song)

    def _advance_song(self, now: float) -> Tone | None:
        if not self._song or now < self._next_song_time:
            return None
        if self._song_index >= len(self._song):
            self._song = ()
            self._mute_feedback_active = False
            return Tone(0, SoundMode.SILENCE)
        note = self._song[self._song_index]
        self._song_index += 1
        self._next_song_time = now + note.interval_seconds
        return note.tone

    def _score_reflex_events(self, events: int, messages: list[str]) -> Tone | None:
        events &= 0x3f
        if not events:
            return None

        points = sum(
            self.config.reflex_points[bit]
            for bit in range(6)
            if events & (1 << bit)
        )
        player_index = self.context.current_player - 1
        self.context.player_scores[player_index] += points
        names = ",".join(
            REFLEX_EVENT_NAMES[bit] for bit in range(6) if events & (1 << bit)
        )
        messages.append(
            f"score: player {self.context.current_player} +{points} "
            f"({names}) = {self.context.player_scores[player_index]}"
        )
        # The interrupt latch can accumulate simultaneous events. Score all of
        # them, and use the stock tone belonging to the lowest numbered event.
        sound_bit = next(bit for bit in range(6) if events & (1 << bit))
        return self.config.reflex_sounds[sound_bit]

    @staticmethod
    def _match_rate(step: int) -> float:
        if MATCH_SEQUENCE_STEPS <= 1:
            return MATCH_END_RATE_HZ
        progress = step / (MATCH_SEQUENCE_STEPS - 1)
        return MATCH_START_RATE_HZ + progress * (
            MATCH_END_RATE_HZ - MATCH_START_RATE_HZ
        )

    def _add_player(self) -> None:
        """Common entry action for player 1 and each later participant."""
        self.context.players_in_game += 1
        self.context.credits = max(0, self.context.credits - 1)
        self._save_nvram()
        self._start_song(self.config.start_song)

    def _start_game(self) -> None:
        self._stop_side_bonus_lamp_effects()
        self.lamps.cancel_all()
        self._attract_lamp_handle = None
        self._matched_players.clear()
        self._completed_game_recorded = False
        self._high_score_tributes.clear()
        self._tribute_player = None
        self.context.players_in_game = 0
        self._add_player()
        self._hole_timer.clear()
        self._enter_state(GameState.WAITING_FOR_LAUNCH)
        self.context.current_player = 1
        self.context.ball_number = 1
        self.context.ball_in_play = False
        self.context.tilted = False
        self.context.bonus = 0
        self.context.bonus_multiplier = 1
        self.context.bonus_payout_multiplier = 1
        self.context.bonus_payout_base = 0
        self.context.bonus_payout_phase = BonusPayoutPhase.COUNTING
        self.context.bonus_returns_to_play = False
        self.context.player_scores[:] = [0, 0, 0, 0]
        self.context.score_at_ball_start = 0
        self.context.same_player_again_started = None
        self.context.grace_started = None
        self.context.grace_save_used = False
        self.context.outlane_save_pending = False
        self.context.ball_ending = False
        self.context.ball_has_left_outhole = False
        self.context.previous_inlane_mask = 0
        self.context.previous_rollover_mask = 0
        self.context.previous_left_flipper = False
        self.context.previous_right_flipper = False
        self.context.rollover_lit_mask = 0xff
        self.context.cup_lit_mask = 0x1f
        self.context.cup_tier = 0
        self._reset_extra_ball_ball_state()
        self.context.extra_ball_pending = False
        self.context.last_match_digit = None
        self.context.match_digit = 0
        self.context.match_step = 0
        self.context.bonus_completed_at = None

    def _launch_ball(self, *, new_numbered_ball: bool) -> None:
        self._standup_coincidence.clear()
        self.context.outlane_save_pending = False
        self.context.ball_ending = False
        self._start_song(self.config.launch_song)
        self._enter_state(GameState.GAME_PLAYING)
        self.context.previous_right_flipper = False
        self.context.previous_left_flipper = False
        self.context.ball_in_play = True
        self.context.ball_has_left_outhole = False
        self.context.same_player_again_started = None
        self.context.grace_started = self._clock()
        if new_numbered_ball:
            self.context.score_at_ball_start = self.context.player_scores[self.context.current_player - 1]
        # Leaving WAITING_FOR_LAUNCH cancels the repeating ready animation.
        # Every launch, manual or automatic, then gets one final clean pass.
        self.lamps.play(AUTO_RELAUNCH_SEQUENCE)
        self._hole_timer.clear()

    def _finish_ball(self, messages: list[str]) -> None:
        self._stop_side_bonus_lamp_effects()
        replay_current_ball = self.context.extra_ball_pending
        self.context.outlane_save_pending = False
        self.context.ball_ending = False
        self.context.bonus = 0
        self.context.bonus_multiplier = 1
        self.context.bonus_payout_multiplier = 1
        self.context.bonus_payout_base = 0
        self.context.bonus_payout_phase = BonusPayoutPhase.COUNTING
        self.context.bonus_returns_to_play = False
        self.context.tilted = False
        self.context.ball_has_left_outhole = False
        self._hole_timer.clear()
        self.context.previous_inlane_mask = 0
        self.context.previous_rollover_mask = 0
        self.context.grace_save_used = False
        self.context.extra_ball_pending = False
        self._reset_extra_ball_ball_state()
        if replay_current_ball:
            self._enter_state(GameState.WAITING_FOR_LAUNCH)
            messages.append(
                f"extra ball: player {self.context.current_player} shoots again"
            )
            return
        if self.context.current_player < self.context.players_in_game:
            self.context.current_player += 1
            self._enter_state(GameState.WAITING_FOR_LAUNCH)
        elif self.context.ball_number < self.config.balls_per_game:
            self.context.current_player = 1
            self.context.ball_number += 1
            self._enter_state(GameState.WAITING_FOR_LAUNCH)
        else:
            self._record_completed_game()
            if self._high_score_tributes:
                self._enter_state(GameState.HIGH_SCORE)
                self._advance_high_score_tributes()
            else:
                self._enter_state(GameState.MATCH_SEQUENCE)
        messages.append(self._state_message())

    def _enter_state(self, state: GameState) -> None:
        if state is GameState.WAITING_FOR_LAUNCH:
            self._ball_ready_lamps = self.lamps.play(BALL_READY_SEQUENCE)
        elif self._ball_ready_lamps is not None:
            self._ball_ready_lamps.cancel()
            self._ball_ready_lamps = None
        self.context.state = state
        if state is GameState.GAME_OVER:
            self._attract_started = self._clock()
            self._reset_attract_lamps()
        if state is not GameState.GAME_PLAYING:
            self._standup_coincidence.clear()
        if state is GameState.WAITING_FOR_LAUNCH:
            self.context.standup_solid_mask = 0x1f
            self.context.standup_flashing_mask = 0
        if state is not GameState.GAME_PLAYING:
            self.context.same_player_again_started = None
            self.context.grace_started = None
        if state is GameState.BONUS_PROCESSING:
            self.context.next_bonus_time = self._clock() + self.config.bonus_tick_seconds
            self.context.bonus_completed_at = self._clock() if not self.context.bonus else None
        if state is GameState.MATCH_SEQUENCE:
            self.context.match_step = 0
            self.context.match_digit = 0
            self.context.next_match_time = self._clock()

    def _state_message(self) -> str:
        return f"state: {self.context.state.value}"

    def _reset_attract_lamps(self) -> None:
        if self._attract_lamp_handle is not None:
            self._attract_lamp_handle.cancel()
        self._attract_lamp_handle = None
        self._attract_lamp_phase = "hold"
        self._attract_lamp_deadline = (
            self._clock() + ATTRACT_PLAYFIELD_HOLD_SECONDS
        )
        self._attract_animation_index = 0

    def _advance_attract_lamps(self, now: float) -> None:
        if self.context.state is not GameState.GAME_OVER:
            return
        if now < self._attract_lamp_deadline:
            return
        if self._attract_lamp_phase == "hold":
            sequence = ATTRACT_LAMP_ANIMATIONS[self._attract_animation_index]
            self._attract_animation_index = (
                self._attract_animation_index + 1
            ) % len(ATTRACT_LAMP_ANIMATIONS)
            self._attract_lamp_handle = self.lamps.play(sequence)
            passes = 1 if sequence.repeat is None else sequence.repeat
            assert isinstance(passes, int)
            duration = sum(step.duration for step in sequence.steps) * passes
            self._attract_lamp_phase = "animation"
            self._attract_lamp_deadline = now + duration
        else:
            if self._attract_lamp_handle is not None:
                self._attract_lamp_handle.cancel()
            self._attract_lamp_handle = None
            self._attract_lamp_phase = "hold"
            self._attract_lamp_deadline = now + ATTRACT_PLAYFIELD_HOLD_SECONDS

    def _render_output(
        self,
        *,
        cup_mask: int = 0,
        launch: bool = False,
        sound: Tone | None = None,
    ) -> OutputFrame:
        display = DisplayFrame()
        for player, score in enumerate(self.context.player_scores, start=1):
            if player <= self.context.players_in_game:
                display.set_player_score(player, score_digits(score))
        if self.context.state in (GameState.GAME_OVER, GameState.HIGH_SCORE):
            now = self._clock()
            if self._tribute_player is not None:
                if int(now * 4) % 2:
                    display.set_player_score(self._tribute_player, "ffffff")
            elif self.context.state is GameState.GAME_OVER and not self._high_score_tributes:
                page_seconds = ATTRACT_HOLD_SECONDS + ATTRACT_TRANSITION_SECONDS
                phase = (now - self._attract_started) % (2 * page_seconds)
                if phase < ATTRACT_HOLD_SECONDS:
                    if int(now * 4) % 2:
                        for player in self._matched_players:
                            digits = score_digits(self.context.player_scores[player - 1])
                            display.set_player_score(player, digits[:-1] + "f")
                elif phase < page_seconds or phase >= page_seconds + ATTRACT_HOLD_SECONDS:
                    for player in range(1, 5):
                        display.set_player_score(player, self._display_random.randrange(1 << 24))
                    for team in (1, 2):
                        display.set_team_score(team, f'f{self._display_random.randrange(1 << 24):06x}')
                else:
                    for rank, score in enumerate(self.high_scores[:4], 1):
                        value = "ffffff" if rank - 1 in self._new_high_score_ranks and int(now * 4) % 2 else score_digits(score)
                        display.set_player_score(rank, value)
                    for team, score in enumerate(self.high_scores[4:], 1):
                        value = "fffffff" if team + 3 in self._new_high_score_ranks and int(now * 4) % 2 else score_digits(score, 7)
                        display.set_team_score(team, value)
        display.set_bonus(score_digits(self.context.bonus))
        display.set_credits(score_digits(self.context.credits, 2))
        display.set_ball_in_play(self.context.ball_number)
        if self.context.state is GameState.MATCH_SEQUENCE:
            digits = list("ffffff")
            position = MATCH_DIGIT_POSITIONS[max(0, self.context.match_step - 1) % 6]
            digits[position] = str(self.context.match_digit)
            display.set_spread("".join(digits))
        elif self.context.state is GameState.GAME_OVER and self.context.last_match_digit is not None:
            digits = list("ffffff")
            digits[MATCH_DIGIT_POSITIONS[-1]] = str(self.context.last_match_digit)
            display.set_spread("".join(digits))
        now = self._clock()
        self._advance_attract_lamps(now)
        game_over_flash = (
            self.context.state is GameState.GAME_OVER
            and int(now * GAME_OVER_FLASH_HZ * 2) % 2 == 0
        )
        display.set_game_over_led(game_over_flash)
        display.set_pay_bartender_led(game_over_flash and self.context.credits == 0)
        display.set_tilt_led(
            self.context.tilted
            and int(now * TILT_FLASH_HZ * 2) % 2 == 0
        )
        flash_on = False
        grace_active = (
            self.context.grace_started is not None
            and not self.context.grace_save_used
            and (self.context.outlane_save_pending
                 or 0 <= now - self.context.grace_started < GRACE_SECONDS - GRACE_FLASH_EARLY_OFF_SECONDS)
        )
        saved_ball_flash = (
            self.context.same_player_again_started is not None
            and 0 <= now - self.context.same_player_again_started < SAME_PLAYER_AGAIN_SECONDS
        )
        if grace_active or saved_ball_flash:
            phase_start = (
                self.context.grace_started
                if grace_active else self.context.same_player_again_started
            )
            assert phase_start is not None
            flash_on = int((now - phase_start) * SAME_PLAYER_AGAIN_FLASH_HZ * 2) % 2 == 0
        lamp_bitmap = bytearray(5)
        for bit, lamp in enumerate(ROLLOVER_LAMPS):
            if self.context.rollover_lit_mask & (1 << bit):
                lamp_bitmap[lamp // 8] |= 1 << (lamp % 8)
        for bit, lamp in enumerate(CUP_LAMPS):
            if self.context.cup_lit_mask & (1 << bit):
                lamp_bitmap[lamp // 8] |= 1 << (lamp % 8)
        for bit, lamp in enumerate(CUP_TARGET_LAMPS):
            solid = self.context.standup_solid_mask & (1 << bit)
            flashing = self.context.standup_flashing_mask & (1 << bit)
            if solid or (flashing and int(now * STANDUP_FLASH_HZ * 2) % 2 == 0):
                lamp_bitmap[lamp // 8] |= 1 << (lamp % 8)
        if self.context.cup_tier < len(CUP_TIER_LAMPS):
            lamp = CUP_TIER_LAMPS[self.context.cup_tier]
            lamp_bitmap[lamp // 8] |= 1 << (lamp % 8)
        if self.context.bonus > 0:
            lamp_bitmap[COLLECT_BONUS_LAMP // 8] |= 1 << (
                COLLECT_BONUS_LAMP % 8
            )
        if self.context.bonus_multiplier == 2:
            lamp_bitmap[DOUBLE_BONUS_LAMP // 8] |= 1 << (
                DOUBLE_BONUS_LAMP % 8
            )
        elif self.context.bonus_multiplier >= 3:
            lamp_bitmap[TRIPLE_BONUS_LAMP // 8] |= 1 << (
                TRIPLE_BONUS_LAMP % 8
            )
        if self.context.extra_ball_qualified:
            for lamp in (EXTRA_BALL_ROLLOVER_LAMP, EXTRA_BALL_SIDE_CUP_LAMP):
                lamp_bitmap[lamp // 8] |= 1 << (lamp % 8)
        if flash_on:
            lamp_bitmap[SAME_PLAYER_AGAIN_LAMP // 8] |= 1 << (SAME_PLAYER_AGAIN_LAMP % 8)
        same_player_on = flash_on or self.context.extra_ball_pending
        if self.context.extra_ball_pending:
            lamp_bitmap[SAME_PLAYER_AGAIN_LAMP // 8] |= 1 << (
                SAME_PLAYER_AGAIN_LAMP % 8
            )
        display.set_same_player_again_led(same_player_on)
        if self.context.state not in (GameState.GAME_OVER, GameState.MATCH_SEQUENCE, GameState.HIGH_SCORE):
            player_led_on = True
            if self.context.state is GameState.WAITING_FOR_LAUNCH:
                player_led_on = int(now * WAITING_PLAYER_FLASH_HZ * 2) % 2 == 0
            display.set_player_led(self.context.current_player, player_led_on)

        host_coils_allowed = (
            self.context.state
            in (
                GameState.GAME_OVER,
                GameState.WAITING_FOR_LAUNCH,
                GameState.GAME_PLAYING,
                GameState.BONUS_PROCESSING,
            )
        )
        # The right-flipper contact is reported to the host even while the local
        # flipper reflex is inhibited.  In WAITING_FOR_LAUNCH this prevents the
        # launch gesture from also flipping the right flipper.  The separately
        # commanded launcher coil remains allowed.
        reflexes_allowed = (
            self.context.state is GameState.GAME_PLAYING
            and not self.context.tilted
            and not self.context.ball_ending
            and not launch
        )
        return OutputFrame(
            display=display,
            reflex_enabled=reflexes_allowed,
            cup_mask=cup_mask if host_coils_allowed else 0,
            launch=launch if host_coils_allowed else False,
            lamp=SAME_PLAYER_AGAIN_LAMP if flash_on else 0xff,
            lamp_bitmap=self.lamps.render(lamp_bitmap, now=now),
            # ff/00 is no-op; 00/00 explicitly silences (rests/end/cleanup).
            tone_pitch=sound.pitch if sound else 0xff,
            tone_duration=int(sound.mode) if sound else 0,
        )


def synchronize_aperture(serial: SerialLines) -> int:
    """Advance past a stale Pico sequence after an 8085-only reset.

    The 8085 adopts the Pico's current host sequence as its boot baseline and
    waits for a *different* value.  Waiting for host==ack before publishing can
    therefore deadlock forever.  Publishing a new all-off command is safe:
    the Pico explicitly permits replacing an unacknowledged mailbox.
    """
    payload = build_control_payload(
        lamp=0xff,
        reflex_enabled=False,
        cup_mask=0,
        launch=False,
        tone_pitch=0,
        tone_duration=0,
    )
    last_error: Exception | None = None
    for _ in range(3):
        try:
            drain_received(serial)
            sequence, _, _ = send_and_verify(serial, payload)
            state = parse_state(serial.command("state"))
            if state != (sequence, sequence):
                raise RuntimeError(
                    f"safe frame {sequence:02x} replied but semaphore is "
                    f"host={state[0]:02x} ack={state[1]:02x}"
                )
            return sequence
        except (ConnectionError, OSError, ResponseMismatch, RuntimeError, TimeoutError) as error:
            last_error = error
    raise TimeoutError(f"safe aperture resynchronization failed: {last_error}")


def safe_cleanup(serial: SerialLines) -> None:
    """Best effort: silence sound and inhibit every locally controlled coil."""
    try:
        synchronize_aperture(serial)
    except (ConnectionError, OSError, RuntimeError, TimeoutError) as error:
        print(f"warning: final safe-output frame was not acknowledged: {error}")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("device", nargs="?", help="CDC device; otherwise auto-detected")
    parser.add_argument(
        "--reset",
        action="store_true",
        help="pulse 8085 reset through the ROMulator before starting",
    )
    parser.add_argument(
        "--config",
        type=Path,
        default=DEFAULT_CONFIG_PATH,
        help=f"game configuration (default: {DEFAULT_CONFIG_PATH})",
    )
    parser.add_argument(
        "--nvram",
        type=Path,
        default=Path(__file__).with_name("micropin_game.nvram.json"),
        help="persistent credits/high-score file",
    )
    parser.add_argument("--dwell", type=float, default=0.01, help="seconds between frames")
    parser.add_argument("--timeout", type=float, default=5.0)
    args = parser.parse_args()
    if args.dwell < 0:
        parser.error("--dwell cannot be negative")

    device = find_device(args.device)
    game = MicropinGame(load_game_config(args.config), nvram_path=args.nvram)
    stop_requested = False

    def request_stop(_signum: int, _frame: object) -> None:
        nonlocal stop_requested
        stop_requested = True

    previous_sigint = signal.signal(signal.SIGINT, request_stop)
    print(f"device: {device}")
    print(f"state: {game.context.state.value}")

    with SerialLines(device, args.timeout) as serial:
        if args.reset:
            reset_reply = serial.command("reset")
            if reset_reply != "reset ok":
                raise RuntimeError(f"unexpected reset response: {reset_reply!r}")
            # The Pico replied after releasing RESET, but the 8085 still needs
            # a moment to initialize RAM and adopt the current mailbox value.
            time.sleep(0.05)
        mode = serial.command("status")
        if mode not in ("mode aperture", "mode aperture-only"):
            raise RuntimeError(f"ROMulator is not in aperture mode: {mode!r}")
        synchronized_sequence = synchronize_aperture(serial)
        print(f"aperture synchronized at sequence {synchronized_sequence:02x}")
        output = game.initial_output()
        try:
            while not stop_requested:
                _sequence, ports, dma = send_and_verify(serial, output.to_payload())
                result = game.step(HardwareSnapshot.from_wire(ports, dma))
                for message in result.messages:
                    print(message)
                output = result.output
                time.sleep(args.dwell)
        finally:
            safe_cleanup(serial)
            signal.signal(signal.SIGINT, previous_sigint)

    print("stopped; coils inhibited and sound silenced")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (ConnectionError, OSError, RuntimeError, TimeoutError, ValueError) as error:
        print(f"FAIL: {error}")
        raise SystemExit(1)
