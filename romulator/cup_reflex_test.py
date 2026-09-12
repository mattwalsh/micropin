#!/usr/bin/env python3
"""Exercise local reflex inhibit and host-commanded Micropin cup ejectors."""

from __future__ import annotations

import argparse
import random
import signal
import time

from aperture_stress import SerialLines, drain_received, find_device, wait_until_ready
from micropin_protocol import (
    DISPLAY_WINDOW_BYTES,
    build_control_payload,
    display_window_from_hex,
)
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
CREDIT_EVENT_MASK = 0x04
RIGHT_FLIPPER_MASK = 0x10
START_MASK = 0x40
OUTHOLE_DMA_INDEX = 24
POPCORN = (
    (0xf1, 0x04),
    (0xd6, 0x04),
    (0xf1, 0x04),
    (0xb4, 0x04),
    (0x8f, 0x04),
    (0xb4, 0x04),
    (0x78, 0x04),
)


def cleanup_outputs(serial: SerialLines) -> None:
    """Best-effort final frame: silence sound and leave mechanisms safe."""
    payload = build_control_payload(
        lamp=0xff,
        reflex_enabled=False,
        cup_mask=0,
        launch=False,
        tone_pitch=0,
        tone_duration=0,
    )
    last_error: Exception | None = None
    for _ in range(3):
        try:
            wait_until_ready(serial)
            send_and_verify(serial, payload)
            return
        except (ConnectionError, OSError, ResponseMismatch, TimeoutError) as error:
            last_error = error
    print(f"warning: final sound-off/safe frame was not verified: {last_error}")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("device", nargs="?", help="CDC device, otherwise auto-detected")
    parser.add_argument("-n", "--commands", type=int, default=0, help="transactions; zero runs until interrupted")
    parser.add_argument("--dwell", type=float, default=0.01, help="seconds between transactions")
    parser.add_argument("--lamp-dance", action="store_true", help="also select a random playfield lamp each transaction")
    display_group = parser.add_mutually_exclusive_group()
    display_group.add_argument(
        "--display-dance",
        dest="display_dance",
        action="store_true",
        help="send 32 new random raw display bytes each transaction (default)",
    )
    display_group.add_argument(
        "--no-display-dance",
        dest="display_dance",
        action="store_false",
        help="leave the displays untouched",
    )
    display_group.add_argument(
        "--display-hex",
        metavar="HEX",
        help="send one fixed 32-byte display window (exactly 64 hex digits)",
    )
    parser.set_defaults(display_dance=True)
    parser.add_argument(
        "--manual-launch",
        action="store_true",
        help="launch only on Start/right-flipper while the outhole is closed",
    )
    parser.add_argument("--seed", type=int, default=0x8085)
    parser.add_argument("--timeout", type=float, default=5.0)
    parser.add_argument(
        "--no-popcorn",
        action="store_true",
        help="silence sound instead of advancing the Popcorn melody each transaction",
    )
    args = parser.parse_args()
    if args.commands < 0:
        parser.error("--commands cannot be negative")
    if args.dwell < 0:
        parser.error("--dwell cannot be negative")
    try:
        fixed_display_window = (
            display_window_from_hex(args.display_hex) if args.display_hex else None
        )
    except ValueError as error:
        parser.error(str(error))

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
    popcorn_index = 0
    stop_requested = False

    def request_stop(_signum: int, _frame: object) -> None:
        nonlocal stop_requested
        stop_requested = True

    previous_sigint = signal.signal(signal.SIGINT, request_stop)

    print(f"device: {device}")
    print("reflex: enabled (hit either tilt input to toggle)")

    with SerialLines(device, args.timeout) as serial:
        mode = serial.command("status")
        if mode not in ("mode aperture", "mode aperture-only"):
            raise RuntimeError(f"ROMulator is not in aperture mode: {mode!r}")
        wait_until_ready(serial)
        drain_received(serial)
        try:
            while not stop_requested and (args.commands == 0 or transaction < args.commands):
                transaction += 1
                lamp = generator.randrange(38) if args.lamp_dance else 0xff
                command_cups = pending_cups
                pending_cups = 0
                command_launch = pending_launch
                pending_launch = 0
                requested_reflex = 1 if reflex_enabled else 0
                if fixed_display_window is not None:
                    display_window = fixed_display_window
                elif args.display_dance:
                    display_window = bytes(
                        generator.randrange(256) for _ in range(DISPLAY_WINDOW_BYTES)
                    )
                else:
                    display_window = None
                if args.no_popcorn:
                    tone_pitch, tone_duration = 0, 0
                else:
                    tone_pitch, tone_duration = POPCORN[popcorn_index]
                    popcorn_index = (popcorn_index + 1) % len(POPCORN)
                payload = build_control_payload(
                    lamp=lamp,
                    reflex_enabled=bool(requested_reflex),
                    cup_mask=command_cups,
                    launch=bool(command_launch),
                    display_window=display_window,
                    tone_pitch=tone_pitch,
                    tone_duration=tone_duration,
                )
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
                if ports[0] & CREDIT_EVENT_MASK:
                    print(
                        f"{transaction:5d}: credit event "
                        f"(p0irq={ports[0]:02x}, sequence {sequence:02x})"
                    )

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
            cleanup_outputs(serial)
            signal.signal(signal.SIGINT, previous_sigint)

    if stop_requested:
        print("stopped; final sound-off/safe frame sent")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (ConnectionError, OSError, RuntimeError, TimeoutError) as error:
        print(f"FAIL: {error}")
        raise SystemExit(1)
