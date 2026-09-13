#!/usr/bin/env python3
"""Minimal host-side Micropin game built on the ROMulator aperture."""

from __future__ import annotations

import argparse
from dataclasses import dataclass, field
from enum import Enum
from pathlib import Path
import random
import signal
import time
import tomllib
from collections.abc import Callable

from aperture_stress import SerialLines, drain_received, find_device, parse_state
from micropin_protocol import DisplayFrame, build_control_payload
from random_lamp_test import ResponseMismatch, send_and_verify


START_MASK = 0x40
RIGHT_FLIPPER_MASK = 0x10
LEFT_FLIPPER_MASK = 0x20
CREDIT_MASK = 0x04
TILT_MASK = 0x88
OUTHOLE_DMA_INDEX = 24

# The six physical cup contacts, in host-command bit order.
CUP_DMA_INDICES = (29, 27, 25, 20, 18, 14)
OUTHOLE_CONTACT = len(CUP_DMA_INDICES)

# R-K and Q-A are physical DMA contacts 1 and 32, hence byte indices 0 and 31
# in the $23e0-$23ff switch snapshot. A clear $10 bit means the contact is shut.
INLANE_DMA_INDICES = (0, 31)
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
MATCH_SEQUENCE_STEPS = 12
MATCH_START_RATE_HZ = 5.0
MATCH_END_RATE_HZ = 0.7
SAME_PLAYER_AGAIN_SECONDS = 2.0
SAME_PLAYER_AGAIN_FLASH_HZ = 4.0
SAME_PLAYER_AGAIN_LAMP = 6
GRACE_SECONDS = 4.0
DEFAULT_CONFIG_PATH = Path(__file__).with_name("micropin_game.toml")

REFLEX_EVENT_NAMES = (
    "lower_left_bumper",
    "upper_left_bumper",
    "middle_rollover_bumper",
    "lower_right_bumper",
    "right_sling",
    "left_sling",
)


@dataclass(frozen=True)
class Tone:
    pitch: int
    duration: int


@dataclass(frozen=True)
class SongNote:
    tone: Tone
    interval_seconds: float


DEFAULT_MATCH_WIN_SONG = tuple(
    SongNote(Tone(pitch, 0x04), 0.14)
    for pitch in (0xf1, 0xd6, 0xf1, 0xb4, 0x8f, 0xb4, 0x78)
)


@dataclass(frozen=True)
class GameConfig:
    balls_per_game: int = 4
    hole_settle_seconds: float = 0.5
    credit_button_launch: bool = True
    inlane_bonus_points: int = 1000
    bonus_tick_seconds: float = 0.10
    reflex_points: tuple[int, ...] = (10, 10, 10, 10, 5, 5)
    reflex_sounds: tuple[Tone, ...] = (
        Tone(0xca, 0x08),
        Tone(0xaa, 0x08),
        Tone(0x87, 0x08),
        Tone(0x65, 0x08),
        Tone(0x33, 0x08),
        Tone(0x3c, 0x08),
    )
    match_sound: Tone = Tone(0x78, 0x04)
    credit_sound: Tone = Tone(0x78, 0x28)
    rollover_sound: Tone = Tone(0x54, 0x08)
    rollover_complete_sound: Tone = Tone(0xf1, 0x10)
    match_win_song: tuple[SongNote, ...] = DEFAULT_MATCH_WIN_SONG
    boot_song: tuple[SongNote, ...] = ()
    start_song: tuple[SongNote, ...] = ()


