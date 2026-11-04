#!/usr/bin/env python3
"""Exercise the AY-3-8912 through the Micropin ROMulator aperture."""

from __future__ import annotations

import argparse
import time

from aperture_stress import SerialLines, find_device
from micropin_game import synchronize_aperture
from micropin_protocol import AyRegisterImage, build_ay_payload
from random_lamp_test import send_and_verify


def send_ay_update(serial: SerialLines, ay: AyRegisterImage) -> None:
    """Send and acknowledge one snapshot of the currently dirty AY registers."""
    update = ay.pending_update()
    payload = build_ay_payload(update)
    send_and_verify(serial, payload)
    ay.acknowledge(update)
    changed = [register for register in range(14) if update.mask & (1 << register)]
    print(
        f"AY mask={update.mask:04x} registers="
        + (",".join(f"R{register}" for register in changed) or "none"),
        flush=True,
    )


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "device_path",
        nargs="?",
        help="CDC device, otherwise auto-detected (legacy positional form)",
    )
    parser.add_argument(
        "--device",
        dest="device_option",
        help="explicit control CDC device, for example /dev/cu.usbmodemEPROM5_00011",
    )
    parser.add_argument("--seconds", type=float, default=1.5, help="duration of each audible phase")
    parser.add_argument("--timeout", type=float, default=5.0)
    args = parser.parse_args()
    if args.device_path and args.device_option:
        parser.error("specify the device either positionally or with --device, not both")
    if args.seconds <= 0:
        parser.error("--seconds must be positive")

    device = find_device(args.device_option or args.device_path)
    print(f"device: {device}")
    print("Use the newly built aperture_roundtrip ROMs; stop run-game first.")

    ay = AyRegisterImage()
    with SerialLines(device, args.timeout) as serial:
        try:
            mode = serial.command("status")
        except TimeoutError as error:
            if device.endswith("3"):
                raise RuntimeError(
                    f"{device} is probably the ROMulator LED-frame port; "
                    f"use the control port ending in 1 instead"
                ) from error
            raise
        print(f"ROMulator status: {mode}")
        synchronize_aperture(serial)
        try:
            # Known-good two-tone setup measured on the physical board.
            ay.set_tone_period(0, 0x0180)
            ay.set_tone_period(1, 0x0143)
            ay.set_register(7, 0x3c)  # Tone A+B; tone C and all noise off.
            ay.set_volume(0, 1)
            ay.set_volume(1, 1)
            ay.set_volume(2, 0)
            print("two tones: A=0180, B=0143")
            send_ay_update(serial, ay)  # First command is a full R0-R13 sync.
            time.sleep(args.seconds)

            print("channel A only")
            ay.set_volume(1, 0)
            send_ay_update(serial, ay)  # One dirty register: R9.
            time.sleep(args.seconds)

            print("raise channel A pitch: period=0143")
            ay.set_tone_period(0, 0x0143)
            # R1 remains $01, so the mirror correctly transmits only dirty R0.
            send_ay_update(serial, ay)
            time.sleep(args.seconds)
        except KeyboardInterrupt:
            pass
        finally:
            # Silence via AY volume, not the old 566 control port.
            ay.set_volume(0, 0)
            ay.set_volume(1, 0)
            ay.set_volume(2, 0)
            try:
                send_ay_update(serial, ay)
            except (ConnectionError, OSError, RuntimeError, TimeoutError) as error:
                print(f"warning: AY cleanup failed: {error}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (ConnectionError, OSError, RuntimeError, TimeoutError) as error:
        print(f"FAIL: {error}")
        raise SystemExit(1)
