"""Client for the experimental MAME ROMulator bridge.

Protocol v1 sends a complete 64-byte host snapshot with ``MPX1 A <hex>``.
The 8085 sees it at $3000-$303f.  Lamps, displays, coils, tone pitch, and
tone duration occupy offsets $02-$2f.  A separate 64-byte coil configuration
mailbox C is at $3080-$30bf.  The real Pico implementation can retain this
public API and swap TCP for USB CDC.
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
CONFIG_SIZE = 64
CONFIG_DURATION_OFFSET = 2
CONFIG_DURATION_SIZE = 32
CONFIG_CANCEL_POLICY_OFFSET = CONFIG_DURATION_OFFSET + CONFIG_DURATION_SIZE
CONFIG_RENEW_POLICY_OFFSET = CONFIG_CANCEL_POLICY_OFFSET + 4


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
        self.coil_configuration = bytearray(CONFIG_SIZE)
        self._config_sequence = self._wait_for_initial_config_sequence()
        self.coil_configuration[0] = self._config_sequence

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

    def config_sequences(self) -> tuple[int, int]:
        """Return ``(host_configuration_sequence, cpu_acknowledgement)``."""
        fields = self._command("MPX1 CSEQ", "MPX1 CS ").split()
        return int(fields[2], 16), int(fields[3], 16)

    def _wait_for_initial_config_sequence(self) -> int:
        deadline = time.monotonic() + self._socket.gettimeout()
        while True:
            host_sequence, cpu_ack = self.config_sequences()
            if host_sequence == cpu_ack:
                return cpu_ack
            if time.monotonic() >= deadline:
                raise TimeoutError("8085 did not acknowledge the existing coil configuration")

    def _wait_until_config_ready(self) -> None:
        deadline = time.monotonic() + self._socket.gettimeout()
        while True:
            host_sequence, cpu_ack = self.config_sequences()
            if host_sequence == cpu_ack == self._config_sequence:
                return
            if time.monotonic() >= deadline:
                raise TimeoutError(
                    f"8085 coil configuration stalled: host={host_sequence:02x} "
                    f"cpu={cpu_ack:02x} expected={self._config_sequence:02x}"
                )

    def configure_coils(self, durations: bytes | bytearray | list[int] | tuple[int, ...],
                        cancel_on_clear: int = 0,
                        renew_while_active: int = 0) -> None:
        """Install timer values and the two 32-bit coil policy masks.

        Duration zero disables a coil.  A clear A-command bit lets an existing
        timer expire naturally unless its bit is set in ``cancel_on_clear``.
        An asserted command starts an idle coil, but only reloads a running
        timer when its bit is set in ``renew_while_active``.
        """
        if len(durations) != CONFIG_DURATION_SIZE:
            raise ValueError(f"exactly {CONFIG_DURATION_SIZE} coil durations are required")
        if any(not 0 <= value <= 0xFF for value in durations):
            raise ValueError("every coil duration must fit in 8 bits")
        if not 0 <= cancel_on_clear <= 0xFFFF_FFFF:
            raise ValueError("cancel-on-clear mask must fit in 32 bits")
        if not 0 <= renew_while_active <= 0xFFFF_FFFF:
            raise ValueError("renew-while-active mask must fit in 32 bits")

        self._wait_until_config_ready()
        self.coil_configuration[CONFIG_DURATION_OFFSET:CONFIG_CANCEL_POLICY_OFFSET] = bytes(durations)
        self.coil_configuration[CONFIG_CANCEL_POLICY_OFFSET:CONFIG_RENEW_POLICY_OFFSET] = (
            cancel_on_clear.to_bytes(4, "little")
        )
        self.coil_configuration[CONFIG_RENEW_POLICY_OFFSET:CONFIG_RENEW_POLICY_OFFSET + 4] = (
            renew_while_active.to_bytes(4, "little")
        )
        self._config_sequence = (self._config_sequence + 1) & 0xFF
        self.coil_configuration[0] = self._config_sequence
        self._command(f"MPX1 C {self.coil_configuration.hex().upper()}", "MPX1 C OK")
        self._wait_until_config_ready()

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
        self.set_outputs(mask, 0)
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
        """Publish lamps, coil renewals, and sound in one complete snapshot.

        Coil command bits are transient and are cleared from the local copy
        after transmission.  Send a bit again on every heartbeat to renew it.
        """
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
        self.snapshot[COIL_OFFSET:COIL_OFFSET + COIL_SIZE] = b"\x00" * COIL_SIZE

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
        self._wait_until_ready()
        return int(self._command("MPX1 GET").split()[2], 16)

    def coils(self) -> int:
        """Read back the 32 currently energized MAME coil outputs."""
        self._wait_until_ready()
        return int(self._command("MPX1 COILS", "MPX1 O ").split()[2], 16)
