"""Client for the experimental MAME ROMulator bridge.

Protocol v1 sends a complete 64-byte host snapshot with ``MPX1 A <hex>``.
The 8085 sees it at $3000-$303f.  Lamps, displays, coils, tone pitch, and
tone duration occupy offsets $02-$2f.  The real Pico implementation can
retain this public API and swap TCP for USB CDC.
"""

from __future__ import annotations

import socket
import time
from dataclasses import dataclass


SNAPSHOT_SIZE = 64
LAMP_OFFSET = 2
LAMP_SIZE = 8
DISPLAY_OFFSET = 10
DISPLAY_SIZE = 32
COIL_OFFSET = DISPLAY_OFFSET + DISPLAY_SIZE
COIL_SIZE = 4
TONE_PITCH_OFFSET = COIL_OFFSET + COIL_SIZE
TONE_DURATION_OFFSET = TONE_PITCH_OFFSET + 1
SWITCH_SNAPSHOT_SIZE = 64


@dataclass(frozen=True)
class SwitchSnapshot:
    """One acknowledged 8085-to-host switch sample."""

    sequence: int
    dma: bytes
    port0: int
    port1: int
    port4: int
    port5: int

    @property
    def active_contacts(self) -> tuple[int, ...]:
        """One-based inductive contact numbers whose active bit is set."""
        return tuple(index + 1 for index, value in enumerate(self.dma) if value & 0x80)


class MicropinBridge:
    """One-controller client for MAME's localhost-only experimental bridge."""

    def __init__(self, host: str = "127.0.0.1", port: int = 8085, timeout: float = 2.0):
        self._socket = socket.create_connection((host, port), timeout=timeout)
        self._socket.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
        self._socket.settimeout(timeout)
        self._received = bytearray()
        self.snapshot = bytearray(SNAPSHOT_SIZE)
        self._sequence = self._wait_for_initial_sequence()
        self.snapshot[0] = self._sequence

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

    def _command(self, command: str, expected_prefix: str = "MPX1 L ") -> str:
        self._socket.sendall((command + "\n").encode("ascii"))
        reply = self._line()
        if not reply.startswith(expected_prefix):
            raise RuntimeError(f"unexpected bridge reply: {reply!r}")
        return reply

    def sequences(self) -> tuple[int, int]:
        """Return ``(host_sequence, cpu_acknowledgement)``."""
        fields = self._command("MPX1 SEQ", "MPX1 S ").split()
        return int(fields[2], 16), int(fields[3], 16)

    def _wait_for_initial_sequence(self) -> int:
        deadline = time.monotonic() + self._socket.gettimeout()
        while True:
            host_sequence, cpu_ack = self.sequences()
            if host_sequence == cpu_ack:
                return cpu_ack
            if time.monotonic() >= deadline:
                raise TimeoutError("8085 did not acknowledge the existing host snapshot")

    def _wait_until_ready(self) -> None:
        deadline = time.monotonic() + self._socket.gettimeout()
        while True:
            host_sequence, cpu_ack = self.sequences()
            if host_sequence == cpu_ack == self._sequence:
                return
            if time.monotonic() >= deadline:
                raise TimeoutError(
                    f"8085 acknowledgement stalled: host={host_sequence:02x} "
                    f"cpu={cpu_ack:02x} expected={self._sequence:02x}"
                )

    def read_switches(self, timeout: float | None = None) -> SwitchSnapshot:
        """Wait for, acknowledge, and return the next 8085 switch snapshot."""
        wait = self._socket.gettimeout() if timeout is None else timeout
        deadline = time.monotonic() + wait
        while True:
            fields = self._command("MPX1 B", "MPX1 B ").split()
            host_ack = int(fields[2], 16)
            block = bytes.fromhex(fields[3])
            if len(block) != SWITCH_SNAPSHOT_SIZE:
                raise RuntimeError(f"unexpected switch snapshot length: {len(block)}")
            sequence = block[0]
            if sequence != host_ack:
                reply = self._command(f"MPX1 K {sequence:02X}", "MPX1 K ")
                if int(reply.split()[2], 16) != sequence:
                    raise RuntimeError(f"switch acknowledgement failed: {reply!r}")
                return SwitchSnapshot(
                    sequence=sequence,
                    dma=block[2:34],
                    port0=block[34],
                    port1=block[35],
                    port4=block[36],
                    port5=block[37],
                )
            if time.monotonic() >= deadline:
                raise TimeoutError("8085 did not publish a new switch snapshot")

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

    def set_sound(self, pitch: int, duration: int) -> None:
        """Play one tone, or silence it when ``duration`` is zero.

        Values are the logical (pre-inversion) bytes used by Micropin's tone
        tables.  Publishing a nonzero duration starts/restarts the hardware
        one-shot; callers own sequencing melodies and pauses.
        """
        lamps = int.from_bytes(self.snapshot[LAMP_OFFSET:LAMP_OFFSET + LAMP_SIZE], "little")
        coils = int.from_bytes(self.snapshot[COIL_OFFSET:COIL_OFFSET + COIL_SIZE], "little")
        self.set_outputs(lamps, coils, pitch, duration)

    def set_outputs(self, lamps: int, coils: int, pitch: int = 0, duration: int = 0) -> None:
        """Publish lamp, coil, and sound state in one complete snapshot."""
        if not 0 <= lamps <= 0xFFFF_FFFF_FFFF_FFFF:
            raise ValueError("lamp mask must fit in 64 bits")
        if not 0 <= coils <= 0xFFFF_FFFF:
            raise ValueError("coil mask must fit in 32 bits")
        if not 0 <= pitch <= 0xFF:
            raise ValueError("tone pitch must fit in 8 bits")
        if not 0 <= duration <= 0xFF:
            raise ValueError("tone duration must fit in 8 bits")
        self.snapshot[LAMP_OFFSET:LAMP_OFFSET + LAMP_SIZE] = lamps.to_bytes(LAMP_SIZE, "little")
        self.snapshot[COIL_OFFSET:COIL_OFFSET + COIL_SIZE] = coils.to_bytes(COIL_SIZE, "little")
        self.snapshot[TONE_PITCH_OFFSET] = pitch
        self.snapshot[TONE_DURATION_OFFSET] = duration
        self.set_snapshot(self.snapshot)

    def set_snapshot(self, snapshot: bytes | bytearray) -> None:
        """Publish one complete 64-byte A snapshot at ``$3000-$303f``."""
        if len(snapshot) != SNAPSHOT_SIZE:
            raise ValueError(f"snapshot must be exactly {SNAPSHOT_SIZE} bytes")
        self._wait_until_ready()
        self.snapshot[:] = snapshot
        self._sequence = (self._sequence + 1) & 0xFF
        self.snapshot[0] = self._sequence
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
