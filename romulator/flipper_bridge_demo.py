#!/usr/bin/env python3
"""Drive holdable flipper coils from the MAME cabinet switches.

Hold Left Shift or Right Shift in the MAME window.  The Python host renews
that flipper's finite lease while the button remains held and cancels it as
soon as a released switch snapshot arrives.
"""

from __future__ import annotations

import signal

from micropin_bridge import MicropinBridge


LEFT_SWITCH = 0x40
RIGHT_SWITCH = 0x20
LEFT_COIL = 12
RIGHT_COIL = 13
LEFT_COIL_MASK = 1 << LEFT_COIL
RIGHT_COIL_MASK = 1 << RIGHT_COIL
FLIPPER_COIL_MASK = LEFT_COIL_MASK | RIGHT_COIL_MASK

# At the modeled 227 Hz RST 6.5 cadence, 64 ticks gives the host roughly
# 282 ms to renew a held flipper.  If the host disappears, the lease expires.
FLIPPER_LEASE_TICKS = 64
running = True


def request_stop(_signum: int, _frame: object) -> None:
    global running
    running = False


def coil_commands(port4: int) -> int:
    commands = 0
    if port4 & LEFT_SWITCH:
        commands |= LEFT_COIL_MASK
    if port4 & RIGHT_SWITCH:
        commands |= RIGHT_COIL_MASK
    return commands


def label(commands: int) -> str:
    names = []
    if commands & LEFT_COIL_MASK:
        names.append("left")
    if commands & RIGHT_COIL_MASK:
        names.append("right")
    return "+".join(names) or "released"


def main() -> None:
    durations = [0] * 32
    durations[LEFT_COIL] = FLIPPER_LEASE_TICKS
    durations[RIGHT_COIL] = FLIPPER_LEASE_TICKS
    previous_commands: int | None = None

    with MicropinBridge() as bridge:
        bridge.configure_coils(
            durations,
            cancel_on_clear=FLIPPER_COIL_MASK,
            renew_while_active=FLIPPER_COIL_MASK,
        )
        print("Hold Left Shift and/or Right Shift in MAME; Ctrl-C exits.", flush=True)
        try:
            while running:
                switches = bridge.read_switches()
                if not running:
                    break
                commands = coil_commands(switches.port4)
                bridge.set_coils(commands)
                if commands != previous_commands:
                    print(f"flippers: {label(commands)}", flush=True)
                    previous_commands = commands
        except (ConnectionError, TimeoutError) as error:
            print(f"bridge stopped: {error}", flush=True)
            return
        bridge.set_coils(0)


if __name__ == "__main__":
    signal.signal(signal.SIGINT, request_stop)
    main()
