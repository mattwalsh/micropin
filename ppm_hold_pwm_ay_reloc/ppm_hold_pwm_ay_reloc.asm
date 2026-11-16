NEXT_TONE EQU 0x21b1
HIGH_SCORE_START EQU 0x222d
HIGH_SCORE_DISP EQU 0x2323
HIGH_SCORE_DISP2 EQU 0x2330
HIGH_SCORE_NOW EQU 0x2393
HIGH_SCORE_DISP3 EQU 0x23b3
HIGH_SCORE_DISP4 EQU 0x23d3
PRICE_1 EQU 0x237f
PRICE_2 EQU 0x239f
PRICE_3 EQU 0x23bf
PRICE_4 EQU 0x23df
CREDITS_1 EQU 0x237a
ROLLOVERS EQU 0x21c6
CONTROL_FLAGS EQU 0x2191
LAMPS_PAGE_1 EQU 0x2380
LAMPS_PAGE_2 EQU 0x23a0
PL13_SCORE_1 EQU 0x2367
PL13_SCORE_2 EQU 0x236f
PL24_SCORE_1 EQU 0x2373
SPREAD_1 EQU 0x21f3
STATE_OUTLANE_1 EQU 0x2193
SWITCH_LATCHED EQU 0x2194
SPREAD_2 EQU 0x2377
SPREAD_3 EQU 0x23b7
SPREAD_4 EQU 0x2397
FREE_BALL EQU 0x2389
CREDIT_1 EQU 0x239a
CREDIT_2 EQU 0x23ba
PL1_SCORE_1 EQU 0x2363
PL1_SCORE_2 EQU 0x2386
PL1_SCORE_DISPLAY EQU 0x23a6
PL1_SCORE_DISPLAY2 EQU 0x2386
PL1_SCORE_hrm EQU 0x2377
PL2_SCORE_1 EQU 0x236b
PL2_SCORE_2 EQU 0x238d
PL2_SCORE_3 EQU 0x23ad
PL2_SCORE_H EQU 0x2360
PL3_SCORE_1 EQU 0x235f
PL3_SCORE_2 EQU 0x23fe
PL1_AND_3 EQU 0x2389
PL3_SCORE_DISPLAY_2 EQU 0x2383
PL4_SCORE_1 EQU 0x236f
PL4_SCORE_2 EQU 0x2390
PL4_SCORE_3 EQU 0x23b0
CREDITS_2 EQU 0x239a
CREDITS_3 EQU 0x23ba
CREDITS_4 EQU 0x23da
BALL_IN_PLAY_hrm EQU 0x237b
BALL_IN_PLAY_1 EQU 0x239b
BALL_IN_PLAY_2 EQU 0x23bb
BALL_IN_PLAY_3 EQU 0x23db
BALLS_PER_GAME EQU 0x2213
DIP_SWITCHES EQU 0x2216
CUPS_LEFT EQU 0x21c7
GAME_STATE EQU 0x2190
GAME_STATE2 EQU 0x2192
STACK_SCRATCH EQU 0x2195
FLIPPER_PWM_MASK EQU 0x22f0

; SOFTWARE TIMER BANK
;
; PERIODIC_TIMER_HANDLER decrements these 26 one-byte timers in address order.
; When slot N reaches zero it dispatches TIMER_EXPIRATION_TABLE[N].  Thus the
; three representations below are one contract:
;
;     timer address = SOFTWARE_TIMER_BASE + N
;     table entry   = TIMER_EXPIRATION_TABLE + (N * 2)
;     table target  = that timer's expiration routine
;
; Names without an "inferred" qualification are supported by both the timer's
; writers and its expiration routine.  The qualified names describe the best
; current static interpretation and should be revisited as those paths become
; better understood.
SOFTWARE_TIMER_BASE EQU 0x2197
SOFTWARE_TIMER_COUNT EQU 0x1a
SWITCH_SETTLE_TIMER EQU 0x2197       ; slot 00, inferred
TONE_TIMER EQU 0x2198                ; slot 01
COIL_PULSE_TIMER EQU 0x2199          ; slot 02
UNUSED_TIMER_03 EQU 0x219a           ; slot 03
CUP_BONUS_TIMER EQU 0x219b           ; slot 04
CUP_COMPLETION_TIMER EQU 0x219c      ; slot 05
END_SEQUENCE_TIMER EQU 0x219d        ; slot 06, inferred
DISPLAY_CLEAR_TIMER EQU 0x219e       ; slot 07, inferred
CLOCK_TIMER EQU 0x219f               ; slot 08, inferred
END_BALL_TIMER EQU 0x21a0            ; slot 09, inferred
GAME_OVER_SEQUENCE_TIMER EQU 0x21a1  ; slot 10, inferred
TILT_TIMER EQU 0x21a2                ; slot 11
HIGH_SCORE_DISPLAY_TIMER EQU 0x21a3  ; slot 12, inferred
ROLLOVER_COMPLETION_TIMER EQU 0x21a4 ; slot 13
CUP_EJECT_SEQUENCE_TIMER EQU 0x21a5  ; slot 14
TARGET_COIL_TIMER EQU 0x21a6         ; slot 15, inferred
BONUS_COUNT_TIMER EQU 0x21a7         ; slot 16, inferred
LEFT_FLIPPER_TIMER EQU 0x21a8        ; slot 17
RIGHT_FLIPPER_TIMER EQU 0x21a9       ; slot 18
UNUSED_TIMER_19 EQU 0x21aa           ; slot 19
COIL_LATCH_TIMER EQU 0x21ab          ; slot 20, inferred
DMA_RECHECK_TIMER EQU 0x21ac         ; slot 21, inferred
OUTLANE_STATE_TIMER EQU 0x21ad       ; slot 22, inferred
BONUS_PAYOUT_TIMER EQU 0x21ae        ; slot 23, inferred
STANDUP_BAR_TIMER EQU 0x21af         ; slot 24, inferred
UNUSED_TIMER_25 EQU 0x21b0           ; slot 25

; Hardware-maintained playfield samples and the software-adjusted comparison
; image.  The dispatcher derives switch N from the low byte of
; PLAYFIELD_DMA_SAMPLES+N.
PLAYFIELD_DMA_SAMPLES EQU 0x23e0
PLAYFIELD_COMPARE_IMAGE EQU 0x233b
PLAYFIELD_SWITCH_COUNT EQU 0x20

; INPUT PORTS
CABINET_TILT_FLIPPERS_TIMER_PORT EQU 0x0
BUMPER_SLINGS_SWITCHES_PORT EQU 0x1
PRICE_CENTS_07_PORT EQU 0x2
PRICE_TENS_07_PORT EQU 0x3
PRICE_89_CAB EQU 0x4
DIP_SWITCH_PORT EQU 0x5

; OUTPUT PORTS
LAMP_0 EQU 0x0
LAMP_1 EQU 0x1
LAMP_2 EQU 0x2
LAMP_3 EQU 0x3
LAMP_4 EQU 0x4
COIL_5 EQU 0x5
COIL_6 EQU 0x6
COIL_7 EQU 0x7
COIL_8 EQU 0x8
TONE_ENABLE_DUR EQU 0x9
TONE_PITCH EQU 0xa
; AY-3-8912 interface.  The Micropin board inverts both of these buses.
AY_REGISTER EQU 0x0b
AY_DATA EQU 0x0c
AY_VOLUME EQU 0x03
AY_ENVELOPE_PERIOD_LO EQU 0x00 ; decay period $0400
AY_ENVELOPE_PERIOD_HI EQU 0x04
AY_ENVELOPE_SHAPE EQU 0x09
AY_GATE_TRIGGER EQU 0xff       ; required shared audio-path pre-trigger
AY_GATE_NORMAL EQU 0x12         ; measured quieter usable shared-path mode
LAMP_D EQU 0xd
LAMP_E EQU 0xe
LAMP_F EQU 0xf
o0000:  JMP j0040
o0003:  CALL CREDIT_HANDLER
o0006:  JMP RESTORE_INTERRUPT_CONTEXT_AND_RETURN
; Force the credit byte to packed-BCD 01.  Returns A=01.
GRANT_INITIAL_CREDIT:
c0009:  MVI A, #01 ;o1606
        STA CREDITS_1
        RET

        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
; Begin the all-five-cups completion delay, then fall through to award 10,000
; bonus points.  The award entry may also be called independently.
START_ALL_CUPS_COMPLETE_AWARD:
c0018:  MVI A, #3c ;jo0aac
        STA CUP_EJECT_SEQUENCE_TIMER
AWARD_10000_BONUS:
c001d:  LXI H, SCORE_10000 ;jo151f
o0020:  CALL ADD_BONUS
        RET

o0024:  JMP j0069
        HLT
        HLT
        HLT
        HLT
        MOV B,M
; RST5.5
o002c:  JMP BUMPER_SLING_HANDLER
; TRAP
        HLT
        HLT
        HLT
        HLT
        NOP
; RST6.5
o0034:  JMP SWITCH_HANDLER
        HLT
        HLT
        HLT
        HLT
o003b:  JNZ j00c3
        (LDHI) #76
j0040:  MVI A, #21 ;o0000
        STA CREDITS_4
        MVI D, #05
j0047:  LXI H, #2710 ;o0053
j004a:  DCX H ;o004f
        OUT LAMP_F
        MOV A,H
        ORA A
o004f:  JNZ j004a
        DCR D
o0053:  JNZ j0047
        IN PRICE_89_CAB
        ANI #20
o005a:  JZ j0069
; hard reset routine
HARD_RESET:
        LXI H, #2000
j0060:  SUB A ;o0066
        MOV M,A
        INX H
        MVI A, #24
        CMP H
o0066:  JNZ j0060
j0069:  LXI SP, GAME_STATE ;o0024,o005a
        MVI A, #07
j006e:  OUT LAMP_E ;o0073
        OUT LAMP_D
        DCR A
o0073:  JP j006e
; Clear the timer bank and the immediately following legacy work area.
        LXI H, SOFTWARE_TIMER_BASE
        MVI C, #2d
j007b:  SUB A ;o007f
        MOV M,A
        INX H
        DCR C
o007f:  JNZ j007b
        MVI A, #05
        STA $0000
        CALL AY_INIT
        NOP
        MVI A, #02
        STA TONE_TIMER
        MVI A, #ff
        STA STATE_OUTLANE_1
o0095:  CALL INIT_FLIPPER_PWM_MASK
        NOP
        NOP
        LXI H, #21fb
        SHLD $21f9
        LXI H, #21b4
        SHLD $21be
        SHLD $21c0
        MVI A, #0f
        STA $21f8
        LDA GAME_STATE
        ORI #05
        STA GAME_STATE
        MVI A, #0c
        SIM
        IN PRICE_89_CAB
        ANI #20
o00bd:  JZ jo00f5
        LXI H, DEFAULT_HIGH_SCORE
j00c3:  LXI D, HIGH_SCORE_START ;o003b
        MVI A, #08
o00c8:  CALL COPY_FROM_HL_TO_DE
        LXI H, SCORE_10000
        LXI D, #2231
        MVI A, #08
o00d3:  CALL COPY_FROM_HL_TO_DE
        MVI A, #71
        STA CLOCK_TIMER
        MVI A, #3c
        STA $221f
        MVI A, #00
        STA $2220
        STA $2221
        MVI A, #04
        STA $2222
        MVI A, #64
        STA $224a
o00f2:  JMP j00fb
jo00f5: CALL COMPARE_PLAYFIELD_CHECKSUM ;o00bd
o00f8:  JZ j0143
j00fb:  MVI A, #07 ;o00f2
        STA $21c2
        CMA
        OUT COIL_5
        MVI A, #06
        STA TARGET_COIL_TIMER
j0108:  EI ;o010d
        LDA TARGET_COIL_TIMER
        ORA A
o010d:  JNZ j0108
        MVI A, #28
        STA $21c2
        CMA
        OUT COIL_5
        MVI A, #20
        STA $21c4
        CMA
        OUT COIL_7
        MVI A, #02
        STA $21c5
        CMA
        OUT COIL_8
        MVI A, #06
        STA TARGET_COIL_TIMER
j012d:  EI ;o0132
        LDA TARGET_COIL_TIMER
        ORA A
o0132:  JNZ j012d
        MVI A, #ff
        OUT COIL_5
        OUT COIL_6
        OUT COIL_7
        OUT COIL_8
        DI
o0140:  CALL RECONCILE_PLAYFIELD_DMA
j0143:  IN PRICE_89_CAB ;o00f8
        MOV B,A
        ANI #20
o0148:  JNZ jo0168
        LDA GAME_STATE2
        ANI #df
        STA GAME_STATE2
        MOV A,B
        ANI #10
o0156:  JNZ jo0168
        MOV A,B
        ANI #40
o015c:  JNZ jo0168
        LXI H, GAME_OVER_MUSIC
o0162:  CALL PLAY_SOUND
o0165:  JMP j01bf
jo0168: CALL CLEAR_GAME_DISPLAY_STATE ;o0148,o0156,o015c
        MVI A, #d0
        STA GAME_STATE2
        MVI A, #00
        STA $237e
        STA $239e
        STA $23be
        STA CREDITS_1
        STA CREDITS_2
        STA CREDITS_3
        MVI A, #0f
        STA BALL_IN_PLAY_hrm
        STA BALL_IN_PLAY_1
        STA BALL_IN_PLAY_2
        STA $2396
        STA $23b6
        LXI H, #23a3
        LXI D, #2320
        MVI A, #2e
o019d:  CALL COPY_FROM_HL_TO_DE
        MVI B, #01
        LXI D, ROLLOVERS
o01a5:  CALL FILL_PLAYER_DISPLAY_BLOCKS
        LXI H, #21c9
        LXI D, #21ce
        MVI A, #0a
o01b0:  CALL COPY_FROM_HL_TO_DE
        LXI H, #2205
        MVI B, #13
        SUB A
j01b9:  MOV M,A ;o01bc
        INX H
        DCR B
o01bc:  JNZ j01b9
j01bf:  DI ;o0165
        MVI A, #30
        STA SWITCH_LATCHED
        LDA GAME_STATE2
        ANI #80
o01ca:  JNZ READ_PRICING_AND_GAME_DIP_SWITCHES
        MVI A, #00
        STA GAME_STATE2
; Read the two pricing rotary encoders (ports 2/3 plus their 8/9 bits on port
; 4), store packed price settings, then read the DIP-selected balls per game.
READ_PRICING_AND_GAME_DIP_SWITCHES:
j01d2:  IN PRICE_CENTS_07_PORT ;o01ca,o1c45,o1c4b,o1c54,o1c70
        CMA
        MOV L,A
; read in the ones place
        IN PRICE_89_CAB
        CMA
        ANI #03
        MOV H,A
        MVI B, #0f
j01de:  DAD H ;o01e3
o01df:  JC j01e6
        DCR B
o01e3:  JNZ j01de
j01e6:  IN PRICE_TENS_07_PORT ;o01df
        CMA
        MOV L,A
; read in the dimes place
        IN PRICE_89_CAB
        CMA
        ANI #0c
        RAR
        RAR
        MOV H,A
        MVI C, #0f
j01f4:  DAD H ;o01f9
o01f5:  JC j01fc
        DCR C
o01f9:  JNZ j01f4
j01fc:  MOV A,C ;o01f5
        RAL
        RAL
        RAL
        RAL
        ANI #f0
        ADD B
        STA PRICE_1
        STA PRICE_2
        STA PRICE_3
        EI
; load dip switches, set # balls per game
        IN DIP_SWITCH_PORT
        LXI H, DIP_SWITCHES
        MOV M,A
        MVI B, #03
        MVI A, #00
o0218:  CALL CHECK_ATH_BIT_OF_HL
o021b:  JNZ j0228
        INR B
        MVI A, #01
o0221:  CALL CHECK_ATH_BIT_OF_HL
o0224:  JNZ j0228
        INR B
j0228:  MOV A,B ;o021b,o0224
        STA BALLS_PER_GAME
; Main hardware-output loop.  It commits the latched coil bytes to ports 5..8,
; services interrupt windows, display/lamp bookkeeping, and eventually loops.
MAIN_OUTPUT_LOOP:
j022c:  OUT LAMP_F ;o028f,o1c7b,o1cc0,o1ccb,o1cd9,o1d63
        EI
        NOP
        EI
        NOP
        EI
        NOP
        DI
        LDA $21c2
        CMA
        OUT COIL_5
        LDA $21c3
        CMA
        OUT COIL_6
        LDA $21c4
        CMA
        OUT COIL_7
        LDA $21c5
        CMA
        OUT COIL_8
        EI
        NOP
        EI
        NOP
        EI
        NOP
        DI
        LHLD $21f9
        LXI D, #21fb
        MOV A,L
        SUB E
o025c:  JZ j027b
o025f:  JM j0267
        CPI #08
o0264:  JC j0270
j0267:  LXI H, #21fb ;o025f
        SHLD $21f9
o026d:  JMP j027b
j0270:  DCX H ;o0264
        MOV A,M
        DCX H
        SHLD $21f9
        MOV L,M
        MOV H,A
o0278:  CALL ADD_PTS
j027b:  EI ;o025c,o026d
        LXI H, GAME_STATE2
        MVI A, #07
o0281:  CALL CHECK_ATH_BIT_OF_HL
o0284:  JNZ j1bb9
        LDA $23b6
        ANI #bf
        STA $23b6
o028f:  JMP MAIN_OUTPUT_LOOP
ADD_BONUS_HL:
        XCHG ;o07c8,o0ce8,o0dc5,o0dd4,o14b7,o15ca,o18d9
        LHLD $21f9
        MOV M,E
        INX H
        MOV M,D
        INX H
        SHLD $21f9
        RET

FLIPPER_HOLD_ROUTINE:
        LDA $21c3 ;o0870
        ANI #10
o02a3:  JZ j087b
        IN PRICE_89_CAB
        ANI #20
o02aa:  JZ j0891
        MVI A, #09
        STA LEFT_FLIPPER_TIMER
o02b2:  JMP APPLY_FLIPPER_PWM_MASK
RIGHT_FLIPPER_HOLD:
        LDA $21c3 ;o092d
        ANI #20
o02ba:  JZ j0938
        IN PRICE_89_CAB
        ANI #40
o02c1:  JZ j094e
        MVI A, #09
        STA RIGHT_FLIPPER_TIMER
APPLY_FLIPPER_PWM_MASK:
        LDA $21c3 ;o02b2
        MOV D,A
        LDA FLIPPER_PWM_MASK
        ANA D
        CMA
        OUT COIL_6
o02d4:  JMP END_MAIN_LOOP
INIT_FLIPPER_PWM_MASK:
        MVI A, #fc ;o0095
        STA SWITCH_LATCHED
        MVI A, #ff
        STA FLIPPER_PWM_MASK
        RET

PWM_RST55_CARRIER:
        CALL PWM_IRQ_COMMON ;o0333
        LDA GAME_STATE
        RET

PWM_RST65_CARRIER:
        CALL PWM_IRQ_COMMON ;o0389
        LXI D, #0000
        RET

PWM_IRQ_COMMON:
        LXI H, FLIPPER_PWM_MASK ;PWM_RST55_CARRIER,PWM_RST65_CARRIER
        MOV A,M
        XRI #30
        MOV M,A
        MOV B,A
o02f8:  CALL ADD_PULL_IN_MASK
        LDA $21c3
        ANA B
        CMA
        OUT COIL_6
        RET

; Sum the 34-byte software playfield comparison image at $233b..$235c.
; Output: HL=sum (16-bit, wrapping); D advances to $235d.
SUM_PLAYFIELD_COMPARE_IMAGE:
c0303:  LXI D, PLAYFIELD_COMPARE_IMAGE ;co0317,o13b5
        LXI B, #0000
        LXI H, #0000
j030c:  LDAX D ;o0313
        MOV C,A
        DAD B
        INX D
        MOV A,E
        CPI #5d
o0313:  JNZ j030c
        RET

; Compare the current playfield-image checksum against the saved value at
; $2224.  Returns Z only when both bytes match (with the original zero special
; case preserved).
COMPARE_PLAYFIELD_CHECKSUM:
co0317: CALL SUM_PLAYFIELD_COMPARE_IMAGE ;jo00f5
        XCHG
        LHLD $2224
        MOV A,E
        CMP L
        RNZ
        ORA A
o0322:  JZ j0328
j0325:  MOV A,D ;o032a
        CMP H
        RET

j0328:  MOV A,D ;o0322
        ORA A
o032a:  JNZ j0325
        INR A
        RET

        DCR L
BUMPER_SLING_HANDLER:
        CALL SAVE_BDPSW ;o002c
o0333:  CALL PWM_RST55_CARRIER
        ORI #80
        STA GAME_STATE
        IN BUMPER_SLINGS_SWITCHES_PORT
        LXI D, #0000