def load_game_config(path: Path) -> GameConfig:
    with path.open("rb") as file:
        data = tomllib.load(file)

    game = data.get("game", {})
    points = data.get("points", {})
    sounds = data.get("sounds", {})

    balls_per_game = int(game.get("balls_per_game", 4))
    if not 1 <= balls_per_game <= 9:
        raise ValueError("game.balls_per_game must be between 1 and 9")
    credit_button_launch = game.get("credit_button_launch", True)
    if not isinstance(credit_button_launch, bool):
        raise ValueError("game.credit_button_launch must be true or false")

    holes = data.get("holes", {})
    hole_settle_seconds = float(holes.get("settle_seconds", 0.5))
    if not 0 <= hole_settle_seconds <= 5.0:
        raise ValueError("holes.settle_seconds must be between 0 and 5 seconds")

    bonus_config = data.get("bonus", {})
    inlane_bonus_points = int(bonus_config.get("inlane_points", 1000))
    bonus_tick_seconds = float(bonus_config.get("tick_seconds", 0.10))
    if inlane_bonus_points <= 0 or inlane_bonus_points % 1000:
        raise ValueError("bonus.inlane_points must be a positive multiple of 1000")
    if not 0.01 <= bonus_tick_seconds <= 5.0:
        raise ValueError("bonus.tick_seconds must be between 0.01 and 5 seconds")

    point_values = tuple(
        int(points.get(name, default))
        for name, default in zip(
            REFLEX_EVENT_NAMES, (10, 10, 10, 10, 5, 5)
        )
    )
    if any(value < 0 for value in point_values):
        raise ValueError("reflex-switch point values cannot be negative")

    def load_tone(name: str, default: Tone) -> Tone:
        source = sounds.get(name, {})
        tone = Tone(
            int(source.get("pitch", default.pitch)),
            int(source.get("duration", default.duration)),
        )
        if not 0 <= tone.pitch <= 0xff or not 1 <= tone.duration <= 0xff:
            raise ValueError(f"sounds.{name} pitch must be 0..255 and duration 1..255")
        return tone

    songs = data.get("songs", {})

    def load_song(name: str) -> tuple[SongNote, ...]:
        if name == "none":
            return ()
        source = songs.get(name)
        if source is None and name == "match_win":
            return DEFAULT_MATCH_WIN_SONG
        if not isinstance(source, list) or not source:
            raise ValueError(f"songs.{name} must contain at least one note")
        result = tuple(
            SongNote(
                Tone(int(note["pitch"]), int(note["duration"])),
                float(note["interval_seconds"]),
            )
            for note in source
        )
        if any(
            not 0 <= note.tone.pitch <= 0xff
            or not 1 <= note.tone.duration <= 0xff
            or not 0.01 <= note.interval_seconds <= 5.0
            for note in result
        ):
            raise ValueError(f"songs.{name} requires byte pitch, nonzero duration, and 0.01..5-second interval")
        return result

    music = data.get("music", {})
    boot_song = load_song(str(music.get("boot", "none")))
    start_song = load_song(str(music.get("start", "none")))

    return GameConfig(
        balls_per_game=balls_per_game,
        hole_settle_seconds=hole_settle_seconds,
        credit_button_launch=credit_button_launch,
        inlane_bonus_points=inlane_bonus_points,
        bonus_tick_seconds=bonus_tick_seconds,
        reflex_points=point_values,
        reflex_sounds=tuple(
            load_tone(name, default)
            for name, default in zip(
                REFLEX_EVENT_NAMES,
                (
                    Tone(0xca, 0x08),
                    Tone(0xaa, 0x08),
                    Tone(0x87, 0x08),
                    Tone(0x65, 0x08),
                    Tone(0x33, 0x08),
                    Tone(0x3c, 0x08),
                ),
            )
        ),
        match_sound=load_tone("match", Tone(0x78, 0x04)),
        credit_sound=load_tone("credit", Tone(0x78, 0x28)),
        rollover_sound=load_tone("rollover", Tone(0x54, 0x08)),
        rollover_complete_sound=load_tone("rollover_complete", Tone(0xf1, 0x10)),
        match_win_song=load_song("match_win"),
        boot_song=boot_song,
        start_song=start_song,
    )


class GameState(Enum):
    GAME_OVER = "game over"
    WAITING_FOR_LAUNCH = "waiting for launch"
    GAME_PLAYING = "game playing"
    BONUS_PROCESSING = "bonus processing"
    MATCH_SEQUENCE = "match sequence"


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


