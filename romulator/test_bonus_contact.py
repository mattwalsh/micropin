import unittest
from dataclasses import replace

from micropin_game import GameConfig, MicropinGame, TEN_THOUSAND_BONUS_DMA_INDEX
from test_micropin_game import snapshot


def contact_snapshot(closed=False, **kwargs):
    base = snapshot(**kwargs)
    dma = bytearray(base.dma)
    dma[TEN_THOUSAND_BONUS_DMA_INDEX] = 0x09 if closed else 0x12
    return replace(base, dma=bytes(dma))


class BonusContactTests(unittest.TestCase):
    def game(self):
        game = MicropinGame(GameConfig(launch_song=()))
        game.step(contact_snapshot(cabinet=0x40))
        game.step(contact_snapshot(cabinet=0x10))
        return game

    def test_c16_adds_bonus_once_per_closure(self):
        game = self.game()
        result = game.step(contact_snapshot(True, outhole=False))
        self.assertEqual(game.context.bonus, 10_000)
        self.assertEqual(game.context.player_scores[0], 0)
        self.assertEqual(result.output.tone_pitch, game.config.bonus_add_sound.pitch)
        game.step(contact_snapshot(True, outhole=False))
        self.assertEqual(game.context.bonus, 10_000)
        game.step(contact_snapshot(outhole=False))
        game.step(contact_snapshot(True, outhole=False))
        self.assertEqual(game.context.bonus, 20_000)

    def test_no_bonus_while_tilted_or_ball_ending(self):
        for flag in ("tilted", "ball_ending"):
            game = self.game()
            setattr(game.context, flag, True)
            game.step(contact_snapshot(True, outhole=False))
            self.assertEqual(game.context.bonus, 0)

    def test_no_bonus_in_game_over(self):
        game = MicropinGame()
        game.step(contact_snapshot(True))
        self.assertEqual(game.context.bonus, 0)


if __name__ == "__main__":
    unittest.main()
