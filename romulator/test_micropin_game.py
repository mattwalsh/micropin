import unittest
from pathlib import Path

from micropin_game import (
    MATCH_END_RATE_HZ,
    MATCH_SEQUENCE_STEPS,
    MATCH_START_RATE_HZ,
    GameConfig,
    GameState,
    HardwareSnapshot,
    HoleDwellTimer,
    MicropinGame,
    ROLLOVER_DMA_INDICES,
    ROLLOVER_LAMPS,
    ROLLOVER_RING_BITS,
    SongNote,
    Tone,
    load_game_config,
    synchronize_aperture,
)
from micropin_protocol import build_control_payload


def snapshot(
    *,
    cabinet: int = 0,
    reflex: int = 0,
    outhole: bool = True,
    cups: int = 0,
    inlanes: int = 0,
    rollovers: int = 0,
    rollover_events: int = 0,
) -> HardwareSnapshot:
    dma = bytearray(b"\x10" * 32)
    if outhole:
        dma[24] = 0
    for bit, index in enumerate((29, 27, 25, 20, 18, 14)):
        if cups & (1 << bit):
            dma[index] = 0
    for bit, index in enumerate((0, 31)):
        if inlanes & (1 << bit):
            dma[index] = 0
    for bit, index in enumerate(ROLLOVER_DMA_INDICES):
        if rollovers & (1 << bit):
            dma[index] = 0
    return HardwareSnapshot.from_wire((cabinet, reflex, 0x8f, rollover_events), bytes(dma))


