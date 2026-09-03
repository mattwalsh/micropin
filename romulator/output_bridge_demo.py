#!/usr/bin/env python3
"""Independently chase 64 lamps and 32 coils through one arbiter snapshot."""

import signal
import time

from micropin_bridge import MicropinBridge


running = True


def request_stop(_signum: int, _frame: object) -> None:
    global running
    running = False


signal.signal(signal.SIGINT, request_stop)

with MicropinBridge() as bridge:
    # Eight RST 6.5 ticks is about 35 ms.  The old coil naturally expires
    # shortly after the chase advances because cancel-on-clear is disabled.
    bridge.configure_coils([8] * 32)
    lamp = 0
    coil = 0
    next_lamp = next_coil = time.monotonic()
    while running:
        now = time.monotonic()
        if now >= next_lamp:
            lamp = (lamp + 1) % 64
            next_lamp += 0.10
        if now >= next_coil:
            coil = (coil + 1) % 32
            next_coil += 0.20
        bridge.set_outputs(1 << lamp, 1 << coil)
        time.sleep(0.02)
    bridge.set_outputs(0, 0)
