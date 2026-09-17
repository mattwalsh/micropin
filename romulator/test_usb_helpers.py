import unittest
from pathlib import Path
from unittest.mock import patch

import usb_helpers as usb


class USBHelpersTests(unittest.TestCase):
    def test_mac_serial(self):
        with patch.object(usb.platform, "system", return_value="Darwin"), patch.object(
            usb.glob, "glob", return_value=["/dev/cu.usbmodemEPROM5_001"]
        ):
            self.assertEqual(usb.serial_device(), "/dev/cu.usbmodemEPROM5_001")

    def test_linux_prefers_stable_id(self):
        with patch.object(usb.platform, "system", return_value="Linux"), patch.object(
            usb.glob, "glob", return_value=["/dev/serial/by-id/romulator"]
        ) as glob, patch.object(usb.os.path, "realpath", return_value="/dev/ttyACM0"):
            self.assertEqual(usb.serial_device(), "/dev/ttyACM0")
            self.assertEqual(glob.call_count, 1)

    def test_no_device(self):
        with patch.object(usb.platform, "system", return_value="Linux"), patch.object(
            usb.glob, "glob", return_value=[]
        ):
            with self.assertRaisesRegex(RuntimeError, "no connected"):
                usb.serial_device()

    def test_multiple_devices(self):
        with patch.object(usb.platform, "system", return_value="Darwin"), patch.object(
            usb.glob, "glob", return_value=["/dev/a", "/dev/b"]
        ):
            with self.assertRaisesRegex(RuntimeError, "multiple"):
                usb.serial_device()

    def test_linux_mounted_volume(self):
        with patch.object(usb.platform, "system", return_value="Linux"), patch.object(
            usb, "linux_volumes", return_value=[
                {"name": "/dev/sda", "label": "EPROMEMU", "mountpoints": ["/media/msw/EPROMEMU"]}
            ]
        ):
            self.assertEqual(usb.volume("EPROMEMU"), Path("/media/msw/EPROMEMU"))

    def test_mac_rejects_stale_directory(self):
        with patch.object(usb.platform, "system", return_value="Darwin"), patch.object(
            usb.os.path, "ismount", return_value=False
        ):
            self.assertIsNone(usb.volume("RPI-RP2"))

    def test_linux_mount(self):
        with patch.object(usb.platform, "system", return_value="Linux"), patch.object(
            usb, "linux_volumes", side_effect=[
                [{"name": "/dev/sda", "label": "RPI-RP2", "mountpoints": [None]}],
                [{"name": "/dev/sda", "label": "RPI-RP2", "mountpoints": ["/media/msw/RPI-RP2"]}],
            ]
        ), patch.object(usb.shutil, "which", return_value="/usr/bin/udisksctl"), patch.object(
            usb.subprocess, "run"
        ) as run:
            self.assertEqual(usb.volume("RPI-RP2", mount=True), Path("/media/msw/RPI-RP2"))
            run.assert_called_once_with(["udisksctl", "mount", "--block-device", "/dev/sda"], check=True)


if __name__ == "__main__":
    unittest.main()
