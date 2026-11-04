import unittest
from dataclasses import replace

from micropin_game import (
    GameConfig, GameState, MicropinGame, STANDUP_DMA_INDICES, CUP_TARGET_LAMPS,
    SongNote, StandupCoincidence, Tone,
)
from test_micropin_game import snapshot


def target_snapshot(targets=0, bar=False, **kwargs):
    base = snapshot(reflex=0x40 if bar else 0, **kwargs)
    dma = bytearray(base.dma)
    for bit, index in enumerate(STANDUP_DMA_INDICES):
        dma[index] = 0x09 if targets & (1 << bit) else 0x12
    return replace(base, dma=bytes(dma))


class StandupTests(unittest.TestCase):
    def setUp(self):
        self.now = [10.0]
        self.game = MicropinGame(GameConfig(launch_song=(), hole_settle_seconds=0), clock=lambda: self.now[0])
        self.game.step(target_snapshot(cabinet=0x40))
        self.game.step(target_snapshot(cabinet=0x10))
        self.game.step(target_snapshot(outhole=False))

    def test_solid_target_scores_and_goes_off_once(self):
        result = self.game.step(target_snapshot(1, bar=True, outhole=False))
        self.assertEqual(self.game.context.player_scores[0], 1000)
        self.assertEqual(self.game.context.standup_solid_mask, 0x1e)
        self.assertEqual(result.output.tone_pitch, self.game.config.standup_sound.pitch)
        self.game.step(target_snapshot(1, bar=True, outhole=False))
        self.assertEqual(self.game.context.player_scores[0], 1000)

    def test_accepts_adjacent_frame_bar_and_closure_in_both_orders(self):
        for bar_first in (True, False):
            self.setUp()
            self.game.step(target_snapshot(0 if bar_first else 1, bar=bar_first, outhole=False))
            self.game.step(target_snapshot(1, bar=not bar_first, outhole=False))
            self.assertEqual(self.game.context.player_scores[0], 1000)
            self.assertEqual(self.game.context.standup_solid_mask, 0x1e)

    def test_two_frame_boundary_and_expiration_in_both_orders(self):
        for target_first in (True, False):
            for gap in (2, 3):
                matcher = StandupCoincidence()
                self.assertEqual(matcher.update(1 if target_first else 0, not target_first), 0)
                for _ in range(gap - 1):
                    self.assertEqual(matcher.update(0, False), 0)
                matched = matcher.update(0 if target_first else 1, target_first)
                self.assertEqual(matched, 1 if gap == 2 else 0)

    def test_match_consumes_both_events(self):
        matcher = StandupCoincidence()
        self.assertEqual(matcher.update(1, True), 1)
        self.assertEqual(matcher.update(2, False), 0)
        matcher.clear()
        self.assertEqual(matcher.update(0, True), 0)

    def test_pending_target_is_cleared_by_tilt(self):
        self.game.step(target_snapshot(1, outhole=False))
        self.game.step(target_snapshot(cabinet=0x08, outhole=False))
        self.game.context.tilted = False
        self.game.step(target_snapshot(bar=True, outhole=False))
        self.assertEqual(self.game.context.player_scores[0], 0)

    def test_cup_flashes_target_and_target_awards_special(self):
        cup = self.game.step(target_snapshot(cups=1, outhole=False))
        self.assertEqual(self.game.context.standup_solid_mask, 0x1e)
        self.assertEqual(self.game.context.standup_flashing_mask, 1)
        lamp = CUP_TARGET_LAMPS[0]
        self.assertTrue(cup.output.lamp_bitmap[lamp // 8] & (1 << (lamp % 8)))
        self.now[0] += 0.25
        dark = self.game.step(target_snapshot(outhole=False))
        self.assertFalse(dark.output.lamp_bitmap[lamp // 8] & (1 << (lamp % 8)))
        hit = self.game.step(target_snapshot(1, bar=True, outhole=False))
        self.assertEqual(self.game.context.player_scores[0], 5250)
        self.assertEqual(self.game.context.bonus, 7000)
        self.assertEqual(self.game.context.standup_flashing_mask, 0)
        self.assertEqual(hit.output.tone_pitch, self.game.config.standup_special_song[0].tone.pitch)

    def test_all_cups_do_not_reset_target_progress(self):
        for index in range(5):
            self.game.step(target_snapshot(cups=1 << index, outhole=False))
            self.game.step(target_snapshot(outhole=False))
        self.assertEqual(self.game.context.standup_solid_mask, 0)
        self.assertEqual(self.game.context.standup_flashing_mask, 0x1f)

    def test_all_standups_award_completion_reset_solid_and_play_own_song(self):
        self.game.config = replace(
            self.game.config,
            standup_complete_song=(SongNote(Tone(0xd2, 0x04), 0.1),),
        )
        result = None
        for index in range(5):
            result = self.game.step(
                target_snapshot(1 << index, bar=True, outhole=False)
            )
            self.game.step(target_snapshot(outhole=False))

        assert result is not None
        self.assertEqual(self.game.context.player_scores[0], 15_000)
        self.assertEqual(self.game.context.bonus_multiplier, 2)
        self.assertEqual(self.game.context.standup_solid_mask, 0x1f)
        self.assertEqual(self.game.context.standup_flashing_mask, 0)
        self.assertEqual((result.output.tone_pitch, result.output.tone_duration), (0xd2, 4))
        self.assertTrue(any(message.startswith("standups complete:") for message in result.messages))

    def test_repeated_standup_completions_raise_multiplier_to_three_and_cap(self):
        for expected_multiplier in (2, 3, 3):
            for index in range(5):
                self.game.step(
                    target_snapshot(1 << index, bar=True, outhole=False)
                )
                self.game.step(target_snapshot(outhole=False))
            self.assertEqual(
                self.game.context.bonus_multiplier, expected_multiplier
            )

        self.game._finish_ball([])
        self.assertEqual(self.game.context.bonus_multiplier, 1)

    def test_unlit_target_beeps_without_scoring(self):
        self.game.context.standup_solid_mask = 0
        result = self.game.step(target_snapshot(1, bar=True, outhole=False))
        self.assertEqual(self.game.context.player_scores[0], 0)
        self.assertEqual(self.game.context.bonus, 0)
        self.assertEqual(result.output.tone_pitch, self.game.config.standup_sound.pitch)

    def test_tilt_or_ball_ending_blocks_award(self):
        for flag in ("tilted", "ball_ending"):
            self.setUp()
            setattr(self.game.context, flag, True)
            self.game.step(target_snapshot(1, bar=True, outhole=False))
            self.assertEqual(self.game.context.player_scores[0], 0)

    def test_new_ball_resets_but_saved_ball_preserves_targets(self):
        self.game.context.standup_solid_mask = 0x02
        self.game.context.standup_flashing_mask = 0x04
        self.game._launch_ball(new_numbered_ball=False)
        self.assertEqual(self.game.context.standup_solid_mask, 0x02)
        self.assertEqual(self.game.context.standup_flashing_mask, 0x04)
        self.game._enter_state(GameState.WAITING_FOR_LAUNCH)
        self.assertEqual(self.game.context.standup_solid_mask, 0x1f)
        self.assertEqual(self.game.context.standup_flashing_mask, 0)

    def test_lane_change_leaves_target_states_stationary(self):
        self.game.context.standup_solid_mask = 1
        self.game.context.standup_flashing_mask = 2
        self.game.step(target_snapshot(cabinet=0x20, outhole=False))
        self.assertEqual(self.game.context.standup_solid_mask, 1)
        self.assertEqual(self.game.context.standup_flashing_mask, 2)
        self.game.step(target_snapshot(cabinet=0, outhole=False))
        self.game.step(target_snapshot(cabinet=0x10, outhole=False))
        self.assertEqual(self.game.context.standup_solid_mask, 1)
        self.assertEqual(self.game.context.standup_flashing_mask, 2)


if __name__ == "__main__":
    unittest.main()
