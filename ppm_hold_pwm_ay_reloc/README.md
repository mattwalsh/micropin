# Relocatable PPM hold/PWM/AY source

This variant starts from `ppm_hold_pwm_ay` and replaces inferred ROM addresses
with assembler symbols.  RAM addresses and hardware constants deliberately
remain absolute.

## What is relocatable

- Both interrupt-vector PCHL tables (`REFLEX_DISPATCH_TABLE` and
  `CABINET_DISPATCH_TABLE`).
- The 26-entry software timer expiration table.
- The 32-entry playfield switch table, with named cup, standup, rollover,
  inlane, outlane, outhole, and extra-ball handlers.
- Music sequences and their range bounds.
- Score constants and the cup, reflex, rollover, player-display, and other ROM
  data tables referenced by code.

The assembler in `/Users/msw/dev/8085-Assembler` must include commit
`251929c`, which permits forward label expressions in `DW` directives.

## Deliberate relocation proof

`ROLLOVER_1_HANDLER` originally lived at `$145f`.  Its seven original bytes
are now NOPs and the handler lives at `$2ff9` in ROM 5.  The playfield switch
table contains the assembled symbol value `$2ff9`.

Build and deploy to MAME:

```sh
./build ppm_hold_pwm_ay_reloc
```

Run the closed-loop relocation regression from `upstream/mame`:

```sh
./micropindev \
  -rompath ./roms -window -skip_gameinfo -sound none -nothrottle \
  -seconds_to_run 22 -autoboot_delay 0 \
  -autoboot_script ../../ppm_hold_pwm_ay_reloc/mame_relocated_rollover.lua \
  pencup2c
```

The expected result is:

```text
relocated rollover: PASS score=00>00 rollovers=ff>fe
```

The rollover bitmap transition is the direct proof: it is performed by the
handler that moved to `$2ff9`.

## Remaining constraint

This is source-relocatable assembly, not a linker/object-file format.  Code and
data can be moved by editing their order or using available ROM coves, and all
known code references follow their labels.  The physical ROM/RAM map and
fixed 2 KiB image boundaries remain hardware constraints.
