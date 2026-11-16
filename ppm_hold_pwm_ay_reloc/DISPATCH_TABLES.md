# Computed dispatch contracts

The original ROM frequently computes an index and finishes with `PCHL` rather
than using direct calls.  In the relocatable source, every such destination is
a `DW` symbol.  Moving a handler is therefore safe as long as its table slot
retains the same meaning.

All table words are little-endian 8085 addresses.

## Software timer dispatch

`PERIODIC_TIMER_HANDLER` scans 26 bytes beginning at `$2197`.  If slot `N`
expires, the code computes `(26 - C) * 2`, indexes
`TIMER_EXPIRATION_TABLE`, and executes the resulting address with `PCHL`.

Consequently, these three things must always remain aligned:

1. timer RAM address `$2197 + N`;
2. expiration-table slot `N`;
3. the semantic expiration handler for slot `N`.

| Slot | RAM | Symbol | Expiration target | Confidence |
|---:|---:|---|---|---|
| 0 | `$2197` | `SWITCH_SETTLE_TIMER` | `SWITCH_SETTLE_TIMER_EXPIRED` | inferred |
| 1 | `$2198` | `TONE_TIMER` | `TONE_TIMER_EXPIRED` | established |
| 2 | `$2199` | `COIL_PULSE_TIMER` | `COIL_PULSE_TIMER_EXPIRED` | established |
| 3 | `$219a` | `UNUSED_TIMER_03` | `END_MAIN_LOOP` | unused |
| 4 | `$219b` | `CUP_BONUS_TIMER` | `CUP_BONUS_TIMER_EXPIRED` | established |
| 5 | `$219c` | `CUP_COMPLETION_TIMER` | `CUP_COMPLETION_TIMER_EXPIRED` | established |
| 6 | `$219d` | `END_SEQUENCE_TIMER` | `END_SEQUENCE_TIMER_EXPIRED` | inferred |
| 7 | `$219e` | `DISPLAY_CLEAR_TIMER` | `DISPLAY_CLEAR_TIMER_EXPIRED` | inferred |
| 8 | `$219f` | `CLOCK_TIMER` | `CLOCK_TIMER_EXPIRED` | inferred |
| 9 | `$21a0` | `END_BALL_TIMER` | `END_BALL_TIMER_EXPIRED` | inferred |
| 10 | `$21a1` | `GAME_OVER_SEQUENCE_TIMER` | `GAME_OVER_SEQUENCE_TIMER_EXPIRED` | inferred |
| 11 | `$21a2` | `TILT_TIMER` | `TILT_TIMER_EXPIRED` | established |
| 12 | `$21a3` | `HIGH_SCORE_DISPLAY_TIMER` | `HIGH_SCORE_DISPLAY_TIMER_EXPIRED` | inferred |
| 13 | `$21a4` | `ROLLOVER_COMPLETION_TIMER` | `ROLLOVER_COMPLETION_TIMER_EXPIRED` | established |
| 14 | `$21a5` | `CUP_EJECT_SEQUENCE_TIMER` | `CUP_EJECT_SEQUENCE_TIMER_EXPIRED` | established |
| 15 | `$21a6` | `TARGET_COIL_TIMER` | `TARGET_COIL_TIMER_EXPIRED` | inferred |
| 16 | `$21a7` | `BONUS_COUNT_TIMER` | `BONUS_COUNT_TIMER_EXPIRED` | inferred |
| 17 | `$21a8` | `LEFT_FLIPPER_TIMER` | `LEFT_FLIPPER_TIMER_EXPIRED` | established |
| 18 | `$21a9` | `RIGHT_FLIPPER_TIMER` | `RIGHT_FLIPPER_TIMER_EXPIRED` | established |
| 19 | `$21aa` | `UNUSED_TIMER_19` | `END_MAIN_LOOP` | unused |
| 20 | `$21ab` | `COIL_LATCH_TIMER` | `COIL_LATCH_TIMER_EXPIRED` | inferred |
| 21 | `$21ac` | `DMA_RECHECK_TIMER` | `DMA_RECHECK_TIMER_EXPIRED` | inferred |
| 22 | `$21ad` | `OUTLANE_STATE_TIMER` | `OUTLANE_STATE_TIMER_EXPIRED` | inferred |
| 23 | `$21ae` | `BONUS_PAYOUT_TIMER` | `BONUS_PAYOUT_TIMER_EXPIRED` | inferred |
| 24 | `$21af` | `STANDUP_BAR_TIMER` | `STANDUP_BAR_TIMER_EXPIRED` | inferred |
| 25 | `$21b0` | `UNUSED_TIMER_25` | `END_MAIN_LOOP` | unused |

The legacy `TIMER_nn_EXPIRED` labels remain as aliases so annotations and old
notes continue to resolve, but new code should use the semantic names.

## Port 1 reflex dispatch

`BUMPER_SLING_HANDLER` rotates the port value until it finds the first asserted
bit.  Register `E` is that bit number.  `XCHG` followed by `DAD H` produces
`E * 2`, which indexes `REFLEX_DISPATCH_TABLE`.

Slots 0–5 are the four bumpers and two slingshots.  Slot 6 is the reflex
control-flag path.  Slot 7 returns without a device action.

## Port 0 cabinet/interrupt dispatch

`SWITCH_HANDLER` performs the same first-set-bit scan and indexes
`CABINET_DISPATCH_TABLE`:

| Bit | Meaning |
|---:|---|
| 0 | periodic software-timer tick |
| 1 | playfield DMA sample ready |
| 2 | credit |
| 3 | tilt |
| 4 | left flipper |
| 5 | right flipper |
| 6 | start |
| 7 | alternate tilt |

Only the first asserted bit is dispatched during one interrupt entry.

## Playfield DMA dispatch

Hardware maintains 32 sample bytes at `PLAYFIELD_DMA_SAMPLES` (`$23e0`–
`$23ff`).  The comparison/adjustment image begins at
`PLAYFIELD_COMPARE_IMAGE` (`$233b`).

When sample address `$23e0 + N` qualifies as a switch event,
`PLAYFIELD_DMA_HANDLER` subtracts `$e0` from its low byte, doubles the resulting
index `N`, and selects `PLAYFIELD_SWITCH_DISPATCH_TABLE[N]`.  The table's
inline comments give the handler for all 32 DMA slots.

## Relocation rule

Handlers may move freely; table order may not.  In particular, inserting code
before a handler is safe because the assembler rewrites its `DW` entry.  Moving
a `DW` entry to another slot changes the hardware event or timer that invokes
that handler and is a behavioral change, not a relocation.
