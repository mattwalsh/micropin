#!/usr/bin/env python3
"""Exercise local reflex inhibit and host-commanded Micropin cup ejectors."""

from __future__ import annotations

import argparse
import random
import time

from aperture_stress import SerialLines, drain_received, find_device, wait_until_ready
from random_lamp_test import (
    CABINET_NAMES,
    REFLEX_NAMES,
    ResponseMismatch,
    describe_events,
    send_and_verify,
)


# (DMA byte index, display name, physical coil output)
CUPS = (
    (29, "cup-1", 3),
    (27, "cup-2", 21),
    (25, "cup-3", 2),
    (20, "cup-4", 0),
    (18, "cup-5", 1),
    (14, "side-bonus-cup", 25),
)
TILT_MASK = 0x88
RIGHT_FLIPPER_MASK = 0x10
START_MASK = 0x40
OUTHOLE_DMA_INDEX = 24


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("device", nargs="?", help="CDC device, otherwise auto-detected")
    parser.add_argument("-n", "--commands", type=int, default=0, help="transactions; zero runs until interrupted")
    parser.add_argument("--dwell", type=float, default=0.01, help="seconds between transactions")
    parser.add_argument("--lamp-dance", action="store_true", help="also select a random playfield lamp each transaction")
    parser.add_argument(
        "--manual-launch",
        action="store_true",
        help="launch only on Start/right-flipper while the outhole is closed",
    )
    parser.add_argument("--seed", type=int, default=0x8085)
    parser.add_argument("--timeout", type=float, default=5.0)
    args = parser.parse_args()
    if args.commands < 0:
        parser.error("--commands cannot be negative")
    if args.dwell < 0:
        parser.error("--dwell cannot be negative")

    device = find_device(args.device)
    generator = random.Random(args.seed)
    reflex_enabled = True
    pending_cups = 0
    previous_closed = [False] * len(CUPS)
    have_snapshot = False
    outhole_was_closed = False
    have_outhole_snapshot = False
    pending_launch = 0
    tilt_was_active = False
    transaction = 0

    print(f"device: {device}")
    print("reflex: enabled (hit either tilt input to toggle)")

    with SerialLines(device, args.timeout) as serial:
        mode = serial.command("status")
        if mode not in ("mode aperture", "mode aperture-only"):
            raise RuntimeError(f"ROMulator is not in aperture mode: {mode!r}")
        wait_until_ready(serial)
        drain_received(serial)
        try:
            while args.commands == 0 or transaction < args.commands:
                transaction += 1
                lamp = generator.randrange(38) if args.lamp_dance else 0xff
                command_cups = pending_cups
                pending_cups = 0
                command_launch = pending_launch
                pending_launch = 0
                requested_reflex = 1 if reflex_enabled else 0
                payload = bytes((lamp, 0x4d, 0x50, requested_reflex, command_cups, command_launch))
                try:
                    sequence, ports, dma = send_and_verify(serial, payload)
                except ResponseMismatch as error:
                    print(f"{transaction:5d}: DISCARDED  {error}")
                    time.sleep(args.dwell)
                    continue

                tilt_active = bool(ports[0] & TILT_MASK)
                if tilt_active and not tilt_was_active:
                    reflex_enabled = not reflex_enabled
                    print(
                        f"{transaction:5d}: tilt event {ports[0] & TILT_MASK:02x}; "
                        f"reflex {'ENABLED' if reflex_enabled else 'INHIBITED'}"
                    )
                tilt_was_active = tilt_active

                reflex = describe_events(ports[1], REFLEX_NAMES)
                if reflex != "-":
                    print(f"{transaction:5d}: reflex {reflex} (sequence {sequence:02x})")
                flippers = describe_events(ports[0] & 0x30, CABINET_NAMES)
                if flippers != "-":
                    print(f"{transaction:5d}: flipper {flippers} (sequence {sequence:02x})")

                outhole_closed = not bool(dma[OUTHOLE_DMA_INDEX] & 0x10)
                start_pressed = bool(ports[0] & START_MASK)
                right_flipper_pressed = bool(ports[0] & RIGHT_FLIPPER_MASK)
                if start_pressed:
                    print(f"{transaction:5d}: Start pressed (sequence {sequence:02x})")

                newly_closed = outhole_closed and (
                    not have_outhole_snapshot or not outhole_was_closed
                )
                manual_request = outhole_closed and (start_pressed or right_flipper_pressed)
                if (newly_closed and not args.manual_launch) or manual_request:
                    pending_launch = 1
                    reason = "outhole closed" if newly_closed and not args.manual_launch else "button pressed"
                    print(f"{transaction:5d}: {reason}; requesting launcher coil 5")
                outhole_was_closed = outhole_closed
                have_outhole_snapshot = True

                closed = [not bool(dma[index] & 0x10) for index, _, _ in CUPS]
                if not have_snapshot:
                    initial = ",".join(name for (_, name, _), is_closed in zip(CUPS, closed) if is_closed)
                    print(f"{transaction:5d}: cup baseline closed={initial or '-'}")
                for cup_index, ((_, name, coil), is_closed) in enumerate(zip(CUPS, closed)):
                    if is_closed and (not have_snapshot or not previous_closed[cup_index]):
                        pending_cups |= 1 << cup_index
                        print(f"{transaction:5d}: {name} closed; requesting coil {coil}")
                previous_closed = closed
                have_snapshot = True
                time.sleep(args.dwell)
        finally:
            # Disable local reflex firing, clear cup commands, and turn lamps
            # off before returning control to the operator.
            try:
                wait_until_ready(serial)
                send_and_verify(serial, b"\xffMP\x00\x00\x00")
            except (ResponseMismatch, TimeoutError) as error:
                print(f"warning: final inhibit response was not verified: {error}")

    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except KeyboardInterrupt:
        print("\nstopped")
    except (ConnectionError, OSError, RuntimeError, TimeoutError) as error:
        print(f"FAIL: {error}")
        raise SystemExit(1)