j0340:  ORA A ;o0349
o0341:  JZ RESTORE_INTERRUPT_CONTEXT_AND_RETURN
        RAR
o0345:  JC j034c
        INR E
o0349:  JMP j0340
j034c:  MOV A,E ;o0345
        CMA
        OUT LAMP_E
        CMA
        LXI H, STATE_OUTLANE_1
o0354:  CALL CHECK_ATH_BIT_OF_HL
o0357:  JNZ RESTORE_INTERRUPT_CONTEXT_AND_RETURN
o035a:  CALL SAVE_BDPSW
        LDA CONTROL_FLAGS
        ANI #02
o0362:  CNZ ROTATE_CUP_LAMP_STATE
o0365:  CALL RESTORE_BDPSW
o0368:  CALL SET_ATH_BIT_OF_HL
; E is the zero-based number of the first asserted port-1 bit.  XCHG moves that
; index to HL and DAD H converts it to a two-byte pointer-table offset.
        XCHG
        DAD H
        LXI D, REFLEX_DISPATCH_TABLE
        DAD D
        MOV A,M
        INX H
        MOV H,M
        MOV L,A
        PCHL
; Input: A=switch bit number.  Clear its software latch, restore the outer
; interrupt context, and return from the handler.
CLEAR_SWITCH_LATCH_AND_RETURN:
j0376:  LXI H, SWITCH_LATCHED ;o0606,o13e7,o178b
o0379:  JMP jo037f
        LXI H, STATE_OUTLANE_1
jo037f: CALL CLEAR_ATH_BIT_OF_HL ;o0379
; vector to 0630 stack restore
RESTORE_INTERRUPT_CONTEXT_AND_RETURN:
jo0382: CALL RESTORE_BDPSW ;o0006,o0341,o0357,o038f,o03a5,o0486,o0540,o0549,o078c,o07cb,o084f,o0865,o086d,o0921,o092a
        RET

SWITCH_HANDLER:
        CALL SAVE_BDPSW ;o0034
o0389:  CALL PWM_RST65_CARRIER
        IN CABINET_TILT_FLIPPERS_TIMER_PORT
j038e:  ORA A ;o0397
o038f:  JZ RESTORE_INTERRUPT_CONTEXT_AND_RETURN
        RAR
o0393:  JC j039a
        INR E
o0397:  JMP j038e
j039a:  MOV A,E ;o0393
        CMA
        OUT LAMP_D
        CMA
        LXI H, SWITCH_LATCHED
o03a2:  CALL CHECK_ATH_BIT_OF_HL
o03a5:  JNZ RESTORE_INTERRUPT_CONTEXT_AND_RETURN
o03a8:  CALL SET_ATH_BIT_OF_HL
; E is the zero-based number of the first asserted port-0 bit.  As above,
; doubling it selects the corresponding little-endian handler pointer.
        XCHG
        DAD H
        LXI D, CABINET_DISPATCH_TABLE
        DAD D
        MOV A,M
        INX H
        MOV H,M
        MOV L,A
        PCHL
REFLEX_DISPATCH_TABLE:
        DW LOWER_LEFT_BUMPER_HANDLER       ; port 1 bit 0
        DW UPPER_LEFT_BUMPER_HANDLER       ; port 1 bit 1
        DW MIDDLE_ROLLOVER_BUMPER_HANDLER  ; port 1 bit 2
        DW LOWER_RIGHT_BUMPER_HANDLER      ; port 1 bit 3
        DW RIGHT_SLINGSHOT_HANDLER         ; port 1 bit 4
        DW LEFT_SLINGSHOT_HANDLER          ; port 1 bit 5
        DW REFLEX_CONTROL_FLAG_HANDLER     ; port 1 bit 6
        DW RESTORE_INTERRUPT_CONTEXT_AND_RETURN                          ; port 1 bit 7, unused/return
CABINET_DISPATCH_TABLE:
        DW PERIODIC_TIMER_HANDLER          ; port 0 bit 0: timer tick
        DW PLAYFIELD_DMA_HANDLER           ; port 0 bit 1: DMA sample ready
        DW o0003                          ; port 0 bit 2: credit
        DW TILT_HANDLER                    ; port 0 bit 3: tilt
        DW LEFT_FLIPPER_HANDLER            ; port 0 bit 4
        DW RIGHT_FLIPPER_HANDLER           ; port 0 bit 5
        DW START_BUTTON_HANDLER            ; port 0 bit 6
        DW TILT_HANDLER                    ; port 0 bit 7: alternate tilt
SET_ATH_BIT_OF_HL:
        PUSH B ;o0368,o03a8,o0410,o052e,o06cb,o079f,o09c0,o09cf,o09f6,o0aa1,o0af2,o0b55,o0c98,o0c9e,o0d52,jo1078,jo10ad,o11f8,o1213,o1283,o13c1,o13fb,o1499,o1568,o15c4,o1657,o170a,jo1738,jo174e,o184b,o1853,o19a3,o19dc,jo1a98,o1aab,o1b6c,o1c42,o1c7e,o1d1f,o1d56,o1d79,o1d7d,o1d94
        MOV B,A
o03d8:  CALL LSHIFT_A
        MOV C,M
        ORA C
        MOV M,A
o03de:  JMP j03f6
CLEAR_ATH_BIT_OF_HL:
        PUSH B ;jo037f,o0423,o06bd,o06d8,o06de,o06e4,o0716,o088b,o0948,o09e7,jo09fc,o0a4d,o0a5b,o0ba4,o0bb4,jo107d,o10ba,o10bf,jo1222,jo1255,o1382,o13e1,o13f1,jo1402,o14ae,o1541,o15e9,o16a7,o1923,jo1955,o199d,o1abf,o1acc,jo1c48,o1c6a,o1d4e,o1d6b,o1d84,o1d8c,o1d98
        MOV B,A
o03e3:  CALL LSHIFT_A
        CMA
        MOV C,A
        MOV A,M
        ANA C
        MOV M,A
o03eb:  JMP j03f6
CHECK_ATH_BIT_OF_HL:
        PUSH B ;o0218,o0221,o0281,o0354,o03a2,o0409,o05b2,o06b9,o0710,o07f8,o084c,o0862,o0875,o0880,o091e,o0932,o093d,o09c5,o09e1,o0a0b,o0a47,o0a55,o0b13,o0b49,o0bec,o0cd6,o0f49,o0f50,o0f57,o0faa,o1071,o10a6,o120b,o1227,o127f,o13d9,o13f5,o149e,o14a8,o153b,o1546,o1557,o1562,o158d,o15be,o15db,o15e3,o1600,o1642,o164a,o16fa,o1702,o17f7,o180d,o186d,jo1949,o195c,o19c4,o1c78,o1cd3,o1d88,o1d9f
        MOV B,A
o03f0:  CALL LSHIFT_A
        MOV C,A
        MOV A,M
        ANA C
j03f6:  MOV A,B ;o03de,o03eb
        POP B
        RET

LSHIFT_A:
        MOV C,A ;o03d8,o03e3,o03f0
        MVI A, #01
j03fc:  DCR C ;o03ff
        RM
        ADD A
o03ff:  JMP j03fc
; Rotate the selected cup-lamp state to the next of five positions.  If the
; source bit is lit it is copied into the corresponding destination page bit;
; the old position is then cleared.
ROTATE_CUP_LAMP_STATE:
c0402:  LDA $2211 ;o0362,o0b4c,o157f
        MOV B,A
o0406:  CALL RESOLVE_CUP_LAMP_PAIR
o0409:  CALL CHECK_ATH_BIT_OF_HL
o040c:  JZ j0413
        XCHG
o0410:  CALL SET_ATH_BIT_OF_HL
j0413:  MOV A,B ;o040c
        INR A
        CPI #05
o0417:  JNZ j041c
        MVI A, #00
j041c:  STA $2211 ;o0417
o041f:  CALL RESOLVE_CUP_LAMP_PAIR
        XCHG
o0423:  CALL CLEAR_ATH_BIT_OF_HL
        RET

; Input: A=cup rotation index 0..4.
; Output: A=bit number, HL=source lamp-state byte, DE=paired byte at HL+5.
RESOLVE_CUP_LAMP_PAIR:
c0427:  MVI D, #00 ;o0406,o041f
        MOV E,A
        LXI H, CUP_LIGHT_INDEX_TABLE
        DAD D
        MOV A,M
        LXI H, CUP_LAMP_STATE_ADDRESS_TABLE
        XCHG
        DAD H
        DAD D
        MOV C,M
        INX H
        MOV H,M
        MOV L,C
        LXI D, #0005
        XCHG
        DAD D
        XCHG
        RET

; unreachable or data or computed call?
CUP_LIGHT_INDEX_TABLE:
        DB #04
        DB #00
        DB #01
        DB #02
        DB #05
CUP_LAMP_STATE_ADDRESS_TABLE:
        DB #cd
        DB #21
        DB #cc
        DB #21
        DB #cc
        DB #21
        DB #cc
        DB #21
        DB #ca
        DB #21
TILT_HELPER:
        LDA GAME_STATE ;TILT_HANDLER,o0591
        ORI #05
        STA GAME_STATE
        MVI A, #00
        STA $220c
        MVI A, #ff
        STA STATE_OUTLANE_1
        LDA SWITCH_LATCHED
        ORI #30
        STA SWITCH_LATCHED
        RET

; Return NZ only for the lockout combination GAME_STATE2 bit 6 set and zero
; credits.  All other combinations return Z.  A is otherwise scratch.
CHECK_CREDIT_LOCKOUT_STATE:
c046a:  LDA GAME_STATE2 ;o0483,o058b
        ANI #40
        RZ
        LDA CREDITS_1
        ORA A
o0474:  JZ j0479
        CMP A
        RET

j0479:  DCR A ;o0474
        RET

TILT_HANDLER:
        CALL TILT_HELPER
        MVI A, #7d
        STA TILT_TIMER
o0483:  CALL CHECK_CREDIT_LOCKOUT_STATE
o0486:  JNZ RESTORE_INTERRUPT_CONTEXT_AND_RETURN
        MVI A, #fa
        STA DISPLAY_CLEAR_TIMER
        LDA $23b6
        ORI #10
        STA $23b6
        MVI A, #ff
        STA LAMPS_PAGE_1
        STA $2381
        STA $2382
        LDA $233f
        ADI #08
        MOV B,A
        LDA $23e4
        SUB B
o04ab:  JM TILT2
        LDA GAME_STATE2
        ANI #40
o04b3:  JNZ TILT2
        LDA SWITCH_LATCHED
        ORI #fc
        STA SWITCH_LATCHED
        LDA $2247
        ORI #40
        STA $2247
        MVI A, #ff
        LXI H, #23c0
        MVI B, #20
j04cd:  MOV M,A ;o04d0
        INX H
        DCR B
o04d0:  JNZ j04cd
        OUT LAMP_0
        OUT LAMP_1
        OUT LAMP_2
        OUT LAMP_3
        OUT LAMP_4
        OUT COIL_5
        OUT COIL_6
        OUT COIL_7
        OUT COIL_8
        MVI A, #00
        MVI A, #0f
        STA $23cc
        STA $23d6
        STA $23de
        LDA GAME_STATE
        ANI #f7
        STA GAME_STATE
        LDA $2396
        ANI #df
        STA $2396
        LDA $23b6
        ANI #df
        STA $23b6
        MVI B, #30
o050c:  CALL CLEAR_LAMP_AND_TEST_FLASH_PAGE
        MVI A, #d0
        STA GAME_STATE2
        LDA BALLS_PER_GAME
        STA BALL_IN_PLAY_hrm
        LXI H, #237e
        MOV A,M
        ANI #0f
        MOV M,A
        MVI B, #ff
j0523:  RAR ;o0528
o0524:  JNC j052b
        INR B
o0528:  JMP j0523
j052b:  MOV A,B ;o0524
        ADI #04
o052e:  CALL SET_ATH_BIT_OF_HL
        MVI A, #01
        STA $2214
        MVI A, #28
        STA $221b
        MVI A, #02
        STA END_SEQUENCE_TIMER
o0540:  JMP RESTORE_INTERRUPT_CONTEXT_AND_RETURN
TILT2:  LXI H, TILT_MUSIC ;o04ab,o04b3
o0546:  CALL PLAY_SOUND
o0549:  JMP RESTORE_INTERRUPT_CONTEXT_AND_RETURN
END_SEQUENCE_TIMER_EXPIRED:
TIMER_06_EXPIRED:
        LDA $221b
        DCR A
        STA $221b
o0553:  JZ j0569
        MVI A, #14
        STA END_SEQUENCE_TIMER
        MVI A, #fa
        STA DISPLAY_CLEAR_TIMER
        LXI H, SILENCE_END_LOOP_MUSIC
o0563:  CALL PLAY_SOUND
o0566:  JMP END_MAIN_LOOP
j0569:  LDA $2247 ;o0553
        ANI #bf
        STA $2247
        MVI A, #01
        STA END_BALL_TIMER
        STA $221c
        LDA SWITCH_LATCHED
        ANI #33
        STA SWITCH_LATCHED
o0581:  JMP END_MAIN_LOOP
; tilt handler 2
TILT_TIMER_EXPIRED:
TIMER_11_EXPIRED:
        IN PRICE_89_CAB
        ANI #80
o0588:  JMP j05a2
o058b:  CALL CHECK_CREDIT_LOCKOUT_STATE
o058e:  JNZ j05a2
o0591:  CALL TILT_HELPER
        MVI A, #7d
        STA TILT_TIMER
        LXI H, TILT_MUSIC
o059c:  CALL PLAY_SOUND
o059f:  JMP END_MAIN_LOOP
j05a2:  LDA SWITCH_LATCHED ;o0588,o058e
        ANI #77
        STA SWITCH_LATCHED
o05aa:  JMP END_MAIN_LOOP
DISPLAY_CLEAR_TIMER_EXPIRED:
TIMER_07_EXPIRED:
        LXI H, GAME_STATE2
        MVI A, #07
o05b2:  CALL CHECK_ATH_BIT_OF_HL
o05b5:  JZ END_MAIN_LOOP
        LDA $23b6
        ANI #ef
        STA $23b6
        MVI A, #f0
        STA LAMPS_PAGE_2
        STA LAMPS_PAGE_1
        MVI A, #ff
        STA $23a1
        STA $2381
        STA $23a2
        STA $2382
o05d6:  JMP END_MAIN_LOOP
; when no switches activated?
PERIODIC_TIMER_HANDLER:
        LXI H, SOFTWARE_TIMER_BASE
        MVI C, SOFTWARE_TIMER_COUNT
j05de:  MVI A, #ff ;o05ea
        ADD M
o05e1:  JNC j05e8
        MOV M,A
o05e5:  JZ j0609
j05e8:  INX H ;o05e1,o0621
        DCR C
o05ea:  JNZ j05de
        LDA TONE_TIMER
        ORA A
o05f1:  JNZ j05f6
        MVI A, #01
j05f6:  ANI #3f ;o05f1
        STA TONE_TIMER
        LDA $2247
        ANI #40
o0600:  CZ FLASH_ROUTINE
        MVI A, #00
        DI
o0606:  JMP CLEAR_SWITCH_LATCH_AND_RETURN
j0609:  DI ;o05e5
o060a:  CALL SAVE_BDPSW
; C is the number of slots remaining when a zero was found, so
; SOFTWARE_TIMER_COUNT-C is the expired slot number.  ADD A multiplies that
; slot by the two-byte DW pointer size before TIMER_EXPIRATION_TABLE is read.
        MVI A, SOFTWARE_TIMER_COUNT
        SUB C
        ADD A
        LXI D, #0000
        MOV E,A
        LXI H, TIMER_EXPIRATION_TABLE
        DAD D
        MOV A,M
        INX H
        MOV H,M
        MOV L,A
        PCHL
END_MAIN_LOOP:
        CALL RESTORE_BDPSW ;o02d4,o0566,o0581,o059f,o05aa,o05b5,o05d6,o071e,o0729,o07e8,o07f0,o07fb,o0803,o0883,o088e,o08a1,o08c8,o08da,o08f1,o0906,o0940,o094b,o095e,o0a6d,o0a90,o0aa9,o0abb,o0ae9,o0b4f,o0ba7,o0bb7,o0cc1,o0cf6,o0d26,o0de9,o121f,o123e,o1252,o125e,o14f7,o152b,o18e7,o1911,o1a37,o1a6e,o1a87,o1ad4,o1aec,jo1ba5,o1d73
o0621:  JMP j05e8
; push A, SP, B, D, H
SAVE_BDPSW:
        SHLD STACK_SCRATCH ;BUMPER_SLING_HANDLER,o035a,SWITCH_HANDLER,o060a,o1406
        XTHL
        PUSH B
        PUSH D
        PUSH PSW
        PUSH H
        LHLD STACK_SCRATCH
        RET

; restore A, SP, B, D, H
RESTORE_BDPSW:
        POP H ;o0365,jo0382,END_MAIN_LOOP,jo1419
        POP PSW
        POP D
        POP B
        XTHL
        RET

FLASH_ROUTINE:
        LXI H, #21f8 ;o0600
        DCR M
o063a:  JNZ j0647
        MVI M, #14
        LDA $2247
        ADI #80
        STA $2247
j0647:  LDA $2247 ;o063a
        ANI #80
o064c:  JZ LAMP_PAGE_2_COPY
        LXI H, LAMPS_PAGE_2
        LXI D, #23c0
        MVI A, #40
LAMP_PAGE_1_COPY:
        CALL COPY_FROM_HL_TO_DE
        LDA $21c9
        CMA
        OUT LAMP_0
        LDA $21ca
        CMA
        OUT LAMP_1
        LDA $21cb
        CMA
        OUT LAMP_2
        LDA $21cc
        CMA
        OUT LAMP_3
        LDA $21cd
        CMA
        OUT LAMP_4
o0678:  JMP j06a4
LAMP_PAGE_2_COPY:
        LXI H, LAMPS_PAGE_1 ;o064c
        LXI D, #23c0
        MVI A, #40
o0683:  CALL COPY_FROM_HL_TO_DE
        LDA $21ce
        CMA
        OUT LAMP_0
        LDA $21cf
        CMA
        OUT LAMP_1
        LDA $21d0
        CMA
        OUT LAMP_2
        LDA $21d1
        CMA
        OUT LAMP_3
        LDA $21d2
        CMA
        OUT LAMP_4
; check credit button
j06a4:  IN PRICE_89_CAB ;o0678
        ANI #10
o06a8:  JNZ CREDIT_HANDLER
        LDA GAME_STATE2
        ORI #20
        STA GAME_STATE2
        RET

CREDIT_HANDLER:
        LXI H, GAME_STATE2 ;o0003,o06a8
        MVI A, #05
o06b9:  CALL CHECK_ATH_BIT_OF_HL
        RZ
o06bd:  CALL CLEAR_ATH_BIT_OF_HL
        LDA CREDITS_1
        CPI #99
        RZ
        LXI H, #21c5
        MVI A, #03
o06cb:  CALL SET_ATH_BIT_OF_HL
        MVI A, #09
        STA COIL_LATCH_TIMER
; Shared credit-award entry: clear the scoreboard indicator bits and lamp 0,
; then fall through through the normal packed-BCD credit increment, sound, and
; optional high-score reset path.
ADD_CREDIT_AND_CLEAR_INDICATORS:
c06d3:  MVI A, #06 ;jo1a71
        LXI H, #2376
o06d8:  CALL CLEAR_ATH_BIT_OF_HL
        LXI H, #2396
o06de:  CALL CLEAR_ATH_BIT_OF_HL
        LXI H, #23b6
o06e4:  CALL CLEAR_ATH_BIT_OF_HL
        MVI B, #00
o06e9:  CALL CLEAR_LAMP_AND_TEST_FLASH_PAGE
        LDA CREDITS_1
        INR A
        DAA
        STA CREDITS_1
        STA CREDITS_2
        STA CREDITS_3
        LXI H, CREDIT_MUSIC
o06fd:  CALL PLAY_SOUND
        LXI H, #224a
        DCR M
        RNZ
        MVI M, #64
o0707:  CALL RESET_HIGH_SCORE_TABLE
        RET

COIL_LATCH_TIMER_EXPIRED:
TIMER_20_EXPIRED:
        LXI H, #21c5
        MVI A, #03
o0710:  CALL CHECK_ATH_BIT_OF_HL
o0713:  JZ j0721
o0716:  CALL CLEAR_ATH_BIT_OF_HL
        MVI A, #09
        STA COIL_LATCH_TIMER
o071e:  JMP END_MAIN_LOOP
j0721:  LDA SWITCH_LATCHED ;o0713
        ANI #bb
        STA SWITCH_LATCHED
