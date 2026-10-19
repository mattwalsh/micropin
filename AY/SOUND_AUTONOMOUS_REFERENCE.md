# Autonomous sound diagnostic snapshot

`sound_autonomous_reference.asm` is an exact copy of the active
`aperture_roundtrip.asm` saved on 2026-09-17 before restoring the full arbiter.

After the arbiter's reset and RAM/output initialization, it bypasses host
transactions and alternates logical pitches 0x49 and 0x50, duration 0x0c.
Both notes use literal active-low port writes, followed by explicit sound-off
and software delays. The loop runs in ROM 1 and polls the aperture during
delays. Maskable interrupts are disabled. Host lamp/control/display
manifestations are bypassed; TRAP still preserves PSW, counts entries and returns.
Earlier packet-path diagnostics remain in the source but are unreachable.

Physical result: after deploying the complete four-ROM set, the user heard
both pitches and the game no longer repeatedly reset. An earlier apparent
reset failure was tested with a mixed ROM set and is not valid evidence of a
software or hardware reset fault.

This is a reference, not the gameplay build. `./build aperture_roundtrip`
continues to assemble `aperture_roundtrip.asm`, not the snapshot. Always deploy
all four generated ROMs together: code changes can affect both ROM 1 and ROM 2.
