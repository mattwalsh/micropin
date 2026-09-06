#!/usr/bin/env python3
"""Play a rising sequence through the arbiter's Micropin tone outputs."""

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
        for pitch in range(0x30, 0xF1, 0x10):
            if not running:
                break
            bridge.set_sound(pitch, 0x08)
            time.sleep(0.10)
            bridge.set_sound(pitch, 0)
            time.sleep(0.03)
    bridge.set_sound(0, 0)