o0729:  JMP END_MAIN_LOOP
TIMER_EXPIRATION_TABLE:
        DW SWITCH_SETTLE_TIMER_EXPIRED       ; 00: $2197
        DW TONE_TIMER_EXPIRED                ; 01: $2198
        DW COIL_PULSE_TIMER_EXPIRED          ; 02: $2199
        DW END_MAIN_LOOP                     ; 03: unused
        DW CUP_BONUS_TIMER_EXPIRED           ; 04: $219b
        DW CUP_COMPLETION_TIMER_EXPIRED      ; 05: $219c
        DW END_SEQUENCE_TIMER_EXPIRED        ; 06: $219d, inferred
        DW DISPLAY_CLEAR_TIMER_EXPIRED       ; 07: $219e, inferred
        DW CLOCK_TIMER_EXPIRED               ; 08: $219f, inferred
        DW END_BALL_TIMER_EXPIRED            ; 09: $21a0, inferred
        DW GAME_OVER_SEQUENCE_TIMER_EXPIRED  ; 10: $21a1, inferred
        DW TILT_TIMER_EXPIRED                ; 11: $21a2
        DW HIGH_SCORE_DISPLAY_TIMER_EXPIRED  ; 12: $21a3, inferred
        DW ROLLOVER_COMPLETION_TIMER_EXPIRED ; 13: $21a4
        DW CUP_EJECT_SEQUENCE_TIMER_EXPIRED  ; 14: $21a5
        DW TARGET_COIL_TIMER_EXPIRED         ; 15: $21a6, inferred
        DW BONUS_COUNT_TIMER_EXPIRED         ; 16: $21a7, inferred
        DW LEFT_FLIPPER_TIMER_EXPIRED        ; 17: $21a8
        DW RIGHT_FLIPPER_TIMER_EXPIRED       ; 18: $21a9
        DW END_MAIN_LOOP                     ; 19: unused
        DW COIL_LATCH_TIMER_EXPIRED          ; 20: $21ab, inferred
        DW DMA_RECHECK_TIMER_EXPIRED         ; 21: $21ac, inferred
        DW OUTLANE_STATE_TIMER_EXPIRED       ; 22: $21ad, inferred
        DW BONUS_PAYOUT_TIMER_EXPIRED        ; 23: $21ae, inferred
        DW STANDUP_BAR_TIMER_EXPIRED         ; 24: $21af, inferred
        DW END_MAIN_LOOP                     ; 25: unused
; Lower-left bumper, coil 11
LOWER_LEFT_BUMPER_HANDLER:
        LXI D, #0000
o0763:  JMP FIRE_REFLEX_DEVICE
; Upper-left bumper, coil 16
UPPER_LEFT_BUMPER_HANDLER:
        LXI D, #0001
o0769:  JMP FIRE_REFLEX_DEVICE
; Middle rollover bumper, coil 17
MIDDLE_ROLLOVER_BUMPER_HANDLER:
        LXI D, #0002
o076f:  JMP FIRE_REFLEX_DEVICE
; Lower-right bumper, coil 10
LOWER_RIGHT_BUMPER_HANDLER:
        LXI D, #0003
o0775:  JMP FIRE_REFLEX_DEVICE
; Right slingshot, coil 19
RIGHT_SLINGSHOT_HANDLER:
        LXI D, #0004
o077b:  JMP FIRE_REFLEX_DEVICE
; Left slingshot, coil 20
LEFT_SLINGSHOT_HANDLER:
        LXI D, #0005
o0781:  JMP FIRE_REFLEX_DEVICE
; port 1 bit 6 handler: set $2191 bit 5
REFLEX_CONTROL_FLAG_HANDLER:
        LDA CONTROL_FLAGS
        ORI #20
        STA CONTROL_FLAGS
o078c:  JMP RESTORE_INTERRUPT_CONTEXT_AND_RETURN
; Input: DE=reflex-device index 0..5.  Resolve and energize its coil, arm the
; pulse timer, then select the matching sound and score table entries.
FIRE_REFLEX_DEVICE:
j078f:  LXI H, REFLEX_COIL_INDEX_TABLE ;o0763,o0769,o076f,o0775,o077b,o0781
        DAD D
        MOV A,M
        XCHG
        DAD H
        XCHG
        LXI H, REFLEX_COIL_STATE_TABLE
        DAD D
        MOV B,M
        INX H
        MOV H,M
        MOV L,B
o079f:  CALL SET_ATH_BIT_OF_HL
        MVI A, #09
        STA COIL_PULSE_TIMER
        LDA $21c3
        CMA
        OUT COIL_6
        LDA $21c4
        CMA
        OUT COIL_7
        LXI H, REFLEX_SOUND_TABLE
        DAD D
        MOV B,M
        INX H
        MOV H,M
        MOV L,B
        PUSH D
; computed sound?
o07bc:  CALL PLAY_SOUND
        POP D
        LXI H, REFLEX_SCORE_TABLE
        DAD D
        MOV B,M
        INX H
        MOV H,M
        MOV L,B
o07c8:  CALL ADD_BONUS_HL
o07cb:  JMP RESTORE_INTERRUPT_CONTEXT_AND_RETURN
COIL_PULSE_TIMER_EXPIRED:
TIMER_02_EXPIRED:
        LDA $21c3
        ANI #30
        STA $21c3
        CMA
        OUT COIL_6
        LDA $21c4
        ANI #20
        STA $21c4
        CMA
        OUT COIL_7
        LDA OUTLANE_STATE_TIMER
        ORA A
o07e8:  JNZ END_MAIN_LOOP
        MVI A, #06
        STA OUTLANE_STATE_TIMER
o07f0:  JMP END_MAIN_LOOP
OUTLANE_STATE_TIMER_EXPIRED:
TIMER_22_EXPIRED:
        LXI H, GAME_STATE
        MVI A, #02
o07f8:  CALL CHECK_ATH_BIT_OF_HL
o07fb:  JNZ END_MAIN_LOOP
        MVI A, #80
        STA STATE_OUTLANE_1
o0803:  JMP END_MAIN_LOOP
REFLEX_COIL_INDEX_TABLE:
        INX B
        NOP
        LXI B, #0302
        INR B
        STAX B
REFLEX_COIL_STATE_TABLE:
        JMP $c421
        LXI H, #21c4
        JMP $c421
        LXI H, #21c4
        DB #c4
        DB #21
REFLEX_SOUND_TABLE:
        DB #ad
        DB #12
        DB #b0
        DB #12
        DB #b3
        DB #12
        DB #b6
        DB #12
        DB #b9
        DB #12
        DB #bc
        DB #12
        DB #bf
        DB #12
REFLEX_SCORE_TABLE:
        DB #55
        DB #11
        DB #59
        DB #11
        DB #5d
        DB #11
        DB #51
        DB #11
        DB #4d
        DB #11
        DB #4d
        DB #11
        DB #49
        DB #11
; left flipper fire
LEFT_FLIPPER_HANDLER:
        LDA $21c3
        ORI #10
        STA $21c3
        CMA
        OUT COIL_6
        MVI A, #19
        STA LEFT_FLIPPER_TIMER
        LXI H, GAME_STATE
        MVI A, #05
o084c:  CALL CHECK_ATH_BIT_OF_HL
o084f:  JNZ RESTORE_INTERRUPT_CONTEXT_AND_RETURN
        LXI H, SILENCE_MUSIC
o0855:  CALL PLAY_SOUND
        MVI A, #04
        STA $2222
        LXI H, CONTROL_FLAGS
        MVI A, #00
o0862:  CALL CHECK_ATH_BIT_OF_HL
o0865:  JZ RESTORE_INTERRUPT_CONTEXT_AND_RETURN
        MVI A, #7d
        STA CLOCK_TIMER
o086d:  JMP RESTORE_INTERRUPT_CONTEXT_AND_RETURN
; left flipper release
LEFT_FLIPPER_TIMER_EXPIRED:
o0870:  JMP FLIPPER_HOLD_ROUTINE
        MVI A, #04
o0875:  CALL CHECK_ATH_BIT_OF_HL
o0878:  JNZ j0891
j087b:  LXI H, GAME_STATE ;o02a3
        MVI A, #02
o0880:  CALL CHECK_ATH_BIT_OF_HL
o0883:  JNZ END_MAIN_LOOP
        MVI A, #04
        LXI H, SWITCH_LATCHED
o088b:  CALL CLEAR_ATH_BIT_OF_HL
o088e:  JMP END_MAIN_LOOP
; right flipper
j0891:  LDA $21c3 ;o02aa,o0878
        ANI #2f
        STA $21c3
        CMA
        OUT COIL_6
        MVI A, #06
        STA LEFT_FLIPPER_TIMER
o08a1:  JMP END_MAIN_LOOP
CLOCK_TIMER_EXPIRED:
TIMER_08_EXPIRED:
        LDA CONTROL_FLAGS
        ANI #01
o08a9:  JZ j08bc
        LDA $21c3
        ORI #30
        STA $21c3
        MVI A, #19
        STA LEFT_FLIPPER_TIMER
        STA RIGHT_FLIPPER_TIMER
j08bc:  MVI A, #71 ;o08a9
        STA CLOCK_TIMER
        LDA $221f
        DCR A
        STA $221f
o08c8:  JNZ END_MAIN_LOOP
        MVI A, #3c
        STA $221f
        LDA $2220
        INR A
        DAA
        STA $2220
        CPI #60
o08da:  JNZ END_MAIN_LOOP
        MVI A, #00
        STA $2220
        LDA $2221
        INR A
        DAA
        STA $2221
        LDA $2222
        DCR A
        STA $2222
o08f1:  JNZ END_MAIN_LOOP
o08f4:  CALL RESET_HIGH_SCORE_TABLE
        MVI A, #64
        STA $224a
        MVI A, #04
        STA $2222
        MVI A, #00
        STA CLOCK_TIMER
o0906:  JMP END_MAIN_LOOP
RIGHT_FLIPPER_HANDLER:
        LDA $21c3
        ORI #20
        STA $21c3
        CMA
        OUT COIL_6
        MVI A, #19
        STA RIGHT_FLIPPER_TIMER
        LXI H, GAME_STATE
        MVI A, #05
o091e:  CALL CHECK_ATH_BIT_OF_HL
o0921:  JNZ RESTORE_INTERRUPT_CONTEXT_AND_RETURN
        LXI H, SILENCE_MUSIC
o0927:  CALL PLAY_SOUND
o092a:  JMP RESTORE_INTERRUPT_CONTEXT_AND_RETURN
RIGHT_FLIPPER_TIMER_EXPIRED:
o092d:  JMP RIGHT_FLIPPER_HOLD
        MVI A, #05
o0932:  CALL CHECK_ATH_BIT_OF_HL
o0935:  JNZ j094e
j0938:  LXI H, GAME_STATE ;o02ba
        MVI A, #02
o093d:  CALL CHECK_ATH_BIT_OF_HL
o0940:  JNZ END_MAIN_LOOP
        LXI H, SWITCH_LATCHED
        MVI A, #05
o0948:  CALL CLEAR_ATH_BIT_OF_HL
o094b:  JMP END_MAIN_LOOP
; right flipper release
j094e:  LDA $21c3 ;o02c1,o0935
        ANI #1f
        STA $21c3
        CMA
        OUT COIL_6
        MVI A, #06
        STA RIGHT_FLIPPER_TIMER
o095e:  JMP END_MAIN_LOOP
CUP_1_HANDLER:
        MVI B, #24
        MVI C, #00
o0965:  JMP DEBOUNCE_MAIN_CUP
CUP_2_HANDLER:
        MVI B, #03
        MVI C, #01
o096c:  JMP DEBOUNCE_MAIN_CUP
CUP_3_HANDLER:
        MVI B, #0b
        MVI C, #02
o0973:  JMP DEBOUNCE_MAIN_CUP
CUP_4_HANDLER:
        MVI B, #13
        MVI C, #03
o097a:  JMP DEBOUNCE_MAIN_CUP
CUP_5_HANDLER:
        MVI B, #29
        MVI C, #04
o0981:  JMP DEBOUNCE_MAIN_CUP
SIDE_BONUS_CUP_HANDLER:
        MVI A, #04
        STA SWITCH_SETTLE_TIMER
        LXI H, #2208
        MVI A, #ff
        ADD M
o098f:  JNC j09ae
        MOV M,A
o0993:  JZ j0bdf
o0996:  JMP RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
; Shared entry for the five main cups.  Debounce the cup via $2208 and the
; switch-settle timer, then continue with the cup number in C and coil id in B.
DEBOUNCE_MAIN_CUP:
j0999:  LXI H, #2208 ;o0965,o096c,o0973,o097a,o0981
        MVI A, #ff
        ADD M
o099f:  JNC j09ae
        MOV M,A
o09a3:  JZ j09bb
        MVI A, #04
        STA SWITCH_SETTLE_TIMER
o09ab:  JMP RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
j09ae:  MVI A, #64 ;o098f,o099f
        STA $2208
        MVI A, #04
        STA SWITCH_SETTLE_TIMER
o09b8:  JMP RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
j09bb:  LXI H, GAME_STATE ;o09a3
        MVI A, #07
o09c0:  CALL SET_ATH_BIT_OF_HL
        MVI A, #02
o09c5:  CALL CHECK_ATH_BIT_OF_HL
o09c8:  JZ jo09da
        MOV A,C
o09cc:  CALL RESOLVE_CUP_TARGET_STATE
o09cf:  CALL SET_ATH_BIT_OF_HL
        MVI A, #06
        STA TARGET_COIL_TIMER
o09d7:  JMP RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
jo09da: CALL CLEAR_LAMP_AND_TEST_FLASH_PAGE ;o09c8
        MOV A,C
        LXI H, CUPS_LEFT
o09e1:  CALL CHECK_ATH_BIT_OF_HL
o09e4:  JZ jo0b52
o09e7:  CALL CLEAR_ATH_BIT_OF_HL
        LXI H, #2211
        CMP M
        LXI H, GAME_STATE2
        MVI A, #01
o09f3:  JNZ jo09fc
o09f6:  CALL SET_ATH_BIT_OF_HL
o09f9:  JMP j09ff
jo09fc: CALL CLEAR_ATH_BIT_OF_HL ;o09f3
j09ff:  MOV A,C ;o09f9
o0a00:  CALL RESOLVE_CUP_TARGET_STATE
o0a03:  CALL CHECK_LAMP_LIT_PAGE
o0a06:  JZ jo0a14
        XCHG
        DAD D
o0a0b:  CALL CHECK_ATH_BIT_OF_HL
        XCHG
        MVI A, #01
o0a11:  JZ j0a24
jo0a14: CALL SET_LAMP_FLASHING ;o0a06
        LXI H, OOPS_MUSIC
o0a1a:  CALL PLAY_SOUND
        MVI A, #c8
        STA $2208
        MVI A, #5a
j0a24:  STA CUP_BONUS_TIMER ;o0a11
o0a27:  JMP RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
CUP_BONUS_TIMER_EXPIRED:
TIMER_04_EXPIRED:
        LXI H, CUP_BONUS_SCORE_TABLE - 1
        LDA $21c8
        ADD A
        MVI D, #00
        MOV E,A
        DAD D
        MOV A,M
        INX H
        MOV H,M
        MOV L,A
o0a39:  CALL ADD_BONUS
        LXI H, UNKNOWN_MUSIC
o0a3f:  CALL PLAY_SOUND
        LXI H, GAME_STATE2
        MVI A, #01
o0a47:  CALL CHECK_ATH_BIT_OF_HL
o0a4a:  JZ FINISH_CUP_AWARD
o0a4d:  CALL CLEAR_ATH_BIT_OF_HL
        LXI H, CONTROL_FLAGS
        MVI A, #01
o0a55:  CALL CHECK_ATH_BIT_OF_HL
o0a58:  JZ FINISH_CUP_AWARD
o0a5b:  CALL CLEAR_ATH_BIT_OF_HL
        MVI A, #fa
        STA $2208
        MVI A, #05
        STA $221a
        MVI A, #28
        STA CUP_COMPLETION_TIMER
o0a6d:  JMP END_MAIN_LOOP
CUP_COMPLETION_TIMER_EXPIRED:
TIMER_05_EXPIRED:
        LXI H, SCORE_5000
o0a73:  CALL ADD_BONUS
        LXI H, SPREAD_HRM_MUSIC
o0a79:  CALL PLAY_SOUND
        LDA $221a
        DCR A
        STA $221a
o0a83:  JZ FINISH_CUP_AWARD
        MVI A, #28
        STA CUP_COMPLETION_TIMER
        MVI A, #fa
        STA $2208
o0a90:  JMP END_MAIN_LOOP
; Finish a cup award: either launch the all-cups-complete sequence or re-arm
; the resolved cup state and its delayed eject coil.
FINISH_CUP_AWARD:
j0a93:  LDA CUPS_LEFT ;o0a4a,o0a58,o0a83
        CPI #00
o0a98:  JZ jo0aac
        LHLD $2209
        LDA $220b
o0aa1:  CALL SET_ATH_BIT_OF_HL
        MVI A, #06
        STA TARGET_COIL_TIMER
o0aa9:  JMP END_MAIN_LOOP
; all cups complete
jo0aac: CALL START_ALL_CUPS_COMPLETE_AWARD ;o0a98
        NOP
        NOP
        MVI A, #64
        STA $2208
        MVI A, #00
        STA $2207
o0abb:  JMP END_MAIN_LOOP
CUP_EJECT_SEQUENCE_TIMER_EXPIRED:
TIMER_14_EXPIRED:
        SUB A
        STA $2208
        LDA $2207
        INR A
        STA $2207
        CPI #06
o0acb:  JZ j0aec
        MVI D, #00
        MOV E,A
        LXI H, CUP_COIL_TABLE - 1
        DAD D
        MOV B,M
o0ad6:  CALL SET_LAMP_SOLID
        LXI H, UNKNOWN_MUSIC
o0adc:  CALL PLAY_SOUND
        MVI A, #0f
        STA CUP_EJECT_SEQUENCE_TIMER
        MVI A, #64
        STA $2208
o0ae9:  JMP END_MAIN_LOOP
j0aec:  LHLD $2209 ;o0acb
        LDA $220b
o0af2:  CALL SET_ATH_BIT_OF_HL
        MVI A, #06
        STA TARGET_COIL_TIMER
        MVI A, #1f
        STA CUPS_LEFT
        LDA $2246
        ADD A
        ADD A
        ADD A
        ADD A
        MOV B,A
        LDA $23be
        ANA B
o0b0b:  JNZ ADVANCE_CUP_EJECT_SEQUENCE
        LXI H, GAME_STATE
        MVI A, #03
o0b13:  CALL CHECK_ATH_BIT_OF_HL
o0b16:  JNZ ADVANCE_CUP_EJECT_SEQUENCE
        MVI B, #31
o0b1b:  CALL CHECK_LAMP_LIT_PAGE
o0b1e:  JNZ ADVANCE_CUP_EJECT_SEQUENCE
        MVI B, #09
o0b23:  CALL SET_LAMP_SOLID
; Advance the five-step cup lamp/eject sequence and transfer the current cup's
; lamp state before returning to the timer/interrupt loop.
ADVANCE_CUP_EJECT_SEQUENCE:
j0b26:  LDA $21c8 ;o0b0b,o0b16,o0b1e
        INR A
        CPI #05
o0b2c:  JZ j0b44
        STA $21c8
        MVI D, #00
        MOV E,A
        LXI H, CUP_LAMP_TABLE - 1
        DAD D
        MOV B,M
        PUSH H
o0b3b:  CALL SET_LAMP_SOLID
        POP H
        DCX H
        MOV B,M
o0b41:  CALL CLEAR_LAMP_AND_TEST_FLASH_PAGE
j0b44:  LXI H, CONTROL_FLAGS ;o0b2c
        MVI A, #01
o0b49:  CALL CHECK_ATH_BIT_OF_HL
o0b4c:  CNZ ROTATE_CUP_LAMP_STATE
o0b4f:  JMP END_MAIN_LOOP
jo0b52: CALL RESOLVE_CUP_TARGET_STATE ;o09e4
o0b55:  CALL SET_ATH_BIT_OF_HL
        MVI A, #06
        STA TARGET_COIL_TIMER
o0b5d:  CALL CHECK_LAMP_LIT_PAGE
o0b60:  JNZ RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
o0b63:  CALL SET_LAMP_SOLID
        LXI H, LOW_MUSIC
o0b69:  CALL PLAY_SOUND
o0b6c:  JMP RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
; Input: A=one-based cup/standup number.
; Output: B=target lamp id, A/C=state bit, HL=state byte, with $2209/$220b
; caching the resolved address/bit for the delayed target handler.
RESOLVE_CUP_TARGET_STATE:
c0b6f:  MVI D, #00 ;o09cc,o0a00,jo0b52
        MOV E,A
        LXI H, CUP_TARGET_LAMP_TABLE - 1
        DAD D
        MOV B,M
        LXI H, CUP_STATE_INDEX_TABLE - 1
        DAD D
        ADD A
        MOV E,A
        MOV A,M
        STA $220b
        MOV C,A
        LXI H, CUP_STATE_ADDRESS_TABLE - 1
        DAD D
        MOV A,M
        INX H
        MOV H,M
        MOV L,A
        SHLD $2209
        MOV A,C
        RET

