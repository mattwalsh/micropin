#!/usr/bin/env python3
"""Verify one-shot bumper and renewable flipper-style coil policies."""

import time

from micropin_bridge import MicropinBridge


COIL = 0
COIL_MASK = 1 << COIL
DURATION_TICKS = 20  # About 88 ms at the modeled 227 Hz RST 6.5 rate.


def require(bridge: MicropinBridge, expected_on: bool, label: str) -> None:
    actual_on = bool(bridge.coils() & COIL_MASK)
    print(f"{label}: {'on' if actual_on else 'off'}")
    if actual_on != expected_on:
        raise AssertionError(f"{label}: expected {'on' if expected_on else 'off'}")


with MicropinBridge() as bridge:
    durations = [0] * 32
    durations[COIL] = DURATION_TICKS

    # Bumper: clear does not cancel; repeated assertions do not renew.
    bridge.configure_coils(durations, cancel_on_clear=0, renew_while_active=0)
    bridge.set_coils(COIL_MASK)
    require(bridge, True, "bumper started")
    time.sleep(0.050)
    bridge.set_coils(COIL_MASK)
    require(bridge, True, "bumper retrigger ignored while active")
    time.sleep(0.055)
    require(bridge, False, "bumper expired on its original deadline")

    # Holdable mechanism: the same second assertion renews the lease.
    bridge.configure_coils(
        durations,
        cancel_on_clear=0,
        renew_while_active=COIL_MASK,
    )
    bridge.set_coils(COIL_MASK)
    time.sleep(0.050)
    bridge.set_coils(COIL_MASK)
    time.sleep(0.055)
    require(bridge, True, "renewable coil extended past original deadline")
    # MAME may throttle or briefly pause emulated time while its window is not
    # focused, so leave ample wall-clock margin for the renewed 20 ISR ticks.
    time.sleep(0.350)
    require(bridge, False, "renewable coil expired after renewed deadline")

    bridge.set_outputs(0, 0)
