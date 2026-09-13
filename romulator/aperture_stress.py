#!/usr/bin/env python3
"""Soak-test the Micropin ROMulator aperture round-trip protocol."""

from __future__ import annotations

import argparse
import glob
import math
import os
import random
import re
import select
import socket
import statistics
import sys
import termios
import time
import tty


DEFAULT_DEVICE_PATTERNS = (
    "/dev/cu.usbmodemEPROM5*",
    "/dev/cu.usbmodem*",
    "/dev/ttyACM*",
)


class SerialLines:
    def __init__(self, device: str, timeout: float) -> None:
        self.device = device
        self.timeout = timeout
        self.fd = os.open(device, os.O_RDWR | os.O_NOCTTY | os.O_NONBLOCK)
        tty.setraw(self.fd, termios.TCSANOW)
        attributes = termios.tcgetattr(self.fd)
        attributes[4] = termios.B115200
        attributes[5] = termios.B115200
        termios.tcsetattr(self.fd, termios.TCSANOW, attributes)
        termios.tcflush(self.fd, termios.TCIOFLUSH)
        self.received = bytearray()

    def close(self) -> None:
        os.close(self.fd)

    def __enter__(self) -> "SerialLines":
        return self

    def __exit__(self, *_: object) -> None:
        self.close()

    def command(self, text: str) -> str:
        request = (text + "\n").encode("ascii")
        written = 0
        deadline = time.monotonic() + self.timeout
        while written < len(request):
            remaining = deadline - time.monotonic()
            if remaining <= 0:
                raise TimeoutError(f"timed out writing {text!r}")
            _, writable, _ = select.select([], [self.fd], [], remaining)
            if writable:
                written += os.write(self.fd, request[written:])
        return self._readline(deadline, text)

    def _readline(self, deadline: float, request: str) -> str:
        while b"\n" not in self.received:
            remaining = deadline - time.monotonic()
            if remaining <= 0:
                raise TimeoutError(f"no reply to {request!r} from {self.device}")
            readable, _, _ = select.select([self.fd], [], [], remaining)
            if not readable:
                continue
            chunk = os.read(self.fd, 256)
            if not chunk:
                raise ConnectionError(f"serial device {self.device} closed")
            self.received.extend(chunk)
        line, _, remainder = self.received.partition(b"\n")
        self.received = bytearray(remainder)
        return line.rstrip(b"\r").decode("ascii")


class SocketLines:
    """Line-command transport for MAME's localhost aperture bridge."""

    def __init__(self, address: str, timeout: float) -> None:
        host, separator, port_text = address.rpartition(":")
        if not separator:
            host, port_text = "127.0.0.1", address
        self.device = f"tcp://{host}:{port_text}"
        self.timeout = timeout
        self.socket = socket.create_connection((host, int(port_text)), timeout=timeout)
        self.socket.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
        self.received = bytearray()

    def close(self) -> None:
        self.socket.close()

    def __enter__(self) -> "SocketLines":
        return self

    def __exit__(self, *_: object) -> None:
        self.close()

    def command(self, text: str) -> str:
        self.socket.sendall((text + "\n").encode("ascii"))
        deadline = time.monotonic() + self.timeout
        while b"\n" not in self.received:
            remaining = deadline - time.monotonic()
            if remaining <= 0:
                raise TimeoutError(f"no reply to {text!r} from {self.device}")
            self.socket.settimeout(remaining)
            chunk = self.socket.recv(256)
            if not chunk:
                raise ConnectionError(f"socket {self.device} closed")
            self.received.extend(chunk)
        line, _, remainder = self.received.partition(b"\n")
        self.received = bytearray(remainder)
        return line.rstrip(b"\r").decode("ascii")


def find_device(explicit: str | None) -> str:
    if explicit:
        return explicit
    matches: list[str] = []
    for pattern in DEFAULT_DEVICE_PATTERNS:
        matches.extend(glob.glob(pattern))
        if matches:
            break
    matches = sorted(set(matches))
    if not matches:
        raise RuntimeError("no ROMulator CDC device found; pass its /dev path explicitly")
    if len(matches) > 1:
        raise RuntimeError(f"multiple CDC devices found; choose one explicitly: {', '.join(matches)}")
    return matches[0]


def parse_state(line: str) -> tuple[int, int]:
    match = re.fullmatch(r"state host=([0-9a-fA-F]{2}) ack=([0-9a-fA-F]{2})", line)
    if not match:
        raise RuntimeError(f"unexpected state response: {line!r}")
    return int(match.group(1), 16), int(match.group(2), 16)


def parse_rx(line: str) -> bytes:
    if line == "rx" or line == "rx ":
        return b""
    if not line.startswith("rx "):
        raise RuntimeError(f"unexpected rx response: {line!r}")
    try:
        return bytes.fromhex(line[3:])
    except ValueError as error:
        raise RuntimeError(f"malformed rx response: {line!r}") from error


def parse_stats(line: str) -> tuple[int, int]:
    match = re.fullmatch(r"stats crc=([0-9]+) drops=([0-9]+)", line)
    if not match:
        raise RuntimeError(f"unexpected stats response: {line!r}")
    return int(match.group(1)), int(match.group(2))


def wait_until_ready(serial: SerialLines) -> tuple[int, int]:
    deadline = time.monotonic() + serial.timeout
    while True:
        state = parse_state(serial.command("state"))
        if state[0] == state[1]:
            return state
        if time.monotonic() >= deadline:
            stats = parse_stats(serial.command("stats"))
            diag = serial.command("diag")
            raise TimeoutError(
                f"outstanding transaction did not recover: host={state[0]:02x} ack={state[1]:02x}, "
                f"crc={stats[0]} drops={stats[1]}; {diag}"
            )
        time.sleep(0.002)