TARGET_COIL_TIMER_EXPIRED:
TIMER_15_EXPIRED:
        MVI A, #00
        STA $21c2
        LDA $21c4
        ANI #1f
        STA $21c4
        CMA
        OUT COIL_7
        LXI H, #21c5
        MVI A, #01
o0ba4:  CALL CLEAR_ATH_BIT_OF_HL
o0ba7:  JMP END_MAIN_LOOP
SWITCH_SETTLE_TIMER_EXPIRED:
TIMER_00_EXPIRED:
        MVI A, #00
        STA $2208
        LXI H, GAME_STATE2
        MVI A, #03
o0bb4:  CALL CLEAR_ATH_BIT_OF_HL
o0bb7:  JMP END_MAIN_LOOP
CUP_COIL_TABLE:       DB #24, #03, #0b, #13, #29
CUP_LAMP_TABLE:       DB #23, #1c, #1b, #12, #2b
CUP_TARGET_LAMP_TABLE: DB #2c, #04, #0c, #14, #03
CUP_STATE_INDEX_TABLE: DB #05, #02, #00, #01, #c2
CUP_STATE_ADDRESS_TABLE:
        DB #21, #c4, #21, #c2, #21, #c2, #21, #c2
CUP_BONUS_SCORE_TABLE:
        DB #21
        DW SCORE_2000, SCORE_4000, SCORE_6000, SCORE_8000
j0bdf:  MVI B, #39 ;o0993
o0be1:  CALL CHECK_LAMP_LIT_PAGE
o0be4:  JZ j0d4d
        LXI H, GAME_STATE
        MVI A, #02
o0bec:  CALL CHECK_ATH_BIT_OF_HL
o0bef:  JNZ j0d4d
        LDA $220c
        ANI #03
o0bf7:  JNZ j0ca6
        LXI H, #235b
        LXI D, #220d
        MVI A, #06
o0c02:  CALL COPY_FROM_HL_TO_DE
        MVI B, #38
o0c07:  CALL CHECK_LAMP_LIT_PAGE
o0c0a:  JZ j0c12
        MVI A, #03
o0c0f:  JMP j0c21
j0c12:  MVI B, #11 ;o0c0a
o0c14:  CALL CHECK_LAMP_LIT_PAGE
o0c17:  JZ j0c1f
        MVI A, #02
o0c1c:  JMP j0c21
j0c1f:  MVI A, #01 ;o0c17
j0c21:  STA $220c ;o0c0f,o0c1c
        MVI B, #31
o0c26:  CALL CHECK_LAMP_LIT_PAGE
o0c29:  JZ j0ca6
        MVI B, #31
o0c2e:  CALL CLEAR_LAMP_AND_TEST_FLASH_PAGE
        MVI B, #09
o0c33:  CALL CLEAR_LAMP_AND_TEST_FLASH_PAGE
        LXI H, MORSE_CODE_MUSIC
o0c39:  CALL PLAY_SOUND
        LXI H, #238a
        LDA $23be
        ANI #f0
        MOV C,A
        MVI E, #04
        MVI B, #4f
        CPI #80
o0c4b:  JZ j0c77
        INX H
        MVI E, #03
        MVI B, #03
        MOV A,M
        ANI #f0
        ORA B
        MOV B,A
        MOV A,C
        CPI #40
o0c5b:  JZ j0c77
        MVI E, #02
        MVI B, #20
        MOV A,M
        ANI #0f
        ORA B
        MOV B,A
        MOV A,C
        CPI #20
o0c6a:  JZ j0c77
        INX H
        MVI E, #01
        MVI B, #01
        MOV A,M
        ANI #f0
        ORA B
        MOV B,A
j0c77:  MOV M,B ;o0c4b,o0c5b,o0c6a
        MVI D, #00
        PUSH D
        LXI D, #0020
        DAD D
        MOV M,B
        MOV A,C
        RLC
        RLC
        RLC
        RLC
        MOV C,A
        LDA $2246
        ORA C
        STA $2246
        LXI H, #2228
        POP D
        DAD D
        MOV M,E
        LXI H, #2396
        MVI A, #05
o0c98:  CALL SET_ATH_BIT_OF_HL
        LXI H, #23b6
o0c9e:  CALL SET_ATH_BIT_OF_HL
        MVI A, #fa
o0ca3:  JMP j0ca8
j0ca6:  MVI A, #3c ;o0bf7,o0c29
j0ca8:  STA BONUS_COUNT_TIMER ;o0ca3
o0cab:  JMP RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
BONUS_COUNT_TIMER_EXPIRED:
TIMER_16_EXPIRED:
        LDA $2349
        MOV B,A
        LDA $23ee
        SUB B
o0cb6:  JM j0cc4
        LDA SWITCH_LATCHED
        ANI #fd
        STA SWITCH_LATCHED
o0cc1:  JMP END_MAIN_LOOP
j0cc4:  MVI A, #00 ;o0cb6
        STA SWITCH_SETTLE_TIMER
        LDA SWITCH_LATCHED
        ORI #02
        STA SWITCH_LATCHED
        LXI H, GAME_STATE
        MVI A, #00
o0cd6:  CALL CHECK_ATH_BIT_OF_HL
o0cd9:  JNZ EJECT_SIDE_BONUS_CUP
        LXI H, SCORE_1000
o0cdf:  CALL TRY_SUBTRACT_FROM_BONUS
o0ce2:  JC j0cf9
        LXI H, SCORE_1000
o0ce8:  CALL ADD_BONUS_HL
        MVI A, #0a
        STA BONUS_COUNT_TIMER
        LXI H, BUMPER_25_MUSIC
o0cf3:  CALL PLAY_SOUND
o0cf6:  JMP END_MAIN_LOOP
j0cf9:  LXI H, SCORE_1000 ;o0ce2
o0cfc:  CALL ADD_BONUS
        LXI H, #235b
o0d02:  CALL ADD_PTS
        LXI H, #235b
o0d08:  CALL TRY_SUBTRACT_FROM_BONUS
        LXI H, #220c
        DCR M
o0d0f:  JZ EJECT_SIDE_BONUS_CUP
o0d12:  JM EJECT_SIDE_BONUS_CUP
        LXI H, #220d
o0d18:  CALL COMMIT_SPREAD_TO_BONUS_DISPLAY
        MVI A, #3c
        STA BONUS_COUNT_TIMER
        LXI H, SPREAD_HRM_MUSIC
jo0d23: CALL PLAY_SOUND ;o0d4a
o0d26:  JMP END_MAIN_LOOP
; Finish side-cup bonus handling: energize its eject coil, clear its lamp and
; switch latch, reset the bonus countdown state, and play the completion tone.
EJECT_SIDE_BONUS_CUP:
j0d29:  LXI H, #21c5 ;o0cd9,o0d0f,o0d12
        MOV A,M
        ORI #02
        MOV M,A
        MVI A, #09
        STA TARGET_COIL_TIMER
        MVI B, #39
o0d37:  CALL CLEAR_LAMP_AND_TEST_FLASH_PAGE
        LDA SWITCH_LATCHED
        ANI #fd
        STA SWITCH_LATCHED
        MVI A, #00
        STA $220c
        LXI H, SPREAD_HRM_MUSIC
o0d4a:  JMP jo0d23
j0d4d:  LXI H, #21c5 ;o0be4,o0bef
        MVI A, #01
o0d52:  CALL SET_ATH_BIT_OF_HL
        MVI A, #06
        STA TARGET_COIL_TIMER
o0d5a:  JMP RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
STANDUP_1_HANDLER:
        MVI A, #2b
o0d5f:  JMP LATCH_STANDUP_TARGET
STANDUP_2_HANDLER:
        MVI A, #2c
o0d64:  JMP LATCH_STANDUP_TARGET
STANDUP_3_HANDLER:
        MVI A, #04
o0d69:  JMP LATCH_STANDUP_TARGET
STANDUP_4_HANDLER:
        MVI A, #0c
o0d6e:  JMP LATCH_STANDUP_TARGET
STANDUP_5_HANDLER:
        MVI A, #14
o0d73:  JMP LATCH_STANDUP_TARGET
; Input: A=standup lamp id.  Remember the target and open/restart the short
; standup-bar coincidence window used by STANDUP_BAR_TIMER_EXPIRED.
LATCH_STANDUP_TARGET:
j0d76:  STA $2226 ;o0d5f,o0d64,o0d69,o0d6e,o0d73
        LDA GAME_STATE
        ANI #04
o0d7e:  JNZ RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
        LDA STANDUP_BAR_TIMER
        ORA A
o0d85:  JNZ j0d95
        LDA CONTROL_FLAGS
        ANI #df
        STA CONTROL_FLAGS
        MVI A, #80
        STA STATE_OUTLANE_1
j0d95:  MVI A, #03 ;o0d85
        STA STANDUP_BAR_TIMER
o0d9a:  JMP RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
STANDUP_BAR_TIMER_EXPIRED:
TIMER_24_EXPIRED:
        LDA CONTROL_FLAGS
        ANI #20
o0da2:  JZ FINISH_STANDUP_BAR_WINDOW
        LDA $21c4
        ORI #04
        STA $21c4
        MVI A, #09
        STA COIL_PULSE_TIMER
        LDA $2226
        MOV B,A
o0db6:  CALL CHECK_LAMP_LIT_PAGE
o0db9:  JZ FINISH_STANDUP_BAR_WINDOW
o0dbc:  CALL CLEAR_LAMP_AND_TEST_FLASH_PAGE
o0dbf:  JZ j0dd1
        LXI H, SCORE_1000
o0dc5:  CALL ADD_BONUS_HL
        LXI H, LOW_MUSIC
o0dcb:  CALL PLAY_SOUND
o0dce:  JMP FINISH_STANDUP_BAR_WINDOW
j0dd1:  LXI H, SCORE_5000 ;o0dbf
o0dd4:  CALL ADD_BONUS_HL
        XCHG
o0dd8:  CALL ADD_BONUS
        LXI H, LIT_STANDUP_MUSIC
o0dde:  CALL PLAY_SOUND
; Common standup-window exit: consume the bar-hit flag and return through the
; periodic timer interrupt epilogue.
FINISH_STANDUP_BAR_WINDOW:
j0de1:  LDA CONTROL_FLAGS ;o0da2,o0db9,o0dce
        ANI #df
        STA CONTROL_FLAGS
o0de9:  JMP END_MAIN_LOOP
; Add A packed-BCD digits from HL into the SPREAD_1 work buffer.  Carry is
; propagated digit-by-digit with DAA; the final half-byte is handled specially.
ADD_BCD_SCORE_TO_SPREAD:
c0dec:  LXI D, SPREAD_1 ;o0e69,o0f73,o100b,o18b1
        ORA A
        PUSH PSW
j0df1:  SBI #02 ;o0e0b
o0df3:  JM j0e0e
        MOV B,A
        POP PSW
        LDAX D
        ADC M
        DAA
        STAX D
        PUSH PSW
        MOV A,B
        ORA A
o0dff:  JNZ j0e09
        POP PSW
        MVI A, #00
        ADC A
        INX D
        STAX D
        RET

j0e09:  INX H ;o0dff
        INX D
o0e0b:  JMP j0df1
j0e0e:  MOV A,M ;o0df3
        ANI #0f
        MOV B,A
        POP PSW
        LDAX D
        ADC B
        DAA
        STAX D
        RET

; Subtract A packed-BCD digits at HL from SPREAD_1 in place.  This doubles as
; the game's score comparison primitive: callers inspect carry after return.
SUBTRACT_BCD_SCORE_FROM_SPREAD:
c0e18:  MVI C, #00 ;o0ea8,o0fcb,o1004,o102a,o1132,o1dc1,o1de7,o1df7,o1e21,o1e31,o1e41,o1e8c,o1e9e,o1eb0,o1ec2,o1ed4,o1ee6,o1ef8,o1f0a,o1f1c,o1f2e
        ORA A
        LXI D, SPREAD_1
        PUSH PSW
j0e1f:  SBI #02 ;o0e3a
o0e21:  JM j0e3d
        MOV B,A
        POP PSW
        MVI A, #9a
        SBB M
j0e29:  XCHG ;o0e47
        ADD M
        DAA
        CMC
        MOV M,A
        PUSH PSW
o0e2f:  JNZ j0e4a
j0e32:  MOV A,B ;o0e4c
        ORA A
o0e34:  JZ j0e4f
        XCHG
        INX D
        INX H
o0e3a:  JMP j0e1f
j0e3d:  MOV A,M ;o0e21
        ANI #0f
        MOV B,A
        POP PSW
        MVI A, #9a
        SBB B
        MVI B, #00
o0e47:  JMP j0e29
j0e4a:  MVI C, #ff ;o0e2f
o0e4c:  JMP j0e32
j0e4f:  MOV A,C ;o0e34
        ORA A
o0e51:  JZ j0e58
        POP PSW
        RC
        ORA C
        RET

j0e58:  POP PSW ;o0e51
        ANI #00
        RET

ADD_BONUS:
        LXI D, SPREAD_1 ;o0020,o0a39,o0a73,o0cfc,o0dd8,o154f,o15ef,o18ed
        MVI A, #08
o0e61:  CALL COPY_FROM_HL_TO_DE
        LXI H, #235b
        MVI A, #08
o0e69:  CALL ADD_BCD_SCORE_TO_SPREAD
        LXI H, SPREAD_1
; Commit the eight-byte SPREAD_1 work buffer to the canonical score/bonus
; buffer at $235b, mirror six display bytes, and synchronize both lamp pages
; when the game-state gate permits it.
COMMIT_SPREAD_TO_BONUS_DISPLAY:
c0e6f:  LXI D, #235b ;o0d18,o18bc,o1af2
        MVI A, #08
o0e74:  CALL COPY_FROM_HL_TO_DE
        LXI H, #235b
        LXI D, LAMPS_PAGE_2
        MVI A, #06
o0e7f:  CALL WRITE_TO_RAM
        LDA GAME_STATE
        ANI #01
        RNZ
        LXI H, LAMPS_PAGE_2
        LXI D, LAMPS_PAGE_1
        MVI A, #06
o0e90:  CALL COPY_FROM_HL_TO_DE
        MVI B, #39
o0e95:  CALL SET_LAMP_SOLID
        RET

; Input: HL=packed-BCD amount.  Copy the current bonus into SPREAD_1, subtract
; the amount, commit the result to both display pages, and return comparison
; status in the flags (carry means the requested subtraction crossed zero).
TRY_SUBTRACT_FROM_BONUS:
c0e99:  PUSH H ;o0cdf,o0d08,o18d0,o18f9
        LXI H, #235b
        LXI D, SPREAD_1
        MVI A, #08
o0ea2:  CALL COPY_FROM_HL_TO_DE
        POP H
        MVI A, #08
o0ea8:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
        PUSH PSW
        LXI H, SPREAD_1
        LXI D, #235b
        MVI A, #08
o0eb4:  CALL COPY_FROM_HL_TO_DE
        LXI H, #235b
        LXI D, LAMPS_PAGE_1
        MVI A, #06
o0ebf:  CALL WRITE_TO_RAM
        LXI H, LAMPS_PAGE_1
        LXI D, LAMPS_PAGE_2
        MVI A, #06
o0eca:  CALL COPY_FROM_HL_TO_DE
        POP PSW
        RET

COPY_FROM_HL_TO_DE:
        ORA A ;o00c8,o00d3,o019d,o01b0,LAMP_PAGE_1_COPY,o0683,o0c02,o0e61,o0e74,o0e90,o0ea2,o0eb4,o0eca,o0f41,o0f7d,o0f91,o0fa2,o0fc3,o0fdb,o0ffc,o1015,o1022,o1039,o104f,o1062,o10cb,o10d6,o112a,o1637,o16ba,o16c5,o1865,o18a6,o1a84,o1b09,o1b14,o1bf6,o1c01,o1c2b,o1c89,o1ca6,o1f40,o1f4e,o1f5a,o1f6a,o1f8a,o1f9b,o1fa5,o1fb3,o1fbd,o1fc7,o1fd0,o1fe6
j0ed0:  SBI #02 ;o0edc
o0ed2:  JM j0ee0
        MOV B,A
        MOV A,M
        STAX D
        INX H
        INX D
        MOV A,B
        ORA A
o0edc:  JNZ j0ed0
        RET

j0ee0:  MOV A,M ;o0ed2
        ANI #0f
        MOV B,A
        LDAX D
        ANI #f0
        ORA B
        STAX D
        RET

WRITE_TO_RAM:
        RRC ;o0e7f,o0ebf,o0f85,o0fe5,o0fee,o1044,o1c15
        PUSH PSW
o0eec:  JNC j0ef2
        INR A
        ANI #7f
j0ef2:  MOV C,A ;o0eec
        DCR C
        MVI B, #00
        DAD B
        XCHG
        DAD B
        XCHG
        POP PSW
o0efb:  JC j0f14
        MOV A,M
j0eff:  ORA A ;o0f26
o0f00:  JZ j0f2a
        ANI #f0
        MOV A,M
o0f06:  JNZ j0f0b
        ORI #f0
j0f0b:  STAX D ;o0f06,o0f10,o0f35
        DCX H
        DCX D
        MOV A,M
        DCR C
o0f10:  JP j0f0b
        RET

j0f14:  LDAX D ;o0efb
        ANI #f0
        MOV B,A
        MOV A,M
        ANI #0f
o0f1b:  JNZ j0f34
        ORI #0f
        ORA B
j0f21:  STAX D ;o0f31
        DCX H
        DCX D
        DCR C
        MOV A,M
o0f26:  JP j0eff
        RET

j0f2a:  MOV A,C ;o0f00
        DCR A
o0f2c:  JM j0f38
        MVI A, #ff
o0f31:  JMP j0f21
j0f34:  ORA B ;o0f1b
o0f35:  JMP j0f0b
j0f38:  MVI A, #f0 ;o0f2c
        STAX D
        RET

ADD_PTS: LXI D, SPREAD_1 ;o0278,o0d02,o1722,o172d,o18f3
        MVI A, #08
o0f41:  CALL COPY_FROM_HL_TO_DE
        LXI H, #237e
        MVI A, #04
o0f49:  CALL CHECK_ATH_BIT_OF_HL
o0f4c:  JNZ j10dd
        INR A
o0f50:  CALL CHECK_ATH_BIT_OF_HL
o0f53:  JNZ j10f4
        INR A
o0f57:  CALL CHECK_ATH_BIT_OF_HL
o0f5a:  JNZ j110b
        LXI H, HIGH_SCORE_NOW
        PUSH H
        LXI H, PL24_SCORE_1
        PUSH H
        LXI H, PL2_SCORE_1
        PUSH H
        LXI H, PL4_SCORE_2
        PUSH H
        LXI H, PL4_SCORE_1
        PUSH H
j0f71:  MVI A, #08 ;o10f1,o1108,o111f
o0f73:  CALL ADD_BCD_SCORE_TO_SPREAD
        POP D
        PUSH D
        LXI H, SPREAD_1
        MVI A, #08
o0f7d:  CALL COPY_FROM_HL_TO_DE
        POP H
        POP D
        PUSH D
        MVI A, #06
o0f85:  CALL WRITE_TO_RAM
        POP D
        PUSH D
        LXI H, #0020
        DAD D
        XCHG
        MVI A, #06
o0f91:  CALL COPY_FROM_HL_TO_DE
        POP D
        LDA $21f6
        ANI #0f
o0f9a:  JZ j0fa5
        LXI H, BLANK_SCORE
        MVI A, #06
o0fa2:  CALL COPY_FROM_HL_TO_DE
j0fa5:  LXI H, #237e ;o0f9a
        MVI A, #03
o0faa:  CALL CHECK_ATH_BIT_OF_HL
o0fad:  JNZ j1008
        POP H
        POP H
        POP H
        LDA $237e
        ANI #0f
        CPI #03
        RNZ
        LXI H, PL1_SCORE_1
        LXI D, SPREAD_1
        MVI A, #07
o0fc3:  CALL COPY_FROM_HL_TO_DE
        LXI H, PL2_SCORE_1
        MVI A, #07
o0fcb:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
        PUSH PSW
o0fcf:  CC COMPARE_PLAYER_SCORES_REVERSED
        LXI H, SPREAD_1
        LXI D, PL1_SCORE_hrm
        PUSH D
        MVI A, #06
o0fdb:  CALL COPY_FROM_HL_TO_DE
        POP H
        PUSH H
        LXI D, SPREAD_4
        MVI A, #06
o0fe5:  CALL WRITE_TO_RAM
        POP H
        LXI D, SPREAD_3
        MVI A, #06
