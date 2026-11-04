import unittest
from dataclasses import replace

from micropin_game import GameConfig, GameState, MicropinGame, OUTLANE_DMA_INDICES
from test_micropin_game import snapshot


def outlane_snapshot(mask=0, **kwargs):
    base = snapshot(**kwargs)
    dma = bytearray(base.dma)
    for bit, index in enumerate(OUTLANE_DMA_INDICES):
        dma[index] = 0x0d if mask & (1 << bit) else 0x16
    return replace(base, dma=bytes(dma))


class OutlaneTests(unittest.TestCase):
    def setUp(self):
        self.now = [10.0]
        self.game = MicropinGame(GameConfig(launch_song=(), hole_settle_seconds=0.5), clock=lambda: self.now[0])
        self.game.step(outlane_snapshot(cabinet=0x40))
        self.game.step(outlane_snapshot(cabinet=0x10))
        self.game.step(outlane_snapshot(outhole=False))

    def test_contacts_and_single_closure_award(self):
        self.assertEqual(OUTLANE_DMA_INDICES, (30, 8))
        self.assertEqual(outlane_snapshot(3).closed_outlane_mask, 3)
        self.game.step(outlane_snapshot(1, outhole=False))
        self.game.step(outlane_snapshot(1, outhole=False))
        self.assertEqual(self.game.context.player_scores[0], 1000)
        self.game.step(outlane_snapshot(outhole=False))
        self.game.step(outlane_snapshot(2, outhole=False))
        self.assertEqual(self.game.context.player_scores[0], 2000)

    def test_grace_save_survives_expiry_and_cabinet_buttons(self):
        self.now[0] += 3.9
        cue = self.game.step(outlane_snapshot(1, outhole=False))
        self.assertEqual(cue.output.tone_pitch, self.game.config.outlane_save_song[0].tone.pitch)
        self.assertTrue(cue.output.reflex_enabled)
        self.now[0] += 6.1
        self.game.step(outlane_snapshot(cabinet=0x20, outhole=False))
        self.assertTrue(self.game.context.outlane_save_pending)
        self.game.step(outlane_snapshot(outhole=True))
        self.now[0] += 0.6
        saved = self.game.step(outlane_snapshot(outhole=True))
        self.assertTrue(saved.output.launch)
        self.assertTrue(self.game.context.grace_save_used)
        self.assertFalse(self.game.context.outlane_save_pending)
        self.assertEqual(saved.output.display.to_bytes()[22] & 0x10, 0)
        self.assertEqual(saved.output.lamp_bitmap[0] & (1 << 6), 0)

    def test_other_hit_cancels_pending_save(self):
        self.game.step(outlane_snapshot(1, outhole=False))
        self.now[0] += 5
        self.game.step(outlane_snapshot(outhole=False, inlanes=1))
        self.assertFalse(self.game.context.outlane_save_pending)
        self.game.step(outlane_snapshot(outhole=True))
        self.now[0] += 0.6
        result = self.game.step(outlane_snapshot(outhole=True))
        self.assertFalse(result.output.launch)
        self.assertIs(self.game.context.state, GameState.BONUS_PROCESSING)

    def test_ordinary_outlane_locks_reflex_until_next_launch(self):
        self.now[0] += 5
        result = self.game.step(outlane_snapshot(2, outhole=False))
        self.assertFalse(result.output.reflex_enabled)
        self.assertTrue(self.game.context.ball_ending)
        self.assertEqual(result.output.tone_pitch, self.game.config.outlane_song[0].tone.pitch)
        self.game.step(outlane_snapshot(outhole=False, reflex=1))
        self.assertEqual(self.game.context.player_scores[0], 1000)
        self.game.step(outlane_snapshot(outhole=True))
        self.now[0] += 0.6
        self.game.step(outlane_snapshot(outhole=True))
        self.now[0] += 0.8
        self.game.step(outlane_snapshot(outhole=True))
        launched = self.game.step(outlane_snapshot(cabinet=0x10))
        self.assertTrue(launched.output.launch)
        self.assertFalse(self.game.context.ball_ending)

    def test_used_grace_save_cannot_be_armed_again(self):
        self.game.context.grace_save_used = True
        result = self.game.step(outlane_snapshot(1, outhole=False))
        self.assertFalse(self.game.context.outlane_save_pending)
        self.assertFalse(result.output.reflex_enabled)

    def test_tilt_cancels_pending_save(self):
        self.game.step(outlane_snapshot(1, outhole=False))
        self.game.step(outlane_snapshot(outhole=False, cabinet=0x08))
        self.assertFalse(self.game.context.outlane_save_pending)


if __name__ == "__main__":
    unittest.main()
