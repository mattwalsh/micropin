#!/usr/bin/env python3
"""Run a calibrated playfield lamp wipe through MAME or the USB ROMulator."""

from __future__ import annotations

import argparse
import signal
import time

from aperture_stress import SocketLines, SerialLines, drain_received, find_device, wait_until_ready
from lamp_coordinates import PLAYFIELD_LAMP_COORDINATES, wavefront_lamps
from micropin_protocol import DisplayFrame, build_control_payload
from random_lamp_test import send_and_verify


running = True


def stop(_signum: int, _frame: object) -> None:
    global running
    running = False


def mask_for(lamps: set[int]) -> int:
    return sum(1 << lamp for lamp in lamps)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--host", default="127.0.0.1")
    parser.add_argument("--port", type=int, default=8085)
    parser.add_argument("--device", help="USB Romulator CDC device (uses aperture protocol)")
    parser.add_argument("--cycles", type=int, default=1)
    parser.add_argument("--frames", type=int, default=40, help="sampled wavefront positions per pass")
    parser.add_argument("--dwell", type=float, default=0.02, help="seconds after each visible change")
    parser.add_argument("--thickness", type=float, default=140.0)
    parser.add_argument("--reverse", action="store_true")
    args = parser.parse_args()
    if args.cycles <= 0 or args.frames < 2 or args.dwell < 0 or args.thickness < 0:
        parser.error("cycles must be positive, frames at least 2, and dwell/thickness non-negative")

    signal.signal(signal.SIGINT, stop)
    print(f"wiping {len(PLAYFIELD_LAMP_COORDINATES)} calibrated playfield lamps")
    positions = [i / (args.frames - 1) for i in range(args.frames)]
    if args.reverse:
        positions.reverse()
    masks = []
    for position in positions:
        mask = mask_for(wavefront_lamps(position, thickness=args.thickness))
        if not masks or mask != masks[-1]:
            masks.append(mask)
    print(f"{len(masks)} visible lamp frames per pass")
    if args.device:
        device = find_device(args.device)
        print(f"connecting to Romulator {device}")
        transport = SerialLines(device, 5.0)
    else:
        print(f"connecting to MAME aperture bridge {args.host}:{args.port}")
        transport = SocketLines(f"{args.host}:{args.port}", 5.0)

    blank_display = DisplayFrame().to_bytes()
    with transport as serial:
        mode = serial.command("status")
        if mode not in ("mode aperture", "mode aperture-only"):
            raise RuntimeError(f"expected aperture mode, got {mode!r}")
        wait_until_ready(serial)
        drain_received(serial)
        try:
            for _ in range(args.cycles):
                for mask in masks:
                    if not running:
                        break
                    payload = build_control_payload(
                        display_window=blank_display,
                        lamp_bitmap=mask.to_bytes(5, "little"),
                    )
                    send_and_verify(serial, payload)
                    time.sleep(args.dwell)
                if not running:
                    break
        finally:
            payload = build_control_payload(
                display_window=blank_display,
                lamp_bitmap=b"\x00" * 5,
                reflex_enabled=False,
            )
            try:
                wait_until_ready(serial)
                send_and_verify(serial, payload)
            except (ConnectionError, OSError, RuntimeError, TimeoutError):
                pass
    print("wipe complete")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