o0fee:  CALL WRITE_TO_RAM
o0ff1:  JMP j1052
; Repeat the two-player comparison with player 2 as the work-buffer source and
; player 1 as the subtrahend.  The caller uses the returned carry to choose
; which team score is displayed first.
COMPARE_PLAYER_SCORES_REVERSED:
c0ff4:  LXI H, PL2_SCORE_1 ;o0fcf
        LXI D, SPREAD_1
        MVI A, #07
o0ffc:  CALL COPY_FROM_HL_TO_DE
        LXI H, PL1_SCORE_1
        MVI A, #07
o1004:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
        RET

j1008:  POP H ;o0fad
        MVI A, #08
o100b:  CALL ADD_BCD_SCORE_TO_SPREAD
        LXI H, SPREAD_1
        POP D
        PUSH D
        MVI A, #07
o1015:  CALL COPY_FROM_HL_TO_DE
        POP H
        POP D
        LXI H, PL13_SCORE_1
        LXI D, SPREAD_1
        MVI A, #07
o1022:  CALL COPY_FROM_HL_TO_DE
        LXI H, PL24_SCORE_1
        MVI A, #07
o102a:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
        PUSH PSW
o102e:  JC j1122
j1031:  LXI H, SPREAD_1 ;o1135
        LXI D, PL1_SCORE_hrm
        MVI A, #06
o1039:  CALL COPY_FROM_HL_TO_DE
        LXI H, PL1_SCORE_hrm
        LXI D, SPREAD_4
        MVI A, #06
o1044:  CALL WRITE_TO_RAM
        LXI H, SPREAD_4
        LXI D, SPREAD_3
        MVI A, #06
o104f:  CALL COPY_FROM_HL_TO_DE
j1052:  LDA $21f6 ;o0ff1
        ANI #0f
o1057:  JZ j1065
        LXI H, BLANK_SCORE
        LXI D, SPREAD_4
        MVI A, #06
o1062:  CALL COPY_FROM_HL_TO_DE
j1065:  POP PSW ;o1057
o1066:  JZ j10b5
o1069:  JC j10a1
        LXI H, #236a
        MVI A, #04
o1071:  CALL CHECK_ATH_BIT_OF_HL
o1074:  JZ jo1078
        RET

jo1078: CALL SET_ATH_BIT_OF_HL ;o1074
        MVI A, #05
jo107d: CALL CLEAR_ATH_BIT_OF_HL ;o10b2
        PUSH H
        PUSH B
        LXI H, SPREAD_TAKEOVER_MUSIC
o1085:  CALL PLAY_SOUND
        LXI H, BONUS_COUNT_TIMER
        MOV A,M
        ORA A
o108d:  JZ j1092
        MVI M, #7d
j1092:  LXI H, BONUS_PAYOUT_TIMER ;o108d
        MOV A,M
        ORA A
o1097:  JZ j109c
        MVI M, #7d
j109c:  POP B ;o1097
        POP H
o109e:  JMP j1138
j10a1:  LXI H, #236a ;o1069
        MVI A, #05
o10a6:  CALL CHECK_ATH_BIT_OF_HL
o10a9:  JZ jo10ad
        RET

jo10ad: CALL SET_ATH_BIT_OF_HL ;o10a9
        MVI A, #04
o10b2:  JMP jo107d
j10b5:  LXI H, #236a ;o1066
        MVI A, #04
o10ba:  CALL CLEAR_ATH_BIT_OF_HL
        MVI A, #05
o10bf:  CALL CLEAR_ATH_BIT_OF_HL
        PUSH H
        LXI H, BLANK_SCORE_PREFIX
        LXI D, SPREAD_4
        MVI A, #06
o10cb:  CALL COPY_FROM_HL_TO_DE
        LXI H, BLANK_SCORE_PREFIX
        LXI D, SPREAD_3
        MVI A, #06
o10d6:  CALL COPY_FROM_HL_TO_DE
        POP H
o10da:  JMP j1138
j10dd:  LXI H, PL1_AND_3 ;o0f4c
        PUSH H
        LXI H, PL13_SCORE_1
        PUSH H
        LXI H, PL3_SCORE_1
        PUSH H
        LXI H, PL1_SCORE_DISPLAY2
        PUSH H
        LXI H, PL1_SCORE_1
        PUSH H
o10f1:  JMP j0f71
j10f4:  LXI H, HIGH_SCORE_NOW ;o0f53
        PUSH H
        LXI H, PL24_SCORE_1
        PUSH H
        LXI H, PL4_SCORE_1
        PUSH H
        LXI H, PL2_SCORE_2
        PUSH H
        LXI H, PL2_SCORE_1
        PUSH H
o1108:  JMP j0f71
j110b:  LXI H, PL1_AND_3 ;o0f5a
        PUSH H
        LXI H, PL13_SCORE_1
        PUSH H
        LXI H, PL1_SCORE_1
        PUSH H
        LXI H, PL3_SCORE_DISPLAY_2
        PUSH H
        LXI H, PL3_SCORE_1
        PUSH H
o111f:  JMP j0f71
j1122:  LXI H, PL24_SCORE_1 ;o102e
        LXI D, SPREAD_1
        MVI A, #07
o112a:  CALL COPY_FROM_HL_TO_DE
        LXI H, PL13_SCORE_1
        MVI A, #07
o1132:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
o1135:  JMP j1031
j1138:  MOV A,M ;o109e,o10da
        ANI #30
        MOV B,A
        LDA $238c
        ANI #0f
        ORA B
        STA $238c
        STA $23ac
        RET

; scores
SCORE_0:     DB #00, #00, #00, #00
SCORE_1:     DB #01, #00, #00, #00
SCORE_10:    DB #10, #00, #00, #00
SCORE_25:    DB #25, #00, #00, #00
SCORE_50:    DB #50, #00, #00, #00
SCORE_100:   DB #00, #01, #00, #00
SCORE_500:   DB #00, #05, #00, #00
SCORE_1000:  DB #00, #10, #00, #00
SCORE_2000:  DB #00, #20, #00, #00
SCORE_4000:  DB #00, #40, #00, #00
SCORE_5000:  DB #00, #50, #00, #00
SCORE_6000:  DB #00, #60, #00, #00
SCORE_8000:  DB #00, #80, #00, #00
SCORE_10000: DB #00, #00, #01, #00
; default high score
DEFAULT_HIGH_SCORE: DB #79, #19, #00, #00
BLANK_SCORE_PREFIX: DB #f0, #ff, #ff, #ff
BLANK_SCORE:        DB #ff, #ff, #ff, #ff
TONE_PLAY:
        CALL AY_MUTE ;o123b,o125b
        NOP
        LXI D, MUSIC_DATA_START
        MOV A,L
        SUB E
        MOV A,H
        SBB D
        RM
        LXI D, MUSIC_DATA_END
        MOV A,E
        SUB L
        MOV A,D
        SBB H
        RM
        MOV A,M
        MOV B,A
        NOP
        NOP
        INX H
        MOV A,M
        CALL AY_PLAY_TONE
        NOP
        SHLD NEXT_TONE
        LXI D, TONE_DURATION_TIMER_TABLE
        CPI #00
o11b3:  JZ j11ef
        CPI #02
o11b8:  JZ j11ee
        CPI #04
o11bd:  JZ j11ed
        CPI #08
o11c2:  JZ j11ec
        CPI #0c
o11c7:  JZ j11eb
        CPI #10
o11cc:  JZ j11ea
        CPI #2c
o11d1:  JZ j11e9
        CPI #28
o11d6:  JZ j11e8
        CPI #24
o11db:  JZ j11e7
        CPI #20
o11e0:  JZ j11e6
o11e3:  JMP j11ef
j11e6:  INX D ;o11e0
j11e7:  INX D ;o11db
j11e8:  INX D ;o11d6
j11e9:  INX D ;o11d1
j11ea:  INX D ;o11cc
j11eb:  INX D ;o11c7
j11ec:  INX D ;o11c2
j11ed:  INX D ;o11bd
j11ee:  INX D ;o11b8
j11ef:  LDAX D ;o11b3,o11e3
        STA TONE_TIMER
        LXI H, GAME_STATE
        MVI A, #05
o11f8:  CALL SET_ATH_BIT_OF_HL
        RET

TONE_DURATION_TIMER_TABLE:
        DB #0d
        DB #0a
        DB #0e
        DB #0a
        DB #18
        DB #20
        DB #0a
        DB #05
        DB #02
        DB #32
TONE_TIMER_EXPIRED:
TIMER_01_EXPIRED:
        LXI H, GAME_STATE
        MVI A, #05
o120b:  CALL CHECK_ATH_BIT_OF_HL
o120e:  JNZ jo1222
        MVI A, #06
o1213:  CALL SET_ATH_BIT_OF_HL
        CALL AY_MUTE
        NOP
        MVI A, #02
        STA TONE_TIMER
o121f:  JMP END_MAIN_LOOP
jo1222: CALL CLEAR_ATH_BIT_OF_HL ;o120e
        MVI A, #06
o1227:  CALL CHECK_ATH_BIT_OF_HL
o122a:  JNZ jo1255
        CALL AY_MUTE
        NOP
        LHLD NEXT_TONE
        INX H
        MOV A,M
        CPI #ff
o1238:  JZ j1241
o123b:  CALL TONE_PLAY
o123e:  JMP END_MAIN_LOOP
j1241:  LDA $21b3 ;o1238
        CPI #00
o1246:  JNZ jo1258
        CALL AY_MUTE
        NOP
        MVI A, #0c
        STA TONE_TIMER
o1252:  JMP END_MAIN_LOOP
jo1255: CALL CLEAR_ATH_BIT_OF_HL ;o122a
jo1258: CALL DEQUEUE_SOUND_POINTER ;o1246
o125b:  CALL TONE_PLAY
o125e:  JMP END_MAIN_LOOP
PLAY_SOUND:
        XCHG ;o0162,o0546,o0563,o059c,o06fd,o07bc,o0855,o0927,o0a1a,o0a3f,o0a79,o0adc,o0b69,o0c39,o0cf3,jo0d23,o0dcb,o0dde,o1085,o14bd,o14ef,o1585,o15a6,o15d0,o15f5,o1786,o1859,o18c7,o18e4,o1a27,o1ae4,o1b72,o1f70
        LHLD $21be
        LXI B, #21be
        MOV A,C
        STA $21b3
        SUB L
o126d:  JNZ j1273
        LXI H, #21b4
j1273:  MOV M,E ;o126d
        INX H
        MOV M,D
        INX H
        SHLD $21be
        LXI H, GAME_STATE
        MVI A, #05
o127f:  CALL CHECK_ATH_BIT_OF_HL
        RNZ
o1283:  CALL SET_ATH_BIT_OF_HL
        MVI A, #01
        STA TONE_TIMER
        RET

; Remove the next 16-bit music pointer from the circular queue at $21b4..$21bd.
; Output: HL=dequeued music pointer; $21c0 advances with wrap; $21b3 is updated
; with the remaining queued-byte distance.
DEQUEUE_SOUND_POINTER:
c128c:  LHLD $21c0 ;jo1258
        LXI B, #21be
        MOV A,C
        SUB L
o1294:  JNZ j129a
        LXI H, #21b4
j129a:  MOV E,M ;o1294
        INX H
        MOV D,M
        INX H
        SHLD $21c0
        PUSH D
        MOV A,L
        LHLD $21be
        SUB L
        STA $21b3
        POP H
        RET

MUSIC_DATA_START:
        DB #ff
BUMPER_25_MUSIC_2:
        DB #ca
        DB #08
        DB #ff
        DB #aa
        DB #08
        DB #ff
        DB #87
        DB #08
        DB #ff
        DB #65
        DB #08
        DB #ff
        ; Left sling: raise two octaves for the AY / existing audio path.
LEFT_SLING_TONE:
        DB #cc
        DB #08
        DB #ff
        ; Right sling: likewise, preserving the original interval.
RIGHT_SLING_TONE:
        DB #f0
        DB #08
        DB #ff
SILENCE_END_LOOP_MUSIC:
        DB #1c
        DB #00
        DB #ff
TILT_MUSIC:
        DB #43
        DB #08
        DB #87
        DB #08
        DB #43
        DB #08
        DB #87
        DB #08
        DB #43
        DB #08
        DB #87
        DB #08
        DB #43
        DB #08
        DB #87
        DB #08
        DB #43
        DB #08
        DB #87
        DB #08
        DB #ff
BONUS_MUSIC:
        DB #55
        DB #08
        DB #ff
START_PLAYER_MUSIC:
        DB #3c
        DB #08
        DB #ff
UNKNOWN_MUSIC:
        DB #2b
        DB #08
        DB #ff
LOW_MUSIC:
        DB #22
        DB #08
        DB #ff
OOPS_MUSIC:
        DB #22
        DB #28
        DB #1e
        DB #0c
        DB #ff
OOPS2_MUSIC:
        DB #15
        DB #02
        DB #15
        DB #0c
        DB #ff
LIL_VICTORY_MUSIC:
        DB #33
        DB #08
        DB #43
        DB #0c
        DB #ff
LIT_STANDUP_MUSIC:
        DB #78
        DB #28
        DB #50
        DB #28
        DB #78
        DB #28
        DB #50
        DB #28
        DB #78
        DB #28
        DB #50
        DB #28
        DB #ff
; game over music
GAME_OVER_MUSIC:
        DB #98
        DB #08
        DB #ca
        DB #08
        DB #00
        DB #00
        DB #ca
        DB #08
        DB #98
        DB #08
        DB #00
        DB #00
        DB #98
        DB #08
        DB #7f
        DB #08
        DB #00
        DB #00
        DB #7f
        DB #08
        DB #65
        DB #08
        DB #ff
; spread takeover music
SPREAD_TAKEOVER_MUSIC:
        DB #43
        DB #20
        DB #43
        DB #08
        DB #55
        DB #08
        DB #65
        DB #08
        DB #72
        DB #0c
        DB #ff
; morse code music
MORSE_CODE_MUSIC:
        DB #43
        DB #04
        DB #43
        DB #04
        DB #43
        DB #00
        DB #43
        DB #04
        DB #43
        DB #04
        DB #43
        DB #00
        DB #43
        DB #04
        DB #43
        DB #04
        DB #ff
; bumper 25 music
BUMPER_25_MUSIC:
        DB #c6
        DB #08
        DB #ff
; spread music
SPREAD_HRM_MUSIC:
        DB #4c
        DB #0c
        DB #ff
; longer bumper 25 music
LONGER_BUMPER_25_MUSIC:
        DB #ca
        DB #08
        DB #ca
        DB #08
        DB #ca
        DB #08
        DB #ca
        DB #0c
        DB #ff
; credit music
CREDIT_MUSIC:
        DB #78
        DB #28
        DB #65
        DB #04
        DB #ff
; next player music
NEXT_PLAYER_MUSIC:
        DB #a0
        DB #2c
        DB #a0
        DB #0c
        DB #ff
; outlane music
OUTLANE_MUSIC:
        DB #15
        DB #0c
        DB #ff
; silence music
SILENCE_MUSIC:
        DB #ca
        DB #00
        DB #ff
; funkytown
HIGH_SCORE_MUSIC:
        DB #87
        DB #0c
        DB #87
        DB #0c
        DB #78
        DB #0c
        DB #87
        DB #0c
        DB #00
        DB #00
        DB #65
        DB #0c
        DB #00
        DB #00
        DB #65
        DB #0c
        DB #87
        DB #0c
        DB #bf
        DB #0c
        DB #aa
        DB #0c
        DB #87
        DB #0c
        DB #ff
; popcorn
POPCORN_MUSIC:
        DB #f1
        DB #04
        DB #d6
        DB #04
        DB #f1
        DB #04
        DB #b4
        DB #04
        DB #8f
        DB #04
        DB #b4
        DB #04
        DB #78
        DB #04
        DB #ff
        DB #ff
        DB #ff
        DB #ff
MUSIC_DATA_END:
        DB #fe
; Reconcile all 32 hardware DMA samples against the adjusted software image.
; Repeats until every absolute sample delta is below three, then saves the
; image checksum in $2224.  Interrupts are controlled by the caller.
RECONCILE_PLAYFIELD_DMA:
jc137d: LXI H, CONTROL_FLAGS ;o0140,o13b2,o1d6f
        MVI A, #03
o1382:  CALL CLEAR_ATH_BIT_OF_HL
        OUT LAMP_F
; Reconcile the 32 hardware-maintained samples with the software comparison
; image.  Both pointers advance together; L wraps after sample $23ff.
        LXI H, PLAYFIELD_DMA_SAMPLES
        LXI D, PLAYFIELD_COMPARE_IMAGE
j138d:  MOV B,M ;o13aa
        LDAX D
        ADI #04
        SUB B
o1392:  JP j1397
        CMA
        INR A
j1397:  CPI #03 ;o1392
o1399:  JC j13a4
        LDA CONTROL_FLAGS
        ORI #08
        STA CONTROL_FLAGS
j13a4:  MOV A,B ;o1399
        SUI #04
        STAX D
        INX D
        INR L
o13aa:  JNZ j138d
        LDA CONTROL_FLAGS
        ANI #08
o13b2:  JNZ RECONCILE_PLAYFIELD_DMA
o13b5:  CALL SUM_PLAYFIELD_COMPARE_IMAGE
        SHLD $2224
        RET

PLAYFIELD_DMA_HANDLER:
        LXI H, CONTROL_FLAGS
        MVI A, #06
o13c1:  CALL SET_ATH_BIT_OF_HL
        LXI H, PLAYFIELD_DMA_SAMPLES
        LXI D, PLAYFIELD_COMPARE_IMAGE
j13ca:  LDAX D ;o13d1
        SUB M
o13cc:  JP j13ea
j13cf:  INX D ;jo141c
        INR L
o13d1:  JNZ j13ca
        LXI H, CONTROL_FLAGS
        MVI A, #06
o13d9:  CALL CHECK_ATH_BIT_OF_HL
o13dc:  JZ j13e4
        MVI A, #07
o13e1:  CALL CLEAR_ATH_BIT_OF_HL
j13e4:  MVI A, #01 ;o13dc
        DI
o13e7:  JMP CLEAR_SWITCH_LATCH_AND_RETURN
j13ea:  DI ;o13cc
        PUSH H
        LXI H, CONTROL_FLAGS
        MVI A, #06
o13f1:  CALL CLEAR_ATH_BIT_OF_HL
        INR A
o13f5:  CALL CHECK_ATH_BIT_OF_HL
o13f8:  JNZ jo1402
o13fb:  CALL SET_ATH_BIT_OF_HL
        POP H
o13ff:  JMP jo141c
jo1402: CALL CLEAR_ATH_BIT_OF_HL ;o13f8
        POP H
o1406:  CALL SAVE_BDPSW
; HL still points at PLAYFIELD_DMA_SAMPLES+N.  Subtracting its $e0 low byte
; yields switch index N (0..31); DAD H converts N to a two-byte DW offset.
        MOV A,L
        SUI #e0
        MOV L,A
        MVI H, #00
        DAD H
        LXI D, PLAYFIELD_SWITCH_DISPATCH_TABLE
        DAD D
        MOV A,M
        INX H
        MOV H,M
        MOV L,A
        PCHL
; Playfield handlers entered through PCHL return here.  Restore their nested
; context, then continue scanning the remaining DMA comparison bytes.
RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE:
jo1419: CALL RESTORE_BDPSW ;o0996,o09ab,o09b8,o09d7,o0a27,o0b60,o0b6c,o0cab,o0d5a,o0d7e,o0d9a,o14a1,o14ab,o14c5,o14d2,o153e,o1549,o15a9,o15c1,o15d3,o15de,o15e6,o15f8,o1810,o1820,o1828,o1886,o18ca
jo141c: JMP j13cf ;o13ff
PLAYFIELD_SWITCH_DISPATCH_TABLE:
        DW INLANE_HANDLER          ; 00: DMA $23e0
        DW RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE                 ; 01: unused
        DW RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE                 ; 02: unused
        DW RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE                 ; 03: unused
        DW RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE                 ; 04: unused
        DW RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE                 ; 05: unused
        DW RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE                 ; 06: unused
        DW RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE                 ; 07: unused
        DW OUTLANE_HANDLER         ; 08
        DW ROLLOVER_2_HANDLER      ; 09
        DW ROLLOVER_3_HANDLER      ; 10
        DW ROLLOVER_6_HANDLER      ; 11
        DW ROLLOVER_4_HANDLER      ; 12
        DW ROLLOVER_5_HANDLER      ; 13
        DW SIDE_BONUS_CUP_HANDLER ; 14
        DW EXTRA_BALL_LANE_HANDLER ; 15
        DW ROLLOVER_7_HANDLER      ; 16
        DW ROLLOVER_8_HANDLER      ; 17
        DW CUP_5_HANDLER           ; 18
        DW ROLLOVER_1_HANDLER      ; 19
        DW CUP_4_HANDLER           ; 20
        DW STANDUP_3_HANDLER       ; 21
        DW STANDUP_4_HANDLER       ; 22
        DW STANDUP_5_HANDLER       ; 23
        DW OUTHOLE_HANDLER         ; 24
        DW CUP_3_HANDLER           ; 25
        DW STANDUP_2_HANDLER       ; 26
        DW CUP_2_HANDLER           ; 27
        DW STANDUP_1_HANDLER       ; 28
        DW CUP_1_HANDLER           ; 29
        DW OUTLANE_HANDLER         ; 30
        DW INLANE_HANDLER          ; 31: DMA $23ff
