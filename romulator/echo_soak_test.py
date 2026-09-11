#!/usr/bin/env python3
"""Soak-test host-to-8085 delivery and the unacknowledged 8085 echo path."""

from __future__ import annotations

import argparse
import random
import re
import time

from aperture_stress import SerialLines, drain_received, find_device, parse_rx, parse_stats


def receive_echo(serial: SerialLines, deadline: float) -> bytes:
    response = bytearray()
    needed = 2
    while len(response) < needed:
        response.extend(parse_rx(serial.command("rx")))
        if len(response) >= 2:
            needed = 2 + response[1]
        if len(response) < needed:
            if time.monotonic() >= deadline:
                raise TimeoutError(f"incomplete echo {response.hex()}")
            time.sleep(0.001)
    return bytes(response)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("device", nargs="?", help="ROMulator CDC device")
    parser.add_argument("-n", "--transactions", type=int, default=1000)
    parser.add_argument("--max-payload", type=int, default=32)
    parser.add_argument("--dwell", type=float, default=0.01)
    parser.add_argument("--timeout", type=float, default=2.0)
    parser.add_argument("--seed", type=int, default=0x8085)
    args = parser.parse_args()

    if args.transactions <= 0:
        parser.error("--transactions must be positive")
    if not 1 <= args.max_payload <= 32:
        parser.error("--max-payload must be between 1 and 32")
    if args.dwell < 0:
        parser.error("--dwell must not be negative")

    device = find_device(args.device)
    generator = random.Random(args.seed)
    print(f"device: {device}")

    with SerialLines(device, args.timeout) as serial:
        mode = serial.command("status")
        if mode not in ("mode aperture", "mode aperture-only"):
            raise RuntimeError(f"ROMulator is not in aperture mode: {mode!r}")
        stale = drain_received(serial)
        initial_crc, initial_drops = parse_stats(serial.command("stats"))
        print(f"starting echo-only test; drained={stale} stale bytes")

        started = time.monotonic()
        payload_bytes = 0
        for transaction in range(1, args.transactions + 1):
            length = generator.randint(1, args.max_payload)
            # Keep the first byte visible as a valid lamp command while the
            # rest exercises every possible byte value in the echo.
            payload = bytes((generator.randrange(38),)) + bytes(
                generator.randrange(256) for _ in range(length - 1)
            )
            reply = serial.command(f"tx {payload.hex()}")
            match = re.fullmatch(r"tx ([0-9a-fA-F]{2})", reply)
            if not match:
                raise RuntimeError(f"unexpected tx response: {reply!r}")
            sequence = int(match.group(1), 16)
            expected = bytes((sequence, length)) + payload
            try:
                received = receive_echo(serial, time.monotonic() + args.timeout)
            except TimeoutError as error:
                raise TimeoutError(
                    f"transaction {transaction}, sequence {sequence:02x}: {error}; "
                    f"{serial.command('diag')}"
                ) from error
            if received != expected:
                raise RuntimeError(
                    f"transaction {transaction}, sequence {sequence:02x}: "
                    f"expected {expected.hex()}, got {received.hex()}; "
                    f"{serial.command('diag')}"
                )
            payload_bytes += length
            if transaction % 100 == 0 or transaction == args.transactions:
                print(f"{transaction}/{args.transactions} echoes verified (sequence {sequence:02x})")
            time.sleep(args.dwell)

        elapsed = time.monotonic() - started
        final_crc, final_drops = parse_stats(serial.command("stats"))

    print("PASS")
    print(f"transactions: {args.transactions}")
    print(f"payload bytes: {payload_bytes}")
    print(f"elapsed: {elapsed:.3f} s")
    print(f"transactions/s: {args.transactions / elapsed:.1f}")
    print(f"rejected outbound CRC frames: {final_crc - initial_crc}")
    print(f"receive-ring drops: {final_drops - initial_drops}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (ConnectionError, OSError, RuntimeError, TimeoutError) as error:
        print(f"FAIL: {error}")
        raise SystemExit(1)
