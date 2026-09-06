#!/usr/bin/env python3
"""Print meaningful switch-state changes received from the 8085 arbiter."""

from micropin_bridge import MicropinBridge


with MicropinBridge() as bridge:
    previous = None
    while True:
        switches = bridge.read_switches()
        state = (
            switches.active_contacts,
            switches.port1,
            switches.port4,
            switches.port5,
        )
        if state != previous:
            contacts = ",".join(map(str, switches.active_contacts)) or "none"
            print(
                f"seq={switches.sequence:02x} contacts={contacts} "
                f"port1={switches.port1:02x} "
                f"port4={switches.port4:02x} port5={switches.port5:02x}",
                flush=True,
            )
            previous = state
