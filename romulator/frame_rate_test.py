#!/usr/bin/env python3
"""Benchmark safe, full-size game frames without energizing coils or sound."""

import argparse
import statistics
import time

from aperture_stress import SerialLines, find_device, parse_stats
from micropin_game import synchronize_aperture, safe_cleanup
from micropin_protocol import DisplayFrame, build_control_payload
from random_lamp_test import send_and_verify


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("device", nargs="?")
    parser.add_argument("-n", type=int, default=300)
    parser.add_argument("--dwell", type=float, default=0)
    args = parser.parse_args()
    if args.n < 1 or args.dwell < 0:
        parser.error("require n >= 1 and dwell >= 0")
    payload = build_control_payload(
        reflex_enabled=False, display_window=DisplayFrame(), lamp_bitmap=bytes(5)
    )
    with SerialLines(find_device(args.device), 5) as serial:
        synchronize_aperture(serial)
        initial = parse_stats(serial.command("stats"))
        samples = []
        try:
            started = time.monotonic()
            for _ in range(args.n):
                before = time.monotonic()
                send_and_verify(serial, payload)
                samples.append((time.monotonic() - before) * 1000)
                if args.dwell:
                    time.sleep(args.dwell)
            elapsed = time.monotonic() - started
            final = parse_stats(serial.command("stats"))
        finally:
            safe_cleanup(serial)
    ordered = sorted(samples)
    print(f"PASS: {args.n} frames, {len(payload)} output bytes, dwell={args.dwell:g}s")
    print(f"rate: {args.n / elapsed:.1f} frames/s; elapsed={elapsed:.3f}s")
    print(f"round-trip ms: min={min(samples):.3f} median={statistics.median(samples):.3f} "
          f"p95={ordered[min(len(ordered)-1, int(len(ordered)*.95))]:.3f} max={max(samples):.3f}")
    print(f"CRC errors={final[0]-initial[0]} ring drops={final[1]-initial[1]}")


if __name__ == "__main__":
    main()
