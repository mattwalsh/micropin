import unittest

from micropin_game import MicropinGame, GameState
from test_micropin_game import snapshot


def player_one_bytes(output):
    return output.display.to_bytes()[6:9]


class ScoreDisplayDanceTests(unittest.TestCase):
    def test_first_ball_shows_real_zero_until_points_scored(self):
        game = MicropinGame()
        game._display_random.seed(123)
        game.step(snapshot(cabinet=0x40))
        launched = game.step(snapshot(cabinet=0x10))
        next_frame = game.step(snapshot(outhole=False))
        self.assertEqual(player_one_bytes(launched.output), bytes((0xf0, 0xff, 0xff)))
        self.assertEqual(player_one_bytes(launched.output), player_one_bytes(next_frame.output))
        self.assertEqual(game.context.player_scores[0], 0)
        scored = game.step(snapshot(outhole=False, reflex=1))
        self.assertEqual(player_one_bytes(scored.output), bytes((0x25, 0xff, 0xff)))
        self.assertEqual(player_one_bytes(game.step(snapshot(outhole=False)).output), bytes((0x25, 0xff, 0xff)))

    def test_later_ball_and_game_over_show_real_score(self):
        game = MicropinGame()
        self.assertEqual(player_one_bytes(game.initial_output()), bytes((0xf0, 0xff, 0xff)))
        game.context.state = GameState.GAME_PLAYING
        game.context.ball_number = 2
        self.assertEqual(player_one_bytes(game.initial_output()), bytes((0xf0, 0xff, 0xff)))


if __name__ == "__main__":
    unittest.main()
