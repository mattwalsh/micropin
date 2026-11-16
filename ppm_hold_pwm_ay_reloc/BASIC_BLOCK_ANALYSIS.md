# Basic-block analysis

This pass treats a block as an instruction sequence with one entry and no
internal branch target.  A branch, return, computed `PCHL`, or fall-through
into another named entry ends the block.

The first semantic pass deliberately concentrates on two high-value classes:

1. every direct or conditional call target that previously had only an address
   label such as `c0e18`;
2. shared branch blocks with high fan-in or hardware-facing behavior.

Legacy address labels remain as aliases, so old notes and address-oriented
cross references still work.  New call and branch operands use the semantic
names.  There are now zero direct call operands whose destination is only an
`o/j/c` address label.

## Callable entry blocks

### Initialization and game state

| Semantic entry | Legacy alias | Contract / exits |
|---|---|---|
| `GRANT_INITIAL_CREDIT` | `c0009` | writes packed-BCD credit 01; `RET` |
| `START_ALL_CUPS_COMPLETE_AWARD` | `c0018` | arms cup sequence; falls into 10,000-point award |
| `AWARD_10000_BONUS` | `c001d` | loads score constant, calls bonus adder; `RET` |
| `ADD_CREDIT_AND_CLEAR_INDICATORS` | `c06d3` | clears indicators, falls through shared credit award path |
| `CLEAR_GAME_DISPLAY_STATE` | `c17a8` | clears score work area and blanks lamp pages; `RET` |
| `FILL_PLAYER_DISPLAY_BLOCKS` | `jc178e` | copies an eight-byte template B times; loop then `RET` |
| `SELECT_END_BALL_COUNTDOWN` | `c17ea` | returns `$20` or `$80`; conditional early returns |
| `RESOLVE_CURRENT_PLAYER_DISPLAY` | `c1a3a` | returns display pointer/mask/page stride; `RET` |
| `RESOLVE_CURRENT_PLAYER_SAVED_STATE` | `c1ba8` | returns current player's saved-state pointer; rotate loop then `RET` |

### Playfield and lamp hardware

| Semantic entry | Legacy alias | Contract / exits |
|---|---|---|
| `SUM_PLAYFIELD_COMPARE_IMAGE` | `c0303` | sums 34 comparison bytes into HL; `RET` |
| `COMPARE_PLAYFIELD_CHECKSUM` | `co0317` | compares sum with `$2224`; returns through several flag-preserving paths |
| `RECONCILE_PLAYFIELD_DMA` | `jc137d` | adjusts 32 samples until stable; loops or `RET` |
| `ROTATE_CUP_LAMP_STATE` | `c0402` | transfers a cup lamp bit and clears its old position; `RET` |
| `RESOLVE_CUP_LAMP_PAIR` | `c0427` | returns bit plus paired page pointers; `RET` |
| `RESOLVE_CUP_TARGET_STATE` | `c0b6f` | returns target lamp/state pointer and caches delayed-handler operands; `RET` |
| `RESOLVE_LAMP_BIT` | `c1da3` | decodes B into lamp byte/bit/page stride; `RET` |
| `SET_LAMP_SOLID` | `co1d76` | sets both pages; `RET` |
| `CLEAR_LAMP_AND_TEST_FLASH_PAGE` | `co1d81` | clears both pages, returns old page-2 state in flags |
| `SET_LAMP_FLASHING` | `co1d91` | sets page 1 and clears page 2; `RET` |
| `CHECK_LAMP_LIT_PAGE` | `co1d9c` | returns page-1 state in Z/NZ |

### Packed-BCD score arithmetic