class MicropinGameTests(unittest.TestCase):
    @staticmethod
    def lit_rollover_lamps(game: MicropinGame) -> set[int]:
        bitmap = game.initial_output().lamp_bitmap
        assert bitmap is not None
        return {
            lamp
            for lamp in ROLLOVER_LAMPS
            if bitmap[lamp // 8] & (1 << (lamp % 8))
        }

    def test_initial_rollover_bitmap_is_sent_in_signed_frame(self) -> None:
        game = MicropinGame()
        frame = game.initial_output()
        self.assertEqual(self.lit_rollover_lamps(game), set(ROLLOVER_LAMPS))
        payload = frame.to_payload()
        self.assertEqual(len(payload), 45)
        self.assertEqual(payload[:3], b"\xffMP")
        self.assertEqual(payload[-5:], frame.lamp_bitmap)

    def test_bitmap_command_requires_five_bytes_and_display(self) -> None:
        with self.assertRaises(ValueError):
            build_control_payload(lamp_bitmap=b"\xff" * 5)
        with self.assertRaises(ValueError):
            build_control_payload(display_window=MicropinGame().initial_output().display, lamp_bitmap=b"\xff")

    def test_new_game_relights_all_rollovers(self) -> None:
        game = MicropinGame()
        game.context.rollover_lit_mask = 0x12
        game.step(snapshot(cabinet=0x40))
        self.assertEqual(game.context.rollover_lit_mask, 0xff)
        self.assertEqual(self.lit_rollover_lamps(game), set(ROLLOVER_LAMPS))

    def test_rollover_scores_only_once_while_lit_and_completion_resets(self) -> None:
        game = MicropinGame(GameConfig(hole_settle_seconds=0))
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        first = game.step(snapshot(outhole=False, rollovers=1))
        self.assertEqual(game.context.player_scores[0], 500)
        self.assertEqual(game.context.rollover_lit_mask, 0xfe)
        assert first.output.lamp_bitmap is not None
        self.assertFalse(first.output.lamp_bitmap[16 // 8] & (1 << (16 % 8)))
        game.step(snapshot(outhole=False, rollovers=1))
        game.step(snapshot(outhole=False))
        game.step(snapshot(outhole=False, rollovers=1))
        self.assertEqual(game.context.player_scores[0], 500)

        for bit in range(1, 8):
            game.step(snapshot(outhole=False))
            game.step(snapshot(outhole=False, rollovers=1 << bit))
        self.assertEqual(game.context.player_scores[0], 4000)
        self.assertEqual(game.context.bonus, 5000)
        self.assertEqual(game.context.rollover_lit_mask, 0xff)
        self.assertEqual(self.lit_rollover_lamps(game), set(ROLLOVER_LAMPS))

    def test_latched_rollover_pulse_scores_after_contact_reopens(self) -> None:
        game = MicropinGame(GameConfig(hole_settle_seconds=0))
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        game.step(snapshot(outhole=False, rollover_events=1))
        self.assertEqual(game.context.player_scores[0], 500)
        self.assertEqual(game.context.rollover_lit_mask, 0xfe)
        game.step(snapshot(outhole=False))
        self.assertEqual(game.context.player_scores[0], 500)

    def test_latched_and_raw_rollover_hit_is_counted_once(self) -> None:
        game = MicropinGame(GameConfig(hole_settle_seconds=0))
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        game.step(snapshot(outhole=False, rollovers=1, rollover_events=1))
        self.assertEqual(game.context.player_scores[0], 500)

    def test_right_flipper_rotates_rollover_lamp_pattern_counterclockwise(self) -> None:
        game = MicropinGame(GameConfig(hole_settle_seconds=0))
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        game.context.rollover_lit_mask = sum(1 << bit for bit in (2, 5, 7))
        game.step(snapshot(outhole=False, cabinet=0))
        result = game.step(snapshot(outhole=False, cabinet=0x10))
        self.assertTrue(any(message.startswith("lane change:") for message in result.messages))
        self.assertEqual(game.context.rollover_lit_mask, sum(1 << bit for bit in (1, 4, 6)))
        game.step(snapshot(outhole=False, cabinet=0))
        self.assertEqual(game.context.rollover_lit_mask, sum(1 << bit for bit in (1, 4, 6)))

    def test_middle_bumper_removes_one_lit_rollover_and_plays_rollover_sound(self) -> None:
        game = MicropinGame(GameConfig(hole_settle_seconds=0), randomizer=__import__("random").Random(1))
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        game.context.rollover_lit_mask = 0xff
        result = game.step(snapshot(outhole=False, reflex=1 << 2))
        self.assertEqual(game.context.rollover_lit_mask.bit_count(), 7)
        self.assertEqual(result.output.tone_pitch, game.config.rollover_sound.pitch)

    def test_lit_cup_awards_tiered_bonus_and_turns_off_cup_and_target(self) -> None:
        game = MicropinGame(GameConfig(hole_settle_seconds=0))
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        result = game.step(snapshot(outhole=False, cups=0x01))
        self.assertEqual(game.context.bonus, 2000)
        self.assertEqual(game.context.player_scores[0], 250)
        self.assertEqual(game.context.cup_lit_mask, 0x1e)
        self.assertEqual(result.output.tone_pitch, game.config.cup_lit_sound.pitch)

    def test_unlit_cup_awards_token_points(self) -> None:
        game = MicropinGame(GameConfig(hole_settle_seconds=0))
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        game.context.cup_lit_mask = 0x1e
        result = game.step(snapshot(outhole=False, cups=0x01))
        self.assertEqual(game.context.bonus, 0)
        self.assertEqual(game.context.player_scores[0], 100)
        self.assertEqual(result.output.tone_pitch, game.config.cup_unlit_sound.pitch)

    def test_left_flipper_rotates_rollover_lamp_pattern_clockwise(self) -> None:
        game = MicropinGame(GameConfig(hole_settle_seconds=0))
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        # Ring NW,N,NE,E,SE,S,SW,W = O,X,O,O,X,O,X,X.
        game.context.rollover_lit_mask = sum(1 << bit for bit in (2, 4, 5, 7))
        result = game.step(snapshot(outhole=False, cabinet=0x20))
        self.assertTrue(any(message.startswith("lane change:") for message in result.messages))
        self.assertEqual(game.context.rollover_lit_mask, sum(1 << bit for bit in (3, 5, 6, 0)))
        game.step(snapshot(outhole=False, cabinet=0))
        self.assertEqual(game.context.rollover_lit_mask, sum(1 << bit for bit in (3, 5, 6, 0)))

    def test_rollover_progress_is_shared_between_players_and_balls(self) -> None:
        now = [10.0]
        game = MicropinGame(GameConfig(hole_settle_seconds=0), clock=lambda: now[0])
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        game.step(snapshot(outhole=False, rollovers=1))
        game.context.current_player = 2
        game.step(snapshot(outhole=False))
        game.step(snapshot(outhole=False, rollovers=2))
        self.assertEqual(game.context.player_scores[:2], [500, 500])
        self.assertEqual(game.context.rollover_lit_mask, 0xfc)
        self.assertEqual(self.lit_rollover_lamps(game), set(ROLLOVER_LAMPS[2:]))

        now[0] += 4.1
        game.step(snapshot(outhole=False))
        game.step(snapshot(outhole=True))
        self.assertIs(game.context.state, GameState.BONUS_PROCESSING)
        game.step(snapshot())
        self.assertIs(game.context.state, GameState.WAITING_FOR_LAUNCH)
        self.assertEqual(game.context.rollover_lit_mask, 0xfc)
        game.step(snapshot(cabinet=0x10))
        self.assertEqual(game.context.rollover_lit_mask, 0xfc)
        self.assertEqual(self.lit_rollover_lamps(game), set(ROLLOVER_LAMPS[2:]))

    def test_startup_resynchronizes_stale_host_sequence_with_safe_frame(self) -> None:
        class FakeSerial:
            timeout = 0.1

            def __init__(self) -> None:
                self.host = 1
                self.ack = 0
                self.response = b""
                self.sent_payload = b""

            def command(self, request: str) -> str:
                if request == "rx":
                    response, self.response = self.response, b""
                    return "rx " + response.hex()
                if request == "state":
                    return f"state host={self.host:02x} ack={self.ack:02x}"
                if request.startswith("tx "):
                    self.sent_payload = bytes.fromhex(request[3:])
                    self.host += 1
                    self.ack = self.host
                    switch_snapshot = bytes((0, 0, 0x8f, 0)) + b"\x10" * 32
                    self.response = (
                        bytes((self.host, len(self.sent_payload) + 36))
                        + self.sent_payload
                        + switch_snapshot
                    )
                    return f"tx {self.host:02x}"
                raise AssertionError(f"unexpected command: {request}")

        serial = FakeSerial()
        sequence = synchronize_aperture(serial)
        self.assertEqual(sequence, 2)
        self.assertEqual((serial.host, serial.ack), (2, 2))
        self.assertEqual(serial.sent_payload[:6], bytes((0xff, 0x4d, 0x50, 0, 0, 0)))
        self.assertEqual(serial.sent_payload[-2:], b"\x00\x00")

    def test_credit_button_plays_sound_and_caps_at_99(self) -> None:
        game = MicropinGame()
        game.context.credits = 98
        credited = game.step(snapshot(cabinet=0x04))
        self.assertEqual(game.context.credits, 99)
        self.assertEqual(credited.output.display.to_bytes()[26], 0x99)
        self.assertEqual(
            (credited.output.tone_pitch, credited.output.tone_duration),
            (game.config.credit_sound.pitch, game.config.credit_sound.duration),
        )
        game.step(snapshot(cabinet=0x04))
        self.assertEqual(game.context.credits, 99)

    def test_config_loads_match_song(self) -> None:
        config = load_game_config(Path(__file__).with_name("micropin_game.toml"))
        self.assertTrue(config.match_win_song)
        self.assertEqual(config.credit_sound, Tone(0x78, 0x28))
        self.assertEqual(config.hole_settle_seconds, 0.5)
        self.assertTrue(config.credit_button_launch)
        self.assertEqual(config.boot_song, config.match_win_song)
        self.assertEqual(config.start_song, config.match_win_song)

    def test_start_enters_waiting_for_launch(self) -> None:
        game = MicropinGame()
        result = game.step(snapshot(cabinet=0x40))
        self.assertIs(game.context.state, GameState.WAITING_FOR_LAUNCH)
        self.assertEqual(game.context.ball_number, 1)
        self.assertFalse(result.output.launch)
        self.assertFalse(result.output.reflex_enabled)

    def test_credit_starts_from_game_over_then_launches_on_next_press(self) -> None:
        game = MicropinGame(GameConfig(credit_button_launch=True))
        started = game.step(snapshot(cabinet=0x04))
        self.assertIs(game.context.state, GameState.WAITING_FOR_LAUNCH)
        self.assertEqual(game.context.credits, 1)
        self.assertFalse(started.output.launch)
        self.assertFalse(started.output.reflex_enabled)

        launched = game.step(snapshot(cabinet=0x04))
        self.assertIs(game.context.state, GameState.GAME_PLAYING)
        self.assertEqual(game.context.credits, 2)
        self.assertTrue(launched.output.launch)
        self.assertFalse(launched.output.reflex_enabled)

    def test_credit_shortcut_off_still_adds_credit_in_game_over(self) -> None:
        game = MicropinGame(GameConfig(credit_button_launch=False))
        credited = game.step(snapshot(cabinet=0x04))
        self.assertIs(game.context.state, GameState.GAME_OVER)
        self.assertEqual(game.context.credits, 1)
        self.assertFalse(credited.output.launch)

    def test_right_flipper_launches_only_with_ball_in_outhole(self) -> None:
        game = MicropinGame()
        game.step(snapshot(cabinet=0x40))

        dry_fire = game.step(snapshot(cabinet=0x10, outhole=False))
        self.assertIs(game.context.state, GameState.WAITING_FOR_LAUNCH)
        self.assertFalse(dry_fire.output.launch)

        launch = game.step(snapshot(cabinet=0x10, outhole=True))
        self.assertIs(game.context.state, GameState.GAME_PLAYING)
        self.assertTrue(launch.output.launch)
        self.assertFalse(launch.output.reflex_enabled)
        self.assertTrue(game.step(snapshot(outhole=False)).output.reflex_enabled)

    def test_zero_score_drain_auto_launches_and_flashes_both_lights(self) -> None:
        now = [10.0]
        game = MicropinGame(GameConfig(hole_settle_seconds=0.5), clock=lambda: now[0])
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        game.step(snapshot(outhole=False))
        game.step(snapshot(outhole=True))
        now[0] += 0.49
        self.assertIs(game.step(snapshot(outhole=True)).output.reflex_enabled, True)
        now[0] += 0.02
        saved = game.step(snapshot(outhole=True))
        self.assertIs(game.context.state, GameState.GAME_PLAYING)
        self.assertEqual(game.context.ball_number, 1)
        self.assertTrue(saved.output.launch)
        self.assertFalse(saved.output.reflex_enabled)
        self.assertEqual(saved.output.display.to_bytes()[22] & 0x10, 0x10)
        self.assertEqual(saved.output.lamp, 6)

        now[0] += 0.125
        off = game.step(snapshot(outhole=True))
        self.assertFalse(off.output.launch)
        self.assertTrue(off.output.reflex_enabled)
        self.assertEqual(off.output.display.to_bytes()[22] & 0x10, 0)
        self.assertEqual(off.output.lamp, 0xff)
        now[0] += 0.125
        on = game.step(snapshot(outhole=True))
        self.assertEqual(on.output.display.to_bytes()[22] & 0x10, 0x10)
        self.assertEqual(on.output.lamp, 6)

        assert game.context.same_player_again_started is not None
        now[0] = game.context.same_player_again_started + 2.0
        still_grace = game.step(snapshot(outhole=True))
        self.assertEqual(still_grace.output.display.to_bytes()[22] & 0x10, 0x10)
        self.assertEqual(still_grace.output.lamp, 6)
        now[0] = game.context.same_player_again_started + 4.0
        expired = game.step(snapshot(outhole=True))
        self.assertFalse(expired.output.launch)
        self.assertEqual(expired.output.display.to_bytes()[22] & 0x10, 0)
        self.assertEqual(expired.output.lamp, 0xff)
        self.assertTrue(game.step(snapshot(outhole=False)).output.reflex_enabled)

    def test_zero_score_save_launches_once_until_ball_leaves_outhole(self) -> None:
        now = [1.0]
        game = MicropinGame(GameConfig(hole_settle_seconds=0), clock=lambda: now[0])
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        game.step(snapshot(outhole=False))
        self.assertTrue(game.step(snapshot(outhole=True)).output.launch)
        now[0] += 3.0
        self.assertFalse(game.step(snapshot(outhole=True)).output.launch)
        game.step(snapshot(outhole=False))
        self.assertTrue(game.step(snapshot(outhole=True)).output.launch)

    def test_ball_save_compares_with_score_at_this_launch(self) -> None:
        game = MicropinGame(GameConfig(hole_settle_seconds=0))
        game.step(snapshot(cabinet=0x40))
        game.context.player_scores[0] = 120
        game.step(snapshot(cabinet=0x10))
        self.assertEqual(game.context.score_at_ball_start, 120)
        game.step(snapshot(outhole=False))
        saved = game.step(snapshot(outhole=True))
        self.assertTrue(saved.output.launch)
        self.assertIs(game.context.state, GameState.GAME_PLAYING)
        self.assertEqual(game.context.player_scores[0], 120)

    def test_grace_flashes_four_seconds_from_first_launch(self) -> None:
        now = [10.0]
        game = MicropinGame(clock=lambda: now[0])
        game.step(snapshot(cabinet=0x40))
        launched = game.step(snapshot(cabinet=0x10))
        self.assertEqual(launched.output.lamp, 6)
        self.assertEqual(launched.output.display.to_bytes()[22] & 0x10, 0x10)
        now[0] += 0.125
        off = game.step(snapshot(outhole=False))
        self.assertEqual(off.output.lamp, 0xff)
        self.assertEqual(off.output.display.to_bytes()[22] & 0x10, 0)
        now[0] = 14.0
        expired = game.step(snapshot(outhole=False))
        self.assertEqual(expired.output.lamp, 0xff)
        self.assertEqual(expired.output.display.to_bytes()[22] & 0x10, 0)

    def test_grace_uses_contact_start_even_if_settle_finishes_after_deadline(self) -> None:
        now = [10.0]
        game = MicropinGame(GameConfig(hole_settle_seconds=0.5), clock=lambda: now[0])
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        game.step(snapshot(reflex=1, outhole=False))
        now[0] = 13.8
        game.step(snapshot(outhole=True))
        now[0] = 14.31
        saved = game.step(snapshot(outhole=True))
        self.assertIs(game.context.state, GameState.GAME_PLAYING)
        self.assertTrue(saved.output.launch)
        self.assertFalse(saved.output.reflex_enabled)
        self.assertTrue(game.context.grace_save_used)
        self.assertEqual(game.context.ball_number, 1)
        self.assertEqual(saved.output.lamp, 6)
        self.assertEqual(saved.output.display.to_bytes()[22] & 0x10, 0x10)
        now[0] += 2.0
        expired = game.step(snapshot(outhole=True))
        self.assertEqual(expired.output.lamp, 0xff)
        self.assertEqual(expired.output.display.to_bytes()[22] & 0x10, 0)

    def test_scored_grace_reshoot_does_not_rebaseline_zero_score(self) -> None:
        now = [10.0]
        game = MicropinGame(GameConfig(hole_settle_seconds=0), clock=lambda: now[0])
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        self.assertEqual(game.context.score_at_ball_start, 0)
        game.step(snapshot(reflex=1, outhole=False))
        now[0] += 1.0
        self.assertTrue(game.step(snapshot(outhole=True)).output.launch)
        self.assertTrue(game.context.grace_save_used)
        self.assertEqual(game.context.player_scores[0], 10)
        self.assertEqual(game.context.score_at_ball_start, 0)

        game.step(snapshot(outhole=False))
        now[0] += 5.0
        drained = game.step(snapshot(outhole=True))
        self.assertFalse(drained.output.launch)
        self.assertIs(game.context.state, GameState.BONUS_PROCESSING)
        self.assertEqual(game.context.ball_number, 1)
        self.assertEqual(game.context.player_scores[0], 10)
        game.step(snapshot())
        self.assertIs(game.context.state, GameState.WAITING_FOR_LAUNCH)
        self.assertEqual(game.context.ball_number, 2)
        self.assertFalse(game.context.grace_save_used)
        next_ball = game.step(snapshot(cabinet=0x10))
        self.assertTrue(next_ball.output.launch)
        self.assertEqual(next_ball.output.lamp, 6)
        self.assertEqual(game.context.score_at_ball_start, 10)

    def test_zero_score_save_does_not_spend_grace_save(self) -> None:
        now = [10.0]
        game = MicropinGame(GameConfig(hole_settle_seconds=0), clock=lambda: now[0])
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        game.step(snapshot(outhole=False))
        now[0] += 1.0
        self.assertTrue(game.step(snapshot(outhole=True)).output.launch)
        self.assertFalse(game.context.grace_save_used)
        game.step(snapshot(reflex=1, outhole=False))
        now[0] += 1.0
        self.assertTrue(game.step(snapshot(outhole=True)).output.launch)
        self.assertTrue(game.context.grace_save_used)

    def test_drain_enters_bonus_only_after_ball_left_outhole(self) -> None:
        now = [10.0]
        game = MicropinGame(GameConfig(hole_settle_seconds=0), clock=lambda: now[0])
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10, outhole=True))
        game.step(snapshot(outhole=True))
        self.assertIs(game.context.state, GameState.GAME_PLAYING)
        game.step(snapshot(reflex=1, outhole=True))
        now[0] += 4.1
        game.step(snapshot(outhole=False))
        drained = game.step(snapshot(outhole=True))
        self.assertIs(game.context.state, GameState.BONUS_PROCESSING)
        self.assertFalse(drained.output.reflex_enabled)

        result = game.step(snapshot())
        self.assertIs(game.context.state, GameState.WAITING_FOR_LAUNCH)
        self.assertEqual(game.context.ball_number, 2)
        self.assertFalse(result.output.reflex_enabled)

    def test_last_ball_runs_match_then_returns_to_game_over(self) -> None:
        now = [10.0]
        game = MicropinGame(clock=lambda: now[0])
        game.context.state = GameState.BONUS_PROCESSING
        game.context.ball_number = game.config.balls_per_game
        game.step(snapshot())
        self.assertIs(game.context.state, GameState.MATCH_SEQUENCE)

        for _ in range(MATCH_SEQUENCE_STEPS):
            result = game.step(snapshot())
            self.assertEqual(
                result.output.display.to_bytes()[27] & 0x0f,
                game.context.match_digit,
            )
            self.assertEqual(result.output.tone_duration, game.config.match_sound.duration)
            now[0] = game.context.next_match_time
        result = game.step(snapshot())
        self.assertIs(game.context.state, GameState.GAME_OVER)
        self.assertEqual(game.context.ball_number, 0)
        self.assertEqual(result.output.display.to_bytes()[27] & 0x0f, game.context.match_digit)
        self.assertFalse(result.output.reflex_enabled)

    def test_start_during_match_abandons_match_and_starts_new_game(self) -> None:
        now = [5.0]
        game = MicropinGame(clock=lambda: now[0])
        game.context.state = GameState.MATCH_SEQUENCE
        game.context.match_step = MATCH_SEQUENCE_STEPS
        game.context.match_digit = 7
        game.context.next_match_time = now[0]
        game.context.player_scores = [17, 0, 0, 0]
        game.context.credits = 2

        started = game.step(snapshot(cabinet=0x40))
        self.assertIs(game.context.state, GameState.WAITING_FOR_LAUNCH)
        self.assertEqual(game.context.ball_number, 1)
        self.assertEqual(game.context.player_scores, [0, 0, 0, 0])
        self.assertEqual(game.context.credits, 2)
        self.assertFalse(started.output.launch)
        self.assertFalse(started.output.reflex_enabled)
        self.assertEqual(started.output.display.to_bytes()[27] & 0x0f, 1)

    def test_match_never_repeats_and_awards_one_credit_with_song(self) -> None:
        class FixedRandom:
            def __init__(self) -> None:
                self.values = iter((1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2))

            def randrange(self, limit: int) -> int:
                self.assert_limit(limit)
                return next(self.values)

            @staticmethod
            def assert_limit(limit: int) -> None:
                if limit != 10:
                    raise AssertionError(f"expected ten match digits, got {limit}")

        now = [10.0]
        config = GameConfig(
            match_win_song=(
                SongNote(Tone(0xa1, 0x04), 0.12),
                SongNote(Tone(0xb2, 0x04), 0.18),
            )
        )
        game = MicropinGame(config, clock=lambda: now[0], randomizer=FixedRandom())
        game.context.state = GameState.MATCH_SEQUENCE
        game.context.next_match_time = now[0]
        game.context.player_scores = [12, 0, 0, 0]
        game.context.credits = 98

        digits = []
        for _ in range(MATCH_SEQUENCE_STEPS):
            result = game.step(snapshot())
            digits.append(game.context.match_digit)
            self.assertEqual(result.output.display.to_bytes()[27] & 0x0f, digits[-1])
            now[0] = game.context.next_match_time
        self.assertTrue(all(left != right for left, right in zip(digits, digits[1:])))
        self.assertEqual(digits[-1], 2)

        result = game.step(snapshot())
        self.assertIs(game.context.state, GameState.GAME_OVER)
        self.assertEqual(game.context.credits, 99)
        self.assertEqual(result.output.display.to_bytes()[26], 0x99)
        self.assertEqual(
            (result.output.tone_pitch, result.output.tone_duration), (0xa1, 0x04)
        )
        now[0] += 0.12
        second = game.step(snapshot())
        self.assertEqual(
            (second.output.tone_pitch, second.output.tone_duration), (0xb2, 0x04)
        )
        game.step(snapshot())
        self.assertEqual(game.context.credits, 99)

    def test_unmatched_final_digit_does_not_award_credit(self) -> None:
        now = [3.0]
        game = MicropinGame(clock=lambda: now[0])
        game.context.state = GameState.MATCH_SEQUENCE
        game.context.match_step = MATCH_SEQUENCE_STEPS
        game.context.match_digit = 7
        game.context.next_match_time = now[0]
        game.context.player_scores = [1, 2, 3, 4]
        result = game.step(snapshot())
        self.assertIs(game.context.state, GameState.GAME_OVER)
        self.assertEqual(game.context.credits, 0)
        self.assertEqual((result.output.tone_pitch, result.output.tone_duration), (0, 0))

    def test_tilt_latches_and_inhibits_coils(self) -> None:
        game = MicropinGame()
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        tilted = game.step(snapshot(cabinet=0x08, outhole=False))
        self.assertTrue(game.context.tilted)
        self.assertFalse(tilted.output.reflex_enabled)

    def test_inlanes_accrue_on_closure_and_payout_1000_per_tick(self) -> None:
        now = [10.0]
        game = MicropinGame(
            GameConfig(balls_per_game=4, hole_settle_seconds=0),
            clock=lambda: now[0],
        )
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        game.step(snapshot(reflex=1, outhole=False))
        first = game.step(snapshot(outhole=False, inlanes=0x01))
        self.assertEqual(game.context.bonus, 1000)
        self.assertEqual(first.output.display.to_bytes()[0:3], bytes((0, 0x10, 0)))
        game.step(snapshot(outhole=False, inlanes=0x01))
        self.assertEqual(game.context.bonus, 1000)
        game.step(snapshot(outhole=False, inlanes=0))
        game.step(snapshot(outhole=False, inlanes=0x03))
        self.assertEqual(game.context.bonus, 3000)

        now[0] += 4.1
        game.step(snapshot(outhole=True))
        self.assertIs(game.context.state, GameState.BONUS_PROCESSING)
        before_tick = game.step(snapshot())
        self.assertEqual(game.context.bonus, 3000)
        self.assertEqual(game.context.player_scores[0], 10)
        self.assertEqual(before_tick.output.display.to_bytes()[0:3], bytes((0, 0x30, 0)))

        for remaining in (2000, 1000, 0):
            now[0] += game.config.bonus_tick_seconds
            result = game.step(snapshot())
            self.assertEqual(game.context.bonus, remaining)
            self.assertEqual(game.context.player_scores[0], 3010 - remaining)
        self.assertIs(game.context.state, GameState.WAITING_FOR_LAUNCH)
        self.assertEqual(game.context.ball_number, 2)

    def test_bonus_display_saturates_without_losing_bank_value(self) -> None:
        game = MicropinGame()
        game.context.bonus = 1_200_000
        self.assertEqual(game.initial_output().display.to_bytes()[0:3], b"\x99\x99\x99")
        self.assertEqual(game.context.bonus, 1_200_000)
        game.context.player_scores[0] = 1_200_000
        self.assertEqual(game.initial_output().display.to_bytes()[6:9], b"\x99\x99\x99")
        self.assertEqual(game.context.player_scores[0], 1_200_000)

    def test_tilt_skips_bonus_payout_and_advances_ball(self) -> None:
        game = MicropinGame(GameConfig(hole_settle_seconds=0))
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        game.step(snapshot(outhole=False, inlanes=0x01))
        self.assertEqual(game.context.bonus, 1000)
        game.step(snapshot(cabinet=0x08, outhole=False, inlanes=0x01))
        drained = game.step(snapshot(outhole=True))
        self.assertIs(game.context.state, GameState.WAITING_FOR_LAUNCH)
        self.assertEqual(game.context.player_scores[0], 0)
        self.assertEqual(game.context.bonus, 0)
        self.assertEqual(game.context.ball_number, 2)
        self.assertFalse(drained.output.reflex_enabled)

    def test_newly_closed_cup_requests_one_eject(self) -> None:
        game = MicropinGame(GameConfig(hole_settle_seconds=0))
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        first = game.step(snapshot(outhole=False, cups=0x01))
        held = game.step(snapshot(outhole=False, cups=0x01))
        self.assertEqual(first.output.cup_mask, 0x01)
        self.assertEqual(held.output.cup_mask, 0)

    def test_hole_dwell_timer_cancels_on_open_and_rearms(self) -> None:
        timer = HoleDwellTimer(2, 0.5)
        self.assertEqual(timer.update((True, False), 1.0), ())
        self.assertEqual(timer.update((True, False), 1.49), ())
        self.assertEqual(timer.update((False, False), 1.50), ())
        self.assertEqual(timer.update((True, False), 1.60), ())
        self.assertEqual(timer.update((True, False), 2.10), (0,))
        self.assertEqual(timer.update((True, False), 2.60), ())
        self.assertEqual(timer.update((False, False), 2.61), ())
        self.assertEqual(timer.update((True, True), 2.70), ())
        self.assertEqual(timer.update((True, True), 3.21), (0, 1))

    def test_cup_and_outhole_wait_for_mature_closure(self) -> None:
        now = [1.0]
        game = MicropinGame(clock=lambda: now[0])
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        game.step(snapshot(reflex=1, outhole=False))
        game.step(snapshot(outhole=False))

        game.step(snapshot(outhole=False, cups=1))
        now[0] += 0.25
        game.step(snapshot(outhole=False, cups=0))
        now[0] += 0.01
        game.step(snapshot(outhole=False, cups=1))
        now[0] += 0.49
        self.assertEqual(game.step(snapshot(outhole=False, cups=1)).output.cup_mask, 0)
        now[0] += 0.02
        self.assertEqual(game.step(snapshot(outhole=False, cups=1)).output.cup_mask, 1)
        self.assertEqual(game.step(snapshot(outhole=False, cups=1)).output.cup_mask, 0)

        now[0] += 4.1
        game.step(snapshot(outhole=True))
        now[0] += 0.25
        game.step(snapshot(outhole=False))
        now[0] += 0.01
        game.step(snapshot(outhole=True))
        now[0] += 0.49
        game.step(snapshot(outhole=True))
        self.assertIs(game.context.state, GameState.GAME_PLAYING)
        now[0] += 0.02
        game.step(snapshot(outhole=True))
        self.assertIs(game.context.state, GameState.BONUS_PROCESSING)

    def test_credit_launch_shortcut_can_be_disabled(self) -> None:
        enabled = MicropinGame(GameConfig(credit_button_launch=True))
        enabled.step(snapshot(cabinet=0x40))
        dry = enabled.step(snapshot(cabinet=0x04, outhole=False))
        self.assertFalse(dry.output.launch)
        self.assertIs(enabled.context.state, GameState.WAITING_FOR_LAUNCH)
        launched = enabled.step(snapshot(cabinet=0x04))
        self.assertTrue(launched.output.launch)
        self.assertEqual(enabled.context.credits, 2)

        disabled = MicropinGame(GameConfig(credit_button_launch=False))
        disabled.step(snapshot(cabinet=0x40))
        not_launched = disabled.step(snapshot(cabinet=0x04))
        self.assertFalse(not_launched.output.launch)
        self.assertIs(disabled.context.state, GameState.WAITING_FOR_LAUNCH)
        self.assertEqual(disabled.context.credits, 1)

    def test_side_bonus_cup_uses_same_dwell_timer(self) -> None:
        now = [4.0]
        game = MicropinGame(clock=lambda: now[0])
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        self.assertEqual(game.step(snapshot(outhole=False, cups=0x20)).output.cup_mask, 0)
        now[0] += 0.51
        self.assertEqual(game.step(snapshot(outhole=False, cups=0x20)).output.cup_mask, 0x20)

    def test_boot_and_start_songs_use_configured_notes(self) -> None:
        boot = (SongNote(Tone(0xa1, 4), 0.1),)
        start = (SongNote(Tone(0xb2, 4), 0.1),)
        game = MicropinGame(GameConfig(boot_song=boot, start_song=start))
        boot_frame = game.step(snapshot())
        self.assertEqual((boot_frame.output.tone_pitch, boot_frame.output.tone_duration), (0xa1, 4))
        start_frame = game.step(snapshot(cabinet=0x40))
        self.assertEqual((start_frame.output.tone_pitch, start_frame.output.tone_duration), (0xb2, 4))

    def test_reflex_switches_score_and_play_configured_sound(self) -> None:
        config = GameConfig(
            balls_per_game=4,
            reflex_points=(10, 11, 12, 13, 5, 6),
            reflex_sounds=(
                Tone(0xa0, 0x04),
                Tone(0xa1, 0x04),
                Tone(0xa2, 0x04),
                Tone(0xa3, 0x04),
                Tone(0xb2, 0x03),
                Tone(0xb3, 0x03),
            ),
            match_sound=Tone(0xc0, 0x04),
        )
        game = MicropinGame(config)
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))

        bumper = game.step(snapshot(reflex=0x02, outhole=False))
        self.assertEqual(game.context.player_scores[0], 11)
        self.assertEqual(bumper.output.display.to_bytes()[6], 0x11)
        self.assertEqual((bumper.output.tone_pitch, bumper.output.tone_duration), (0xa1, 0x04))

        sling = game.step(snapshot(reflex=0x10, outhole=False))
        self.assertEqual(game.context.player_scores[0], 16)
        self.assertEqual((sling.output.tone_pitch, sling.output.tone_duration), (0xb2, 0x03))

        silence = game.step(snapshot(outhole=False))
        self.assertEqual((silence.output.tone_pitch, silence.output.tone_duration), (0, 0))

    def test_match_rate_slows_from_five_to_point_seven_hz(self) -> None:
        self.assertAlmostEqual(MicropinGame._match_rate(0), MATCH_START_RATE_HZ)
        self.assertAlmostEqual(
            MicropinGame._match_rate(MATCH_SEQUENCE_STEPS - 1),
            MATCH_END_RATE_HZ,
        )

    def test_player_led_is_hidden_only_in_game_over_and_match(self) -> None:
        game = MicropinGame()
        self.assertEqual(game.initial_output().display.to_bytes()[30] & 0x0f, 0)
        waiting = game.step(snapshot(cabinet=0x40))
        self.assertEqual(waiting.output.display.to_bytes()[30] & 0x0f, 1)
        game.context.current_player = 4
        game.context.state = GameState.BONUS_PROCESSING
        bonus = game.step(snapshot())
        self.assertEqual(bonus.output.display.to_bytes()[30] & 0x0f, 8)
        game.context.state = GameState.MATCH_SEQUENCE
        match = game.step(snapshot())
        self.assertEqual(match.output.display.to_bytes()[30] & 0x0f, 0)


if __name__ == "__main__":
    unittest.main()
