import unittest

from lamp_coordinates import PLAYFIELD_LAMP_COORDINATES, lamp_bitmap, wavefront_lamps


class LampCoordinateTests(unittest.TestCase):
    def test_coordinates_include_calibrated_playfield_lamps(self) -> None:
        self.assertIn(17, PLAYFIELD_LAMP_COORDINATES)
        self.assertEqual(len(PLAYFIELD_LAMP_COORDINATES), 28)

    def test_wavefront_is_bounded_and_moves(self) -> None:
        first = wavefront_lamps(0.0, thickness=0)
        last = wavefront_lamps(1.0, thickness=0)
        self.assertTrue(first)
        self.assertTrue(last)
        self.assertNotEqual(first, last)

    def test_bitmap_packs_lamp_numbers(self) -> None:
        self.assertEqual(lamp_bitmap((0, 8, 37)), bytes((1, 1, 0, 0, 0x20)))


if __name__ == "__main__":
    unittest.main()