@dataclass
class GameContext:
    state: GameState = GameState.GAME_OVER
    current_player: int = 1
    ball_number: int = 0
    ball_in_play: bool = False
    tilted: bool = False
    credits: int = 0
    bonus: int = 0
    player_scores: list[int] = field(default_factory=lambda: [0, 0, 0, 0])
    score_at_ball_start: int = 0
    same_player_again_started: float | None = None
    grace_started: float | None = None
    grace_save_used: bool = False
    ball_has_left_outhole: bool = False
    previous_inlane_mask: int = 0
    previous_rollover_mask: int = 0
    rollover_lit_mask: int = 0xff
    previous_left_flipper: bool = False
    previous_right_flipper: bool = False
    next_bonus_time: float = 0.0
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
    ) -> None:
        self.config = config or GameConfig()
        self._clock = clock
        self._random = randomizer or random.Random()
        self.context = GameContext()
        self._hole_timer = HoleDwellTimer(OUTHOLE_CONTACT + 1, self.config.hole_settle_seconds)
        self._song: tuple[SongNote, ...] = ()
        self._song_index = 0
        self._next_song_time = 0.0
        self._start_song(self.config.boot_song)

    def initial_output(self) -> OutputFrame:
        return self._render_output()

    def step(self, inputs: HardwareSnapshot) -> StepResult:
        messages: list[str] = []
        launch = False
        cup_mask = 0
        sound: Tone | None = None

        if inputs.credit_pressed:
            self._add_credit("button", messages)
            sound = self.config.credit_sound

        if self.context.state is GameState.GAME_OVER:
            if inputs.start_pressed or (
                self.config.credit_button_launch and inputs.credit_pressed
            ):
                self._start_game()
                messages.append(self._state_message())

        elif self.context.state is GameState.WAITING_FOR_LAUNCH:
            if inputs.right_flipper_pressed or (
                self.config.credit_button_launch and inputs.credit_pressed
            ):
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
            if left_flipper_edge and not self.context.tilted:
                old_lit = self.context.rollover_lit_mask
                rotated = 0
                for ring_index, bit in enumerate(ROLLOVER_RING_BITS):
                    if old_lit & (1 << bit):
                        rotated |= 1 << ROLLOVER_RING_BITS[(ring_index + 1) % len(ROLLOVER_RING_BITS)]
                self.context.rollover_lit_mask = rotated
                messages.append(f"lane change: rollovers={rotated:02x}")
            right_flipper_edge = inputs.right_flipper_pressed and not self.context.previous_right_flipper
            self.context.previous_right_flipper = inputs.right_flipper_pressed
            if right_flipper_edge and not self.context.tilted:
                old_lit = self.context.rollover_lit_mask
                rotated = 0
                for ring_index, bit in enumerate(ROLLOVER_RING_BITS):
                    if old_lit & (1 << bit):
                        rotated |= 1 << ROLLOVER_RING_BITS[(ring_index - 1) % len(ROLLOVER_RING_BITS)]
                self.context.rollover_lit_mask = rotated
                messages.append(f"lane change: rollovers={rotated:02x}")
            if inputs.tilt_pressed and not self.context.tilted:
                self.context.tilted = True
                messages.append("TILT: local reflex and flipper coils inhibited")

            if not self.context.tilted:
                sound = self._score_reflex_events(inputs.reflex_events, messages)
                if inputs.reflex_events & (1 << 2):
                    lit = [bit for bit in range(8) if self.context.rollover_lit_mask & (1 << bit)]
                    if lit:
                        removed = self._random.choice(lit)
                        self.context.rollover_lit_mask &= ~(1 << removed)
                        messages.append(f"middle bumper: rollover {removed} off; remaining={self.context.rollover_lit_mask:02x}")
                        sound = self.config.rollover_sound
                        if not self.context.rollover_lit_mask:
                            self.context.rollover_lit_mask = 0xff
                            self.context.bonus += ROLLOVER_COMPLETE_BONUS
                            messages.append(f"rollovers complete: +{ROLLOVER_COMPLETE_BONUS} bonus")
                            sound = self.config.rollover_complete_sound

            closed_inlanes = inputs.closed_inlane_mask
            newly_closed_inlanes = closed_inlanes & ~self.context.previous_inlane_mask
            self.context.previous_inlane_mask = closed_inlanes
            if newly_closed_inlanes and not self.context.tilted:
                gained = newly_closed_inlanes.bit_count() * self.config.inlane_bonus_points
                self.context.bonus += gained
                messages.append(f"bonus: +{gained} = {self.context.bonus}")

            closed_rollovers = inputs.closed_rollover_mask
            # The 8085 samples and latches brief rollover closures between
            # host frames. Keep the raw snapshot edge as a fallback for an
            # older ROM that still returns zero in the fourth trailer byte.
            newly_closed_rollovers = (
                inputs.rollover_events
                | (closed_rollovers & ~self.context.previous_rollover_mask)
            )
            self.context.previous_rollover_mask = closed_rollovers
            if newly_closed_rollovers and not self.context.tilted:
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
                        and outhole_started - self.context.grace_started <= GRACE_SECONDS
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
                        self.context.same_player_again_started = now
                        launch = True
                        messages.append("same player again: grace save used; auto-launching coil 5")
                    elif self.context.tilted:
                        messages.append("bonus: skipped after tilt")
                        self._finish_ball(messages)
                    else:
                        self._enter_state(GameState.BONUS_PROCESSING)
                        messages.append(self._state_message())
                    break
                cup_mask |= 1 << hole
                messages.append(f"cup eject requested: {hole + 1}")

        elif self.context.state is GameState.BONUS_PROCESSING:
            if self.context.bonus and self._clock() >= self.context.next_bonus_time:
                payout = min(1000, self.context.bonus)
                self.context.bonus -= payout
                player_index = self.context.current_player - 1
                self.context.player_scores[player_index] += payout
                self.context.next_bonus_time = self._clock() + self.config.bonus_tick_seconds
                messages.append(
                    f"bonus payout: player {self.context.current_player} +{payout}; "
                    f"remaining {self.context.bonus}"
                )
            if not self.context.bonus:
                self._finish_ball(messages)

        elif self.context.state is GameState.MATCH_SEQUENCE:
            if inputs.start_pressed:
                self._start_game()
                messages.append("match: skipped for new game")
                messages.append(self._state_message())
            elif (now := self._clock()) >= self.context.next_match_time:
                if self.context.match_step >= MATCH_SEQUENCE_STEPS:
                    matching_players = [
                        player
                        for player, score in enumerate(self.context.player_scores, start=1)
                        if score % 10 == self.context.match_digit
                    ]
                    if matching_players:
                        self._add_credit("match", messages)
                        messages.append(
                            "match: digit "
                            f"{self.context.match_digit} matches player(s) "
                            + ",".join(map(str, matching_players))
                        )
                        self._start_song(self.config.match_win_song)
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

    def _start_song(self, song: tuple[SongNote, ...]) -> None:
        self._song = song
        self._song_index = 0
        self._next_song_time = self._clock()

    def _advance_song(self, now: float) -> Tone | None:
        if not self._song or now < self._next_song_time:
            return None
        if self._song_index >= len(self._song):
            self._song = ()
            return None
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

    def _start_game(self) -> None:
        self._start_song(self.config.start_song)
        self._hole_timer.clear()
        self._enter_state(GameState.WAITING_FOR_LAUNCH)
        self.context.current_player = 1
        self.context.ball_number = 1
        self.context.ball_in_play = False
        self.context.tilted = False
        self.context.bonus = 0
        self.context.player_scores[:] = [0, 0, 0, 0]
        self.context.score_at_ball_start = 0
        self.context.same_player_again_started = None
        self.context.grace_started = None
        self.context.grace_save_used = False
        self.context.ball_has_left_outhole = False
        self.context.previous_inlane_mask = 0
        self.context.previous_rollover_mask = 0
        self.context.previous_left_flipper = False
        self.context.previous_right_flipper = False
        self.context.rollover_lit_mask = 0xff

    def _launch_ball(self, *, new_numbered_ball: bool) -> None:
        self._enter_state(GameState.GAME_PLAYING)
        self.context.previous_right_flipper = False
        self.context.previous_left_flipper = False
        self.context.ball_in_play = True
        self.context.ball_has_left_outhole = False
        self.context.same_player_again_started = None
        self.context.grace_started = self._clock()
        if new_numbered_ball:
            self.context.score_at_ball_start = self.context.player_scores[self.context.current_player - 1]
        self._hole_timer.clear()

    def _finish_ball(self, messages: list[str]) -> None:
        self.context.bonus = 0
        self.context.tilted = False
        self.context.ball_has_left_outhole = False
        self._hole_timer.clear()
        self.context.previous_inlane_mask = 0
        self.context.previous_rollover_mask = 0
        self.context.grace_save_used = False
        if self.context.ball_number < self.config.balls_per_game:
            self.context.ball_number += 1
            self._enter_state(GameState.WAITING_FOR_LAUNCH)
        else:
            self._enter_state(GameState.MATCH_SEQUENCE)
        messages.append(self._state_message())

    def _enter_state(self, state: GameState) -> None:
        self.context.state = state
        if state is not GameState.GAME_PLAYING:
            self.context.same_player_again_started = None
            self.context.grace_started = None
        if state is GameState.BONUS_PROCESSING:
            self.context.next_bonus_time = self._clock() + self.config.bonus_tick_seconds
        if state is GameState.MATCH_SEQUENCE:
            self.context.match_step = 0
            self.context.match_digit = 0
            self.context.next_match_time = self._clock()

    def _state_message(self) -> str:
        return f"state: {self.context.state.value}"

    def _render_output(
        self,
        *,
        cup_mask: int = 0,
        launch: bool = False,
        sound: Tone | None = None,
    ) -> OutputFrame:
        display = DisplayFrame()
        for player, score in enumerate(self.context.player_scores, start=1):
            display.set_player_score(player, f"{min(score, 999_999):06d}")
        display.set_bonus(f"{min(self.context.bonus, 999_999):06d}")
        display.set_credits(f"{self.context.credits % 100:02d}")
        ball_display = (
            self.context.match_digit
            if self.context.state is GameState.MATCH_SEQUENCE
            else (
                self.context.last_match_digit
                if self.context.state is GameState.GAME_OVER and self.context.last_match_digit is not None
                else self.context.ball_number
            )
        )
        display.set_ball_in_play(ball_display)
        display.set_game_over_led(self.context.state is GameState.GAME_OVER)
        display.set_tilt_led(self.context.tilted)
        flash_on = False
        now = self._clock()
        grace_active = (
            self.context.grace_started is not None
            and not self.context.grace_save_used
            and 0 <= now - self.context.grace_started < GRACE_SECONDS
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
        if flash_on:
            lamp_bitmap[SAME_PLAYER_AGAIN_LAMP // 8] |= 1 << (SAME_PLAYER_AGAIN_LAMP % 8)
        display.set_same_player_again_led(flash_on)
        if self.context.state not in (GameState.GAME_OVER, GameState.MATCH_SEQUENCE):
            display.set_player_led(self.context.current_player, True)

        host_coils_allowed = (
            self.context.state in (GameState.WAITING_FOR_LAUNCH, GameState.GAME_PLAYING)
            and not self.context.tilted
        )
        # The right-flipper contact is reported to the host even while the local
        # flipper reflex is inhibited.  In WAITING_FOR_LAUNCH this prevents the
        # launch gesture from also flipping the right flipper.  The separately
        # commanded launcher coil remains allowed.
        reflexes_allowed = (
            self.context.state is GameState.GAME_PLAYING
            and not self.context.tilted
            and not launch
        )
        return OutputFrame(
            display=display,
            reflex_enabled=reflexes_allowed,
            cup_mask=cup_mask if host_coils_allowed else 0,
            launch=launch if host_coils_allowed else False,
            lamp=SAME_PLAYER_AGAIN_LAMP if flash_on else 0xff,
            lamp_bitmap=bytes(lamp_bitmap),
            tone_pitch=sound.pitch if sound else 0,
            tone_duration=sound.duration if sound else 0,
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
    parser.add_argument("--dwell", type=float, default=0.01, help="seconds between frames")
    parser.add_argument("--timeout", type=float, default=5.0)
    args = parser.parse_args()
    if args.dwell < 0:
        parser.error("--dwell cannot be negative")

    device = find_device(args.device)
    game = MicropinGame(load_game_config(args.config))
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
