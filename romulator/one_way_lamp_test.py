#!/usr/bin/env python3
"""Exercise only the host-to-8085 mailbox with a one-byte lamp command."""

from __future__ import annotations

import argparse
import random
import re
import time

from aperture_stress import SerialLines, find_device


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("device", nargs="?", help="CDC device, otherwise auto-detected")
    parser.add_argument("-n", "--commands", type=int, default=1000)
    parser.add_argument("--dwell", type=float, default=0.05)
    parser.add_argument("--seed", type=int, default=0x8085)
    parser.add_argument("--timeout", type=float, default=2.0)
    args = parser.parse_args()
    if args.commands <= 0:
        parser.error("--commands must be positive")
    if args.dwell < 0:
        parser.error("--dwell cannot be negative")

    device = find_device(args.device)
    generator = random.Random(args.seed)
    print(f"device: {device}")
    print("one-way mode: no 8085 acknowledgement or response is expected")

    with SerialLines(device, args.timeout) as serial:
        if serial.command("status") not in {"mode aperture", "mode aperture-only"}:
            raise RuntimeError("ROMulator is not in aperture mode")
        for number in range(1, args.commands + 1):
            lamp = generator.randrange(38)
            reply = serial.command(f"tx {lamp:02x}")
            if not re.fullmatch(r"tx [0-9a-fA-F]{2}", reply):
                raise RuntimeError(f"unexpected tx response: {reply!r}")
            if number % 100 == 0 or number == args.commands:
                print(f"{number}/{args.commands}: lamp {lamp}")
            time.sleep(args.dwell)

        reply = serial.command("tx ff")
        if not re.fullmatch(r"tx [0-9a-fA-F]{2}", reply):
            raise RuntimeError(f"unexpected final tx response: {reply!r}")

    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except KeyboardInterrupt:
        print("\nstopped")
    except (ConnectionError, OSError, RuntimeError, TimeoutError) as error:
        print(f"FAIL: {error}")
        raise SystemExit(1)
