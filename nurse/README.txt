Nurse ROM comparison
====================

Compared against pentacpt_ORIG/microt_1.bin through microt_4.bin, assuming
the two four-ROM sets use matching 1-based file numbering.

Result
------

The Nurse set differs in exactly two bytes total:

  ROM image       Address       PentaCup original       Nurse
  ---------       -------       ----------------       -----
  ROM 1           $0193         $94                     $90
  ROM 2           $0AD9         $01                     $00
  ROM 3           --            identical              identical
  ROM 4           --            identical              identical

Thus, if a prior socket map described ROMs 3 and 4 as changed, it likely used
a different socket/file numbering convention.  The supplied binary files named
coin_3.bin and coin_4.bin are byte-for-byte identical to microt_3.bin and
microt_4.bin.

Patch 1: reset/initialization state byte
----------------------------------------

At CPU address $0190, both sets execute:

        MVI A,$30

PentaCup then has:

        STA $2194

Nurse instead has:

        STA $2190

This redirects the initial value $30 from RAM byte $2194 to $2190.  Both are
game-state bytes, but $2190 is especially central: many state-bit operations
use it, and it lies immediately after the stock stack base at $2190.  This
looks like an intentional reset-state initialization correction.

Patch 2: selected state bit
---------------------------

At CPU address $0AD5, both sets load HL with $2192.  The next instruction is:

        PentaCup: MVI A,$01     ; select bit 1
        Nurse:    MVI A,$00     ; select bit 0

The surrounding routine compares a value against RAM $2211 and then uses the
selected bit in $2192 to set or clear a state condition.  Therefore this is a
one-bit state-machine correction, not a timing or broad rules change.

Conclusion
----------

Nurse appears to be an extremely close PentaCup production revision: likely a
targeted two-fix update, consisting of one startup-state correction and one
state-bit-selection correction.  The exact player-visible behavior of each
fix remains an inference until those RAM variables and their call paths are
fully named/traced.