def drain_received(serial: SerialLines) -> int:
    drained = 0
    while True:
        chunk = parse_rx(serial.command("rx"))
        if not chunk:
            return drained
        drained += len(chunk)


def percentile(sorted_values: list[float], fraction: float) -> float:
    return sorted_values[max(0, math.ceil(len(sorted_values) * fraction) - 1)]


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("device", nargs="?", help="CDC device, otherwise auto-detected")
    parser.add_argument("--tcp", metavar="HOST:PORT", help="test MAME's socket bridge instead of USB CDC")
    parser.add_argument("-n", "--transactions", type=int, default=1000)
    parser.add_argument("--max-payload", type=int, default=32)
    parser.add_argument("--seed", type=int, default=0x8085)
    parser.add_argument("--timeout", type=float, default=2.0)
    args = parser.parse_args()

    if args.transactions <= 0:
        parser.error("--transactions must be positive")
    if not 1 <= args.max_payload <= 32:
        parser.error("--max-payload must be between 1 and 32")

    if args.tcp and args.device:
        parser.error("device and --tcp are mutually exclusive")
    device = f"tcp://{args.tcp}" if args.tcp else find_device(args.device)
    generator = random.Random(args.seed)
    latencies: list[float] = []
    payload_bytes = 0
    expected_previous_sequence: int | None = None

    print(f"device: {device}")
    transport = SocketLines(args.tcp, args.timeout) if args.tcp else SerialLines(device, args.timeout)
    with transport as serial:
        mode = serial.command("status")
        if mode != "mode aperture":
            raise RuntimeError(f"ROMulator is not in aperture mode: {mode!r}")
        initial_state = wait_until_ready(serial)
        stale = drain_received(serial)
        initial_stats = parse_stats(serial.command("stats"))
        print(f"starting: host={initial_state[0]:02x} ack={initial_state[1]:02x}, drained={stale} stale bytes")

        overall_start = time.monotonic()
        for transaction in range(1, args.transactions + 1):
            length = generator.randint(1, args.max_payload)
            payload = bytes(generator.randrange(256) for _ in range(length))
            started = time.monotonic()
            tx_reply = serial.command(f"tx {payload.hex()}")
            match = re.fullmatch(r"tx ([0-9a-fA-F]{2})", tx_reply)
            if not match:
                raise RuntimeError(f"transaction {transaction}: unexpected tx response {tx_reply!r}")
            sequence = int(match.group(1), 16)
            if expected_previous_sequence is not None and sequence != (expected_previous_sequence + 1) & 0xff:
                raise RuntimeError(
                    f"transaction {transaction}: sequence jumped from {expected_previous_sequence:02x} to {sequence:02x}"
                )

            response = bytearray()
            response_deadline = time.monotonic() + args.timeout
            needed = 2
            while len(response) < needed:
                response.extend(parse_rx(serial.command("rx")))
                if len(response) >= 2:
                    needed = 2 + response[1]
                if len(response) < needed:
                    if time.monotonic() >= response_deadline:
                        state = parse_state(serial.command("state"))
                        stats = parse_stats(serial.command("stats"))
                        diag = serial.command("diag")
                        raise TimeoutError(
                            f"transaction {transaction}: incomplete response {response.hex()}, "
                            f"host={state[0]:02x} ack={state[1]:02x}, "
                            f"crc={stats[0]} drops={stats[1]}; {diag}"
                        )
                    time.sleep(0.001)

            # RST 6.5-latched Port-0 events, RST 5.5-latched Port-1 reflex
            # events, cabinet Port 4, latched rollover edges, and all 32 raw
            # inductive DMA samples make up the 36-byte switch snapshot.
            expected_prefix = bytes((sequence, length + 36)) + payload
            if len(response) != len(expected_prefix) + 36 or not response.startswith(expected_prefix):
                state = parse_state(serial.command("state"))
                raise RuntimeError(
                    f"transaction {transaction}: expected prefix {expected_prefix.hex()} plus 36 switch bytes, "
                    f"got {response.hex()}, "
                    f"host={state[0]:02x} ack={state[1]:02x}"
                )
            state = parse_state(serial.command("state"))
            if state != (sequence, sequence):
                raise RuntimeError(
                    f"transaction {transaction}: response arrived but semaphore is host={state[0]:02x} ack={state[1]:02x}"
                )

            latencies.append(time.monotonic() - started)
            payload_bytes += length
            expected_previous_sequence = sequence
            if transaction % 100 == 0 or transaction == args.transactions:
                print(f"{transaction}/{args.transactions} transactions verified (sequence {sequence:02x})")

        elapsed = time.monotonic() - overall_start
        final_stats = parse_stats(serial.command("stats"))

    sorted_latencies = sorted(latencies)
    print("PASS")
    print(f"transactions: {len(latencies)}")
    print(f"payload bytes: {payload_bytes}")
    print(f"elapsed: {elapsed:.3f} s")
    print(f"transactions/s: {len(latencies) / elapsed:.1f}")
    print(f"payload bytes/s: {payload_bytes / elapsed:.1f}")
    print(f"recovered CRC failures: {final_stats[0] - initial_stats[0]}")
    print(f"receive-ring drops: {final_stats[1] - initial_stats[1]}")
    print(
        "round-trip latency ms: "
        f"min={sorted_latencies[0] * 1000:.3f} "
        f"median={statistics.median(sorted_latencies) * 1000:.3f} "
        f"p95={percentile(sorted_latencies, 0.95) * 1000:.3f} "
        f"max={sorted_latencies[-1] * 1000:.3f}"
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (ConnectionError, OSError, RuntimeError, TimeoutError) as error:
        print(f"FAIL: {error}", file=sys.stderr)
        raise SystemExit(1)
