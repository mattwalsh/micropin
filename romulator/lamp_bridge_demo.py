#!/usr/bin/env python3
"""Continuously chase one lamp bit across the experimental arbiter."""

import time

from micropin_bridge import MicropinBridge


with MicropinBridge() as bridge:
    try:
        while True:
            for lamp in range(64):
                mask = 1 << lamp
                assert bridge.set_lamps(mask) == mask
                time.sleep(0.10)
    except KeyboardInterrupt:
        bridge.set_lamps(0)
