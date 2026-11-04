import unittest

from micropin_game import FOREVER, LampController, LampSequence, LampStep


def lamp_is_on(bitmap: bytes, lamp: int) -> bool:
    return bool(bitmap[lamp // 8] & (1 << (lamp % 8)))


class LampControllerTests(unittest.TestCase):
    def test_global_flash_phase_and_persistent_modes(self) -> None:
        now = [0.0]
        lamps = LampController(clock=lambda: now[0], flash_hz=2.0)
        lamps.flash((1, 7))
        lamps.on(2)
        lamps.off(3)
        baseline = bytes((0x08, 0, 0, 0, 0))

        lit = lamps.render(baseline)
        self.assertTrue(lamp_is_on(lit, 1))
        self.assertTrue(lamp_is_on(lit, 7))
        self.assertTrue(lamp_is_on(lit, 2))
        self.assertFalse(lamp_is_on(lit, 3))

        now[0] = 0.25
        dark = lamps.render(baseline)
        self.assertFalse(lamp_is_on(dark, 1))
        self.assertFalse(lamp_is_on(dark, 7))
        self.assertTrue(lamp_is_on(dark, 2))

        lamps.relinquish(3)
        self.assertTrue(lamp_is_on(lamps.render(baseline), 3))

    def test_sequence_repeats_total_pass_count_and_reveals_live_baseline(self) -> None:
        now = [0.0]
        lamps = LampController(clock=lambda: now[0])
        sequence = LampSequence(
            name="chase",
            controls=frozenset((1, 2)),
            steps=(
                LampStep(on=frozenset((1,)), duration=0.1),
                LampStep(on=frozenset((2,)), duration=0.1),
            ),
            repeat=3,
        )
        handle = lamps.play(sequence)

        self.assertTrue(lamp_is_on(lamps.render(bytes(5)), 1))
        now[0] = 0.15
        self.assertTrue(lamp_is_on(lamps.render(bytes(5)), 2))
        now[0] = 0.45
        self.assertTrue(lamp_is_on(lamps.render(bytes(5)), 1))

        # The baseline changes while hidden.  It appears at 0.6 seconds when
        # the third and final pass has completed.
        baseline = bytes((1 << 2, 0, 0, 0, 0))
        now[0] = 0.61
        rendered = lamps.render(baseline)
        self.assertTrue(handle.finished)
        self.assertFalse(lamp_is_on(rendered, 1))
        self.assertTrue(lamp_is_on(rendered, 2))

    def test_forever_sequence_runs_until_handle_is_cancelled(self) -> None:
        now = [0.0]
        lamps = LampController(clock=lambda: now[0])
        handle = lamps.play(
            LampSequence(
                name="forever",
                controls=frozenset((4,)),
                steps=(LampStep(on=frozenset((4,)), duration=0.1),),
                repeat=FOREVER,
            )
        )
        now[0] = 1000.0
        self.assertTrue(lamp_is_on(lamps.render(bytes(5)), 4))
        self.assertFalse(handle.finished)
        handle.cancel()
        self.assertTrue(handle.finished)
        self.assertFalse(lamp_is_on(lamps.render(bytes(5)), 4))


if __name__ == "__main__":
    unittest.main()
