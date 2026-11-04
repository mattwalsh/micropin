import unittest
from pathlib import Path

from midi_ay import MidiAySequencer, MidiNote, MidiTrack, load_midi, midi_note_to_ay_period
from micropin_protocol import AyRegisterImage


class MidiAyTests(unittest.TestCase):
    def test_chase_pluck_track_is_selectable_and_monophonic(self):
        song = load_midi(Path(__file__).parents[1] / "py_pin/midi/chase.mid")
        track = song.select_track("Synth Pluck (Classic)")
        self.assertEqual(track.index, 0)
        self.assertGreater(len(track.notes), 900)
        self.assertEqual(track.notes[0].note, 34)
        self.assertAlmostEqual(track.notes[0].start_seconds, 1.92)
        self.assertAlmostEqual(song.seconds_at_measure(38), 71.04)

    def test_midi_a4_uses_nominal_ay_period(self):
        self.assertEqual(midi_note_to_ay_period(69), 142)
        self.assertEqual(midi_note_to_ay_period(57), 284)
        self.assertLess(midi_note_to_ay_period(81), 142)

    def test_envelope_voice_retriggers_on_a_note_on(self):
        track = MidiTrack(0, "test", (MidiNote(69, 100, 0.0, 1.0),))
        sequencer = MidiAySequencer(
            track, channel=1, volume=2, loop=False, a4_period=142,
            use_envelope=True, envelope_shape=0x09, started_at=100.0,
        )
        registers = AyRegisterImage()
        sequencer.advance(registers, now=100.0)
        update = registers.pending_update()
        values = dict(zip(
            (index for index in range(14) if update.mask & (1 << index)),
            update.values,
        ))
        self.assertEqual(values[9], 0x10)
        self.assertEqual(values[13], 0x09)

    def test_looping_window_restarts_at_its_own_end(self):
        track = MidiTrack(
            0, "test",
            (MidiNote(60, 100, 0.0, 1.0), MidiNote(72, 100, 5.0, 6.0)),
        )
        sequencer = MidiAySequencer(
            track, channel=1, volume=2, loop=True, a4_period=142,
            started_at=100.0, window_start_seconds=5.0, window_end_seconds=6.0,
        )
        sequencer.advance_timeline(now=100.0)
        self.assertEqual(sequencer.active_notes, [72])
        sequencer.advance_timeline(now=101.0)
        self.assertEqual(sequencer.active_notes, [72])


if __name__ == "__main__":
    unittest.main()
