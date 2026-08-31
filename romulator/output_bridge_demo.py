#!/usr/bin/env python3
"""Independently chase 64 lamps and 32 coils through one arbiter snapshot."""

import time

from micropin_bridge import MicropinBridge


with MicropinBridge() as bridge:
    lamp = 0
    coil = 0
    next_lamp = next_coil = time.monotonic()
    try:
        while True:
            now = time.monotonic()
            if now >= next_lamp:
                lamp = (lamp + 1) % 64
                next_lamp += 0.10
            if now >= next_coil:
                coil = (coil + 1) % 32
                next_coil += 0.20
            bridge.set_outputs(1 << lamp, 1 << coil)
            time.sleep(0.02)
    except KeyboardInterrupt:
        bridge.set_outputs(0, 0)
