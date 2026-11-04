import unittest
from pathlib import Path
from unittest.mock import patch

from midi_ay import MidiFile, MidiNote, MidiSongConfig, MidiTrack, MidiVoiceConfig
from micropin_game import AySoundAdapter, OutputFrame, ay_hard_mute_update
from micropin_protocol import (
    AY_REGISTER_MASK,
    AyRegisterImage,
    AyRegisterUpdate,
    DisplayFrame,
    build_ay_payload,
    build_control_payload,
)


class AyProtocolTests(unittest.TestCase):
    @staticmethod
    def output(pitch=0xff, duration=0, *, trigger=False):
        return OutputFrame(
            display=DisplayFrame(),
            reflex_enabled=False,
            lamp_bitmap=bytes(5),
            tone_pitch=pitch,
            tone_duration=duration,
            tone_trigger=trigger,
        )

    def test_full_register_image_fits_aperture(self):
        registers = bytes(range(14))
        update = AyRegisterUpdate.from_registers(registers)
        payload = build_control_payload(
            display_window=DisplayFrame(),
            lamp_bitmap=bytes(5),
            ay_update=update,
        )
        self.assertEqual(len(payload), 59)
        self.assertEqual(payload[43:45], AY_REGISTER_MASK.to_bytes(2, "little"))
        self.assertEqual(payload[45:], registers)

    def test_diff_values_are_packed_in_register_order(self):
        update = AyRegisterUpdate.from_registers(
            bytes(range(0x80, 0x80 + 14)),
            (1 << 0) | (1 << 1) | (1 << 8),
        )
        self.assertEqual(update.to_bytes(), b"\x03\x01\x80\x81\x88")
        self.assertEqual(build_ay_payload(update), b"AY\x03\x01\x80\x81\x88")

    def test_image_sends_full_sync_then_only_dirty_registers(self):
        image = AyRegisterImage()
        initial = image.pending_update()
        self.assertEqual(initial.mask, AY_REGISTER_MASK)
        image.acknowledge(initial)
        self.assertEqual(image.pending_update().mask, 0)

        image.set_tone_period(0, 0x0180)
        image.set_volume(0, 1)
        update = image.pending_update()
        self.assertEqual(update.mask, (1 << 0) | (1 << 1) | (1 << 8))
        self.assertEqual(update.values, b"\x80\x01\x01")

    def test_ack_does_not_clear_a_value_changed_while_in_flight(self):
        image = AyRegisterImage()
        first = image.pending_update()
        image.set_register(8, 3)
        image.acknowledge(first)
        self.assertEqual(image.pending_update().mask, 1 << 8)

    def test_envelope_shape_write_retriggers_unchanged_shape(self):
        image = AyRegisterImage()
        initial = image.pending_update()
        image.acknowledge(initial)

        image.set_envelope_period(0x0180)
        image.set_volume(0, 0x10)
        image.trigger_envelope(0)
        update = image.pending_update()
        self.assertEqual(
            update.mask,
            (1 << 8) | (1 << 11) | (1 << 12) | (1 << 13),
        )
        image.acknowledge(update)

        image.trigger_envelope(0)
        retrigger = image.pending_update()
        self.assertEqual(retrigger.mask, 1 << 13)
        self.assertEqual(retrigger.values, b"\x00")

    def test_io_registers_and_malformed_updates_are_rejected(self):
        image = AyRegisterImage()
        with self.assertRaises(ValueError):
            image.set_register(14, 0)
        with self.assertRaises(ValueError):
            AyRegisterUpdate(1 << 14, b"\x00")
        with self.assertRaises(ValueError):
            AyRegisterUpdate(3, b"\x00")

    def test_ay_suffix_requires_full_output_frame(self):
        with self.assertRaises(ValueError):
            build_control_payload(ay_update=AyRegisterUpdate(0, b""))

    def test_zero_mask_is_not_appended_to_a_full_game_frame(self):
        payload = build_control_payload(
            display_window=DisplayFrame(), lamp_bitmap=bytes(5),
            ay_update=AyRegisterUpdate(0, b""),
        )
        self.assertEqual(len(payload), 43)

    def test_hard_mute_disables_every_ay_sound_source(self):
        update = ay_hard_mute_update()
        self.assertEqual(update.mask, AY_REGISTER_MASK)
        registers = dict(zip(range(14), update.values))
        self.assertEqual(registers[7], 0x3F)
        self.assertEqual((registers[8], registers[9], registers[10]), (0, 0, 0))

    def test_game_tones_transparently_drive_ay_channel_a(self):
        adapter = AySoundAdapter()
        initial = adapter.update_for(self.output())
        self.assertEqual(initial.mask, AY_REGISTER_MASK)
        adapter.acknowledge(initial)

        note = adapter.update_for(self.output(0xf0, 0x08))
        self.assertEqual(note.mask, (1 << 0) | (1 << 8))
        self.assertEqual(note.values, b"\xc0\x01")
        adapter.acknowledge(note)

        unchanged = adapter.update_for(self.output())
        self.assertEqual(unchanged.mask, 0)
        silence = adapter.update_for(self.output(0, 0))
        self.assertEqual(silence.mask, 1 << 8)
        self.assertEqual(silence.values, b"\x00")

    def test_repeated_direct_game_tone_forces_a_port9_gate_transaction(self):
        adapter = AySoundAdapter()
        adapter.acknowledge(adapter.update_for(self.output()))

        first = adapter.update_for(self.output(0x87, 0x08, trigger=True))
        adapter.acknowledge(first)
        repeated = adapter.update_for(self.output(0x87, 0x08, trigger=True))

        # Only R8 needs to be resent. The aperture's AY handler translates
        # that otherwise identical write into a fresh port-9 gated note-on.
        self.assertEqual(repeated.mask, 1 << 8)
        self.assertEqual(repeated.values, b"\x01")

    def test_midi_track_uses_channel_b_without_displacing_game_channel_a(self):
        adapter = AySoundAdapter()
        track = MidiTrack(
            0, "test bass", (MidiNote(69, 100, 0.0, 0.5),)
        )
        adapter.start_midi(track, channel=1, volume=2, now=100.0)

        initial = adapter.update_for(self.output(), now=100.0)
        self.assertEqual(initial.mask, AY_REGISTER_MASK)
        registers = dict(zip(
            (index for index in range(14) if initial.mask & (1 << index)),
            initial.values,
        ))
        self.assertEqual(registers[7], 0x3c)  # tone A+B; all noise disabled
        self.assertEqual(registers[2], 142)
        self.assertEqual(registers[3], 0)
        self.assertEqual(registers[9], 2)
        adapter.acknowledge(initial)

        finished = adapter.update_for(self.output(), now=100.5)
        self.assertEqual(finished.mask, 1 << 9)
        self.assertEqual(finished.values, b"\x00")

    def test_gameplay_midi_resumes_its_position_after_a_pause(self):
        adapter = AySoundAdapter()
        track = MidiTrack(0, "test", (MidiNote(69, 100, 0.0, 10.0),))
        song = MidiSongConfig(
            name="test",
            path=Path("test.mid"),
            voices=(MidiVoiceConfig("test", 1, (1,), 2, 142),),
            loop=True,
        )
        midi = MidiFile(480, (track,))
        with patch("micropin_game.load_midi", return_value=midi):
            adapter.configure_gameplay_midi(song)
            adapter.set_gameplay_midi_active(True, now=100.0)
            adapter.update_for(self.output(), now=102.25)
            adapter.set_gameplay_midi_active(False, now=102.25)
            adapter.set_gameplay_midi_active(True, now=107.0)

        # Resuming at 107 seconds recreates the source at its 2.25-second
        # song position, rather than replaying the song from measure one.
        self.assertEqual(len(adapter._midi_song_sources), 1)
        sequencer = adapter._midi_song_sources[0][1]
        self.assertAlmostEqual(sequencer.started_at, 104.75)


if __name__ == "__main__":
    unittest.main()
