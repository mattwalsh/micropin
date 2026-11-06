import unittest
from unittest.mock import patch

from led_controller import (
    BLACK_RGB,
    GameLedRenderer,
    LAUNCH_FLIPPER_PULSE_PIXELS,
    LAUNCH_FLIPPER_PULSE_RGB,
    LAUNCH_FLIPPER_PULSE_SECONDS,
    SIDE_CUP_LED_FIRST,
    SIDE_CUP_LED_LAST,
    StripGeometry,
    WAITING_WIPE_RGB,
    WAITING_WIPE_ROWS,
    WAITING_WIPE_SECONDS,
    find_led_device,
)


class LedDeviceDiscoveryTests(unittest.TestCase):
    def test_mac_uses_led_interface(self) -> None:
        with patch("led_controller.platform.system", return_value="Darwin"), patch(
            "led_controller.glob.glob",
            return_value=[
                "/dev/cu.usbmodemEPROM5_00011",
                "/dev/cu.usbmodemEPROM5_00013",
            ],
        ), patch("led_controller.os.path.realpath", side_effect=lambda path: path):
            self.assertEqual(
                find_led_device(), "/dev/cu.usbmodemEPROM5_00013"
            )

    def test_linux_prefers_stable_led_interface(self) -> None:
        def matches(pattern: str) -> list[str]:
            return ["/dev/serial/by-id/romulator-if02"] if "if02" in pattern else []

        with patch("led_controller.platform.system", return_value="Linux"), patch(
            "led_controller.glob.glob", side_effect=matches
        ), patch("led_controller.os.path.realpath", return_value="/dev/ttyACM1"):
            self.assertEqual(
                find_led_device(control_device="/dev/ttyACM0"), "/dev/ttyACM1"
            )

    def test_linux_falls_back_to_acm_port_other_than_control(self) -> None:
        def matches(pattern: str) -> list[str]:
            return ["/dev/ttyACM0", "/dev/ttyACM1"] if pattern == "/dev/ttyACM*" else []

        with patch("led_controller.platform.system", return_value="Linux"), patch(
            "led_controller.glob.glob", side_effect=matches
        ), patch(
            "led_controller.linux_tty_interface", return_value=None
        ), patch("led_controller.os.path.realpath", side_effect=lambda path: path):
            self.assertEqual(
                find_led_device(control_device="/dev/ttyACM0"), "/dev/ttyACM1"
            )

    def test_linux_uses_named_led_interface_without_by_id(self) -> None:
        def matches(pattern: str) -> list[str]:
            return ["/dev/ttyACM0", "/dev/ttyACM1"] if pattern == "/dev/ttyACM*" else []

        with patch("led_controller.platform.system", return_value="Linux"), patch(
            "led_controller.glob.glob", side_effect=matches
        ), patch(
            "led_controller.linux_tty_interface",
            side_effect=lambda path: "Romulator LEDs" if path.endswith("1") else "Romulator Control",
        ), patch("led_controller.os.path.realpath", side_effect=lambda path: path):
            self.assertEqual(
                find_led_device(control_device="/dev/ttyACM0"), "/dev/ttyACM1"
            )


