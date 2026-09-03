#!/usr/bin/env python3
"""Continuously chase one lamp bit across the experimental arbiter."""

import signal
import time

from micropin_bridge import MicropinBridge


running = True


def request_stop(_signum: int, _frame: object) -> None:
    global running
    running = False


signal.signal(signal.SIGINT, request_stop)

with MicropinBridge() as bridge:
    while running:
        for lamp in range(64):
            if not running:
                break
            mask = 1 << lamp
            assert bridge.set_lamps(mask) == mask
            time.sleep(0.10)
    bridge.set_lamps(0)