; Relocated to the ROM-5 cove at $2ff9.  These NOPs intentionally preserve
; every following legacy address; the symbolic PCHL table is the only route
; that needs to know where the handler lives.
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
ROLLOVER_2_HANDLER:
        MVI C, #01
        MVI B, #2a
o146a:  JMP PROCESS_ROLLOVER
ROLLOVER_3_HANDLER:
        MVI C, #02
        MVI B, #10
o1471:  JMP PROCESS_ROLLOVER
ROLLOVER_4_HANDLER:
        MVI C, #03
        MVI B, #1a
o1478:  JMP PROCESS_ROLLOVER
ROLLOVER_5_HANDLER:
        MVI C, #04
        MVI B, #01
o147f:  JMP PROCESS_ROLLOVER
ROLLOVER_6_HANDLER:
        MVI C, #05
        MVI B, #19
o1486:  JMP PROCESS_ROLLOVER
ROLLOVER_7_HANDLER:
        MVI C, #06
        MVI B, #21
o148d:  JMP PROCESS_ROLLOVER
ROLLOVER_8_HANDLER:
        MVI C, #07
        MVI B, #0a
; Input: C=rollover bit, B=lamp id.  Ignore inactive/already-collected lanes;
; otherwise extinguish the lamp, award 500 bonus, and detect set completion.
PROCESS_ROLLOVER:
j1494:  LXI H, GAME_STATE ;o1463,o146a,o1471,o1478,o1486,o148d
        MVI A, #07
o1499:  CALL SET_ATH_BIT_OF_HL
        MVI A, #02
o149e:  CALL CHECK_ATH_BIT_OF_HL
o14a1:  JNZ RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
        MOV A,C
        LXI H, ROLLOVERS
o14a8:  CALL CHECK_ATH_BIT_OF_HL
o14ab:  JZ RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
o14ae:  CALL CLEAR_ATH_BIT_OF_HL
o14b1:  CALL CLEAR_LAMP_AND_TEST_FLASH_PAGE
        LXI H, SCORE_500
o14b7:  CALL ADD_BONUS_HL
        LXI H, BONUS_MUSIC
o14bd:  CALL PLAY_SOUND
        LDA ROLLOVERS
        CPI #00
o14c5:  JNZ RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
        MVI A, #3d
        STA ROLLOVER_COMPLETION_TIMER
        MVI A, #00
        STA $2205
o14d2:  JMP RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
ROLLOVER_COMPLETION_TIMER_EXPIRED:
TIMER_13_EXPIRED:
        LDA $2205
        INR A
        STA $2205
        CPI #09
o14de:  JZ j14fa
        MVI D, #00
        MOV E,A
        LXI H, ROLLOVER_LAMP_SEQUENCE_TABLE - 1
        DAD D
        MOV B,M
o14e9:  CALL SET_LAMP_SOLID
        LXI H, BONUS_MUSIC
o14ef:  CALL PLAY_SOUND
        MVI A, #0a
        STA ROLLOVER_COMPLETION_TIMER
o14f7:  JMP END_MAIN_LOOP
j14fa:  MVI A, #00 ;o14de
        STA $220c
        MVI B, #11
o1501:  CALL CHECK_LAMP_LIT_PAGE
o1504:  JNZ jo1517
        MVI B, #38
o1509:  CALL CHECK_LAMP_LIT_PAGE
o150c:  JNZ jo151f
        MVI B, #11
o1511:  CALL SET_LAMP_SOLID
o1514:  JMP jo151f
jo1517: CALL CLEAR_LAMP_AND_TEST_FLASH_PAGE ;o1504
        MVI B, #38
o151c:  CALL SET_LAMP_SOLID
jo151f: CALL AWARD_10000_BONUS ;o150c,o1514
; reset rollovers
        MVI A, #ff
        STA ROLLOVERS
        SUB A
        STA $2205
o152b:  JMP END_MAIN_LOOP
ROLLOVER_LAMP_SEQUENCE_TABLE:
        STAX B
        LHLD $1a10
        LXI B, #2119
        LDAX B
; 10,000 / EB lane
EXTRA_BALL_LANE_HANDLER:
        LXI H, GAME_STATE
        MVI A, #07
o153b:  CALL CHECK_ATH_BIT_OF_HL
o153e:  JZ RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
o1541:  CALL CLEAR_ATH_BIT_OF_HL
        MVI A, #02
o1546:  CALL CHECK_ATH_BIT_OF_HL
o1549:  JNZ RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
        LXI H, SCORE_10000
o154f:  CALL ADD_BONUS
        LXI H, GAME_STATE
        MVI A, #04
o1557:  CALL CHECK_ATH_BIT_OF_HL
o155a:  JZ j1588
        LXI H, CONTROL_FLAGS
        MVI A, #01
o1562:  CALL CHECK_ATH_BIT_OF_HL
o1565:  JNZ j1588
o1568:  CALL SET_ATH_BIT_OF_HL
        LDA CUPS_LEFT
        MVI B, #ff
j1570:  INR B ;o1572
        RAR
o1572:  JNC j1570
        MOV A,B
        DCR A
o1577:  JP j157c
        MVI A, #04
j157c:  STA $2211 ;o1577
o157f:  CALL ROTATE_CUP_LAMP_STATE
        LXI H, LONGER_BUMPER_25_MUSIC
o1585:  CALL PLAY_SOUND
j1588:  LXI H, GAME_STATE ;o155a,o1565
        MVI A, #03
o158d:  CALL CHECK_ATH_BIT_OF_HL
o1590:  JNZ j15a3
        MVI B, #09
o1595:  CALL CHECK_LAMP_LIT_PAGE
o1598:  JZ j15a3
o159b:  CALL CLEAR_LAMP_AND_TEST_FLASH_PAGE
        MVI B, #31
o15a0:  CALL SET_LAMP_FLASHING
j15a3:  LXI H, LIL_VICTORY_MUSIC ;o1590,o1598
o15a6:  CALL PLAY_SOUND
o15a9:  JMP RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
; outlane handler
OUTLANE_HANDLER:
        MVI A, #ff
        STA STATE_OUTLANE_1
        LDA SWITCH_LATCHED
        ORI #30
        STA SWITCH_LATCHED
; don't let outlane scrore > 1x
        LXI H, GAME_STATE
        MVI A, #02
o15be:  CALL CHECK_ATH_BIT_OF_HL
o15c1:  JNZ RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
o15c4:  CALL SET_ATH_BIT_OF_HL
        LXI H, SCORE_1000
o15ca:  CALL ADD_BONUS_HL
        LXI H, OUTLANE_MUSIC
o15d0:  CALL PLAY_SOUND
o15d3:  JMP RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
; inlane routine
INLANE_HANDLER:
        LXI H, GAME_STATE
        MVI A, #02
o15db:  CALL CHECK_ATH_BIT_OF_HL
o15de:  JNZ RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
        MVI A, #07
o15e3:  CALL CHECK_ATH_BIT_OF_HL
o15e6:  JZ RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
o15e9:  CALL CLEAR_ATH_BIT_OF_HL
        LXI H, SCORE_1000
o15ef:  CALL ADD_BONUS
        LXI H, SPREAD_HRM_MUSIC
o15f5:  CALL PLAY_SOUND
o15f8:  JMP RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
START_BUTTON_HANDLER:
        LXI H, GAME_STATE2
        MVI A, #00
o1600:  CALL CHECK_ATH_BIT_OF_HL
o1603:  JNZ CLEAR_START_SWITCH_LATCH_AND_RETURN
o1606:  CALL GRANT_INITIAL_CREDIT
; check if credits
        ORA A
o160a:  JNZ j1620
        LDA $239e
        ANI #08
o1612:  JNZ CLEAR_START_SWITCH_LATCH_AND_RETURN
        LDA $23b6
        ORI #40
        STA $23b6
o161d:  JMP CLEAR_START_SWITCH_LATCH_AND_RETURN
j1620:  LDA BALL_IN_PLAY_hrm ;o160a
        ANI #0f
        CPI #01
o1627:  JZ j16ed
        CPI #00
o162c:  JZ j16ed
        LXI H, #23a3
        LXI D, #2320
        MVI A, #2e
o1637:  CALL COPY_FROM_HL_TO_DE
o163a:  CALL CLEAR_GAME_DISPLAY_STATE
        LXI H, GAME_STATE2
        MVI A, #04
o1642:  CALL CHECK_ATH_BIT_OF_HL
o1645:  JZ j1655
        MVI A, #07
o164a:  CALL CHECK_ATH_BIT_OF_HL
o164d:  JZ j1655
        MVI A, #01
o1652:  JMP j1671
j1655:  MVI A, #06 ;o1645,o164d
o1657:  CALL SET_ATH_BIT_OF_HL
        LDA GAME_STATE
        ORI #05
        STA GAME_STATE
        MVI A, #ff
        STA STATE_OUTLANE_1
        LDA SWITCH_LATCHED
        ORI #30
        STA SWITCH_LATCHED
        MVI A, #00
j1671:  STA BALL_IN_PLAY_hrm ;o1652
        STA BALL_IN_PLAY_1
        STA BALL_IN_PLAY_2
        MVI A, #11
        STA $237e
        STA $23be
        MVI A, #01
        STA $239e
        MVI A, #f0
        STA PL1_SCORE_DISPLAY2
        STA PL1_SCORE_DISPLAY
        STA LAMPS_PAGE_1
        STA LAMPS_PAGE_2
        MVI A, #00
        STA $2214
        LXI D, #21d3
        MVI B, #04
o169f:  CALL FILL_PLAYER_DISPLAY_BLOCKS
        LXI H, GAME_STATE2
        MVI A, #06
o16a7:  CALL CLEAR_ATH_BIT_OF_HL
        LDA $23b6
        ANI #7f
        STA $23b6
        LXI H, #21d3
        LXI D, ROLLOVERS
        MVI A, #10
o16ba:  CALL COPY_FROM_HL_TO_DE
        LXI H, #21c9
        LXI D, #21ce
        MVI A, #0a
o16c5:  CALL COPY_FROM_HL_TO_DE
        LDA GAME_STATE
        ANI #e7
        STA GAME_STATE
DECREASE_CREDIT:
        LDA CREDITS_1 ;o1735,o174b,o176d,o1780
        ADI #99
        DAA
        STA CREDITS_1
        STA CREDITS_2
        STA CREDITS_3
        LDA $2214
        MOV B,A
        LDA BALLS_PER_GAME
        ADD B
        STA $2214
o16ea:  JMP j1783
j16ed:  LDA $237e ;o1627,o162c
        ANI #08
o16f2:  JNZ CLEAR_START_SWITCH_LATCH_AND_RETURN
        MVI A, #01
        LXI H, #237e
o16fa:  CALL CHECK_ATH_BIT_OF_HL
o16fd:  JZ jo1738
        MVI A, #02
o1702:  CALL CHECK_ATH_BIT_OF_HL
o1705:  JZ jo174e
        MVI A, #03
o170a:  CALL SET_ATH_BIT_OF_HL
        MVI A, #f0
        STA PL4_SCORE_2
        STA PL4_SCORE_3
        DI
        LDA $237e
        PUSH PSW
        MVI A, #1f
        STA $237e
        LXI H, SCORE_0
o1722:  CALL ADD_PTS
        MVI A, #2f
        STA $237e
        LXI H, SCORE_0
o172d:  CALL ADD_PTS
        POP PSW
        STA $237e
        EI
o1735:  JMP DECREASE_CREDIT
jo1738: CALL SET_ATH_BIT_OF_HL ;o16fd
        MVI A, #f0
        STA PL2_SCORE_2
        STA PL2_SCORE_3
        MVI A, #f0
        STA SPREAD_4
        STA SPREAD_3
o174b:  JMP DECREASE_CREDIT
jo174e: CALL SET_ATH_BIT_OF_HL ;o1705
        MVI A, #f0
        STA PL3_SCORE_DISPLAY_2
        STA $23a3
        MVI A, #ff
        STA SPREAD_4
        STA $2398
        STA $2399
        STA SPREAD_3
        STA $23b8
        STA $23b9
o176d:  JMP DECREASE_CREDIT
        LDA $237e
        STA $23be
        ANI #0f
        MOV B,A
        LDA $239e
        ORA B
        STA $239e
o1780:  JMP DECREASE_CREDIT
j1783:  LXI H, POPCORN_MUSIC ;o16ea
o1786:  CALL PLAY_SOUND
; Release the latched start-button event and return through the switch ISR.
CLEAR_START_SWITCH_LATCH_AND_RETURN:
j1789:  MVI A, #06 ;o1603,o1612,o161d,o16f2
o178b:  JMP CLEAR_SWITCH_LATCH_AND_RETURN
; Input: DE=destination, B=number of player/display blocks.
; Copy the same eight-byte initial display template B times.
FILL_PLAYER_DISPLAY_BLOCKS:
jc178e: LXI H, PLAYER_INITIAL_DISPLAY_TABLE ;o01a5,o169f,o179c
        MVI C, #08
j1793:  MOV A,M ;o1798
        STAX D
        INX D
        INX H
        DCR C
o1798:  JNZ j1793
        DCR B
o179c:  JNZ FILL_PLAYER_DISPLAY_BLOCKS
        RET

PLAYER_INITIAL_DISPLAY_TABLE:
        DB #ff
        DB #1f
        DB #01
        DB #04
        DB #39
        DB #2b
        DB #37
        DB #37
; Clear score/display work RAM, blank both 26-byte lamp pages, and establish
; the fixed scoreboard masks used at the start of a game.
CLEAR_GAME_DISPLAY_STATE:
c17a8:  LXI H, #235b ;jo0168,o163a
        MVI A, #00
        MVI D, #1f
j17af:  MOV M,A ;o17b2
        INX H
        DCR D
o17b2:  JNZ j17af
        STA $2246
        LXI H, LAMPS_PAGE_1
        MVI A, #ff
        MVI D, #1a
j17bf:  MOV M,A ;o17c2
        INX H
        DCR D
o17c2:  JNZ j17bf
        LXI H, LAMPS_PAGE_2
        MVI A, #ff
        MVI D, #1a
j17cc:  MOV M,A ;o17cf
        INX H
        DCR D
o17cf:  JNZ j17cc
        MVI A, #0f
        STA $238c
        STA $23ac
        STA $2396
        STA $23b6
        LXI H, #ffff
        SHLD $239c
        SHLD $23bc
        RET

; Select the end-of-ball countdown value.  Returns A=$20 normally and A=$80
; for the gated multi-ball/player condition encoded by $237e/$2214/GAME_STATE.
SELECT_END_BALL_COUNTDOWN:
c17ea:  LDA $237e ;o1880,o18fc
        ANI #02
        MVI A, #20
        RZ
        LXI H, GAME_STATE
        MVI A, #03
o17f7:  CALL CHECK_ATH_BIT_OF_HL
        MVI A, #20
        RNZ
        LDA $2214
        CPI #01
        MVI A, #20
        RZ
        MVI A, #80
        RET

OUTHOLE_HANDLER:
        LXI H, GAME_STATE2
        MVI A, #04
o180d:  CALL CHECK_ATH_BIT_OF_HL
o1810:  JNZ RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
        LXI H, #2208
        MVI A, #ff
        ADD M
o1819:  JNC j1823
        MOV M,A
o181d:  JZ j182b
o1820:  JMP RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
j1823:  MVI A, #32 ;o1819
        STA $2208
o1828:  JMP RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
j182b:  MVI A, #ff ;o181d
        STA STATE_OUTLANE_1
        MVI A, #00
        STA $220c
        STA $21c3
        STA LEFT_FLIPPER_TIMER
        STA RIGHT_FLIPPER_TIMER
        LDA SWITCH_LATCHED
        ORI #30
        STA SWITCH_LATCHED
        LXI H, GAME_STATE
        MVI A, #02
o184b:  CALL SET_ATH_BIT_OF_HL
        LXI H, GAME_STATE2
        MVI A, #04
o1853:  CALL SET_ATH_BIT_OF_HL
        LXI H, OOPS2_MUSIC
o1859:  CALL PLAY_SOUND
o185c:  CALL RESOLVE_CURRENT_PLAYER_SAVED_STATE
        XCHG
        LXI H, ROLLOVERS
        MVI A, #10
o1865:  CALL COPY_FROM_HL_TO_DE
        LXI H, GAME_STATE
        MVI A, #00
o186d:  CALL CHECK_ATH_BIT_OF_HL
o1870:  JNZ j187b
        MVI B, #39
o1875:  CALL CHECK_LAMP_LIT_PAGE
o1878:  JNZ j1889
j187b:  MVI A, #02 ;o1870
        STA END_BALL_TIMER
o1880:  CALL SELECT_END_BALL_COUNTDOWN
        STA $221c
o1886:  JMP RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
j1889:  LHLD $235c ;o1878
        DAD H
        DAD H
        DAD H
        DAD H
        SHLD SPREAD_1
        LHLD $235d
        DAD H
        DAD H
        DAD H
        DAD H
        MOV A,H
        STA $21f5
        LXI H, SPREAD_1
        LXI D, #220d
        MVI A, #06
o18a6:  CALL COPY_FROM_HL_TO_DE
        MVI A, #04
j18ab:  PUSH PSW ;o18b6
        LXI H, #220d
        MVI A, #06
o18b1:  CALL ADD_BCD_SCORE_TO_SPREAD
        POP PSW
        DCR A
o18b6:  JNZ j18ab
        LXI H, SPREAD_1
o18bc:  CALL COMMIT_SPREAD_TO_BONUS_DISPLAY
        MVI A, #3c
        STA BONUS_PAYOUT_TIMER
        LXI H, SPREAD_HRM_MUSIC
o18c7:  CALL PLAY_SOUND
o18ca:  JMP RESTORE_PLAYFIELD_CONTEXT_AND_CONTINUE
BONUS_PAYOUT_TIMER_EXPIRED:
TIMER_23_EXPIRED:
        LXI H, SCORE_1000
o18d0:  CALL TRY_SUBTRACT_FROM_BONUS
o18d3:  JC j18ea
        LXI H, SCORE_1000
o18d9:  CALL ADD_BONUS_HL
        MVI A, #0a
        STA BONUS_PAYOUT_TIMER
        LXI H, BUMPER_25_MUSIC
o18e4:  CALL PLAY_SOUND
o18e7:  JMP END_MAIN_LOOP
j18ea:  LXI H, SCORE_1000 ;o18d3
o18ed:  CALL ADD_BONUS
        LXI H, #235b
o18f3:  CALL ADD_PTS
        LXI H, #235b
o18f9:  CALL TRY_SUBTRACT_FROM_BONUS
o18fc:  CALL SELECT_END_BALL_COUNTDOWN
        STA $221c
END_BALL_TIMER_EXPIRED:
TIMER_09_EXPIRED:
        LDA $221c
        DCR A
        STA $221c
o1909:  JZ j1914
        MVI A, #02
        STA END_BALL_TIMER
o1911:  JMP END_MAIN_LOOP
j1914:  MVI A, #01 ;o1909
        STA $2212
        MVI A, #32
        STA SWITCH_LATCHED
        LXI H, GAME_STATE2
        MVI A, #03
o1923:  CALL CLEAR_ATH_BIT_OF_HL
        LXI H, BALL_IN_PLAY_hrm
        LDA BALLS_PER_GAME
        SUB M
o192d:  JP j193b
o1930:  CALL RESOLVE_CURRENT_PLAYER_DISPLAY
        MOV A,M
        ORA B
        MOV M,A
        DAD D
        MOV M,A
o1938:  JMP j1976
j193b:  LDA BALL_IN_PLAY_hrm ;o192d
        ORA A
        MVI A, #01
        LXI H, #237e
o1944:  JZ j1a8a
        MVI A, #04
jo1949: CALL CHECK_ATH_BIT_OF_HL ;o1952
o194c:  JNZ jo1955
        INR A
        CPI #08
o1952:  JNZ jo1949
jo1955: CALL CLEAR_ATH_BIT_OF_HL ;o194c
        INR A
        MOV C,A
        SUI #04
o195c:  CALL CHECK_ATH_BIT_OF_HL
        MOV A,C
o1960:  JNZ jo1a98
        LDA BALLS_PER_GAME
        INR A
        MOV B,A
        LDA BALL_IN_PLAY_hrm
        INR A
        CMP B
