import unittest

from micropin_game import (
    FOREVER,
    GameConfig,
    MicropinGame,
    SongNote,
    SoundController,
    SoundMode,
    SoundSequence,
    Tone,
)
from test_micropin_game import snapshot


class SoundControllerTests(unittest.TestCase):
    def test_loop_uses_each_notes_own_onset_interval(self):
        now = [0.0]
        controller = SoundController(clock=lambda: now[0])
        first = Tone(0x70, SoundMode.LONG)
        second = Tone(0x80, SoundMode.LONG)
        controller.play(
            SoundSequence(
                "variable_timing",
                (
                    SongNote(first, 0.10),
                    SongNote(second, 0.30),
                ),
                repeat=FOREVER,
            )
        )

        self.assertEqual(controller.advance(), first)
        now[0] = 0.09
        self.assertIsNone(controller.advance())
        now[0] = 0.10
        self.assertEqual(controller.advance(), second)
        now[0] = 0.39
        self.assertIsNone(controller.advance())
        now[0] = 0.40
        self.assertEqual(controller.advance(), first)

    def test_direct_bumper_wins_without_cancelling_background_loop(self):
        now = [0.0]
        background = Tone(0x70, SoundMode.LONG)
        game = MicropinGame(
            GameConfig(
                boot_song=(),
                start_song=(),
                launch_song=(),
                gameplay_song=(SongNote(background, 0.10),),
            ),
            clock=lambda: now[0],
        )
        game.step(snapshot(cabinet=0x40))
        launched = game.step(snapshot(cabinet=0x10))
        self.assertEqual(launched.output.tone_pitch, background.pitch)

        now[0] = 0.10
        bumper = game.step(snapshot(reflex=0x01, outhole=False))
        self.assertEqual(
            bumper.output.tone_pitch, game.config.reflex_sounds[0].pitch
        )

        now[0] = 0.20
        resumed = game.step(snapshot(outhole=False))
        self.assertEqual(resumed.output.tone_pitch, background.pitch)


if __name__ == "__main__":
    unittest.main()
