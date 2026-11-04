import unittest

from random_lamp_test import send_and_verify, ResponseMismatch


class FakeSerial:
    timeout = 1

    def __init__(self, frame):
        self.frame = frame

    def command(self, command):
        if command.startswith("tx "):
            return "tx 42"
        frame, self.frame = self.frame, b""
        return "rx " + frame.hex()


class CompactResponseTests(unittest.TestCase):
    def test_compact_v2_expands_packed_contacts(self):
        packed = bytes((0x01, 0x80, 0x04, 0x10))
        sequence, ports, dma = send_and_verify(
            FakeSerial(b"\x42\x08\x00\x01\x02\x03" + packed), b"hello"
        )
        self.assertEqual((sequence, ports), (0x42, (0, 1, 2, 3)))
        self.assertEqual(len(dma), 32)
        self.assertEqual(dma[0], 0x00)
        self.assertEqual(dma[15], 0x00)
        self.assertEqual(dma[18], 0x00)
        self.assertEqual(dma[28], 0x00)
        self.assertEqual(dma[1], 0x10)

    def test_compact(self):
        switches = bytes(range(36))
        sequence, ports, dma = send_and_verify(FakeSerial(b"\x42\x24" + switches), b"hello")
        self.assertEqual((sequence, ports, dma), (0x42, (0, 1, 2, 3), switches[4:]))

    def test_echo_compatible(self):
        switches = bytes(range(36))
        sequence, ports, dma = send_and_verify(FakeSerial(b"\x42\x29hello" + switches), b"hello")
        self.assertEqual((sequence, ports, dma), (0x42, (0, 1, 2, 3), switches[4:]))

    def test_bad_sequence(self):
        with self.assertRaises(ResponseMismatch):
            send_and_verify(FakeSerial(b"\x41\x24" + bytes(36)), b"hello")

    def test_bad_echo(self):
        with self.assertRaises(ResponseMismatch):
            send_and_verify(FakeSerial(b"\x42\x29wrong" + bytes(36)), b"hello")


if __name__ == "__main__":
    unittest.main()
