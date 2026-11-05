#!/usr/bin/env python3
"""Read and display one raw packed aperture switch snapshot.

Use this with the normal game process stopped and a ball resting in the
outhole.  It sends a harmless control frame (reflexes disabled, no coils) and
prints both the eight response bytes and the decoded state of contact 24.
"""

from __future__ import annotations

import argparse
import re
import time

from aperture_stress import SerialLines, find_device, parse_rx
from micropin_protocol import build_control_payload
from random_lamp_test import _expand_packed_contacts


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--device", help="ROMulator control CDC device")
    parser.add_argument("--timeout", type=float, default=3.0)
    args = parser.parse_args()

    device = find_device(args.device)
    payload = build_control_payload(reflex_enabled=False)
    with SerialLines(device, args.timeout) as serial:
        reply = serial.command(f"tx {payload.hex()}")
        match = re.fullmatch(r"tx ([0-9a-fA-F]{2})", reply)
        if not match:
            raise RuntimeError(f"unexpected tx reply: {reply!r}")
        sequence = int(match.group(1), 16)
        response = bytearray()
        deadline = time.monotonic() + args.timeout
        while len(response) < 2 or len(response) < 2 + response[1]:
            response.extend(parse_rx(serial.command("rx")))
            if time.monotonic() >= deadline:
                raise TimeoutError(f"incomplete aperture response for {sequence:02x}")
            time.sleep(0.001)

    if len(response) != 10 or response[:2] != bytes((sequence, 8)):
        raise RuntimeError(f"expected packed v2 response, got {response.hex()}")
    ports = response[2:6]
    packed = response[6:10]
    dma = _expand_packed_contacts(packed)
    print(f"response: {response.hex()}")
    print(f"ports:    {ports.hex()}  packed contacts: {packed.hex()}")
    print(
        f"contact 24 / outhole: {'CLOSED' if dma[24] == 0 else 'OPEN'} "
        f"(packed[3] bit0={'1' if packed[3] & 1 else '0'}, raw={dma[24]:02x})"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
