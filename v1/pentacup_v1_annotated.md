# Pentacup / Micropin revision 1 ROM notes

This is an address-correct map of the seven original 1 KiB ROMs in
`roms_orig`.  The companion file `pentacup_v1_serialized.lst` contains every
byte and marks the important addresses discussed below.

## ROM map

| ROM | CPU address | MD5 |
|---|---:|---|
| `ic2.bin` | `$6400-$67ff` | `25d116ce8be30b53df04b7aad65cfe88` |
| `ic3.bin` | `$6800-$6bff` | `8836d8ac677f3d6b25846d40b00da10c` |
| `ic4.bin` | `$6c00-$6fff` | `fc3ecde636c6b13e23bc986c5d775953` |
| `ic5.bin` | `$7000-$73ff` | `4448897d8569c18ffda9d5a1de4d4d1d` |
| `ic6.bin` | `$7400-$77ff` | `c123bb5fb7a6172e5aa8dfaf089089e6` |
| `ic7.bin` | `$7800-$7bff` | `0ae49bf08e68574e5e18ae0534abb5c6` |
| `ic8.bin` | `$7c00-$7fff` | `8e03c4b82697d25e454e5ed710cbecf1` |

`ic8` is also mirrored at `$fc00-$ffff`, putting the reset and interrupt
vectors at the usual 6800 locations.

## Two instruction sets are present

This software has an unusual split architecture:

1. Native Motorola 6800 firmware scans hardware, refreshes displays, queues
   events, and runs an interpreter.
2. Most game rules are serialized bytecode consumed by that interpreter.

That is why a conventional 6800 disassembler produces convincing-looking but
false instructions throughout `$6400-$6dea`.  For example, bytecode opcode
`$09` gets printed as native `DEX`.  The companion listing intentionally uses
`.byte` for the serialized image instead of making that claim.

The native firmware begins at `$6deb` (NMI handler); RESET is `$6e18`.

## Start-button path

The physical Start input is `$4000`, bit `$10`.  The native switch scanner at
`$70de` detects changes, the code at `$7117-$71b5` translates the changed bit
to an internal event, and the event table entry at `$7ced` points to serialized
handler `$66a1`.

Thus there are three useful answers to “where does it decide to start?”:

| Address | Meaning |
|---:|---|
| **`$66a1`** | Entry to the complete Start-button policy routine |
| **`$66d1`** | Decisive “credits nonzero?” / **should I start?** branch |
| **`$6700`** | Accepted branch: actual new-game initialization begins |

## Decoded Start handler

The mnemonics below are names assigned from the native opcode handlers.  Flag
numbers are interpreter object IDs, not direct RAM addresses.

```text
$66a1  09 d1
         CLEAR_FLAG $d1

$66a3  0c 07 0d 74 77 70 06 0f 04 66 dd
         IF_ANY_FLAG_SET {$0d,$74,$77,$70,$06,$0f,$04}
             GOTO $66dd                         ; reject

$66ae  0b 71 66 dd
         IF_FLAG_CLEAR $71 GOTO $66dd           ; reject

$66b2  0a 6e 66 c6
         IF_FLAG_SET $6e GOTO $66c6             ; game-over route

$66b6  14 02 66 c6
         PLAYER/GAME_STATE_TEST $02, $66c6       ; not fully named yet

$66ba  19 08 20 00 00 66 de 66 c6
         NUMERIC/GAME_STATE_COMPARE ..., $66de, $66c6
                                                  ; two-result branch; exact
                                                  ; operands not fully named

$66c3  29 66 de
         PLAYER/GAME_STATE_TEST ..., $66de       ; existing-game route

$66c6  0b 03 66 cf
         IF_FLAG_CLEAR $03 GOTO $66cf

$66ca  14 05 66 cf
         PLAYER/GAME_STATE_TEST $05, $66cf

$66ce  00
         END                                     ; reject this route

$66cf  08 0e
         SET_FLAG $0e

$66d1  1a 09 67 00
         IF_NUMERIC_FIELD_NONZERO CREDITS, GOTO $6700

$66d5  05 35 0f
$66d8  09 25
$66da  03 09 0e
$66dd  00
         NO_CREDIT_RESPONSE; END                 ; no game starts

$66de  ...
         add-player/current-game path

$6700  ...
         NEW_GAME_INITIALIZATION                 ; game starts
```

The `$1a` handler is native code at `$7723`.  Its operand `$09` identifies the
numeric object used for the credit display/counter.  A zero value falls through
to `$66d5`; a nonzero value loads program counter `$6700`.

## Start interlocks

The first branch rejects Start if any of these internal flags are set:

| Flag ID | Storage | Current interpretation |
|---:|---:|---|
| `$04` | `$20` bit `$08` | internal blocking state, exact name unknown |
| `$06` | `$20` bit `$02` | internal blocking state, exact name unknown |
| `$0d` | `$21` bit `$04` | internal blocking state, exact name unknown |
| `$0f` | `$21` bit `$01` | internal blocking state, exact name unknown |
| `$70` | `$2e` bit `$01` | Tilt 4 input |
| `$74` | `$2e` bit `$08` | Tilt 2 input |
| `$77` | `$2e` bit `$40` | Tilt 1 input |

Flag `$71` (`$2e` bit `$02`) is the active-low Tilt 3/interlock input: Start is
rejected unless this flag is set.  Consequently the raw hardware state that
passes the four `$4000` tilt/interlock tests is:

```text
($4000 & $c9) == $40
```

That condition is independent of the separate logical Alarm/Tilt input read
through the PIA at `$5102` bit `$80`; the real lock connector may fan out to
both in hardware.

The four “mysterious variables” `$0d,$06,$0f,$04` are therefore **flag IDs**.
The native decoder at `$7b54` maps flag ID `n` to RAM byte `$20 + (n >> 3)` and
bit mask `{$80,$40,$20,$10,$08,$04,$02,$01}[n & 7]`.

## Reset and possibly stale RAM

RESET enters at `$6e18`.  At `$6e48` the firmware chooses between preserving
battery-backed state and clearing RAM.  The preserved-RAM signature is
`$e8=$55, $e9=$aa`.

The cold/forced-reset path at `$6e5d-$6e6c` explicitly clears the complete
`$0000-$01ff` RAM range, which includes the four internal blocking flags above.
The warm path at `$6eb1` does not clear them.  Therefore they are initialized on
a true cold/forced reset, but can absolutely be trusted from retained RAM on a
warm boot.  A missing or marginal battery plus a warm-path false positive is a
credible explanation for a machine that otherwise runs but refuses Start.

## Native landmarks

```text
$6deb  NMI handler
$6e18  RESET handler
$6ee5  IRQ handler
$7096  capture input snapshots
$70de  compare current inputs with snapshots
$7117  changed bit on $4000 found
$7136  changed-bit identification and event translation
$72c7  bytecode interpreter loop
$72dd  opcode dispatch
$7309  dequeue an internal event
$732c  fetch its serialized handler pointer
$747e  opcode-handler table
$7b54  internal flag-to-RAM decoder
$7ccd  event-handler pointer table
$7ced  Start event pointer ($66a1)
```

## Vectors

```text
$fff8 IRQ   -> $6ee5
$fffa SWI   -> $6f17
$fffc NMI   -> $6deb
$fffe RESET -> $6e18
```