class LedGeometryTests(unittest.TestCase):
    def test_front_back_pairs_are_mirrored(self) -> None:
        geometry = StripGeometry(160)
        self.assertEqual(geometry.rows, 75)
        self.assertEqual(geometry.physical_pair(0), (0, 154))
        self.assertEqual(geometry.physical_pair(74), (74, 80))

    def test_row_colors_land_on_both_halves(self) -> None:
        geometry = StripGeometry(8, ignored_pixels=frozenset())
        pixels = geometry.rows_to_pixels([(1, 2, 3)] * 4)
        self.assertEqual(pixels[:3], bytes((1, 2, 3)))
        self.assertEqual(pixels[-3:], bytes((1, 2, 3)))

    def test_game_strip_uses_the_calibrated_75_row_spans(self) -> None:
        geometry = StripGeometry(160)
        pixels = geometry.rows_to_pixels([(1, 2, 3)] * geometry.rows)
        self.assertEqual(pixels[75 * 3 : 80 * 3], b"\0" * 15)
        self.assertEqual(pixels[155 * 3 : 160 * 3], b"\0" * 15)

    def test_normal_playfield_is_uniform_and_sound_does_not_change_it(self) -> None:
        renderer = GameLedRenderer(StripGeometry(160))
        quiet = renderer.frame(b"\0" * 5, 0xFF, 0)
        lit = renderer.frame(b"\x01" + b"\0" * 4, 0xFF, 0)
        tone = renderer.frame(b"\0" * 5, 0x80, 4)
        self.assertEqual(quiet, lit)
        self.assertEqual(quiet, tone)

    def test_waiting_wipe_is_ten_rows_blackout_and_moves_toward_the_back(self) -> None:
        geometry = StripGeometry(160)
        renderer = GameLedRenderer(geometry)
        pixels = renderer.frame(b"\0" * 5, 0xFF, 0, waiting_for_launch=True, now=0.0)
        # At the start, a full ten-row band starts at the front and every
        # non-band row is black, independent of ordinary lamp state.
        self.assertEqual(pixels[:3], bytes(WAITING_WIPE_RGB))
        row_9_left, _ = geometry.physical_pair(WAITING_WIPE_ROWS - 1)
        row_10_left, _ = geometry.physical_pair(WAITING_WIPE_ROWS)
        self.assertEqual(pixels[row_9_left * 3 : row_9_left * 3 + 3], bytes(WAITING_WIPE_RGB))
        self.assertEqual(pixels[row_10_left * 3 : row_10_left * 3 + 3], bytes(BLACK_RGB))
        later = renderer.frame(
            b"\0" * 5, 0xFF, 0,
            waiting_for_launch=True,
            now=WAITING_WIPE_SECONDS / 2,
        )
        # Halfway through, the ten-row band has moved toward the middle.
        left, right = geometry.physical_pair(37)
        self.assertEqual(later[left * 3 : left * 3 + 3], bytes(WAITING_WIPE_RGB))
        self.assertEqual(later[right * 3 : right * 3 + 3], bytes(WAITING_WIPE_RGB))

    def test_named_launch_wipe_matches_waiting_renderer(self) -> None:
        renderer = GameLedRenderer(StripGeometry(160))
        self.assertEqual(
            renderer.effect_frame("launch_wipe", now=0.5),
            renderer.frame(b"\0" * 5, 0, 0, waiting_for_launch=True, now=0.5),
        )

    def test_launch_flipper_pulse_only_uses_the_final_ten_pixels(self) -> None:
        geometry = StripGeometry(160)
        renderer = GameLedRenderer(geometry)
        # One half-cycle is the bright point of the cosine-shaped breath.
        pixels = renderer.effect_frame(
            "launch_flipper_pulse", now=LAUNCH_FLIPPER_PULSE_SECONDS / 2
        )
        start = geometry.count - LAUNCH_FLIPPER_PULSE_PIXELS
        self.assertEqual(pixels[:start * 3], b"\0" * (start * 3))
        self.assertEqual(pixels[start * 3:], bytes(LAUNCH_FLIPPER_PULSE_RGB) * 10)
        self.assertEqual(
            renderer.effect_frame("launch_flipper_pulse", now=0),
            b"\0" * (geometry.count * 3),
        )

    def test_vivid_rainbow_starts_with_saturated_red(self) -> None:
        renderer = GameLedRenderer(StripGeometry(160))
        frame = renderer.effect_frame("rainbow_vivid", now=0)
        self.assertEqual(frame[:3], bytes((255, 0, 0)))

    def test_fast_rainbow_advances_at_five_times_the_normal_rate(self) -> None:
        renderer = GameLedRenderer(StripGeometry(160))
        self.assertEqual(
            renderer.effect_frame("rainbow_fast", now=0.2),
            renderer.effect_frame("rainbow", now=1.0),
        )

    def test_side_cup_rainbow_only_illuminates_pixels_15_through_25(self) -> None:
        geometry = StripGeometry(160)
        renderer = GameLedRenderer(geometry)
        frame = renderer.effect_frame("side_cup_rainbow", now=0.25)
        self.assertEqual(
            frame[: SIDE_CUP_LED_FIRST * 3],
            b"\0" * (SIDE_CUP_LED_FIRST * 3),
        )
        active = frame[
            SIDE_CUP_LED_FIRST * 3 : (SIDE_CUP_LED_LAST + 1) * 3
        ]
        self.assertNotEqual(
            active,
            b"\0" * ((SIDE_CUP_LED_LAST - SIDE_CUP_LED_FIRST + 1) * 3),
        )
        self.assertEqual(
            frame[(SIDE_CUP_LED_LAST + 1) * 3 :],
            b"\0" * ((geometry.count - SIDE_CUP_LED_LAST - 1) * 3),
        )


if __name__ == "__main__":
    unittest.main()