o196d:  JNZ j1a8a
        STA BALL_IN_PLAY_hrm
        STA BALL_IN_PLAY_2
j1976:  MVI A, #ff ;o1938
        STA BALL_IN_PLAY_1
        LDA $2246
        ORA A
o197f:  JZ j19bf
        LXI H, #237e
        MOV B,A
        MOV A,M
        ANI #0f
        MOV M,A
        MOV A,B
        MVI B, #00
j198d:  RAR ;o1992
o198e:  JC j1995
        INR B
o1992:  JMP j198d
j1995:  XCHG ;o198e
        LXI H, #2246
        MOV A,B
        STA $2245
o199d:  CALL CLEAR_ATH_BIT_OF_HL
        ADI #04
        XCHG
o19a3:  CALL SET_ATH_BIT_OF_HL
o19a6:  CALL RESOLVE_CURRENT_PLAYER_DISPLAY
        MOV A,M
        ORA B
        MOV M,A
        LDA $2396
        ANI #df
        STA $2396
        LDA GAME_STATE
        ORI #08
        STA GAME_STATE
o19bc:  JMP j1aae
j19bf:  LXI H, CONTROL_FLAGS ;o197f
        MVI A, #00
o19c4:  CALL CHECK_ATH_BIT_OF_HL
        MVI A, #01
o19c9:  JNZ j1a8a
        LDA GAME_STATE2
        ORI #c0
        STA GAME_STATE2
o19d4:  CALL PROCESS_HIGH_SCORES
        LXI H, #23b6
        MVI A, #07
o19dc:  CALL SET_ATH_BIT_OF_HL
        LDA $2396
        ANI #cf
        STA $2396
        LDA $23b6
        ANI #cf
        STA $23b6
        LDA $23ac
        ANI #30
o19f4:  JZ j1a00
        CPI #10
        MVI A, #05
o19fb:  JZ j1a00
        MVI A, #0a
j1a00:  STA $23be ;o19f4,o19fb
        SUB A
        STA $239e
        LDA $238c
        ANI #0f
        STA $238c
        LDA $2247
        ANI #08
o1a14:  JZ j1a24
        MVI A, #04
        STA $2217
        MVI A, #7a
        STA HIGH_SCORE_DISPLAY_TIMER
o1a21:  JMP j1a2a
j1a24:  LXI H, GAME_OVER_MUSIC ;o1a14
o1a27:  CALL PLAY_SOUND
j1a2a:  MVI A, #00 ;o1a21
        STA BALL_IN_PLAY_1
        STA BALL_IN_PLAY_2
        MVI A, #fa
        STA DISPLAY_CLEAR_TIMER
o1a37:  JMP END_MAIN_LOOP
; Resolve the current player selected by $2245.
; Output: HL=player display byte, B=nibble mask, DE=$20 page stride.
RESOLVE_CURRENT_PLAYER_DISPLAY:
c1a3a:  LXI H, PLAYER_SCORE_ADDRESS_TABLE ;o1930,o19a6
        LDA $2245
        ADD A
        LXI B, #0000
        MOV C,A
        DAD B
        MOV E,M
        INX H
        MOV D,M
        LXI H, PLAYER_DISPLAY_MASK_TABLE
        MOV A,C
        RAR
        MOV C,A
        DAD B
        MOV B,M
        XCHG
        LXI D, #0020
        RET

PLAYER_SCORE_ADDRESS_TABLE:
        DB #8c
        DB #23
        DB #8b
        DB #23
        DB #8b
        DB #23
        DB #8a
        DB #23
PLAYER_DISPLAY_MASK_TABLE:
        DB #0f
        DB #f0
        DB #0f
        DB #f0
HIGH_SCORE_DISPLAY_TIMER_EXPIRED:
TIMER_12_EXPIRED:
        LXI H, #2217
        DCR M
o1a66:  JZ jo1a71
        MVI A, #72
        STA HIGH_SCORE_DISPLAY_TIMER
o1a6e:  JMP END_MAIN_LOOP
jo1a71: CALL ADD_CREDIT_AND_CLEAR_INDICATORS ;o1a66
        LDA $2247
        ANI #f7
        STA $2247
        MVI A, #07
        LXI H, HIGH_SCORE_DISP3
        LXI D, HIGH_SCORE_NOW
o1a84:  CALL COPY_FROM_HL_TO_DE
o1a87:  JMP END_MAIN_LOOP
j1a8a:  STA BALL_IN_PLAY_hrm ;o1944,o196d,o19c9
        STA BALL_IN_PLAY_1
        STA BALL_IN_PLAY_2
        MVI A, #04
        LXI H, #237e
jo1a98: CALL SET_ATH_BIT_OF_HL ;o1960
        LDA BALLS_PER_GAME
        MOV C,A
        LDA BALL_IN_PLAY_hrm
        CMP C
o1aa3:  JNZ j1aae
        LXI H, GAME_STATE
        MVI A, #04
o1aab:  CALL SET_ATH_BIT_OF_HL
j1aae:  LDA $237e ;o19bc,o1aa3
        STA $23be
        MOV B,A
        ANI #0f
        STA $239e
        LXI H, GAME_STATE
        MVI A, #00
o1abf:  CALL CLEAR_ATH_BIT_OF_HL
        MVI B, #09
o1ac4:  CALL CLEAR_LAMP_AND_TEST_FLASH_PAGE
        LXI H, #23b6
        MVI A, #04
o1acc:  CALL CLEAR_ATH_BIT_OF_HL
        MVI A, #02
        STA GAME_OVER_SEQUENCE_TIMER
o1ad4:  JMP END_MAIN_LOOP
GAME_OVER_SEQUENCE_TIMER_EXPIRED:
TIMER_10_EXPIRED:
        LDA $2212
        DCR A
        STA $2212
o1ade:  JZ j1aef
        LXI H, MORSE_CODE_MUSIC
o1ae4:  CALL PLAY_SOUND
        MVI A, #a0
        STA GAME_OVER_SEQUENCE_TIMER
o1aec:  JMP END_MAIN_LOOP
j1aef:  LXI H, SCORE_0 ;o1ade
o1af2:  CALL COMMIT_SPREAD_TO_BONUS_DISPLAY
        LDA $21c9
        STA $2218
        LDA $21ce
        STA $2219
o1b01:  CALL RESOLVE_CURRENT_PLAYER_SAVED_STATE
        LXI D, ROLLOVERS
        MVI A, #10
o1b09:  CALL COPY_FROM_HL_TO_DE
        LXI H, #21c9
        LXI D, #21ce
        MVI A, #0a
o1b14:  CALL COPY_FROM_HL_TO_DE
        MVI B, #2b
o1b19:  CALL SET_LAMP_SOLID
        MVI B, #2c
o1b1e:  CALL SET_LAMP_SOLID
        MVI B, #04
o1b23:  CALL SET_LAMP_SOLID
        MVI B, #0c
o1b28:  CALL SET_LAMP_SOLID
        MVI B, #14
o1b2d:  CALL SET_LAMP_SOLID
        MVI B, #11
o1b32:  CALL CLEAR_LAMP_AND_TEST_FLASH_PAGE
        MVI B, #38
o1b37:  CALL CLEAR_LAMP_AND_TEST_FLASH_PAGE
        MVI B, #31
o1b3c:  CALL CLEAR_LAMP_AND_TEST_FLASH_PAGE
        MVI B, #09
o1b41:  CALL CLEAR_LAMP_AND_TEST_FLASH_PAGE
        LDA $2218
        ANI #41
        MOV B,A
        LDA $21c9
        ANI #be
        ORA B
        STA $21c9
        LDA $2219
        ANI #41
        MOV B,A
        LDA $21ce
        ANI #be
        ORA B
        STA $21ce
        MVI B, #39
o1b64:  CALL CLEAR_LAMP_AND_TEST_FLASH_PAGE
        LXI H, GAME_STATE2
        MVI A, #07
o1b6c:  CALL SET_ATH_BIT_OF_HL
        LXI H, NEXT_PLAYER_MUSIC
o1b72:  CALL PLAY_SOUND
        LDA $2214
        DCR A
        STA $2214
        SUI #02
o1b7e:  JM FINISH_GAME_OVER_SEQUENCE_STEP
o1b81:  JNZ FINISH_GAME_OVER_SEQUENCE_STEP
        LDA $237e
        MVI B, #00
        ANI #0f
j1b8b:  RAR ;o1b90
o1b8c:  JNC j1b93
        INR B
o1b90:  JMP j1b8b
j1b93:  LDA CREDITS_1 ;o1b8c
        SUB B
o1b97:  JP FINISH_GAME_OVER_SEQUENCE_STEP
        MVI B, #00
o1b9c:  CALL CHECK_LAMP_LIT_PAGE
o1b9f:  JNZ FINISH_GAME_OVER_SEQUENCE_STEP
o1ba2:  CALL SET_LAMP_SOLID
; Common exit for the game-over/next-player sequence.
FINISH_GAME_OVER_SEQUENCE_STEP:
jo1ba5: JMP END_MAIN_LOOP ;o1b7e,o1b81,o1b97,o1b9f
; Resolve the saved 16-byte state block for the current player encoded in the
; high nibble of $237e.  Output: HL points into the per-player state area.
RESOLVE_CURRENT_PLAYER_SAVED_STATE:
c1ba8:  LDA $237e ;o185c,o1b01
        ANI #f0
        LXI H, #21eb
        LXI D, #fff8
j1bb3:  RAL ;o1bb6
        RC
        DAD D
o1bb6:  JMP j1bb3
j1bb9:  EI ;o0284
        LXI H, #2215
        IN PRICE_89_CAB
        MOV M,A
        ANI #40
o1bc2:  JNZ j1c73
        DI
        LDA $2353
        MOV B,A
        LDA $23f8
        SUB B
        LDA SWITCH_LATCHED
o1bd1:  JM j1bd9
        ANI #fd
o1bd6:  JMP j1bdb
j1bd9:  ORI #02 ;o1bd1
j1bdb:  STA SWITCH_LATCHED ;o1bd6
        LDA GAME_STATE2
        MOV B,A
        ANI #01
o1be4:  JZ j1c04
        MOV A,B
        ANI #fe
        STA GAME_STATE2
        EI
        LXI H, #224b
        LXI D, LAMPS_PAGE_1
        MVI A, #34
o1bf6:  CALL COPY_FROM_HL_TO_DE
        LXI H, #226b
        LXI D, LAMPS_PAGE_2
        MVI A, #34
o1c01:  CALL COPY_FROM_HL_TO_DE
j1c04:  LDA $2215 ;o1be4
        ANI #20
o1c09:  JNZ j1cc3
        EI
        LXI H, HIGH_SCORE_START
        LXI D, HIGH_SCORE_DISP3
        MVI A, #07
o1c15:  CALL WRITE_TO_RAM
        LXI H, BLANK_SCORE
        LDA $2247
        ANI #08
o1c20:  JNZ j1c26
        LXI H, HIGH_SCORE_DISP3
j1c26:  LXI D, HIGH_SCORE_NOW ;o1c20
        MVI A, #07
o1c2b:  CALL COPY_FROM_HL_TO_DE
        LDA GAME_STATE2
        ANI #40
o1c33:  JZ j1c4e
        LDA CREDITS_1
; seems pointless
        ORA A
        LXI H, #23b6
        MVI A, #06
o1c3f:  JNZ jo1c48
o1c42:  CALL SET_ATH_BIT_OF_HL
o1c45:  JMP READ_PRICING_AND_GAME_DIP_SWITCHES
jo1c48: CALL CLEAR_ATH_BIT_OF_HL ;o1c3f
o1c4b:  JMP READ_PRICING_AND_GAME_DIP_SWITCHES
j1c4e:  LDA CONTROL_FLAGS ;o1c33
        ANI #01
        EI
o1c54:  JZ READ_PRICING_AND_GAME_DIP_SWITCHES
        IN PRICE_TENS_07_PORT
        CPI #fe
o1c5b:  JNZ j1c65
        IN PRICE_CENTS_07_PORT
        CPI #fb
o1c62:  JZ j1cdc
j1c65:  LXI H, CONTROL_FLAGS ;o1c5b
        MVI A, #00
o1c6a:  CALL CLEAR_ATH_BIT_OF_HL
        STA CLOCK_TIMER
o1c70:  JMP READ_PRICING_AND_GAME_DIP_SWITCHES
j1c73:  LXI H, GAME_STATE2 ;o1bc2
        MVI A, #00
o1c78:  CALL CHECK_ATH_BIT_OF_HL
o1c7b:  JNZ MAIN_OUTPUT_LOOP
o1c7e:  CALL SET_ATH_BIT_OF_HL
        LXI H, LAMPS_PAGE_1
        LXI D, #224b
        MVI A, #80
o1c89:  CALL COPY_FROM_HL_TO_DE
        MVI A, #ff
        LXI H, PL3_SCORE_DISPLAY_2
        MVI B, #17
j1c93:  MOV M,A ;o1c96
        INX H
        DCR B
o1c96:  JNZ j1c93
        MVI A, #0f
        STA $238c
        LXI H, #2320
        LXI D, #23a3
        MVI A, #2e
o1ca6:  CALL COPY_FROM_HL_TO_DE
        LDA $2261
        ORI #0f
        STA $2396
        LDA $2281
        ANI #f0
        MOV B,A
        LDA $23b6
        ANI #0f
        ORA B
        STA $23b6
o1cc0:  JMP MAIN_OUTPUT_LOOP
j1cc3:  LDA $2353 ;o1c09
        MOV B,A
        LDA $23f8
        SUB B
o1ccb:  JP MAIN_OUTPUT_LOOP
        LXI H, GAME_STATE2
        MVI A, #06
o1cd3:  CALL CHECK_ATH_BIT_OF_HL
o1cd6:  JZ j1cdc
o1cd9:  JMP MAIN_OUTPUT_LOOP
j1cdc:  LDA $237e ;o1c62,o1cd6
        STA $239e
        LDA $23ac
        STA $238c
        LDA BALL_IN_PLAY_2
        STA BALL_IN_PLAY_1
        LDA $23aa
        STA $238a
        LDA $23ab
        STA $238b
        LDA $23ac
        STA $238c
        LDA $2396
        ANI #ef
        STA $2396
        LDA $23b6
        ANI #ef
        STA $23b6
        ANI #20
        MOV B,A
        LDA $2396
        ORA B
        STA $2396
        LXI H, #21c2
        MVI A, #05
o1d1f:  CALL SET_ATH_BIT_OF_HL
        LDA $21c2
        CMA
        OUT COIL_5
        MVI A, #80
        STA STATE_OUTLANE_1
        MVI A, #06
        STA DMA_RECHECK_TIMER
        MVI A, #00
        STA SWITCH_LATCHED
        LDA GAME_STATE
        ANI #38
        ORI #80
        STA GAME_STATE
        LDA GAME_STATE2
        ANI #67
        STA GAME_STATE2
        LXI H, CONTROL_FLAGS
        MVI A, #01
o1d4e:  CALL CLEAR_ATH_BIT_OF_HL
        LXI H, SWITCH_LATCHED
        MVI A, #04
o1d56:  CALL SET_ATH_BIT_OF_HL
        MVI A, #06
        STA LEFT_FLIPPER_TIMER
        MVI A, #05
        STA SWITCH_SETTLE_TIMER
o1d63:  JMP MAIN_OUTPUT_LOOP
DMA_RECHECK_TIMER_EXPIRED:
TIMER_21_EXPIRED:
        LXI H, #21c2
        MVI A, #05
o1d6b:  CALL CLEAR_ATH_BIT_OF_HL
        DI
o1d6f:  CALL RECONCILE_PLAYFIELD_DMA
        EI
o1d73:  JMP END_MAIN_LOOP
; Input: B=encoded lamp output.  Set its bit in both lamp pages (solid on).
SET_LAMP_SOLID:
co1d76: CALL RESOLVE_LAMP_BIT ;o0ad6,o0b23,o0b3b,o0b63,o0e95,o14e9,o1511,o151c,o1b19,o1b1e,o1b23,o1b28,o1b2d,o1ba2
o1d79:  CALL SET_ATH_BIT_OF_HL
        DAD D
o1d7d:  CALL SET_ATH_BIT_OF_HL
        RET

; Input: B=encoded lamp output.  Clear both pages, preserving in the flags
; whether the second-page bit had been set before it was cleared.
CLEAR_LAMP_AND_TEST_FLASH_PAGE:
co1d81: CALL RESOLVE_LAMP_BIT ;o050c,o06e9,jo09da,o0b41,o0c2e,o0c33,o0d37,o0dbc,o14b1,jo1517,o159b,o1ac4,o1b32,o1b37,o1b3c,o1b41,o1b64
o1d84:  CALL CLEAR_ATH_BIT_OF_HL
        DAD D
o1d88:  CALL CHECK_ATH_BIT_OF_HL
        PUSH PSW
o1d8c:  CALL CLEAR_ATH_BIT_OF_HL
        POP PSW
        RET

; Input: B=encoded lamp output.  Set page 1 and clear page 2 (flashing).
SET_LAMP_FLASHING:
co1d91: CALL RESOLVE_LAMP_BIT ;jo0a14,o15a0
o1d94:  CALL SET_ATH_BIT_OF_HL
        DAD D
o1d98:  CALL CLEAR_ATH_BIT_OF_HL
        RET

; Input: B=encoded lamp output.  Return Z/NZ from its page-1 bit.
CHECK_LAMP_LIT_PAGE:
co1d9c: CALL RESOLVE_LAMP_BIT ;o0a03,o0b1b,o0b5d,o0be1,o0c07,o0c14,o0c26,o0db6,o1501,o1509,o1595,o1875,o1b9c
o1d9f:  CALL CHECK_ATH_BIT_OF_HL
        RET

; Decode lamp B: low three bits select a byte at $21c9, the next three select
; a bit within it.  Output: HL=page-1 byte, A=bit number, DE=5-byte page stride.
RESOLVE_LAMP_BIT:
c1da3:  LXI H, #21c9 ;co1d76,co1d81,co1d91,co1d9c
        MVI D, #00
        MOV A,B
        ANI #07
        MOV E,A
        DAD D
        MOV A,B
        RAR
        RAR
        RAR
        ANI #07
        LXI D, #0005
        RET

; Rank all participating player scores, compare them with the four stored high
; scores, insert qualifiers, and trigger the first-place music/indicator.
PROCESS_HIGH_SCORES:
c1db7:  LXI H, PL1_SCORE_1 ;o19d4
o1dba:  CALL LOAD_SCORE_TO_SPREAD_BUFFER
        LXI H, PL2_SCORE_1
        PUSH H
o1dc1:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
        POP H
o1dc5:  JNC j1dd4
        SHLD $223d
        LXI H, PL1_SCORE_1
        SHLD $223f
o1dd1:  JMP j1ddd
j1dd4:  SHLD $223f ;o1dc5
        LXI H, PL1_SCORE_1
        SHLD $223d
j1ddd:  LHLD $223d ;o1dd1
o1de0:  CALL LOAD_SCORE_TO_SPREAD_BUFFER
        LXI H, PL3_SCORE_1
        PUSH H
o1de7:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
        POP H
o1deb:  JC j1e04
        PUSH H
        LHLD $223f
o1df2:  CALL LOAD_SCORE_TO_SPREAD_BUFFER
        POP H
        PUSH H
o1df7:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
        POP H
o1dfb:  JC j1e0f
        SHLD $2241
o1e01:  JMP j1e17
j1e04:  PUSH H ;o1deb
o1e05:  CALL SHIFT_SCORE_RANK_POINTERS_ONE
        POP H
        SHLD $223d
o1e0c:  JMP j1e17
j1e0f:  PUSH H ;o1dfb
o1e10:  CALL SHIFT_SCORE_RANK_POINTERS_ONE
        POP H
        SHLD $223f
j1e17:  LHLD $223d ;o1e01,o1e0c
o1e1a:  CALL LOAD_SCORE_TO_SPREAD_BUFFER
        LXI H, PL4_SCORE_1
        PUSH H
o1e21:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
        POP H
o1e25:  JC j1e4e
        PUSH H
        LHLD $223f
o1e2c:  CALL LOAD_SCORE_TO_SPREAD_BUFFER
        POP H
        PUSH H
o1e31:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
        POP H
o1e35:  JC j1e59
        PUSH H
        LHLD $2241
o1e3c:  CALL LOAD_SCORE_TO_SPREAD_BUFFER
        POP H
        PUSH H
o1e41:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
        POP H
o1e45:  JC j1e77
        SHLD $2243
o1e4b:  JMP j1e82
j1e4e:  PUSH H ;o1e25
o1e4f:  CALL SHIFT_SCORE_RANK_POINTERS_TWO
        POP H
        SHLD $223d
