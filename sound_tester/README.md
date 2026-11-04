# Direct-port low-pitch comparison

Build with `./build sound_tester` from the micropin directory. Deploy all four
generated `coin_*.bin` files as a normal ROM set (aperture mode is not needed),
then reset the 8085. No Python program should be running.

The high-score display alternates **49** and **50**. Each phase writes logical
pitch 0x49 or 0x50 with duration 0x0c directly to ports, exactly as ppm's
TONE_PLAY does, waits about one second, then writes the stock 0xfe stop value
and waits another second. The display identifies which pitch was requested;
it is not a frequency measurement. All coils remain off.

If 49 remains silent but 50 sounds, packet decoding and Python are eliminated
as causes. This does not by itself establish the oscillator's transfer curve
or prove every possible duration behaves the same way.

Only ROM 1 contains code. Keep the other three test images installed to make
the standalone configuration unambiguous. Restore the aperture_roundtrip ROMs
and reset before restarting run-game.

Current diagnostic revision additionally runs the arbiter's startup lamp-bank
and interrupt-encoder initialization before entering the original direct sound
loop. Compare this with the earlier standalone result where both pitches were
audible; no host communications or maskable interrupts are involved.

The latest revision also reads aperture addresses $2800/$2802/$2803 before
each note, and polls $2800 about once every 256 delay iterations. It sends no
response strobes and requires no Python process. The added instructions make
the pauses longer; their timing is not the subject of this comparison.
Keep the Pico in aperture mode for this experiment (`status` should report
`mode aperture` or `mode aperture-only`).

The newest comparison additionally emits one fixed, CRC-valid response frame
immediately after each note using the arbiter's exact outbound nibble-read
routine. No host is required. The frames contain sequence 0, length 36, 36 zero
bytes and CRC a5; their data is synthetic, not a switch report. They can leave
stale receive bytes on the Pico, which normal synchronization drains later.
