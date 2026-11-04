import unittest
from pathlib import Path
from tempfile import TemporaryDirectory

from micropin_game import (
    GameConfig,
    GameState,
    MicropinGame,
    SongNote,
    SoundMode,
    Tone,
    load_game_config,
)
from test_micropin_game import snapshot


class SoundCueTests(unittest.TestCase):
    def test_tone_rejects_unsafe_raw_sound_modes(self):
        for unsafe in (0x02, 0x03, 0x10, 0x20, 0x24, 0x28, 0x2c):
            with self.subTest(mode=unsafe), self.assertRaises(ValueError):
                Tone(0x78, unsafe)
        self.assertEqual(Tone(0, SoundMode.SILENCE).duration, 0)

    def test_three_x_bonus_presents_two_x_then_three_x_before_counting(self):
        now = [20.0]
        two_x = (SongNote(Tone(0xa2, 4), 0.1),)
        three_x = (SongNote(Tone(0xa3, 4), 0.1),)
        game = MicropinGame(
            GameConfig(
                bonus_multiplier_pause_seconds=0.5,
                bonus_2x_song=two_x,
                bonus_3x_song=three_x,
            ),
            clock=lambda: now[0],
        )
        game.context.bonus = 12_000
        game._begin_bonus_payout(3, return_to_play=False, messages=[])

        waiting = game.step(snapshot())
        self.assertEqual(game.context.bonus, 12_000)
        self.assertEqual(waiting.output.tone_pitch, 0xff)

        now[0] += game.config.bonus_entry_pause_seconds + 0.001
        doubled = game.step(snapshot())
        self.assertEqual(game.context.bonus, 24_000)
        self.assertEqual(doubled.output.tone_pitch, 0xa2)
        self.assertEqual(game.context.player_scores[0], 0)

        now[0] += 0.501
        tripled = game.step(snapshot())
        self.assertEqual(game.context.bonus, 36_000)
        self.assertEqual(tripled.output.tone_pitch, 0xa3)
        self.assertEqual(game.context.player_scores[0], 0)

        now[0] += 0.501
        game.step(snapshot())
        self.assertEqual(game.context.bonus, 35_000)
        self.assertEqual(game.context.player_scores[0], 1000)

    def test_song_leaves_ports_alone_between_notes_and_stops_at_end(self):
        now = [0.0]
        song = (SongNote(Tone(0x49, 0x0c), 0.3),)
        game = MicropinGame(GameConfig(boot_song=song), clock=lambda: now[0])
        first = game.step(snapshot()).output
        self.assertEqual((first.tone_pitch, first.tone_duration), (0x49, 0x0c))
        now[0] = 0.1
        held = game.step(snapshot()).output
        self.assertEqual((held.tone_pitch, held.tone_duration), (0xff, 0))
        now[0] = 0.3
        stop = game.step(snapshot()).output
        self.assertEqual((stop.tone_pitch, stop.tone_duration), (0, 0))
        quiet = game.step(snapshot()).output
        self.assertEqual((quiet.tone_pitch, quiet.tone_duration), (0xff, 0))

    def test_single_effect_expires_and_rest_is_explicit_silence(self):
        now = [0.0]
        game = MicropinGame(
            GameConfig(boot_song=(), start_song=(), launch_song=()),
            clock=lambda: now[0],
        )
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        game.step(snapshot(outhole=False, reflex=1))
        now[0] = 0.05
        self.assertEqual(game.step(snapshot()).output.tone_pitch, 0xff)
        now[0] = 0.15
        self.assertEqual(game.step(snapshot()).output.tone_pitch, 0)
        game._start_song((SongNote(Tone(0, 0), 0.2),))
        rest = game.step(snapshot()).output
        self.assertEqual((rest.tone_pitch, rest.tone_duration), (0, 0))

    def test_bonus_pause_starts_at_final_payout(self):
        now = [10.0]
        game = MicropinGame(clock=lambda: now[0])
        game.context.state = GameState.BONUS_PROCESSING
        game.context.bonus = 1000
        game.context.next_bonus_time = now[0]
        result = game.step(snapshot())
        self.assertEqual(game.context.bonus, 0)
        self.assertNotEqual(result.output.tone_duration, 0)
        self.assertIs(game.context.state, GameState.BONUS_PROCESSING)
        now[0] += 0.749
        quiet = game.step(snapshot())
        self.assertIs(game.context.state, GameState.BONUS_PROCESSING)
        self.assertEqual(quiet.output.tone_duration, 0)
        now[0] += 0.002
        game.step(snapshot())
        self.assertIs(game.context.state, GameState.WAITING_FOR_LAUNCH)

    def test_every_bonus_payout_tick_plays_tone(self):
        now = [10.0]
        tone = Tone(0x94, 4)
        game = MicropinGame(GameConfig(bonus_payout_sound=tone), clock=lambda: now[0])
        game.context.state = GameState.BONUS_PROCESSING
        game.context.bonus = 3000
        game.context.next_bonus_time = now[0]
        for remaining in (2000, 1000, 0):
            result = game.step(snapshot())
            self.assertEqual(game.context.bonus, remaining)
            self.assertEqual((result.output.tone_pitch, result.output.tone_duration), (tone.pitch, tone.duration))
            if remaining:
                self.assertEqual(game.step(snapshot()).output.tone_duration, 0)
            now[0] += game.config.bonus_tick_seconds + 0.001
        self.assertIs(game.context.state, GameState.BONUS_PROCESSING)
        now[0] += game.config.bonus_pause_seconds
        game.step(snapshot())
        self.assertIs(game.context.state, GameState.WAITING_FOR_LAUNCH)

    def test_bonus_add_uses_configured_tone_once(self):
        tone = Tone(0x87, 4)
        game = MicropinGame(GameConfig(launch_song=(), bonus_add_sound=tone))
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        result = game.step(snapshot(outhole=False, inlanes=1))
        self.assertEqual((result.output.tone_pitch, result.output.tone_duration), (tone.pitch, tone.duration))
        self.assertEqual(game.context.bonus, 1000)
        self.assertEqual(game.step(snapshot(outhole=False, inlanes=1)).output.tone_duration, 0)

    def test_end_ball_after_settle_not_initial_contact(self):
        now = [10.0]
        tone = Tone(0x78, 4)
        game = MicropinGame(GameConfig(launch_song=(), end_ball_sound=tone), clock=lambda: now[0])
        game.step(snapshot(cabinet=0x40))
        game.step(snapshot(cabinet=0x10))
        game.step(snapshot(outhole=False, reflex=1))
        now[0] += 5
        first = game.step(snapshot(outhole=True))
        self.assertEqual(first.output.tone_duration, 0)
        now[0] += 0.6
        result = game.step(snapshot(outhole=True))
        self.assertIs(game.context.state, GameState.BONUS_PROCESSING)
        self.assertEqual((result.output.tone_pitch, result.output.tone_duration), (tone.pitch, tone.duration))

    def test_launch_plays_five_notes_and_dry_launch_is_silent(self):
        now = [10.0]
        game = MicropinGame(clock=lambda: now[0])
        game.step(snapshot(cabinet=0x40))
        self.assertEqual(game.step(snapshot(cabinet=0x10, outhole=False)).output.tone_duration, 0)
        result = game.step(snapshot(cabinet=0x10))
        observed = [result.output.tone_pitch]
        for note in game.config.launch_song[:-1]:
            now[0] += note.interval_seconds + 0.001
            observed.append(game.step(snapshot(outhole=False)).output.tone_pitch)
        self.assertEqual(observed, [note.tone.pitch for note in game.config.launch_song])
        self.assertEqual(len(observed), 5)

    def test_config_has_new_cues(self):
        config = load_game_config(Path(__file__).with_name("micropin_game.toml"))
        self.assertEqual(len(config.launch_song), 5)
        self.assertEqual(config.default_sound_mode, SoundMode.MEDIUM)
        self.assertEqual(config.match_percentage, 0.1)
        self.assertEqual(config.bonus_add_sound, Tone(0x87, SoundMode.MEDIUM))
        self.assertEqual(config.end_ball_sound, Tone(0x15, SoundMode.MEDIUM))
        self.assertEqual(
            dict(config.song_library)["funkytown"], config.high_score_song
        )

    def test_compact_song_mode_hierarchy(self):
        with TemporaryDirectory() as directory:
            path = Path(directory) / "game.toml"
            path.write_text(
                """
[sound]
default_mode = "medium"

[music]
high_score = "demo"
boot = "fallback"

[sounds.bonus_add]
pitch = 0x87

[songs.demo]
mode = "long"
speedup = 0.5
notes = [
    { pitch = 0x70, seconds = 0.10 },
    { pitch = 0x80, mode = "short", seconds = 0.20 },
    { pitch = 0x00, seconds = 0.30 },
]

[songs.fallback]
notes = [{ pitch = 0x90, seconds = 0.10 }]
""".strip()
            )
            config = load_game_config(path)

        self.assertEqual(config.default_sound_mode, SoundMode.MEDIUM)
        self.assertEqual(config.bonus_add_sound.mode, SoundMode.MEDIUM)
        self.assertEqual(config.boot_song[0].tone.mode, SoundMode.MEDIUM)
        self.assertEqual(
            tuple(note.tone.mode for note in config.high_score_song),
            (SoundMode.LONG, SoundMode.SHORT, SoundMode.SILENCE),
        )
        self.assertEqual(
            tuple(note.interval_seconds for note in config.high_score_song),
            (0.20, 0.40, 0.60),
        )

    def test_match_percentage_rejects_values_outside_probability_range(self):
        for percentage in (-0.01, 1.0001):
            with self.subTest(percentage=percentage), TemporaryDirectory() as directory:
                path = Path(directory) / "game.toml"
                path.write_text(f"[match]\npercentage = {percentage}\n")
                with self.assertRaisesRegex(
                    ValueError, r"match\.percentage"
                ):
                    load_game_config(path)


if __name__ == "__main__":
    unittest.main()
