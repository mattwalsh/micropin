"""Client for the experimental MAME ROMulator bridge.

Protocol v1 sends a complete 64-byte host snapshot with ``MPX1 A <hex>``.
The 8085 sees it at $3000-$303f.  The real Pico implementation can retain
this public API and swap TCP for USB CDC.
"""

from __future__ import annotations

import socket


SNAPSHOT_SIZE = 64
LAMP_OFFSET = 2
LAMP_SIZE = 8
DISPLAY_OFFSET = 10
DISPLAY_SIZE = 32
COIL_OFFSET = DISPLAY_OFFSET + DISPLAY_SIZE
COIL_SIZE = 4


class MicropinBridge:
    """One-controller client for MAME's localhost-only experimental bridge."""

    def __init__(self, host: str = "127.0.0.1", port: int = 8085, timeout: float = 2.0):
        self._socket = socket.create_connection((host, port), timeout=timeout)
        self._socket.settimeout(timeout)
        self._received = bytearray()
        self.snapshot = bytearray(SNAPSHOT_SIZE)

    def close(self) -> None:
        self._socket.close()

    def __enter__(self) -> "MicropinBridge":
        return self

    def __exit__(self, *_: object) -> None:
        self.close()

    def _line(self) -> str:
        while b"\n" not in self._received:
            chunk = self._socket.recv(256)
            if not chunk:
                raise ConnectionError("MAME bridge closed the connection")
            self._received.extend(chunk)
        line, _, remainder = self._received.partition(b"\n")
        self._received = bytearray(remainder)
        return line.decode("ascii").rstrip("\r")

    def _command(self, command: str) -> str:
        self._socket.sendall((command + "\n").encode("ascii"))
        reply = self._line()
        if not reply.startswith("MPX1 L "):
            raise RuntimeError(f"unexpected bridge reply: {reply!r}")
        return reply

    def set_lamps(self, mask: int) -> int:
        """Set A+$02 through A+$09, the 64-bit little-endian lamp bitmap."""
        if not 0 <= mask <= 0xFFFF_FFFF_FFFF_FFFF:
            raise ValueError("lamp mask must fit in 64 bits")
        coils = int.from_bytes(self.snapshot[COIL_OFFSET:COIL_OFFSET + COIL_SIZE], "little")
        self.set_outputs(mask, coils)
        return mask

    def set_coils(self, mask: int) -> int:
        """Set A+$2a through A+$2d, the 32-bit little-endian coil bitmap."""
        if not 0 <= mask <= 0xFFFF_FFFF:
            raise ValueError("coil mask must fit in 32 bits")
        lamps = int.from_bytes(self.snapshot[LAMP_OFFSET:LAMP_OFFSET + LAMP_SIZE], "little")
        self.set_outputs(lamps, mask)
        return mask

    def set_outputs(self, lamps: int, coils: int) -> None:
        """Publish lamp and coil state together in one complete snapshot."""
        if not 0 <= lamps <= 0xFFFF_FFFF_FFFF_FFFF:
            raise ValueError("lamp mask must fit in 64 bits")
        if not 0 <= coils <= 0xFFFF_FFFF:
            raise ValueError("coil mask must fit in 32 bits")
        self.snapshot[LAMP_OFFSET:LAMP_OFFSET + LAMP_SIZE] = lamps.to_bytes(LAMP_SIZE, "little")
        self.snapshot[COIL_OFFSET:COIL_OFFSET + COIL_SIZE] = coils.to_bytes(COIL_SIZE, "little")
        self.set_snapshot(self.snapshot)

    def set_snapshot(self, snapshot: bytes | bytearray) -> None:
        """Publish one complete 64-byte A snapshot at ``$3000-$303f``."""
        if len(snapshot) != SNAPSHOT_SIZE:
            raise ValueError(f"snapshot must be exactly {SNAPSHOT_SIZE} bytes")
        self.snapshot[:] = snapshot
        self._command(f"MPX1 A {self.snapshot.hex().upper()}")

    def set_high_score(self, value: int) -> None:
        """Set the six-digit high-score field in the direct display image."""
        if not 0 <= value <= 999_999:
            raise ValueError("high score must fit in six digits")
        digits = f"{value:06d}"
        self.snapshot[DISPLAY_OFFSET + 0x13] = int(digits[4:6], 16)
        self.snapshot[DISPLAY_OFFSET + 0x14] = int(digits[2:4], 16)
        self.snapshot[DISPLAY_OFFSET + 0x15] = int(digits[0:2], 16)
        self.set_snapshot(self.snapshot)

    def lamps(self) -> int:
        """Read back the currently presented lamp mask."""
        return int(self._command("MPX1 GET").split()[2], 16)