o1e56:  JMP j1e82
j1e59:  PUSH H ;o1e35
o1e5a:  CALL SHIFT_SCORE_RANK_POINTERS_ONE
        POP H
        SHLD $223f
o1e61:  JMP j1e82
; Shift the third-ranked player-score pointer down into fourth place, then use
; the common one-place shifter for the remaining ranks.
SHIFT_SCORE_RANK_POINTERS_TWO:
c1e64:  LHLD $2241 ;o1e4f
        SHLD $2243
; Shift the ranked player-score pointers at $223d/$223f/$2241 down one place.
SHIFT_SCORE_RANK_POINTERS_ONE:
c1e6a:  LHLD $223f ;o1e05,o1e10,o1e5a
        SHLD $2241
        LHLD $223d
        SHLD $223f
        RET

j1e77:  PUSH H ;o1e45
        LHLD $2241
        SHLD $2243
        POP H
        SHLD $2241
j1e82:  LXI H, HIGH_SCORE_START ;o1e4b,o1e56,o1e61
o1e85:  CALL LOAD_SCORE_TO_SPREAD_BUFFER
        LHLD $223d
        PUSH H
o1e8c:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
        POP H
o1e90:  CC INSERT_FIRST_HIGH_SCORE
        RC
        LXI H, #2231
o1e97:  CALL LOAD_SCORE_TO_SPREAD_BUFFER
        LHLD $223d
        PUSH H
o1e9e:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
        POP H
o1ea2:  CC INSERT_SECOND_HIGH_SCORE
        RC
        LXI H, #2235
o1ea9:  CALL LOAD_SCORE_TO_SPREAD_BUFFER
        LHLD $223d
        PUSH H
o1eb0:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
        POP H
o1eb4:  CC INSERT_THIRD_HIGH_SCORE
        RC
        LXI H, #2239
o1ebb:  CALL LOAD_SCORE_TO_SPREAD_BUFFER
        LHLD $223d
        PUSH H
o1ec2:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
        POP H
o1ec6:  CC INSERT_FOURTH_HIGH_SCORE
        RET

        LXI H, #2231
o1ecd:  CALL LOAD_SCORE_TO_SPREAD_BUFFER
        LHLD $223f
        PUSH H
o1ed4:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
        POP H
o1ed8:  CC INSERT_SECOND_HIGH_SCORE
        RC
        LXI H, #2235
o1edf:  CALL LOAD_SCORE_TO_SPREAD_BUFFER
        LHLD $223f
        PUSH H
o1ee6:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
        POP H
o1eea:  CC INSERT_THIRD_HIGH_SCORE
        RC
        LXI H, #2239
o1ef1:  CALL LOAD_SCORE_TO_SPREAD_BUFFER
        LHLD $223f
        PUSH H
o1ef8:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
        POP H
o1efc:  CC INSERT_FOURTH_HIGH_SCORE
        RET

        LXI H, #2235
o1f03:  CALL LOAD_SCORE_TO_SPREAD_BUFFER
        LHLD $2241
        PUSH H
o1f0a:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
        POP H
o1f0e:  CC INSERT_THIRD_HIGH_SCORE
        RC
        LXI H, #2239
o1f15:  CALL LOAD_SCORE_TO_SPREAD_BUFFER
        LHLD $2241
        PUSH H
o1f1c:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
        POP H
o1f20:  CC INSERT_FOURTH_HIGH_SCORE
        RET

        LXI H, #2239
o1f27:  CALL LOAD_SCORE_TO_SPREAD_BUFFER
        LHLD $2243
        PUSH H
o1f2e:  CALL SUBTRACT_BCD_SCORE_FROM_SPREAD
        POP H
o1f32:  CC INSERT_FOURTH_HIGH_SCORE
        RET

; Input: A=number of existing high-score slots to shift.  Move lower-ranked
; seven-byte entries down to make room for a new score.
MAKE_ROOM_IN_HIGH_SCORE_TABLE:
c1f36:  PUSH PSW ;o1f61,o1f81,o1f92
        LXI H, #2235
        PUSH H
        LXI D, #2239
        MVI A, #07
o1f40:  CALL COPY_FROM_HL_TO_DE
        POP D
        POP PSW
        DCR A
        RZ
        PUSH PSW
        LXI H, #2231
        PUSH H
        MVI A, #07
o1f4e:  CALL COPY_FROM_HL_TO_DE
        POP D
        POP PSW
        DCR A
        RZ
        LXI H, HIGH_SCORE_START
        MVI A, #07
o1f5a:  CALL COPY_FROM_HL_TO_DE
        RET

; Insert the seven-byte score at HL into first place, shifting all lower slots;
; play the high-score music and set the new-high-score state bit.  Returns C.
INSERT_FIRST_HIGH_SCORE:
c1f5e:  PUSH H ;o1e90
        MVI A, #03
o1f61:  CALL MAKE_ROOM_IN_HIGH_SCORE_TABLE
        POP H
        LXI D, HIGH_SCORE_START
        MVI A, #07
o1f6a:  CALL COPY_FROM_HL_TO_DE
        LXI H, HIGH_SCORE_MUSIC
o1f70:  CALL PLAY_SOUND
        LDA $2247
        ORI #08
        STA $2247
        ORA A
        CMC
        RET

; Insert the seven-byte score at HL into second place.  Returns C.
INSERT_SECOND_HIGH_SCORE:
c1f7e:  PUSH H ;o1ea2,o1ed8
        MVI A, #02
o1f81:  CALL MAKE_ROOM_IN_HIGH_SCORE_TABLE
        POP H
        LXI D, #2231
        MVI A, #07
o1f8a:  CALL COPY_FROM_HL_TO_DE
        CMC
        RET

; Insert the seven-byte score at HL into third place.  Returns C.
INSERT_THIRD_HIGH_SCORE:
c1f8f:  PUSH H ;o1eb4,o1eea,o1f0e
        MVI A, #01
o1f92:  CALL MAKE_ROOM_IN_HIGH_SCORE_TABLE
        POP H
        LXI D, #2235
        MVI A, #07
o1f9b:  CALL COPY_FROM_HL_TO_DE
        CMC
        RET

; Insert the seven-byte score at HL into fourth place.  Returns C.
INSERT_FOURTH_HIGH_SCORE:
c1fa0:  LXI D, #2239 ;o1ec6,o1efc,o1f20,o1f32
        MVI A, #07
o1fa5:  CALL COPY_FROM_HL_TO_DE
        CMC
        RET

; Restore the four-entry high-score table by shifting the existing values up
; and copying DEFAULT_HIGH_SCORE into the last slot.
RESET_HIGH_SCORE_TABLE:
c1faa:  LXI H, #2231 ;o0707,o08f4
        PUSH H
        LXI D, HIGH_SCORE_START
        MVI A, #07
o1fb3:  CALL COPY_FROM_HL_TO_DE
        POP D
        LXI H, #2235
        PUSH H
        MVI A, #07
o1fbd:  CALL COPY_FROM_HL_TO_DE
        POP D
        LXI H, #2239
        PUSH H
        MVI A, #07
o1fc7:  CALL COPY_FROM_HL_TO_DE
        LXI H, DEFAULT_HIGH_SCORE
        POP D
        MVI A, #07
o1fd0:  CALL COPY_FROM_HL_TO_DE
        RET

; Input: HL=seven-byte packed-BCD score.  Zero the four-byte SPREAD_1 work
; prefix, copy the score into it, and return A=7 for the comparison routines.
LOAD_SCORE_TO_SPREAD_BUFFER:
c1fd4:  LXI D, SPREAD_1 ;o1dba,o1de0,o1df2,o1e1a,o1e2c,o1e3c,o1e85,o1e97,o1ea9,o1ebb,o1ecd,o1edf,o1ef1,o1f03,o1f15,o1f27
        MVI A, #00
        MVI B, #04
j1fdb:  STAX D ;o1fde
        INX D
        DCR B
o1fde:  JNZ j1fdb
        LXI D, SPREAD_1
        MVI A, #07
o1fe6:  CALL COPY_FROM_HL_TO_DE
        MVI A, #07
        RET

ADD_PULL_IN_MASK:
        LDA LEFT_FLIPPER_TIMER ;o02f8
        ANI #10
        ORA B
        MOV B,A
        LDA RIGHT_FLIPPER_TIMER
        ANI #10
        ADD A
        ORA B
        MOV B,A
        RET

        NOP
        NOP
        MOV H,B
        SUB D
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        POP PSW
        INR B
        SUI #04
        POP PSW
        INR B
        ORA H
        INR B
        ADC A
        INR B
        ORA H
        INR B
        MOV A,B
        INR B
        RST 7
; ROM 5 ($2810 onward): AY sound backend for the original two-byte sound
; streams.  TONE_PLAY still performs all timing and pointer advancement.
;
; The board has an inverter between the 8085 and the AY data/control bus, so
; AY_WRITE_REG complements the register number and data byte before OUTing it.
AY_INIT:
        PUSH B
        ; The original 566 and the AY can share the downstream audio path.
        ; Park the 566 at its observed silent pitch so later writes to the
        ; common port-9 gate cannot revive its last audible tone.
        MVI A, #ff
        OUT TONE_PITCH
        ; The quiet $12 gate setting only takes effect after a fresh $ff
        ; pre-trigger, matching the aperture AY transaction sequence.
        MVI A, AY_GATE_TRIGGER
        OUT TONE_ENABLE_DUR
        MVI B, #07
        MVI C, #3e
        CALL AY_WRITE_REG
        ; Set the shared decay envelope once.  R13 is retriggered per note.
        MVI B, #0b
        MVI C, AY_ENVELOPE_PERIOD_LO
        CALL AY_WRITE_REG
        MVI B, #0c
        MVI C, AY_ENVELOPE_PERIOD_HI
        CALL AY_WRITE_REG
        MVI B, #0d
        MVI C, AY_ENVELOPE_SHAPE
        CALL AY_WRITE_REG
        MVI B, #08
        MVI C, #10
        CALL AY_WRITE_REG
        MVI B, #09
        MVI C, #00
        CALL AY_WRITE_REG
        MVI B, #0a
        MVI C, #00
        CALL AY_WRITE_REG
        MVI B, #00
        MVI C, #ff
        CALL AY_WRITE_REG
        MVI B, #01
        MVI C, #01
        CALL AY_WRITE_REG
        MVI A, AY_GATE_NORMAL
        OUT TONE_ENABLE_DUR
        POP B
        RET

; Mute only channel A; B and C remain reserved for future sound modalities.
AY_MUTE:
        PUSH B
        MVI B, #08
        MVI C, #00
        CALL AY_WRITE_REG
        POP B
        RET

; Entry: B = original 566 pitch byte, A = original tone-character byte.
; Return: A is unchanged so the original duration scheduler below TONE_PLAY
; can continue to interpret it.  ROM 6 holds two-byte AY periods indexed by
; the original frequency-proportional pitch byte.
AY_PLAY_TONE:
        PUSH PSW
        PUSH B
        ANI #1e
        JZ AY_PLAY_TONE_MUTE
        ; Port $09 is not simply a steady volume setting on this board.  A
        ; note must begin with its $ff trigger, then restore $12 only after
        ; the AY register writes are complete.  Writing $12 alone is silent.
        MVI A, AY_GATE_TRIGGER
        OUT TONE_ENABLE_DUR
        PUSH H
        LXI H, AY_PERIOD_TABLE
        MOV E,B
        MVI D, #00
        DAD D
        DAD D
        MOV C,M
        INX H
        MOV A,M
        MOV D,A
        POP H
        MVI B, #00
        CALL AY_WRITE_REG
        MVI B, #01
        MOV C,D
        CALL AY_WRITE_REG
        MVI B, #08
        MVI C, #10
        CALL AY_WRITE_REG
        ; Rewriting R13 restarts the same decay on every note.
        MVI B, #0d
        MVI C, AY_ENVELOPE_SHAPE
        CALL AY_WRITE_REG
        ; The downstream legacy audio gate needs a fresh trigger per note.
        MVI A, AY_GATE_NORMAL
        OUT TONE_ENABLE_DUR
        JMP AY_PLAY_TONE_DONE
AY_PLAY_TONE_MUTE:
        MVI B, #08
        MVI C, #00
        CALL AY_WRITE_REG
AY_PLAY_TONE_DONE:
        POP B
        POP PSW
        RET

; Entry: B = AY register, C = non-inverted AY value.
AY_WRITE_REG:
        MOV A,B
        CMA
        OUT AY_REGISTER
        MOV A,C
        CMA
        OUT AY_DATA
        RET
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
ROLLOVER_1_HANDLER:
        MVI C, #00
        MVI B, #02
        JMP PROCESS_ROLLOVER
        NOP
        NOP
        NOP
        NOP
; ROM 6 ($3000-$37ff): legacy-pitch to AY-period lookup table.
; Entry N is little-endian round($b400 / N), clamped to the AY's 12 bits.
; Entry zero is reserved for a rest/no period.
AY_PERIOD_TABLE:
        DB #00
        DB #00
        DB #ff
        DB #0f
        DB #ff
        DB #0f
        DB #ff
        DB #0f
        DB #ff
        DB #0f
        DB #ff
        DB #0f
        DB #ff
        DB #0f
        DB #ff
        DB #0f
        DB #ff
        DB #0f
        DB #ff
        DB #0f
        DB #ff
        DB #0f
        DB #ff
        DB #0f
        DB #00
        DB #0f
        DB #d9
        DB #0d
        DB #db
        DB #0c
        DB #00
        DB #0c
        DB #40
        DB #0b
        DB #97
        DB #0a
        DB #00
        DB #0a
        DB #79
        DB #09
        DB #00
        DB #09
        DB #92
        DB #08
        DB #2f
        DB #08
        DB #d3
        DB #07
        DB #80
        DB #07
        DB #33
        DB #07
        DB #ec
        DB #06
        DB #ab
        DB #06
        DB #6e
        DB #06
        DB #35
        DB #06
        DB #00
        DB #06
        DB #ce
        DB #05
        DB #a0
        DB #05
        DB #74
        DB #05
        DB #4b
        DB #05
        DB #25
        DB #05
        DB #00
        DB #05
        DB #dd
        DB #04
        DB #bd
        DB #04
        DB #9e
        DB #04
        DB #80
        DB #04
        DB #64
        DB #04
        DB #49
        DB #04
        DB #30
        DB #04
        DB #17
        DB #04
        DB #00
        DB #04
        DB #ea
        DB #03
        DB #d4
        DB #03
        DB #c0
        DB #03
        DB #ac
        DB #03
        DB #9a
        DB #03
        DB #88
        DB #03
        DB #76
        DB #03
        DB #65
        DB #03
        DB #55
        DB #03
        DB #46
        DB #03
        DB #37
        DB #03
        DB #28
        DB #03
        DB #1a
        DB #03
        DB #0d
        DB #03
        DB #00
        DB #03
        DB #f3
        DB #02
        DB #e7
        DB #02
        DB #db
        DB #02
        DB #d0
        DB #02
        DB #c5
        DB #02
        DB #ba
        DB #02
        DB #b0
        DB #02
        DB #a6
        DB #02
        DB #9c
        DB #02
        DB #92
        DB #02
        DB #89
        DB #02
        DB #80
        DB #02
        DB #77
        DB #02
        DB #6f
        DB #02
        DB #66
        DB #02
        DB #5e
        DB #02
        DB #56
        DB #02
        DB #4f
        DB #02
        DB #47
        DB #02
        DB #40
        DB #02
        DB #39
        DB #02
        DB #32
        DB #02
        DB #2b
        DB #02
        DB #25
        DB #02
        DB #1e
        DB #02
        DB #18
        DB #02
        DB #12
        DB #02
        DB #0c
        DB #02
        DB #06
        DB #02
        DB #00
        DB #02
        DB #fa
        DB #01
        DB #f5
        DB #01
        DB #ef
        DB #01
        DB #ea
        DB #01
        DB #e5
        DB #01
        DB #e0
        DB #01
        DB #db
        DB #01
        DB #d6
        DB #01
        DB #d1
        DB #01
        DB #cd
        DB #01
        DB #c8
        DB #01
        DB #c4
        DB #01
        DB #bf
        DB #01
        DB #bb
        DB #01
        DB #b7
        DB #01
        DB #b3
        DB #01
        DB #af
        DB #01
        DB #ab
        DB #01
        DB #a7
        DB #01
        DB #a3
        DB #01
        DB #9f
        DB #01
        DB #9b
        DB #01
        DB #98
        DB #01
        DB #94
        DB #01
        DB #91
        DB #01
        DB #8d
        DB #01
        DB #8a
        DB #01
        DB #87
        DB #01
        DB #83
        DB #01
        DB #80
        DB #01
        DB #7d
        DB #01
        DB #7a
        DB #01
        DB #77
        DB #01
        DB #74
        DB #01
        DB #71
        DB #01
        DB #6e
        DB #01
        DB #6b
        DB #01
        DB #68
        DB #01
        DB #65
        DB #01
        DB #62
        DB #01
        DB #60
        DB #01
        DB #5d
        DB #01
        DB #5a
        DB #01
        DB #58
        DB #01
        DB #55
        DB #01
        DB #53
        DB #01
        DB #50
        DB #01
        DB #4e
        DB #01
        DB #4c
        DB #01
        DB #49
        DB #01
        DB #47
        DB #01
        DB #45
        DB #01
        DB #42
        DB #01
        DB #40
        DB #01
        DB #3e
        DB #01
        DB #3c
        DB #01
        DB #39
        DB #01
        DB #37
        DB #01
        DB #35
        DB #01
        DB #33
        DB #01
        DB #31
        DB #01
        DB #2f
        DB #01
        DB #2d
        DB #01
        DB #2b
        DB #01
        DB #29
        DB #01
        DB #27
        DB #01
        DB #26
        DB #01
        DB #24
        DB #01
        DB #22
        DB #01
        DB #20
        DB #01
        DB #1e
        DB #01
        DB #1c
        DB #01
        DB #1b
        DB #01
        DB #19
        DB #01
        DB #17
        DB #01
        DB #16
        DB #01
        DB #14
        DB #01
        DB #12
        DB #01
        DB #11
        DB #01
        DB #0f
        DB #01
        DB #0d
        DB #01
        DB #0c
        DB #01
        DB #0a
        DB #01
        DB #09
        DB #01
        DB #07
        DB #01
        DB #06
        DB #01
        DB #04
        DB #01
        DB #03
        DB #01
        DB #01
        DB #01
        DB #00
        DB #01
        DB #ff
        DB #00
        DB #fd
        DB #00
        DB #fc
        DB #00
        DB #fa
        DB #00
        DB #f9
        DB #00
        DB #f8
        DB #00
        DB #f6
        DB #00
        DB #f5
        DB #00
        DB #f4
        DB #00
        DB #f3
        DB #00
        DB #f1
        DB #00
        DB #f0
        DB #00
        DB #ef
        DB #00
        DB #ee
        DB #00
        DB #ec
        DB #00
        DB #eb
        DB #00
        DB #ea
        DB #00
        DB #e9
        DB #00
        DB #e8
        DB #00
        DB #e6
        DB #00
        DB #e5
        DB #00
        DB #e4
        DB #00
        DB #e3
        DB #00
        DB #e2
        DB #00
        DB #e1
        DB #00
        DB #e0
        DB #00
        DB #df
        DB #00
        DB #de
        DB #00
        DB #dc
        DB #00
        DB #db
        DB #00
        DB #da
        DB #00
        DB #d9
        DB #00
        DB #d8
        DB #00
        DB #d7
        DB #00
        DB #d6
        DB #00
        DB #d5
        DB #00
        DB #d4
        DB #00
        DB #d3
        DB #00
        DB #d2
        DB #00
        DB #d1
        DB #00
        DB #d1
        DB #00
        DB #d0
        DB #00
        DB #cf
        DB #00
        DB #ce
        DB #00
        DB #cd
        DB #00
        DB #cc
        DB #00
        DB #cb
        DB #00
        DB #ca
        DB #00
        DB #c9
        DB #00
        DB #c8
        DB #00
        DB #c7
        DB #00
        DB #c7
        DB #00
        DB #c6
        DB #00
        DB #c5
        DB #00
        DB #c4
        DB #00
        DB #c3
        DB #00
        DB #c2
        DB #00
        DB #c2
        DB #00
        DB #c1
        DB #00
        DB #c0
        DB #00
        DB #bf
        DB #00
        DB #be
        DB #00
        DB #be
        DB #00
        DB #bd
        DB #00
        DB #bc
        DB #00
        DB #bb
        DB #00
        DB #bb
        DB #00
        DB #ba
        DB #00
        DB #b9
        DB #00
        DB #b8
        DB #00
        DB #b8
        DB #00
        DB #b7
        DB #00
        DB #b6
        DB #00
        DB #b5
        DB #00
        DB #b5
        DB #00
; Keep the sixth 2 KiB page fully populated so ROM 7 remains the next page.
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