| Semantic entry | Legacy alias | Contract / exits |
|---|---|---|
| `ADD_BCD_SCORE_TO_SPREAD` | `c0dec` | adds HL into work buffer; digit loop then `RET` |
| `SUBTRACT_BCD_SCORE_FROM_SPREAD` | `c0e18` | subtracts HL in place; returns comparison status in carry |
| `COMMIT_SPREAD_TO_BONUS_DISPLAY` | `c0e6f` | copies work buffer to canonical/display storage; gated early `RET` |
| `TRY_SUBTRACT_FROM_BONUS` | `c0e99` | stages, subtracts, and commits a bonus decrement; `RET` with flags |
| `COMPARE_PLAYER_SCORES_REVERSED` | `c0ff4` | stages player 2 minus player 1 for ordering; `RET` with carry |
| `LOAD_SCORE_TO_SPREAD_BUFFER` | `c1fd4` | clears prefix and stages seven score bytes; `RET` |

### Sound queue

| Semantic entry | Legacy alias | Contract / exits |
|---|---|---|
| `DEQUEUE_SOUND_POINTER` | `c128c` | removes one 16-bit circular-queue entry, returns it in HL; `RET` |

### High-score processing

| Semantic entry | Legacy alias | Contract / exits |
|---|---|---|
| `PROCESS_HIGH_SCORES` | `c1db7` | ranks players and inserts qualifying scores; many comparison returns |
| `SHIFT_SCORE_RANK_POINTERS_TWO` | `c1e64` | shifts rank pointers two positions; falls into one-position shift |
| `SHIFT_SCORE_RANK_POINTERS_ONE` | `c1e6a` | shifts rank pointers one position; `RET` |
| `MAKE_ROOM_IN_HIGH_SCORE_TABLE` | `c1f36` | shifts A lower-ranked stored entries; conditional `RET`s |
| `INSERT_FIRST_HIGH_SCORE` | `c1f5e` | inserts rank 1 and sets new-high-score state; returns carry |
| `INSERT_SECOND_HIGH_SCORE` | `c1f7e` | inserts rank 2; returns carry |
| `INSERT_THIRD_HIGH_SCORE` | `c1f8f` | inserts rank 3; returns carry |
| `INSERT_FOURTH_HIGH_SCORE` | `c1fa0` | inserts rank 4; returns carry |
| `RESET_HIGH_SCORE_TABLE` | `c1faa` | shifts defaults through all four slots; `RET` |

### State predicates

| Semantic entry | Legacy alias | Contract / exits |
|---|---|---|
| `CHECK_CREDIT_LOCKOUT_STATE` | `c046a` | NZ only when state bit 6 is set and credits are zero |

## Shared high-fan-in branch blocks

These are internal blocks rather than callable functions, but their fan-in or
hardware effect makes an address-only name especially unhelpful:

- `READ_PRICING_AND_GAME_DIP_SWITCHES`
- `MAIN_OUTPUT_LOOP`
- `CLEAR_SWITCH_LATCH_AND_RETURN`
- `RESTORE_INTERRUPT_CONTEXT_AND_RETURN`
- `FIRE_REFLEX_DEVICE`
- `DEBOUNCE_MAIN_CUP`
- `FINISH_CUP_AWARD`
- `ADVANCE_CUP_EJECT_SEQUENCE`
- `EJECT_SIDE_BONUS_CUP`
- `LATCH_STANDUP_TARGET`
- `FINISH_STANDUP_BAR_WINDOW`
- `RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE`
- `PROCESS_ROLLOVER`
- `CLEAR_START_SWITCH_LATCH_AND_RETURN`
- `FINISH_GAME_OVER_SEQUENCE_STEP`

Their comments in the assembly describe live inputs, side effects, and exit
paths.  Lower-level loop and two-way branch labels intentionally retain their
address names until the enclosing routine is understood; naming them merely
`LOOP_1` or `ELSE_2` would add churn without semantic information.

## Verification invariant

This pass adds aliases, comments, and symbolic operands only.  It is accepted
only if all six generated ROM MD5s remain unchanged and the relocated-rollover
MAME regression still produces `rollovers=ff>fe`.
