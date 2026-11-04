#!/usr/bin/env python3
"""Wipe matched front/back LED pairs to calibrate the folded strip mapping."""

from __future__ import annotations

import argparse
import signal
import time

from led_controller import LedTransport, StripGeometry


def parse_lights(value: str, *, led_count: int) -> list[int]:
    """Parse a comma-separated list of *physical* LED indices."""
    try:
        lights = [int(item.strip(), 0) for item in value.split(",") if item.strip()]
    except ValueError as error:
        raise argparse.ArgumentTypeError("--lights must be comma-separated LED numbers") from error
    if not lights:
        raise argparse.ArgumentTypeError("--lights needs at least one LED number")
    if any(light < 0 or light >= led_count for light in lights):
        raise argparse.ArgumentTypeError(f"LED numbers must be in 0..{led_count - 1}")
    return lights


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("device", help="Romulator LEDs CDC device, e.g. /dev/cu.usbmodemEPROM5_00013")
    parser.add_argument("--led-count", type=int, default=160)
    parser.add_argument("--split", type=int, help="pixels in the first (front-to-back) half; default count/2")
    parser.add_argument("--dwell", type=float, default=0.08, help="seconds per paired row")
    parser.add_argument("--cycles", type=int, default=1)
    parser.add_argument("--reverse", action="store_true")
    parser.add_argument(
        "--lights",
        help="light these physical pixel numbers instead of wiping, e.g. 0,75,76,80,84,159",
    )
    args = parser.parse_args()
    if args.dwell < 0 or args.cycles < 1:
        parser.error("--dwell must be non-negative and --cycles must be positive")
    geometry = StripGeometry(args.led_count, args.split)
    selected_lights = (
        parse_lights(args.lights, led_count=geometry.count)
        if args.lights is not None
        else None
    )
    rows = list(range(geometry.rows))
    if args.reverse:
        rows.reverse()
    print(f"{geometry.count} pixels; {geometry.rows} matched front/back rows; split={geometry.split}")
    with LedTransport(args.device, led_count=geometry.count) as leds:
        try:
            if selected_lights is not None:
                pixels = bytearray(geometry.count * 3)
                for light in selected_lights:
                    pixels[light * 3 : light * 3 + 3] = bytes((255, 80, 8))
                leds.show(bytes(pixels))
                print(f"physical LEDs lit: {', '.join(map(str, selected_lights))}; Ctrl-C to clear")
                signal.pause()
            else:
                for _ in range(args.cycles):
                    for row in rows:
                        colors = [(0, 0, 0)] * geometry.rows
                        colors[row] = (255, 80, 8)
                        leds.show(geometry.rows_to_pixels(colors))
                        time.sleep(args.dwell)
        except KeyboardInterrupt:
            pass
        finally:
            leds.show(bytes(geometry.count * 3))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
