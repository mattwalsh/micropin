#!/usr/bin/env python3
"""Select random Micropin lamps through the real ROMulator aperture."""

from __future__ import annotations

import argparse
import random
import re
import time

from aperture_stress import SerialLines, drain_received, find_device, parse_rx, wait_until_ready

REFLEX_NAMES = (
    "lower-left-bumper",
    "upper-left-bumper",
    "middle-rollover-button",
    "lower-right-bumper",
    "right-sling",
    "left-sling",
    "standup-bar",
    "unknown-7",
)

CABINET_NAMES = (
    "periodic-0",
    "playfield-dma",
    "credit",
    "tilt-3",
    "right-flipper",
    "left-flipper",
    "start",
    "tilt-7",
)


class ResponseMismatch(RuntimeError):
    """A completed transaction whose returned snapshot cannot be trusted."""


def describe_events(events: int, names_by_bit: tuple[str, ...]) -> str:
    names = [name for bit, name in enumerate(names_by_bit) if events & (1 << bit)]
    return ",".join(names) if names else "-"


def send_and_verify(serial: SerialLines, payload: bytes) -> tuple[int, tuple[int, int, int, int], bytes]:
    reply = serial.command(f"tx {payload.hex()}")
    match = re.fullmatch(r"tx ([0-9a-fA-F]{2})", reply)
    if not match:
        raise RuntimeError(f"unexpected tx response: {reply!r}")
    sequence = int(match.group(1), 16)

    response = bytearray()
    needed = 2
    deadline = time.monotonic() + serial.timeout
    while len(response) < needed:
        response.extend(parse_rx(serial.command("rx")))
        if len(response) >= 2:
            needed = 2 + response[1]
        if len(response) < needed:
            if time.monotonic() >= deadline:
                raise TimeoutError(f"incomplete response for lamp transaction {sequence:02x}")
            time.sleep(0.001)

    expected_prefix = bytes((sequence, len(payload) + 36)) + payload
    if len(response) != len(expected_prefix) + 36 or not response.startswith(expected_prefix):
        returned_sequence = response[0] if response else -1
        returned_payload = response[2:2 + len(payload)] if len(response) >= 2 else b""
        raise ResponseMismatch(
            f"sequence {sequence:02x}: expected echo {payload.hex()}, "
            f"received sequence {returned_sequence:02x} echo {returned_payload.hex()}"
        )
    switches = response[len(expected_prefix):]
    return sequence, tuple(switches[:4]), bytes(switches[4:])


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("device", nargs="?", help="CDC device, otherwise auto-detected")
    parser.add_argument("-n", "--commands", type=int, default=100)
    parser.add_argument("--dwell", type=float, default=0.25, help="seconds per lamp")
    parser.add_argument("--seed", type=int, default=None)
    parser.add_argument("--timeout", type=float, default=2.0)
    args = parser.parse_args()
    if args.commands <= 0:
        parser.error("--commands must be positive")
    if args.dwell < 0:
        parser.error("--dwell cannot be negative")

    device = find_device(args.device)
    generator = random.Random(args.seed)
    print(f"device: {device}")

    with SerialLines(device, args.timeout) as serial:
        if serial.command("status") != "mode aperture":
            raise RuntimeError("ROMulator is not in aperture mode")
        wait_until_ready(serial)
        drain_received(serial)
        previous_dma: bytes | None = None
        try:
            for number in range(1, args.commands + 1):
                lamp = generator.randrange(38)
                try:
                    sequence, ports, dma = send_and_verify(serial, bytes((lamp,)))
                except ResponseMismatch as error:
                    print(f"{number:4d}: DISCARDED  {error}")
                    time.sleep(args.dwell)
                    continue
                if previous_dma is None:
                    changed = "initial"
                else:
                    changes = [
                        f"c{index + 1:02d}:{old:02x}->{new:02x}"
                        f"({'closed' if not new & 0x10 else 'open'})"
                        for index, (old, new) in enumerate(zip(previous_dma, dma))
                        if (old ^ new) & 0x10
                    ]
                    changed = ",".join(changes) if changes else "-"
                print(
                    f"{number:4d}: lamp {lamp:2d}  sequence {sequence:02x}  "
                    f"ports p0irq={ports[0]:02x} p1irq={ports[1]:02x} "
                    f"p4={ports[2]:02x} rollovers={ports[3]:02x}  "
                    f"dma={dma.hex()}  changed={changed}  "
                    f"p0-events={describe_events(ports[0], CABINET_NAMES)}  "
                    f"reflex={describe_events(ports[1], REFLEX_NAMES)}"
                )
                previous_dma = dma
                time.sleep(args.dwell)
        finally:
            # An invalid lamp number is the protocol's explicit all-off command.
            wait_until_ready(serial)
            for attempt in range(3):
                try:
                    send_and_verify(serial, b"\xff")
                    break
                except ResponseMismatch:
                    if attempt == 2:
                        print("warning: all-off acknowledgement was not reliable")

    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (ConnectionError, OSError, RuntimeError, TimeoutError) as error:
        print(f"FAIL: {error}")
        raise SystemExit(1)
