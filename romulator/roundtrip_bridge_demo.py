#!/usr/bin/env python3
"""Exercise lamps, coils, sound, and switches through one arbiter connection.

Left Shift and Right Shift are the MAME flipper inputs.  Their physical
contacts appear here through the cabinet-switch fan-out on input port 4.
"""

from __future__ import annotations

import signal
import time

from micropin_bridge import MicropinBridge, SwitchSnapshot


LEFT_FLIPPER = 0x40
RIGHT_FLIPPER = 0x20
LEFT_PITCH = 0x78
RIGHT_PITCH = 0xD6
# Long enough to bridge the present socket heartbeat.  Each transaction while
# held renews the one-shot; the first transaction after release silences it.
HELD_TONE_DURATION = 0x20
running = True


def request_stop(_signum: int, _frame: object) -> None:
    global running
    running = False


def flipper_tone(switches: SwitchSnapshot) -> tuple[int, int]:
    left = bool(switches.port4 & LEFT_FLIPPER)
    right = bool(switches.port4 & RIGHT_FLIPPER)
    if left and right:
        # There is one tone generator, so trill when both buttons are held.
        pitch = LEFT_PITCH if switches.sequence & 1 else RIGHT_PITCH
    elif left:
        pitch = LEFT_PITCH
    elif right:
        pitch = RIGHT_PITCH
    else:
        return 0, 0
    return pitch, HELD_TONE_DURATION


def flipper_label(port4: int) -> str:
    names = []
    if port4 & LEFT_FLIPPER:
        names.append("left")
    if port4 & RIGHT_FLIPPER:
        names.append("right")
    return "+".join(names) or "released"


def main() -> None:
    lamp = 0
    coil = 0
    previous_flippers: int | None = None

    with MicropinBridge() as bridge:
        bridge.configure_coils([8] * 32)
        try:
            while running:
                switches = bridge.read_switches()
                if not running:
                    break
                flippers = switches.port4 & (LEFT_FLIPPER | RIGHT_FLIPPER)
                if flippers != previous_flippers:
                    print(f"flippers: {flipper_label(flippers)}", flush=True)
                    previous_flippers = flippers

                pitch, duration = flipper_tone(switches)
                bridge.set_outputs(1 << lamp, 1 << coil, pitch, duration)
                lamp = (lamp + 1) % 64
                coil = (coil + 1) % 32
        except (ConnectionError, TimeoutError) as error:
            print(f"bridge stopped: {error}", flush=True)
            return
        bridge.set_outputs(0, 0, 0, 0)


if __name__ == "__main__":
    signal.signal(signal.SIGINT, request_stop)
    main()
