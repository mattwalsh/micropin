import unittest
from pathlib import Path
from tempfile import TemporaryDirectory

from midi_ay import load_midi_song_config
from micropin_protocol import legacy_pitch_to_ay_period


class SoundApertureTests(unittest.TestCase):
    def test_legacy_frequency_values_become_reciprocal_ay_periods(self):
        self.assertEqual(legacy_pitch_to_ay_period(0), 0)
        self.assertEqual(legacy_pitch_to_ay_period(0x78), 0x180)
        self.assertEqual(legacy_pitch_to_ay_period(0xf0), 0x0c0)

    def test_chase_selects_the_pluck_bass_line(self):
        config = load_midi_song_config(
            Path(__file__).with_name("micropin_game.toml"), "chase"
        )
        self.assertEqual(len(config.voices), 2)
        self.assertEqual(config.voices[0].track, "Synth Pluck (Classic)")
        self.assertEqual(config.voices[1].track, "Clean Guitar")
        self.assertEqual(config.voices[1].channel, 2)
        self.assertEqual([voice.volume for voice in config.voices], [2, 2])
        self.assertTrue(config.path.is_file())

    def test_popcorn_selects_jazz_guitar_and_triangle(self):
        config = load_midi_song_config(
            Path(__file__).with_name("micropin_game.toml"), "popcorn"
        )
        self.assertEqual(
            [(voice.track, voice.channel) for voice in config.voices],
            [("Jazz Guitar", 0), ("8-Bit Triangle", 1), ("Electric Drum Kit", 2)],
        )
        self.assertTrue(config.voices[2].use_envelope)
        self.assertFalse(config.voices[2].use_tone)
        self.assertTrue(config.voices[2].use_noise)
        self.assertIsNotNone(config.noise_period)
        self.assertTrue(config.path.is_file())

    def test_global_song_and_voice_envelope_defaults(self):
        with TemporaryDirectory() as temporary_directory:
            config_path = Path(temporary_directory) / "test.toml"
            config_path.write_text(
                """
[audio]
midi_use_envelope = true
midi_envelope_period = 0x0400
midi_envelope_shape = 0x09

[midi_songs.demo]
file = "demo.mid"
use_envelope = false

[[midi_songs.demo.voices]]
track = "lead"
channel = 0

[[midi_songs.demo.voices]]
track = "drum"
channel = 1
use_envelope = true

[midi_songs.all_global]
file = "all_global.mid"

[[midi_songs.all_global.voices]]
track = "all"
channel = 0
"""
            )
            config = load_midi_song_config(config_path, "demo")
            all_global = load_midi_song_config(config_path, "all_global")

        # The song default overrides the global audition switch, while a
        # voice can explicitly opt back into the same global envelope.
        self.assertEqual([voice.use_envelope for voice in config.voices], [False, True])
        self.assertEqual(config.envelope_period, 0x0400)
        self.assertEqual(config.envelope_shape, 0x09)
        self.assertTrue(all_global.voices[0].use_envelope)
        self.assertEqual(all_global.envelope_period, 0x0400)
