#!/usr/bin/env python3
"""Preview named WS2812 strip effects without running the pinball game.

Examples:

    python3 romulator/led_effect_test.py --effect launch_wipe
    python3 romulator/led_effect_test.py /dev/cu.usbmodemEPROM5_00013 --effect blackout
"""

from __future__ import annotations

import argparse
import time

from led_controller import (
    LED_EFFECT_NAMES,
    GameLedRenderer,
    LedTransport,
    StripGeometry,
    find_led_device,
)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("device", nargs="?", help="Romulator LEDs CDC device; otherwise auto-detected")
    parser.add_argument("--effect", choices=LED_EFFECT_NAMES, default="launch_wipe")
    parser.add_argument("--led-count", type=int, default=160)
    parser.add_argument("--split", type=int, help="pixels in the front-to-back strip half")
    parser.add_argument("--fps", type=float, default=30.0)
    parser.add_argument("--seconds", type=float, help="stop after this duration; default is Ctrl-C")
    args = parser.parse_args()
    if args.fps <= 0:
        parser.error("--fps must be positive")
    if args.seconds is not None and args.seconds <= 0:
        parser.error("--seconds must be positive")

    device = find_led_device(args.device)
    geometry = StripGeometry(args.led_count, args.split)
    renderer = GameLedRenderer(geometry)
    deadline = None if args.seconds is None else time.monotonic() + args.seconds
    print(f"LED device: {device}")
    print(f"effect: {args.effect}; {geometry.rows} folded rows; Ctrl-C to stop")
    with LedTransport(device, led_count=geometry.count) as leds:
        try:
            while deadline is None or time.monotonic() < deadline:
                leds.show(renderer.effect_frame(args.effect))
                time.sleep(1.0 / args.fps)
        except KeyboardInterrupt:
            pass
        finally:
            leds.show(bytes(geometry.count * 3))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
