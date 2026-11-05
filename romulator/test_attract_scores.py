import tempfile
import unittest
from pathlib import Path

from micropin_game import (DEFAULT_HIGH_SCORES, GameState, MicropinGame,
                           score_digits, load_game_config)
from test_micropin_game import snapshot, spread_digits


class AttractScoreTests(unittest.TestCase):
    def test_match_flashes_only_final_score_digit_on_last_game_page(self):
        now = [0.0]
        game = MicropinGame(clock=lambda: now[0])
        game.context.players_in_game = 2
        game.context.player_scores = [123, 124, 0, 0]
        game._enter_state(GameState.MATCH_SEQUENCE)
        game.context.match_step = 6
        game.context.match_digit = 3
        game.step(snapshot())
        self.assertEqual(game._matched_players, {1})
        self.assertEqual(spread_digits(game.initial_output()), 'f60000')
        now[0] = 0.25
        window = game.initial_output().display.to_bytes()
        self.assertEqual(window[6:9], bytes.fromhex('2ff1ff'))
        self.assertEqual(window[13:16], bytes.fromhex('24f1ff'))
        self.assertEqual(spread_digits(game.initial_output()), 'f60000')
        # The high-score display always owns the former match position once
        # the live match animation has completed.
        game.high_scores[0] = 123
        game._new_high_score_ranks.clear()
        now[0] = 5.25
        self.assertEqual(game.initial_output().display.to_bytes()[6:9],
                         bytes.fromhex('0000f5'))
        self.assertEqual(spread_digits(game.initial_output()), 'fff123')
        game.step(snapshot(cabinet=0x40))
        self.assertEqual(game._matched_players, set())

    def test_configured_defaults_initialize_and_reset_without_overwriting_saved_scores(self):
        with tempfile.TemporaryDirectory() as directory:
            config_path = Path(directory) / 'game.toml'
            config_path.write_text('[high_scores]\ndefaults = [10, 20, 30, 40, 50, 60]\n')
            config = load_game_config(config_path)
            nvram = Path(directory) / 'nvram.json'
            game = MicropinGame(config, nvram_path=nvram)
            self.assertEqual(game.high_scores, [60, 50, 40, 30, 20, 10])
            game.high_scores = [99, 88, 77, 66, 55, 44]
            game._save_nvram()
            restored = MicropinGame(config, nvram_path=nvram)
            self.assertEqual(restored.high_scores, game.high_scores)
            restored.reset_high_scores()
            self.assertEqual(restored.high_scores, [60, 50, 40, 30, 20, 10])
            for invalid in ('[1, 2]', '[1, 2, 3, 4, 5, -1]', '[1, 2, 3, 4, 5, true]'):
                config_path.write_text(f'[high_scores]\ndefaults = {invalid}\n')
                with self.assertRaises(ValueError):
                    load_game_config(config_path)

    def test_high_score_tributes_precede_match_and_awards_are_not_repeated(self):
        now = [0.0]
        game = MicropinGame(clock=lambda: now[0])
        game.context.ball_number = game.config.balls_per_game
        game.context.player_scores[0] = 70000
        game._finish_ball([])
        self.assertIs(game.context.state, GameState.HIGH_SCORE)
        self.assertEqual(game.context.credits, 1)
        self.assertEqual(game.high_scores[0], 70000)
        self.assertEqual(game._song, game.config.high_score_song)
        now[0] = game._tribute_until
        game.step(snapshot())
        self.assertIs(game.context.state, GameState.MATCH_SEQUENCE)
        game.step(snapshot(cabinet=0x40))
        self.assertEqual(game.context.credits, 0)  # Award spent once, not twice.
        self.assertEqual(game.recent_games, [70000])

    def test_new_top_high_score_flashes_in_the_former_match_display(self):
        now = [0.0]
        game = MicropinGame(clock=lambda: now[0])
        game.context.players_in_game = 2
        game.context.player_scores = [70000, 25000, 0, 0]
        game._record_completed_game()
        game._high_score_tributes.clear()
        self.assertEqual(game._new_high_score_ranks, {0, 5})
        now[0] = 5.0
        on = game.initial_output().display.to_bytes()
        self.assertEqual(spread_digits(game.initial_output()), 'f70000')
        self.assertEqual(on[6:9], bytes.fromhex('0000f6'))
        now[0] = 5.25
        off = game.initial_output().display.to_bytes()
        self.assertEqual(spread_digits(game.initial_output()), 'ffffff')
        self.assertEqual(off[6:9], bytes.fromhex('0000f6'))

    def test_match_position_order_and_blank_numeric_padding(self):
        now = [0.0]
        game = MicropinGame(clock=lambda: now[0])
        game._enter_state(GameState.MATCH_SEQUENCE)
        for index, position in enumerate((5, 0, 1, 4, 3, 2)):
            frame = game.step(snapshot()).output
            digits = spread_digits(frame)
            self.assertEqual(digits[position], str(game.context.match_digit))
            self.assertEqual(digits.count('f'), 5)
            now[0] = game.context.next_match_time
        window = frame.display.to_bytes()
        self.assertEqual(window[0:3], bytes.fromhex('f0ffff'))
        self.assertEqual(window[26], 0xf0)

    def test_config_high_score_cue_uses_the_requested_cantina_excerpt(self):
        config = load_game_config(Path(__file__).with_name('micropin_game.toml'))
        cue = config.cue('high_score')
        self.assertEqual(cue.midi, 'cantina')
        self.assertEqual((cue.start_measure, cue.end_measure), (11, 27))
        self.assertEqual(cue.light_effect, 'rainbow')

    def test_start_during_match_settles_high_scores_silently_before_reset(self):
        game = MicropinGame()
        game.context.state = GameState.MATCH_SEQUENCE
        game.context.players_in_game = 2
        game.context.player_scores = [70000, 80000, 999999, 999999]
        game.step(snapshot(cabinet=0x40))
        self.assertIs(game.context.state, GameState.WAITING_FOR_LAUNCH)
        self.assertEqual(game.context.credits, 1)  # Two awards minus new entry.
        self.assertEqual(game.high_scores[:2], [80000, 70000])
        self.assertEqual(game.recent_games, [80000])
        self.assertEqual(game.context.player_scores, [0, 0, 0, 0])
        self.assertEqual(game._high_score_tributes, [])
        self.assertIsNone(game._tribute_player)
        self.assertEqual(game._song, game.config.start_song)

    def test_start_interrupts_tribute_and_every_attract_phase_without_double_awards(self):
        for phase in (0, 4.5, 5.0, 9.5):
            now = [0.0]
            game = MicropinGame(clock=lambda: now[0])
            game.context.player_scores = [70000, 0, 0, 0]
            game._record_completed_game()
            game._advance_high_score_tributes()
            if phase:
                now[0] = game._tribute_until
                game._advance_high_score_tributes()
                now[0] += phase
            game.step(snapshot(cabinet=0x40))
            self.assertIs(game.context.state, GameState.WAITING_FOR_LAUNCH)
            self.assertEqual(game.context.credits, 0)
            self.assertEqual(game.high_scores[0], 70000)
            self.assertEqual(game.recent_games, [70000])
            self.assertEqual(game._high_score_tributes, [])
            self.assertIsNone(game._tribute_player)

    def test_attract_cycle_and_blank_padding(self):
        now = [0.0]
        game = MicropinGame(clock=lambda: now[0])
        game.context.player_scores = [123, 45, 0, 0]
        game.context.players_in_game = 2
        game._display_random.seed(1)
        last = game.initial_output().display.to_bytes()
        self.assertEqual(last[6:9], bytes.fromhex('23f1ff'))
        self.assertEqual(last[3:6], b'\xff' * 3)
        self.assertEqual(last[9:12], b'\xff' * 3)
        now[0] = 4.49
        self.assertEqual(game.initial_output().display.to_bytes()[6:9], last[6:9])
        now[0] = 4.5
        random_frame = game.initial_output().display.to_bytes()
        self.assertNotEqual(random_frame[3:6], b'\xff' * 3)
        self.assertEqual(random_frame[9:12], b'\xff' * 3)
        self.assertEqual(random_frame[12] & 15, 15)
        self.assertEqual(random_frame[22] & 15, 15)
        now[0] = 5.0
        high = game.initial_output().display.to_bytes()
        self.assertEqual(spread_digits(game.initial_output()), 'f60000')
        self.assertEqual(high[6:9], bytes.fromhex('0000f5'))
        self.assertEqual(high[9:12], b'\xff' * 3)
        self.assertEqual(high[12] & 15, 15)
        now[0] = 9.5
        self.assertNotEqual(game.initial_output().display.to_bytes()[6:9], high[6:9])
        now[0] = 10.0
        self.assertEqual(game.initial_output().display.to_bytes()[6:9], last[6:9])
        self.assertEqual(score_digits(0), 'fffff0')

    def test_old_cutoff_rewards_even_scores_displaced_by_other_players(self):
        game = MicropinGame()
        game.high_scores = [60000, 50000, 40000, 30000, 11000, 10000]
        game.context.players_in_game = 2
        game.context.player_scores = [10500, 10750, 999999, 999999]
        game._record_completed_game()
        self.assertEqual(game.context.credits, 2)
        self.assertEqual(game.high_scores, [60000, 50000, 40000, 30000, 11000, 10750])
        self.assertEqual(game._high_score_tributes, [1, 2])

    def test_duplicates_persistence_reset_and_tribute_spacing(self):
        now = [0.0]
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'nvram.json'
            game = MicropinGame(clock=lambda: now[0], nvram_path=path)
            game.context.players_in_game = 2
            game.context.player_scores = [70000, 70000, 0, 0]
            game.context.credits = 98
            game._record_completed_game()
            self.assertEqual(game.context.credits, 99)
            self.assertEqual(game.high_scores[:2], [70000, 70000])
            self.assertEqual(MicropinGame(nvram_path=path).high_scores, game.high_scores)
            game._advance_high_score_tributes()
            self.assertEqual(game._tribute_player, 1)
            until = game._tribute_until
            now[0] = until - 0.001
            game._advance_high_score_tributes()
            self.assertEqual(game._tribute_player, 1)
            now[0] = until
            game._advance_high_score_tributes()
            self.assertEqual(game._tribute_player, 2)
            now[0] = game._tribute_until
            game._advance_high_score_tributes()
            self.assertIsNone(game._tribute_player)
            self.assertEqual(game._attract_started, now[0])
            game.reset_high_scores()
            self.assertEqual(MicropinGame(nvram_path=path).high_scores, list(DEFAULT_HIGH_SCORES))
