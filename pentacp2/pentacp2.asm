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
PL13_SCORE_1 EQU 0x2367
PL13_SCORE_2 EQU 0x236f
PL24_SCORE_1 EQU 0x2373
SPREAD_1 EQU 0x21f3
STATE_OUTLANE_1 EQU 0x2194
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
HARD_RESET EQU 0x5d
GAME_STATE EQU 0x2190
GAME_STATE2 EQU 0x2192
STACK_SCRATCH EQU 0x2195

; INPUT PORTS
MYSTERY_PORT_1 EQU 0x1
PRICE_CENTS_07_PORT EQU 0x2
PRICE_TENS_07_PORT EQU 0x3
PRICE_89_CAB EQU 0x4

; OUTPUT PORTS
TONE_ENABLE_DUR EQU 0x9
TONE_PITCH EQU 0xa
LAMP_1 EQU 0xd
LAMP_2 EQU 0xe
LAMP_3 EQU 0xf
DIP_SWITCH_PORT EQU 0x5
o0000:  JMP j0040
o0003:  CALL jcCREDIT_HANDLER
o0006:  JMP jo0382
c0009:  LDA PRICE_1 ;o1606
        ORA A
o000d:  JNZ j0014
        INR A
        STA CREDITS_1
j0014:  LDA CREDITS_1 ;o000d
        RET

        HLT
        HLT
        HLT
        HLT
        HLT
        HLT
        HLT
        HLT
        HLT
        HLT
        HLT
        HLT
o0024:  JMP j0069
        HLT
        HLT
        HLT
        HLT
        MOV B,M
o002c:  JMP jo0330
        HLT
        HLT
        HLT
        HLT
        NOP
o0034:  JMP joSWITCH_HANDLER
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
        OUT LAMP_3
        MOV A,H
        ORA A
o004f:  JNZ j004a
        DCR D
o0053:  JNZ j0047
        IN PRICE_89_CAB
        ANI #20
o005a:  JZ j0069
; hard reset routine
        LXI H, #2000
j0060:  SUB A ;o0066
        MOV M,A
        INX H
        MVI A, #24
        CMP H
o0066:  JNZ j0060
j0069:  LXI SP, GAME_STATE ;o0024,o005a
        MVI A, #07
j006e:  OUT LAMP_2 ;o0073
        OUT LAMP_1
        DCR A
o0073:  JP j006e
        LXI H, #2197
        MVI C, #2d
j007b:  SUB A ;o007f
        MOV M,A
        INX H
        DCR C
o007f:  JNZ j007b
        MVI A, #05
        STA $0000
        MVI A, #fe
        OUT TONE_ENABLE_DUR
        MVI A, #02
        STA $2198
        MVI A, #ff
        STA $2193
        MVI A, #fc
        STA STATE_OUTLANE_1
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
        LXI H, #1181
j00c3:  LXI D, HIGH_SCORE_START ;o003b
        MVI A, #08
o00c8:  CALL cCOPY_FROM_HL_TO_DE
        LXI H, #117d
        LXI D, #2231
        MVI A, #08
o00d3:  CALL cCOPY_FROM_HL_TO_DE
        MVI A, #71
        STA $219f
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
jo00f5: CALL co0317 ;o00bd
o00f8:  JZ j0143
j00fb:  MVI A, #07 ;o00f2
        STA $21c2
        CMA
        OUT DIP_SWITCH_PORT
        MVI A, #06
        STA $21a6
j0108:  EI ;o010d
        LDA $21a6
        ORA A
o010d:  JNZ j0108
        MVI A, #28
        STA $21c2
        CMA
        OUT DIP_SWITCH_PORT
        MVI A, #20
        STA $21c4
        CMA
        OUT #07
        MVI A, #02
        STA $21c5
        CMA
        OUT #08
        MVI A, #06
        STA $21a6
j012d:  EI ;o0132
        LDA $21a6
        ORA A
o0132:  JNZ j012d
        MVI A, #ff
        OUT DIP_SWITCH_PORT
        OUT #06
        OUT #07
        OUT #08
        DI
        CALL $137d
j0143:  IN PRICE_89_CAB ;o00f8,o0300
        ANI #20
o0147:  JNZ jo0168
        LDA GAME_STATE2
        ANI #df
        STA GAME_STATE2
        IN PRICE_TENS_07_PORT
        CPI #fe
o0156:  JNZ j01bf
        IN PRICE_CENTS_07_PORT
        CPI #fb
o015d:  JZ j029e
        CPI #f7
o0162:  JZ j02c8
o0165:  JMP j01bf
jo0168: CALL c17a8 ;o0147,o02c5
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
o019d:  CALL cCOPY_FROM_HL_TO_DE
        MVI B, #01
        LXI D, #21c6
o01a5:  CALL jc178e
        LXI H, #21c9
        LXI D, #21ce
        MVI A, #0a
o01b0:  CALL cCOPY_FROM_HL_TO_DE
        LXI H, #2205
        MVI B, #13
        SUB A
j01b9:  MOV M,A ;o01bc
        INX H
        DCR B
o01bc:  JNZ j01b9
j01bf:  DI ;o0156,o0165,o02a4
        MVI A, #30
        STA STATE_OUTLANE_1
        LDA GAME_STATE2
        ANI #80
o01ca:  JNZ j01d2
        MVI A, #00
        STA GAME_STATE2
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
        IN #05
        LXI H, DIP_SWITCHES
        MOV M,A
        MVI B, #03
        MVI A, #00
o0218:  CALL cCHECK_ATH_BIT_OF_HL
o021b:  JNZ j0228
        INR B
        MVI A, #01
o0221:  CALL cCHECK_ATH_BIT_OF_HL
o0224:  JNZ j0228
        INR B
j0228:  MOV A,B ;o021b,o0224
        STA BALLS_PER_GAME
j022c:  OUT LAMP_3 ;o028f,o1c7b,o1cc0,o1ccb,o1cd9,o1d63
        EI
        NOP
        EI
        NOP
        EI
        NOP
        DI
        LDA $21c2
        CMA
        OUT DIP_SWITCH_PORT
        LDA $21c3
        CMA
        OUT #06
        LDA $21c4
        CMA
        OUT #07
        LDA $21c5
        CMA
        OUT #08
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
o0278:  CALL c0f3c
j027b:  EI ;o025c,o026d
        LXI H, GAME_STATE2
        MVI A, #07
o0281:  CALL cCHECK_ATH_BIT_OF_HL
o0284:  JNZ j1bb9
        LDA $23b6
        ANI #bf
        STA $23b6
o028f:  JMP j022c
cADD_BONUS_HL:
              XCHG ;o07c8,o0ce8,o0dc5,o0dd4,o14b7,o15ca,o18d9
        LHLD $21f9
        MOV M,E
        INX H
        MOV M,D
        INX H
        SHLD $21f9
        RET

j029e:  LDA $2191 ;o015d
        MOV B,A
        ANI #01
o02a4:  JNZ j01bf
        MOV A,B
        ORI #01
        STA $2191
        DI
        MVI A, #30
        STA STATE_OUTLANE_1
        MVI A, #7d
        STA $219f
        MVI A, #3c
        STA $221f
        MVI A, #00
        STA $2220
        STA $2221
o02c5:  JMP jo0168
j02c8:  DI ;o0162
        LXI H, #23c0
        MVI B, #0c
j02ce:  MVI M, #88 ;o02d2
        INX H
        DCR B
o02d2:  JNZ j02ce
        MVI M, #f8
        INX H
        MVI B, #09
j02da:  MVI M, #88 ;o02de
        INX H
        DCR B
o02de:  JNZ j02da
        MVI M, #f8
        INX H
        MVI B, #07
j02e6:  MVI M, #88 ;o02ea
        INX H
        DCR B
o02ea:  JNZ j02e6
        MVI M, #ff
        INX H
        MVI M, #88
        MVI A, #00
        OUT #00
        OUT #01
        OUT #02
        OUT #03
        OUT #04
        OUT LAMP_3
o0300:  JMP j0143
c0303:  LXI D, #233b ;co0317,o13b5
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

co0317: CALL c0303 ;jo00f5
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
jo0330: CALL cSAVE_BDPSW ;o002c
        LDA GAME_STATE
        ORI #80
        STA GAME_STATE
        IN MYSTERY_PORT_1
        LXI D, #0000
j0340:  ORA A ;o0349
o0341:  JZ jo0382
        RAR
o0345:  JC j034c
        INR E
o0349:  JMP j0340
j034c:  MOV A,E ;o0345
        CMA
        OUT LAMP_2
        CMA
        LXI H, #2193
o0354:  CALL cCHECK_ATH_BIT_OF_HL
o0357:  JNZ jo0382
o035a:  CALL cSAVE_BDPSW
        LDA $2191
        ANI #02
o0362:  CNZ c0402
o0365:  CALL cRESTORE_BDPSW
o0368:  CALL cSET_ATH_BIT_OF_HL
        XCHG
        DAD H
        LXI D, #03b6
        DAD D
        MOV A,M
        INX H
        MOV H,M
        MOV L,A
        PCHL
j0376:  LXI H, STATE_OUTLANE_1 ;o0606,o13e7,o178b
o0379:  JMP jo037f
        LXI H, #2193
jo037f: CALL cCLEAR_ATH_BIT_OF_HL ;o0379
; vector to 0630 stack restore
jo0382: CALL cRESTORE_BDPSW ;o0006,o0341,o0357,o038f,o03a5,o0486,o0540,o0549,o078c,o07cb,o084f,o0865,o086d,o0921,o092a
        RET

joSWITCH_HANDLER:
              CALL cSAVE_BDPSW ;o0034
        LXI D, #0000
        IN #00
j038e:  ORA A ;o0397
o038f:  JZ jo0382
        RAR
o0393:  JC j039a
        INR E
o0397:  JMP j038e
j039a:  MOV A,E ;o0393
        CMA
        OUT LAMP_1
        CMA
        LXI H, STATE_OUTLANE_1
o03a2:  CALL cCHECK_ATH_BIT_OF_HL
o03a5:  JNZ jo0382
o03a8:  CALL cSET_ATH_BIT_OF_HL
        XCHG
        DAD H
        LXI D, #03c6
        DAD D
        MOV A,M
        INX H
        MOV H,M
        MOV L,A
        PCHL
        MOV H,B
        RLC
        MOV H,M
        RLC
        MOV L,H
        RLC
        MOV M,D
        RLC
        MOV A,B
        RLC
        MOV A,M
        RLC
        ADD H
        RLC
        ADD D
        INX B
        (SHLX)
        DCR B
        CMP H
        INX D
        DB #03
        DB #00
        DB #7b
        DB #04
        STC
        (DSUB)
        DAD B
        DAD B
        EI
        DCR D
        DB #7b
        DB #04
cSET_ATH_BIT_OF_HL:
              PUSH B ;o0368,o03a8,o0410,o052e,o06cb,o079f,o09c0,o09cf,o09f6,o0aa1,o0af2,o0b55,o0c98,o0c9e,o0d52,jo1078,jo10ad,o11f8,o1213,o1283,o13c1,o13fb,o1499,o1568,o15c4,o1657,o170a,jo1738,jo174e,o184b,o1853,o19a3,o19dc,jo1a98,o1aab,o1b6c,o1c42,o1c7e,o1d1f,o1d56,o1d79,o1d7d,o1d94
        MOV B,A
o03d8:  CALL c2_LSHIFT_A
        MOV C,M
        ORA C
        MOV M,A
o03de:  JMP j03f6
cCLEAR_ATH_BIT_OF_HL:
              PUSH B ;jo037f,o0423,o06bd,o06d8,o06de,o06e4,o0716,o088b,o0948,o09e7,jo09fc,o0a4d,o0a5b,o0ba4,o0bb4,jo107d,o10ba,o10bf,jo1222,jo1255,o1382,o13e1,o13f1,jo1402,o14ae,o1541,o15e9,o16a7,o1923,jo1955,o199d,o1abf,o1acc,jo1c48,o1c6a,o1d4e,o1d6b,o1d84,o1d8c,o1d98
        MOV B,A
o03e3:  CALL c2_LSHIFT_A
        CMA
        MOV C,A
        MOV A,M
        ANA C
        MOV M,A
o03eb:  JMP j03f6
cCHECK_ATH_BIT_OF_HL:
              PUSH B ;o0218,o0221,o0281,o0354,o03a2,o0409,o05b2,o06b9,o0710,o07f8,o084c,o0862,o0875,o0880,o091e,o0932,o093d,o09c5,o09e1,o0a0b,o0a47,o0a55,o0b13,o0b49,o0bec,o0cd6,o0f49,o0f50,o0f57,o0faa,o1071,o10a6,o120b,o1227,o127f,o13d9,o13f5,o149e,o14a8,o153b,o1546,o1557,o1562,o158d,o15be,o15db,o15e3,o1600,o1642,o164a,o16fa,o1702,o17f7,o180d,o186d,jo1949,o195c,o19c4,o1c78,o1cd3,o1d88,o1d9f
        MOV B,A
o03f0:  CALL c2_LSHIFT_A
        MOV C,A
        MOV A,M
        ANA C
j03f6:  MOV A,B ;o03de,o03eb
        POP B
        RET

c2_LSHIFT_A:
              MOV C,A ;o03d8,o03e3,o03f0
        MVI A, #01
j03fc:  DCR C ;o03ff
        RM
        ADD A
o03ff:  JMP j03fc
c0402:  LDA $2211 ;o0362,o0b4c,o157f
        MOV B,A
o0406:  CALL c0427
o0409:  CALL cCHECK_ATH_BIT_OF_HL
o040c:  JZ j0413
        XCHG
o0410:  CALL cSET_ATH_BIT_OF_HL
j0413:  MOV A,B ;o040c
        INR A
        CPI #05
o0417:  JNZ j041c
        MVI A, #00
j041c:  STA $2211 ;o0417
o041f:  CALL c0427
        XCHG
o0423:  CALL cCLEAR_ATH_BIT_OF_HL
        RET

c0427:  MVI D, #00 ;o0406,o041f
        MOV E,A
        LXI H, #0440
        DAD D
        MOV A,M
        LXI H, #0445
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
        DB #04
        DB #00
        DB #01,#02,#05
        DB #cd,#21,#cc
        DB #21,#cc,#21
        DB #cc,#21,#ca
        DB #21,#3a,#90
        LXI H, #05f6
        STA GAME_STATE
        MVI A, #00
        STA $220c
        MVI A, #ff
        STA $2193
        LDA STATE_OUTLANE_1
        ORI #30
        STA STATE_OUTLANE_1
        RET

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

        CALL $044f
        MVI A, #7d
        STA $21a2
o0483:  CALL c046a
o0486:  JNZ jo0382
        MVI A, #fa
        STA $219e
        LDA $23b6
        ORI #10
        STA $23b6
        MVI A, #ff
        STA $2380
        STA $2381
        STA $2382
        LDA $233f
        ADI #08
        MOV B,A
        LDA $23e4
        SUB B
o04ab:  JM jTILT2
        LDA GAME_STATE2
        ANI #40
o04b3:  JNZ jTILT2
        LDA STATE_OUTLANE_1
        ORI #fc
        STA STATE_OUTLANE_1
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
        OUT #00
        OUT #01
        OUT #02
        OUT #03
        OUT #04
        OUT DIP_SWITCH_PORT
        OUT #06
        OUT #07
        OUT #08
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
o050c:  CALL co1d81
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
o052e:  CALL cSET_ATH_BIT_OF_HL
        MVI A, #01
        STA $2214
        MVI A, #28
        STA $221b
        MVI A, #02
        STA $219d
o0540:  JMP jo0382
jTILT2: LXI H, #12c2 ;o04ab,o04b3
o0546:  CALL cPLAY_SOUND_2
o0549:  JMP jo0382
        LDA $221b
        DCR A
        STA $221b
o0553:  JZ j0569
        MVI A, #14
        STA $219d
        MVI A, #fa
        STA $219e
        LXI H, #12bf
o0563:  CALL cPLAY_SOUND_2
o0566:  JMP joEND_MAIN_LOOP
j0569:  LDA $2247 ;o0553
        ANI #bf
        STA $2247
        MVI A, #01
        STA $21a0
        STA $221c
        LDA STATE_OUTLANE_1
        ANI #33
        STA STATE_OUTLANE_1
o0581:  JMP joEND_MAIN_LOOP
; tilt handler 2
        IN PRICE_89_CAB
        ANI #80
o0588:  JMP j05a2
o058b:  CALL c046a
o058e:  JNZ j05a2
        CALL $044f
        MVI A, #7d
        STA $21a2
        LXI H, #12c2
o059c:  CALL cPLAY_SOUND_2
o059f:  JMP joEND_MAIN_LOOP
j05a2:  LDA STATE_OUTLANE_1 ;o0588,o058e
        ANI #77
        STA STATE_OUTLANE_1
o05aa:  JMP joEND_MAIN_LOOP
        LXI H, GAME_STATE2
        MVI A, #07
o05b2:  CALL cCHECK_ATH_BIT_OF_HL
o05b5:  JZ joEND_MAIN_LOOP
        LDA $23b6
        ANI #ef
        STA $23b6
        MVI A, #f0
        STA $23a0
        STA $2380
        MVI A, #ff
        STA $23a1
        STA $2381
        STA $23a2
        STA $2382
o05d6:  JMP joEND_MAIN_LOOP
; when no switches activated?
        LXI H, #2197
        MVI C, #1a
j05de:  MVI A, #ff ;o05ea
        ADD M
o05e1:  JNC j05e8
        MOV M,A
o05e5:  JZ j0609
j05e8:  INX H ;o05e1,o0621
        DCR C
o05ea:  JNZ j05de
        LDA $2198
        ORA A
o05f1:  JNZ j05f6
        MVI A, #01
j05f6:  ANI #3f ;o05f1
        STA $2198
        LDA $2247
        ANI #40
o0600:  CZ c0636
        MVI A, #00
        DI
o0606:  JMP j0376
j0609:  DI ;o05e5
o060a:  CALL cSAVE_BDPSW
        MVI A, #1a
        SUB C
        ADD A
        LXI D, #0000
        MOV E,A
        LXI H, #072c
        DAD D
        MOV A,M
        INX H
        MOV H,M
        MOV L,A
        PCHL
joEND_MAIN_LOOP:
              CALL cRESTORE_BDPSW ;o0566,o0581,o059f,o05aa,o05b5,o05d6,o071e,o0729,o07e8,o07f0,o07fb,o0803,o0883,o088e,o08a1,o08c8,o08da,o08f1,o0906,o0940,o094b,o095e,o0a6d,o0a90,o0aa9,o0abb,o0ae9,o0b4f,o0ba7,o0bb7,o0cc1,o0cf6,o0d26,o0de9,o121f,o123e,o1252,o125e,o14f7,o152b,o18e7,o1911,o1a37,o1a6e,o1a87,o1ad4,o1aec,jo1ba5,o1d73
o0621:  JMP j05e8
; push A, SP, B, D, H
cSAVE_BDPSW:
              SHLD STACK_SCRATCH ;jo0330,o035a,joSWITCH_HANDLER,o060a,o1406
        XTHL
        PUSH B
        PUSH D
        PUSH PSW
        PUSH H
        LHLD STACK_SCRATCH
        RET

; restore A, SP, B, D, H
cRESTORE_BDPSW:
              POP H ;o0365,jo0382,joEND_MAIN_LOOP,jo1419
        POP PSW
        POP D
        POP B
        XTHL
        RET

c0636:  LXI H, #21f8 ;o0600
        DCR M
o063a:  JNZ j0647
        MVI M, #14
        LDA $2247
        ADI #80
        STA $2247
j0647:  LDA $2247 ;o063a
        ANI #80
o064c:  JZ j067b
        LXI H, #23a0
        LXI D, #23c0
        MVI A, #40
o0657:  CALL cCOPY_FROM_HL_TO_DE
        LDA $21c9
        CMA
        OUT #00
        LDA $21ca
        CMA
        OUT #01
        LDA $21cb
        CMA
        OUT #02
        LDA $21cc
        CMA
        OUT #03
        LDA $21cd
        CMA
        OUT #04
o0678:  JMP j06a4
j067b:  LXI H, #2380 ;o064c
        LXI D, #23c0
        MVI A, #40
o0683:  CALL cCOPY_FROM_HL_TO_DE
        LDA $21ce
        CMA
        OUT #00
        LDA $21cf
        CMA
        OUT #01
        LDA $21d0
        CMA
        OUT #02
        LDA $21d1
        CMA
        OUT #03
        LDA $21d2
        CMA
        OUT #04
; check credit button
j06a4:  IN PRICE_89_CAB ;o0678
        ANI #10
o06a8:  JNZ jcCREDIT_HANDLER
        LDA GAME_STATE2
        ORI #20
        STA GAME_STATE2
        RET

jcCREDIT_HANDLER:
              LXI H, GAME_STATE2 ;o0003,o06a8
        MVI A, #05
o06b9:  CALL cCHECK_ATH_BIT_OF_HL
        RZ
o06bd:  CALL cCLEAR_ATH_BIT_OF_HL
        LDA CREDITS_1
        CPI #99
        RZ
        LXI H, #21c5
        MVI A, #03
o06cb:  CALL cSET_ATH_BIT_OF_HL
        MVI A, #09
        STA $21ab
c06d3:  MVI A, #06 ;jo1a71
        LXI H, #2376
o06d8:  CALL cCLEAR_ATH_BIT_OF_HL
        LXI H, #2396
o06de:  CALL cCLEAR_ATH_BIT_OF_HL
        LXI H, #23b6
o06e4:  CALL cCLEAR_ATH_BIT_OF_HL
        MVI B, #00
o06e9:  CALL co1d81
        LDA CREDITS_1
        INR A
        DAA
        STA CREDITS_1
        STA CREDITS_2
        STA CREDITS_3
        LXI H, #1341
o06fd:  CALL cPLAY_SOUND_2
        LXI H, #224a
        DCR M
        RNZ
        MVI M, #64
o0707:  CALL c1faa
        RET

        LXI H, #21c5
        MVI A, #03
o0710:  CALL cCHECK_ATH_BIT_OF_HL
o0713:  JZ j0721
o0716:  CALL cCLEAR_ATH_BIT_OF_HL
        MVI A, #09
        STA $21ab
o071e:  JMP joEND_MAIN_LOOP
j0721:  LDA STATE_OUTLANE_1 ;o0713
        ANI #bb
        STA STATE_OUTLANE_1
o0729:  JMP joEND_MAIN_LOOP
        XRA D
        DCX B
        MVI B, #12
        ACI #07
        MVI E, #06
        LHLD $700a
        LDAX B
        MOV C,H
        DCR B
        XRA L
        DCR B
        ANA H
        (DSUB)
        STAX B
        DAD D
        RST 2
        LDAX D
        DB #84
        DB #05
        MOV H,D
        LDAX D
        PUSH D
        INR D
        CMP M
        LDAX B
        ADC A
        DCX B
        XRA M
        INR C
        MOV M,B
        (DSUB)
        DCR L
        DAD B
        MVI E, #06
        DCX B
        RLC
        MOV H,M
        DCR E
        DI
        RLC
        CALL $9d18
        DCR C
        MVI E, #06
        LXI D, #0000
o0763:  JMP j078f
        LXI D, #0001
o0769:  JMP j078f
        LXI D, #0002
o076f:  JMP j078f
        LXI D, #0003
o0775:  JMP j078f
        LXI D, #0004
o077b:  JMP j078f
        LXI D, #0005
o0781:  JMP j078f
        LDA $2191
        ORI #20
        STA $2191
o078c:  JMP jo0382
j078f:  LXI H, #0806 ;o0763,o0769,o076f,o0775,o077b,o0781
        DAD D
        MOV A,M
        XCHG
        DAD H
        XCHG
        LXI H, #080d
        DAD D
        MOV B,M
        INX H
        MOV H,M
        MOV L,B
o079f:  CALL cSET_ATH_BIT_OF_HL
        MVI A, #09
        STA $2199
        LDA $21c3
        CMA
        OUT #06
        LDA $21c4
        CMA
        OUT #07
        LXI H, #081b
        DAD D
        MOV B,M
        INX H
        MOV H,M
        MOV L,B
        PUSH D
o07bc:  CALL cPLAY_SOUND_2
        POP D
        LXI H, #0829
        DAD D
        MOV B,M
        INX H
        MOV H,M
        MOV L,B
o07c8:  CALL cADD_BONUS_HL
o07cb:  JMP jo0382
        LDA $21c3
        ANI #30
        STA $21c3
        CMA
        OUT #06
        LDA $21c4
        ANI #20
        STA $21c4
        CMA
        OUT #07
        LDA $21ad
        ORA A
o07e8:  JNZ joEND_MAIN_LOOP
        MVI A, #06
        STA $21ad
o07f0:  JMP joEND_MAIN_LOOP
        LXI H, GAME_STATE
        MVI A, #02
o07f8:  CALL cCHECK_ATH_BIT_OF_HL
o07fb:  JNZ joEND_MAIN_LOOP
        MVI A, #80
        STA $2193
o0803:  JMP joEND_MAIN_LOOP
        INX B
        NOP
        LXI B, #0302
        INR B
        STAX B
        JMP $c421
        LXI H, #21c4
        JMP $c421
        LXI H, #21c4
        CNZ $ad21
        STAX D
        ORA B
        STAX D
        ORA E
        STAX D
        ORA M
        STAX D
        CMP C
        STAX D
        CMP H
        STAX D
        CMP A
        STAX D
        MOV D,L
        LXI D, #1159
        MOV E,L
        LXI D, #1151
        MOV C,L
        LXI D, #114d
        MOV C,C
        LXI D, #c33a
        LXI H, #10f6
        STA $21c3
        CMA
        OUT #06
        MVI A, #09
        STA $21a8
        LXI H, GAME_STATE
        MVI A, #05
o084c:  CALL cCHECK_ATH_BIT_OF_HL
o084f:  JNZ jo0382
        LXI H, #134e
o0855:  CALL cPLAY_SOUND_2
        MVI A, #04
        STA $2222
        LXI H, #2191
        MVI A, #00
o0862:  CALL cCHECK_ATH_BIT_OF_HL
o0865:  JZ jo0382
        MVI A, #7d
        STA $219f
o086d:  JMP jo0382
        LXI H, #21c3
        MVI A, #04
o0875:  CALL cCHECK_ATH_BIT_OF_HL
o0878:  JNZ j0891
        LXI H, GAME_STATE
        MVI A, #02
o0880:  CALL cCHECK_ATH_BIT_OF_HL
o0883:  JNZ joEND_MAIN_LOOP
        MVI A, #04
        LXI H, STATE_OUTLANE_1
o088b:  CALL cCLEAR_ATH_BIT_OF_HL
o088e:  JMP joEND_MAIN_LOOP
j0891:  LDA $21c3 ;o0878
        ANI #2f
        STA $21c3
        CMA
        OUT #06
        MVI A, #06
        STA $21a8
o08a1:  JMP joEND_MAIN_LOOP
        LDA $2191
        ANI #01
o08a9:  JZ j08bc
        LDA $21c3
        ORI #30
        STA $21c3
        MVI A, #09
        STA $21a8
        STA $21a9
j08bc:  MVI A, #71 ;o08a9
        STA $219f
        LDA $221f
        DCR A
        STA $221f
o08c8:  JNZ joEND_MAIN_LOOP
        MVI A, #3c
        STA $221f
        LDA $2220
        INR A
        DAA
        STA $2220
        CPI #60
o08da:  JNZ joEND_MAIN_LOOP
        MVI A, #00
        STA $2220
        LDA $2221
        INR A
        DAA
        STA $2221
        LDA $2222
        DCR A
        STA $2222
o08f1:  JNZ joEND_MAIN_LOOP
o08f4:  CALL c1faa
        MVI A, #64
        STA $224a
        MVI A, #04
        STA $2222
        MVI A, #00
        STA $219f
o0906:  JMP joEND_MAIN_LOOP
        LDA $21c3
        ORI #20
        STA $21c3
        CMA
        OUT #06
        MVI A, #09
        STA $21a9
        LXI H, GAME_STATE
        MVI A, #05
o091e:  CALL cCHECK_ATH_BIT_OF_HL
o0921:  JNZ jo0382
        LXI H, #134e
o0927:  CALL cPLAY_SOUND_2
o092a:  JMP jo0382
        LXI H, #21c3
        MVI A, #05
o0932:  CALL cCHECK_ATH_BIT_OF_HL
o0935:  JNZ j094e
        LXI H, GAME_STATE
        MVI A, #02
o093d:  CALL cCHECK_ATH_BIT_OF_HL
o0940:  JNZ joEND_MAIN_LOOP
        LXI H, STATE_OUTLANE_1
        MVI A, #05
o0948:  CALL cCLEAR_ATH_BIT_OF_HL
o094b:  JMP joEND_MAIN_LOOP
j094e:  LDA $21c3 ;o0935
        ANI #1f
        STA $21c3
        CMA
        OUT #06
        MVI A, #06
        STA $21a9
o095e:  JMP joEND_MAIN_LOOP
        MVI B, #24
        MVI C, #00
o0965:  JMP j0999
        MVI B, #03
        MVI C, #01
o096c:  JMP j0999
        MVI B, #0b
        MVI C, #02
o0973:  JMP j0999
        MVI B, #13
        MVI C, #03
o097a:  JMP j0999
        MVI B, #29
        MVI C, #04
o0981:  JMP j0999
        MVI A, #04
        STA $2197
        LXI H, #2208
        MVI A, #ff
        ADD M
o098f:  JNC j09ae
        MOV M,A
o0993:  JZ j0bdf
o0996:  JMP jo1419
j0999:  LXI H, #2208 ;o0965,o096c,o0973,o097a,o0981
        MVI A, #ff
        ADD M
o099f:  JNC j09ae
        MOV M,A
o09a3:  JZ j09bb
        MVI A, #04
        STA $2197
o09ab:  JMP jo1419
j09ae:  MVI A, #64 ;o098f,o099f
        STA $2208
        MVI A, #04
        STA $2197
o09b8:  JMP jo1419
j09bb:  LXI H, GAME_STATE ;o09a3
        MVI A, #07
o09c0:  CALL cSET_ATH_BIT_OF_HL
        MVI A, #02
o09c5:  CALL cCHECK_ATH_BIT_OF_HL
o09c8:  JZ jo09da
        MOV A,C
o09cc:  CALL c0b6f
o09cf:  CALL cSET_ATH_BIT_OF_HL
        MVI A, #06
        STA $21a6
o09d7:  JMP jo1419
jo09da: CALL co1d81 ;o09c8
        MOV A,C
        LXI H, #21c7
o09e1:  CALL cCHECK_ATH_BIT_OF_HL
o09e4:  JZ jo0b52
o09e7:  CALL cCLEAR_ATH_BIT_OF_HL
        LXI H, #2211
        CMP M
        LXI H, GAME_STATE2
        MVI A, #01
o09f3:  JNZ jo09fc
o09f6:  CALL cSET_ATH_BIT_OF_HL
o09f9:  JMP j09ff
jo09fc: CALL cCLEAR_ATH_BIT_OF_HL ;o09f3
j09ff:  MOV A,C ;o09f9
o0a00:  CALL c0b6f
o0a03:  CALL co1d9c
o0a06:  JZ jo0a14
        XCHG
        DAD D
o0a0b:  CALL cCHECK_ATH_BIT_OF_HL
        XCHG
        MVI A, #01
o0a11:  JZ j0a24
jo0a14: CALL co1d91 ;o0a06
        LXI H, #12e3
o0a1a:  CALL cPLAY_SOUND_2
        MVI A, #c8
        STA $2208
        MVI A, #5a
j0a24:  STA $219b ;o0a11
o0a27:  JMP jo1419
        LXI H, #0bd5
        LDA $21c8
        ADD A
        MVI D, #00
        MOV E,A
        DAD D
        MOV A,M
        INX H
        MOV H,M
        MOV L,A
o0a39:  CALL c0e5c
        LXI H, #12dd
o0a3f:  CALL cPLAY_SOUND_2
        LXI H, GAME_STATE2
        MVI A, #01
o0a47:  CALL cCHECK_ATH_BIT_OF_HL
o0a4a:  JZ j0a93
o0a4d:  CALL cCLEAR_ATH_BIT_OF_HL
        LXI H, #2191
        MVI A, #01
o0a55:  CALL cCHECK_ATH_BIT_OF_HL
o0a58:  JZ j0a93
o0a5b:  CALL cCLEAR_ATH_BIT_OF_HL
        MVI A, #fa
        STA $2208
        MVI A, #05
        STA $221a
        MVI A, #28
        STA $219c
o0a6d:  JMP joEND_MAIN_LOOP
        LXI H, #1171
o0a73:  CALL c0e5c
        LXI H, #1335
o0a79:  CALL cPLAY_SOUND_2
        LDA $221a
        DCR A
        STA $221a
o0a83:  JZ j0a93
        MVI A, #28
        STA $219c
        MVI A, #fa
        STA $2208
o0a90:  JMP joEND_MAIN_LOOP
j0a93:  LDA $21c7 ;o0a4a,o0a58,o0a83
        CPI #00
o0a98:  JZ j0aac
        LHLD $2209
        LDA $220b
o0aa1:  CALL cSET_ATH_BIT_OF_HL
        MVI A, #06
        STA $21a6
o0aa9:  JMP joEND_MAIN_LOOP
j0aac:  MVI A, #3c ;o0a98
        STA $21a5
        MVI A, #64
        STA $2208
        MVI A, #00
        STA $2207
o0abb:  JMP joEND_MAIN_LOOP
        SUB A
        STA $2208
        LDA $2207
        INR A
        STA $2207
        CPI #06
o0acb:  JZ j0aec
        MVI D, #00
        MOV E,A
        LXI H, #0bb9
        DAD D
        MOV B,M
o0ad6:  CALL co1d76
        LXI H, #12dd
o0adc:  CALL cPLAY_SOUND_2
        MVI A, #0f
        STA $21a5
        MVI A, #64
        STA $2208
o0ae9:  JMP joEND_MAIN_LOOP
j0aec:  LHLD $2209 ;o0acb
        LDA $220b
o0af2:  CALL cSET_ATH_BIT_OF_HL
        MVI A, #06
        STA $21a6
        MVI A, #1f
        STA $21c7
        LDA $2246
        ADD A
        ADD A
        ADD A
        ADD A
        MOV B,A
        LDA $23be
        ANA B
o0b0b:  JNZ j0b26
        LXI H, GAME_STATE
        MVI A, #03
o0b13:  CALL cCHECK_ATH_BIT_OF_HL
o0b16:  JNZ j0b26
        MVI B, #31
o0b1b:  CALL co1d9c
o0b1e:  JNZ j0b26
        MVI B, #09
o0b23:  CALL co1d76
j0b26:  LDA $21c8 ;o0b0b,o0b16,o0b1e
        INR A
        CPI #05
o0b2c:  JZ j0b44
        STA $21c8
        MVI D, #00
        MOV E,A
        LXI H, #0bbe
        DAD D
        MOV B,M
        PUSH H
o0b3b:  CALL co1d76
        POP H
        DCX H
        MOV B,M
o0b41:  CALL co1d81
j0b44:  LXI H, #2191 ;o0b2c
        MVI A, #01
o0b49:  CALL cCHECK_ATH_BIT_OF_HL
o0b4c:  CNZ c0402
o0b4f:  JMP joEND_MAIN_LOOP
jo0b52: CALL c0b6f ;o09e4
o0b55:  CALL cSET_ATH_BIT_OF_HL
        MVI A, #06
        STA $21a6
o0b5d:  CALL co1d9c
o0b60:  JNZ jo1419
o0b63:  CALL co1d76
        LXI H, #12e0
o0b69:  CALL cPLAY_SOUND_2
o0b6c:  JMP jo1419
c0b6f:  MVI D, #00 ;o09cc,o0a00,jo0b52
        MOV E,A
        LXI H, #0bc3
        DAD D
        MOV B,M
        LXI H, #0bc8
        DAD D
        ADD A
        MOV E,A
        MOV A,M
        STA $220b
        MOV C,A
        LXI H, #0bcd
        DAD D
        MOV A,M
        INX H
        MOV H,M
        MOV L,A
        SHLD $2209
        MOV A,C
        RET

        MVI A, #00
        STA $21c2
        LDA $21c4
        ANI #1f
        STA $21c4
        CMA
        OUT #07
        LXI H, #21c5
        MVI A, #01
o0ba4:  CALL cCLEAR_ATH_BIT_OF_HL
o0ba7:  JMP joEND_MAIN_LOOP
        MVI A, #00
        STA $2208
        LXI H, GAME_STATE2
        MVI A, #03
o0bb4:  CALL cCLEAR_ATH_BIT_OF_HL
o0bb7:  JMP joEND_MAIN_LOOP
        INR H
        INX B
        DCX B
        INX D
        DAD H
        INX H
        INR E
        DCX D
        STAX D
        DCX H
        INR L
        INR B
        INR C
        INR D
        INX B
        DCR B
        STAX B
        NOP
        LXI B, #21c2
        CNZ $c221
        LXI H, #21c2
        JNZ $6921
        LXI D, #116d
        MOV M,L
        LXI D, #1179
j0bdf:  MVI B, #39 ;o0993
o0be1:  CALL co1d9c
o0be4:  JZ j0d4d
        LXI H, GAME_STATE
        MVI A, #02
o0bec:  CALL cCHECK_ATH_BIT_OF_HL
o0bef:  JNZ j0d4d
        LDA $220c
        ANI #03
o0bf7:  JNZ j0ca6
        LXI H, #235b
        LXI D, #220d
        MVI A, #06
o0c02:  CALL cCOPY_FROM_HL_TO_DE
        MVI B, #38
o0c07:  CALL co1d9c
o0c0a:  JZ j0c12
        MVI A, #03
o0c0f:  JMP j0c21
j0c12:  MVI B, #11 ;o0c0a
o0c14:  CALL co1d9c
o0c17:  JZ j0c1f
        MVI A, #02
o0c1c:  JMP j0c21
j0c1f:  MVI A, #01 ;o0c17
j0c21:  STA $220c ;o0c0f,o0c1c
        MVI B, #31
o0c26:  CALL co1d9c
o0c29:  JZ j0ca6
        MVI B, #31
o0c2e:  CALL co1d81
        MVI B, #09
o0c33:  CALL co1d81
        LXI H, #1321
o0c39:  CALL cPLAY_SOUND_2
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
o0c98:  CALL cSET_ATH_BIT_OF_HL
        LXI H, #23b6
o0c9e:  CALL cSET_ATH_BIT_OF_HL
        MVI A, #fa
o0ca3:  JMP j0ca8
j0ca6:  MVI A, #3c ;o0bf7,o0c29
j0ca8:  STA $21a7 ;o0ca3
o0cab:  JMP jo1419
        LDA $2349
        MOV B,A
        LDA $23ee
        SUB B
o0cb6:  JM j0cc4
        LDA STATE_OUTLANE_1
        ANI #fd
        STA STATE_OUTLANE_1
o0cc1:  JMP joEND_MAIN_LOOP
j0cc4:  MVI A, #00 ;o0cb6
        STA $2197
        LDA STATE_OUTLANE_1
        ORI #02
        STA STATE_OUTLANE_1
        LXI H, GAME_STATE
        MVI A, #00
o0cd6:  CALL cCHECK_ATH_BIT_OF_HL
o0cd9:  JNZ j0d29
        LXI H, #1165
o0cdf:  CALL c0e99
o0ce2:  JC j0cf9
        LXI H, #1165
o0ce8:  CALL cADD_BONUS_HL
        MVI A, #0a
        STA $21a7
        LXI H, #1332
o0cf3:  CALL cPLAY_SOUND_2
o0cf6:  JMP joEND_MAIN_LOOP
j0cf9:  LXI H, #1165 ;o0ce2
o0cfc:  CALL c0e5c
        LXI H, #235b
o0d02:  CALL c0f3c
        LXI H, #235b
o0d08:  CALL c0e99
        LXI H, #220c
        DCR M
o0d0f:  JZ j0d29
o0d12:  JM j0d29
        LXI H, #220d
o0d18:  CALL c0e6f
        MVI A, #3c
        STA $21a7
        LXI H, #1335
jo0d23: CALL cPLAY_SOUND_2 ;o0d4a
o0d26:  JMP joEND_MAIN_LOOP
j0d29:  LXI H, #21c5 ;o0cd9,o0d0f,o0d12
        MOV A,M
        ORI #02
        MOV M,A
        MVI A, #09
        STA $21a6
        MVI B, #39
o0d37:  CALL co1d81
        LDA STATE_OUTLANE_1
        ANI #fd
        STA STATE_OUTLANE_1
        MVI A, #00
        STA $220c
        LXI H, #1335
o0d4a:  JMP jo0d23
j0d4d:  LXI H, #21c5 ;o0be4,o0bef
        MVI A, #01
o0d52:  CALL cSET_ATH_BIT_OF_HL
        MVI A, #06
        STA $21a6
o0d5a:  JMP jo1419
        MVI A, #2b
o0d5f:  JMP j0d76
        MVI A, #2c
o0d64:  JMP j0d76
        MVI A, #04
o0d69:  JMP j0d76
        MVI A, #0c
o0d6e:  JMP j0d76
        MVI A, #14
o0d73:  JMP j0d76
j0d76:  STA $2226 ;o0d5f,o0d64,o0d69,o0d6e,o0d73
        LDA GAME_STATE
        ANI #04
o0d7e:  JNZ jo1419
        LDA $21af
        ORA A
o0d85:  JNZ j0d95
        LDA $2191
        ANI #df
        STA $2191
        MVI A, #80
        STA $2193
j0d95:  MVI A, #03 ;o0d85
        STA $21af
o0d9a:  JMP jo1419
        LDA $2191
        ANI #20
o0da2:  JZ j0de1
        LDA $21c4
        ORI #04
        STA $21c4
        MVI A, #09
        STA $2199
        LDA $2226
        MOV B,A
o0db6:  CALL co1d9c
o0db9:  JZ j0de1
o0dbc:  CALL co1d81
o0dbf:  JZ j0dd1
        LXI H, #1165
o0dc5:  CALL cADD_BONUS_HL
        LXI H, #12e0
o0dcb:  CALL cPLAY_SOUND_2
o0dce:  JMP j0de1
j0dd1:  LXI H, #1171 ;o0dbf
o0dd4:  CALL cADD_BONUS_HL
        XCHG
o0dd8:  CALL c0e5c
        LXI H, #12f2
o0dde:  CALL cPLAY_SOUND_2
j0de1:  LDA $2191 ;o0da2,o0db9,o0dce
        ANI #df
        STA $2191
o0de9:  JMP joEND_MAIN_LOOP
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

c0e5c:  LXI D, SPREAD_1 ;o0a39,o0a73,o0cfc,o0dd8,o154f,o15ef,o18ed
        MVI A, #08
o0e61:  CALL cCOPY_FROM_HL_TO_DE
        LXI H, #235b
        MVI A, #08
o0e69:  CALL c0dec
        LXI H, SPREAD_1
c0e6f:  LXI D, #235b ;o0d18,o18bc,o1af2
        MVI A, #08
o0e74:  CALL cCOPY_FROM_HL_TO_DE
        LXI H, #235b
        LXI D, #23a0
        MVI A, #06
o0e7f:  CALL cWRITE_TO_RAM
        LDA GAME_STATE
        ANI #01
        RNZ
        LXI H, #23a0
        LXI D, #2380
        MVI A, #06
o0e90:  CALL cCOPY_FROM_HL_TO_DE
        MVI B, #39
o0e95:  CALL co1d76
        RET

c0e99:  PUSH H ;o0cdf,o0d08,o18d0,o18f9
        LXI H, #235b
        LXI D, SPREAD_1
        MVI A, #08
o0ea2:  CALL cCOPY_FROM_HL_TO_DE
        POP H
        MVI A, #08
o0ea8:  CALL c0e18
        PUSH PSW
        LXI H, SPREAD_1
        LXI D, #235b
        MVI A, #08
o0eb4:  CALL cCOPY_FROM_HL_TO_DE
        LXI H, #235b
        LXI D, #2380
        MVI A, #06
o0ebf:  CALL cWRITE_TO_RAM
        LXI H, #2380
        LXI D, #23a0
        MVI A, #06
o0eca:  CALL cCOPY_FROM_HL_TO_DE
        POP PSW
        RET

cCOPY_FROM_HL_TO_DE:
              ORA A ;o00c8,o00d3,o019d,o01b0,o0657,o0683,o0c02,o0e61,o0e74,o0e90,o0ea2,o0eb4,o0eca,o0f41,o0f7d,o0f91,o0fa2,o0fc3,o0fdb,o0ffc,o1015,o1022,o1039,o104f,o1062,o10cb,o10d6,o112a,o1637,o16ba,o16c5,o1865,o18a6,o1a84,o1b09,o1b14,o1bf6,o1c01,o1c2b,o1c89,o1ca6,o1f40,o1f4e,o1f5a,o1f6a,o1f8a,o1f9b,o1fa5,o1fb3,o1fbd,o1fc7,o1fd0,o1fe6
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

cWRITE_TO_RAM:
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

c0f3c:  LXI D, SPREAD_1 ;o0278,o0d02,o1722,o172d,o18f3
        MVI A, #08
o0f41:  CALL cCOPY_FROM_HL_TO_DE
        LXI H, #237e
        MVI A, #04
o0f49:  CALL cCHECK_ATH_BIT_OF_HL
o0f4c:  JNZ j10dd
        INR A
o0f50:  CALL cCHECK_ATH_BIT_OF_HL
o0f53:  JNZ j10f4
        INR A
o0f57:  CALL cCHECK_ATH_BIT_OF_HL
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
o0f73:  CALL c0dec
        POP D
        PUSH D
        LXI H, SPREAD_1
        MVI A, #08
o0f7d:  CALL cCOPY_FROM_HL_TO_DE
        POP H
        POP D
        PUSH D
        MVI A, #06
o0f85:  CALL cWRITE_TO_RAM
        POP D
        PUSH D
        LXI H, #0020
        DAD D
        XCHG
        MVI A, #06
o0f91:  CALL cCOPY_FROM_HL_TO_DE
        POP D
        LDA $21f6
        ANI #0f
o0f9a:  JZ j0fa5
        LXI H, #1189
        MVI A, #06
o0fa2:  CALL cCOPY_FROM_HL_TO_DE
j0fa5:  LXI H, #237e ;o0f9a
        MVI A, #03
o0faa:  CALL cCHECK_ATH_BIT_OF_HL
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
o0fc3:  CALL cCOPY_FROM_HL_TO_DE
        LXI H, PL2_SCORE_1
        MVI A, #07
o0fcb:  CALL c0e18
        PUSH PSW
o0fcf:  CC c0ff4
        LXI H, SPREAD_1
        LXI D, PL1_SCORE_hrm
        PUSH D
        MVI A, #06
o0fdb:  CALL cCOPY_FROM_HL_TO_DE
        POP H
        PUSH H
        LXI D, SPREAD_4
        MVI A, #06
o0fe5:  CALL cWRITE_TO_RAM
        POP H
        LXI D, SPREAD_3
        MVI A, #06
o0fee:  CALL cWRITE_TO_RAM
o0ff1:  JMP j1052
c0ff4:  LXI H, PL2_SCORE_1 ;o0fcf
        LXI D, SPREAD_1
        MVI A, #07
o0ffc:  CALL cCOPY_FROM_HL_TO_DE
        LXI H, PL1_SCORE_1
        MVI A, #07
o1004:  CALL c0e18
        RET

j1008:  POP H ;o0fad
        MVI A, #08
o100b:  CALL c0dec
        LXI H, SPREAD_1
        POP D
        PUSH D
        MVI A, #07
o1015:  CALL cCOPY_FROM_HL_TO_DE
        POP H
        POP D
        LXI H, PL13_SCORE_1
        LXI D, SPREAD_1
        MVI A, #07
o1022:  CALL cCOPY_FROM_HL_TO_DE
        LXI H, PL24_SCORE_1
        MVI A, #07
o102a:  CALL c0e18
        PUSH PSW
o102e:  JC j1122
j1031:  LXI H, SPREAD_1 ;o1135
        LXI D, PL1_SCORE_hrm
        MVI A, #06
o1039:  CALL cCOPY_FROM_HL_TO_DE
        LXI H, PL1_SCORE_hrm
        LXI D, SPREAD_4
        MVI A, #06
o1044:  CALL cWRITE_TO_RAM
        LXI H, SPREAD_4
        LXI D, SPREAD_3
        MVI A, #06
o104f:  CALL cCOPY_FROM_HL_TO_DE
j1052:  LDA $21f6 ;o0ff1
        ANI #0f
o1057:  JZ j1065
        LXI H, #1189
        LXI D, SPREAD_4
        MVI A, #06
o1062:  CALL cCOPY_FROM_HL_TO_DE
j1065:  POP PSW ;o1057
o1066:  JZ j10b5
o1069:  JC j10a1
        LXI H, #236a
        MVI A, #04
o1071:  CALL cCHECK_ATH_BIT_OF_HL
o1074:  JZ jo1078
        RET

jo1078: CALL cSET_ATH_BIT_OF_HL ;o1074
        MVI A, #05
jo107d: CALL cCLEAR_ATH_BIT_OF_HL ;o10b2
        PUSH H
        PUSH B
        LXI H, #1316
o1085:  CALL cPLAY_SOUND_2
        LXI H, #21a7
        MOV A,M
        ORA A
o108d:  JZ j1092
        MVI M, #7d
j1092:  LXI H, #21ae ;o108d
        MOV A,M
        ORA A
o1097:  JZ j109c
        MVI M, #7d
j109c:  POP B ;o1097
        POP H
o109e:  JMP j1138
j10a1:  LXI H, #236a ;o1069
        MVI A, #05
o10a6:  CALL cCHECK_ATH_BIT_OF_HL
o10a9:  JZ jo10ad
        RET

jo10ad: CALL cSET_ATH_BIT_OF_HL ;o10a9
        MVI A, #04
o10b2:  JMP jo107d
j10b5:  LXI H, #236a ;o1066
        MVI A, #04
o10ba:  CALL cCLEAR_ATH_BIT_OF_HL
        MVI A, #05
o10bf:  CALL cCLEAR_ATH_BIT_OF_HL
        PUSH H
        LXI H, #1185
        LXI D, SPREAD_4
        MVI A, #06
o10cb:  CALL cCOPY_FROM_HL_TO_DE
        LXI H, #1185
        LXI D, SPREAD_3
        MVI A, #06
o10d6:  CALL cCOPY_FROM_HL_TO_DE
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
o112a:  CALL cCOPY_FROM_HL_TO_DE
        LXI H, PL13_SCORE_1
        MVI A, #07
o1132:  CALL c0e18
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

        DB #00
        DB #00
        DB #00
        DB #00
        DB #01,#00,#00
        DB #00
        DB #10
        DB #00
        DB #00
        DB #00
        DB #25
        DB #00
        DB #00
        DB #00
        DB #50
        DB #00
        DB #00
        DB #00
        DB #00
        DB #01,#00,#00
        DB #00
        DB #05
        DB #00
        DB #00
        DB #00
        DB #10
        DB #00
        DB #00
        DB #00
        DB #20
        DB #00
        DB #00
        DB #00
        DB #40
        DB #00
        DB #00
        DB #00
        DB #50
        DB #00
        DB #00
        DB #00
        DB #60
        DB #00
        DB #00
        DB #00
        DB #80
        DB #00
        DB #00
        DB #00
        DB #00
        DB #01,#00,#85
        DB #80
        DB #00
        DB #00
        DB #f0
        DB #ff
        DB #ff
        DB #ff
        DB #ff
        DB #ff
        DB #ff
        DB #ff
c118d:  MVI A, #ff ;o123b,o125b
        OUT TONE_ENABLE_DUR
        LXI D, #12ac
        MOV A,L
        SUB E
        MOV A,H
        SBB D
        RM
        LXI D, #137c
        MOV A,E
        SUB L
        MOV A,D
        SBB H
        RM
        MOV A,M
        CMA
        OUT TONE_PITCH
        INX H
        MOV A,M
        CMA
        OUT TONE_ENABLE_DUR
        CMA
        SHLD $21b1
        LXI D, #11fc
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
        STA $2198
        LXI H, GAME_STATE
        MVI A, #05
o11f8:  CALL cSET_ATH_BIT_OF_HL
        RET

        DCR C
        LDAX B
        MVI C, #0a
        (RLDE)
        RIM
        LDAX B
        DCR B
        STAX B
        STA $9021
        LXI H, #053e
o120b:  CALL cCHECK_ATH_BIT_OF_HL
o120e:  JNZ jo1222
        MVI A, #06
o1213:  CALL cSET_ATH_BIT_OF_HL
        MVI A, #fe
        OUT TONE_ENABLE_DUR
        MVI A, #02
        STA $2198
o121f:  JMP joEND_MAIN_LOOP
jo1222: CALL cCLEAR_ATH_BIT_OF_HL ;o120e
        MVI A, #06
o1227:  CALL cCHECK_ATH_BIT_OF_HL
o122a:  JNZ jo1255
        MVI A, #ff
        OUT TONE_ENABLE_DUR
        LHLD $21b1
        INX H
        MOV A,M
        CPI #ff
o1238:  JZ j1241
o123b:  CALL c118d
o123e:  JMP joEND_MAIN_LOOP
j1241:  LDA $21b3 ;o1238
        CPI #00
o1246:  JNZ jo1258
        MVI A, #ff
        OUT TONE_ENABLE_DUR
        MVI A, #0c
        STA $2198
o1252:  JMP joEND_MAIN_LOOP
jo1255: CALL cCLEAR_ATH_BIT_OF_HL ;o122a
jo1258: CALL c128c ;o1246
o125b:  CALL c118d
o125e:  JMP joEND_MAIN_LOOP
cPLAY_SOUND_2:
              XCHG ;o0546,o0563,o059c,o06fd,o07bc,o0855,o0927,o0a1a,o0a3f,o0a79,o0adc,o0b69,o0c39,o0cf3,jo0d23,o0dcb,o0dde,o1085,o14bd,o14ef,o1585,o15a6,o15d0,o15f5,o1786,o1859,o18c7,o18e4,o1a27,o1ae4,o1b72,o1f70
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
o127f:  CALL cCHECK_ATH_BIT_OF_HL
        RNZ
o1283:  CALL cSET_ATH_BIT_OF_HL
        MVI A, #01
        STA $2198
        RET

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

        RST 7
        JZ $ff08
        XRA D
        (DSUB)
        RST 7
        ADD A
        (DSUB)
        RST 7
        MOV H,L
        (DSUB)
        RST 7
        INR E
        INR C
        RST 7
        INR E
        INR C
        RST 7
        INR E
        NOP
        RST 7
        MOV B,E
        (DSUB)
        ADD A
        (DSUB)
        MOV B,E
        (DSUB)
        ADD A
        (DSUB)
        MOV B,E
        (DSUB)
        ADD A
        (DSUB)
        MOV B,E
        (DSUB)
        ADD A
        (DSUB)
        MOV B,E
        (DSUB)
        ADD A
        (DSUB)
        RST 7
        MOV D,L
        (DSUB)
        RST 7
        INR A
        (DSUB)
        RST 7
        DCX H
        (DSUB)
        RST 7
        SHLD $ff08
        SHLD $1e28
        INR C
        RST 7
        DCR D
        STAX B
        DCR D
        INR C
        RST 7
        MOV C,H
        (DSUB)
        MOV H,L
        INR C
        RST 7
        MOV A,B
        (LDHI) #50
        (LDHI) #78
        (LDHI) #50
        (LDHI) #78
        (LDHI) #50
        (LDHI) #ff
        MOV D,L
        (DSUB)
        MOV H,L
        (DSUB)
        MOV A,B
        (DSUB)
        MOV A,B
        NOP
        MOV D,L
        (DSUB)
        MOV H,L
        (DSUB)
        MOV A,B
        (DSUB)
        MOV A,B
        NOP
        MOV D,L
        (DSUB)
        MOV H,L
        (DSUB)
        MOV A,B
        (DSUB)
        RST 7
        MOV B,E
        RIM
        MOV B,E
        (DSUB)
        MOV D,L
        (DSUB)
        MOV H,L
        (DSUB)
        MOV M,D
        INR C
        RST 7
        MOV B,E
        INR B
        MOV B,E
        INR B
        MOV B,E
        NOP
        MOV B,E
        INR B
        MOV B,E
        INR B
        MOV B,E
        NOP
        MOV B,E
        INR B
        MOV B,E
        INR B
        RST 7
        ADI #08
        RST 7
        MOV C,H
        INR C
        RST 7
        JZ $ca08
        (DSUB)
        JZ $ca08
        INR C
        RST 7
        MOV A,B
        (LDHI) #65
        INR B
        RST 7
        ANA B
        INR L
        ANA B
        INR C
        RST 7
        DCR D
        INR C
        RST 7
        JZ $ff00
        MOV H,L
        INR C
        ADD A
        INR C
        XRA D
        INR C
        JZ $ca0c
        NOP
        JZ $ca08
        (DSUB)
        JZ $aa08
        NOP
        XRA D
        INR C
        XRA D
        NOP
        XRA D
        (DSUB)
        XRA D
        (DSUB)
        XRA D
        (DSUB)
        ADD A
        NOP
        ADD A
        INR C
        XRA D
        INR C
        ADD A
        INR C
        MOV H,L
        INR C
        MOV H,L
        RIM
        MOV H,L
        RIM
        RST 7
        CPI #21
        SUB C
        LXI H, #033e
o1382:  CALL cCLEAR_ATH_BIT_OF_HL
        OUT LAMP_3
        LXI H, #23e0
        LXI D, #233b
j138d:  MOV B,M ;o13aa
        LDAX D
        ADI #04
        SUB B
o1392:  JP j1397
        CMA
        INR A
j1397:  CPI #03 ;o1392
o1399:  JC j13a4
        LDA $2191
        ORI #08
        STA $2191
j13a4:  MOV A,B ;o1399
        SUI #04
        STAX D
        INX D
        INR L
o13aa:  JNZ j138d
        LDA $2191
        ANI #08
        JNZ $137d
o13b5:  CALL c0303
        SHLD $2224
        RET

        LXI H, #2191
        MVI A, #06
o13c1:  CALL cSET_ATH_BIT_OF_HL
        LXI H, #23e0
        LXI D, #233b
j13ca:  LDAX D ;o13d1
        SUB M
o13cc:  JP j13ea
j13cf:  INX D ;jo141c
        INR L
o13d1:  JNZ j13ca
        LXI H, #2191
        MVI A, #06
o13d9:  CALL cCHECK_ATH_BIT_OF_HL
o13dc:  JZ j13e4
        MVI A, #07
o13e1:  CALL cCLEAR_ATH_BIT_OF_HL
j13e4:  MVI A, #01 ;o13dc
        DI
o13e7:  JMP j0376
j13ea:  DI ;o13cc
        PUSH H
        LXI H, #2191
        MVI A, #06
o13f1:  CALL cCLEAR_ATH_BIT_OF_HL
        INR A
o13f5:  CALL cCHECK_ATH_BIT_OF_HL
o13f8:  JNZ jo1402
o13fb:  CALL cSET_ATH_BIT_OF_HL
        POP H
o13ff:  JMP jo141c
jo1402: CALL cCLEAR_ATH_BIT_OF_HL ;o13f8
        POP H
o1406:  CALL cSAVE_BDPSW
        MOV A,L
        SUI #e0
        MOV L,A
        MVI H, #00
        DAD H
        LXI D, #141f
        DAD D
        MOV A,M
        INX H
        MOV H,M
        MOV L,A
        PCHL
jo1419: CALL cRESTORE_BDPSW ;o0996,o09ab,o09b8,o09d7,o0a27,o0b60,o0b6c,o0cab,o0d5a,o0d7e,o0d9a,o14a1,o14ab,o14c5,o14d2,o153e,o1549,o15a9,o15c1,o15d3,o15de,o15e6,o15f8,o1810,o1820,o1828,o1886,o18ca
jo141c: JMP j13cf ;o13ff
        SUI #15
        DAD D
        INR D
        DAD D
        INR D
        DAD D
        INR D
        DAD D
        INR D
        DAD D
        INR D
        DAD D
        INR D
        DAD D
        INR D
        XRA H
        DCR D
        MOV H,M
        INR D
        MOV L,L
        INR D
        ADD D
        INR D
        MOV M,H
        INR D
        MOV A,E
        INR D
        ADD H
        DAD B
        MVI M, #15
        ADC C
        INR D
        SUB B
        INR D
        MOV A,L
        DAD B
        MOV E,A
        INR D
        HLT
        DAD B
        MOV H,A
        DCR C
        MOV L,H
        DCR C
        MOV M,C
        DCR C
        (DSUB)
        (RLDE)
        MOV L,A
        DAD B
        MOV H,D
        DCR C
        MOV L,B
        DAD B
        MOV E,L
        DCR C
        MOV H,C
        DAD B
        DB #ac
        DB #15
        DB #d6,#15
        MVI C, #00
        MVI B, #02
o1463:  JMP j1494
        MVI C, #01
        MVI B, #2a
o146a:  JMP j1494
        MVI C, #02
        MVI B, #10
o1471:  JMP j1494
        MVI C, #03
        MVI B, #1a
o1478:  JMP j1494
        MVI C, #04
        MVI B, #01
o147f:  JMP j1494
        MVI C, #05
        MVI B, #19
o1486:  JMP j1494
        MVI C, #06
        MVI B, #21
o148d:  JMP j1494
        MVI C, #07
        MVI B, #0a
j1494:  LXI H, GAME_STATE ;o1463,o146a,o1471,o1478,o147f,o1486,o148d
        MVI A, #07
o1499:  CALL cSET_ATH_BIT_OF_HL
        MVI A, #02
o149e:  CALL cCHECK_ATH_BIT_OF_HL
o14a1:  JNZ jo1419
        MOV A,C
        LXI H, #21c6
o14a8:  CALL cCHECK_ATH_BIT_OF_HL
o14ab:  JZ jo1419
o14ae:  CALL cCLEAR_ATH_BIT_OF_HL
o14b1:  CALL co1d81
        LXI H, #1161
o14b7:  CALL cADD_BONUS_HL
        LXI H, #12d7
o14bd:  CALL cPLAY_SOUND_2
        LDA $21c6
        CPI #00
o14c5:  JNZ jo1419
        MVI A, #3d
        STA $21a4
        MVI A, #00
        STA $2205
o14d2:  JMP jo1419
        LDA $2205
        INR A
        STA $2205
        CPI #09
o14de:  JZ j14fa
        MVI D, #00
        MOV E,A
        LXI H, #152d
        DAD D
        MOV B,M
o14e9:  CALL co1d76
        LXI H, #12d7
o14ef:  CALL cPLAY_SOUND_2
        MVI A, #0a
        STA $21a4
o14f7:  JMP joEND_MAIN_LOOP
j14fa:  MVI A, #00 ;o14de
        STA $220c
        MVI B, #11
o1501:  CALL co1d9c
o1504:  JNZ jo1517
        MVI B, #38
o1509:  CALL co1d9c
o150c:  JNZ j1522
        MVI B, #11
o1511:  CALL co1d76
o1514:  JMP j1522
jo1517: CALL co1d81 ;o1504
        MVI B, #38
o151c:  CALL co1d76
o151f:  JMP j1522
j1522:  MVI A, #ff ;o150c,o1514,o151f
        STA $21c6
        SUB A
        STA $2205
o152b:  JMP joEND_MAIN_LOOP
        STAX B
        LHLD $1a10
        LXI B, #2119
        LDAX B
; 10,000 / EB lane
        LXI H, GAME_STATE
        MVI A, #07
o153b:  CALL cCHECK_ATH_BIT_OF_HL
o153e:  JZ jo1419
o1541:  CALL cCLEAR_ATH_BIT_OF_HL
        MVI A, #02
o1546:  CALL cCHECK_ATH_BIT_OF_HL
o1549:  JNZ jo1419
        LXI H, #117d
o154f:  CALL c0e5c
        LXI H, GAME_STATE
        MVI A, #04
o1557:  CALL cCHECK_ATH_BIT_OF_HL
o155a:  JZ j1588
        LXI H, #2191
        MVI A, #01
o1562:  CALL cCHECK_ATH_BIT_OF_HL
o1565:  JNZ j1588
o1568:  CALL cSET_ATH_BIT_OF_HL
        LDA $21c7
        MVI B, #ff
j1570:  INR B ;o1572
        RAR
o1572:  JNC j1570
        MOV A,B
        DCR A
o1577:  JP j157c
        MVI A, #04
j157c:  STA $2211 ;o1577
o157f:  CALL c0402
        LXI H, #1338
o1585:  CALL cPLAY_SOUND_2
j1588:  LXI H, GAME_STATE ;o155a,o1565
        MVI A, #03
o158d:  CALL cCHECK_ATH_BIT_OF_HL
o1590:  JNZ j15a3
        MVI B, #09
o1595:  CALL co1d9c
o1598:  JZ j15a3
o159b:  CALL co1d81
        MVI B, #31
o15a0:  CALL co1d91
j15a3:  LXI H, #12ed ;o1590,o1598
o15a6:  CALL cPLAY_SOUND_2
o15a9:  JMP jo1419
; outlane handler
        MVI A, #ff
        STA $2193
        LDA STATE_OUTLANE_1
        ORI #30
        STA STATE_OUTLANE_1
; don't let outlane scrore > 1x
        LXI H, GAME_STATE
        MVI A, #02
o15be:  CALL cCHECK_ATH_BIT_OF_HL
o15c1:  JNZ jo1419
o15c4:  CALL cSET_ATH_BIT_OF_HL
        LXI H, #1165
o15ca:  CALL cADD_BONUS_HL
        LXI H, #134b
o15d0:  CALL cPLAY_SOUND_2
o15d3:  JMP jo1419
; inlane routine
        LXI H, GAME_STATE
        MVI A, #02
o15db:  CALL cCHECK_ATH_BIT_OF_HL
o15de:  JNZ jo1419
        MVI A, #07
o15e3:  CALL cCHECK_ATH_BIT_OF_HL
o15e6:  JZ jo1419
o15e9:  CALL cCLEAR_ATH_BIT_OF_HL
        LXI H, #1165
o15ef:  CALL c0e5c
        LXI H, #1335
o15f5:  CALL cPLAY_SOUND_2
o15f8:  JMP jo1419
        LXI H, GAME_STATE2
        MVI A, #00
o1600:  CALL cCHECK_ATH_BIT_OF_HL
o1603:  JNZ j1789
o1606:  CALL c0009
; check if credits
        ORA A
o160a:  JNZ j1620
        LDA $239e
        ANI #08
o1612:  JNZ j1789
        LDA $23b6
        ORI #40
        STA $23b6
o161d:  JMP j1789
j1620:  LDA BALL_IN_PLAY_hrm ;o160a
        ANI #0f
        CPI #01
o1627:  JZ j16ed
        CPI #00
o162c:  JZ j16ed
        LXI H, #23a3
        LXI D, #2320
        MVI A, #2e
o1637:  CALL cCOPY_FROM_HL_TO_DE
o163a:  CALL c17a8
        LXI H, GAME_STATE2
        MVI A, #04
o1642:  CALL cCHECK_ATH_BIT_OF_HL
o1645:  JZ j1655
        MVI A, #07
o164a:  CALL cCHECK_ATH_BIT_OF_HL
o164d:  JZ j1655
        MVI A, #01
o1652:  JMP j1671
j1655:  MVI A, #06 ;o1645,o164d
o1657:  CALL cSET_ATH_BIT_OF_HL
        LDA GAME_STATE
        ORI #05
        STA GAME_STATE
        MVI A, #ff
        STA $2193
        LDA STATE_OUTLANE_1
        ORI #30
        STA STATE_OUTLANE_1
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
        STA $2380
        STA $23a0
        MVI A, #00
        STA $2214
        LXI D, #21d3
        MVI B, #04
o169f:  CALL jc178e
        LXI H, GAME_STATE2
        MVI A, #06
o16a7:  CALL cCLEAR_ATH_BIT_OF_HL
        LDA $23b6
        ANI #7f
        STA $23b6
        LXI H, #21d3
        LXI D, #21c6
        MVI A, #10
o16ba:  CALL cCOPY_FROM_HL_TO_DE
        LXI H, #21c9
        LXI D, #21ce
        MVI A, #0a
o16c5:  CALL cCOPY_FROM_HL_TO_DE
        LDA GAME_STATE
        ANI #e7
        STA GAME_STATE
jDECREASE_CREDIT:
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
o16f2:  JNZ j1789
        MVI A, #01
        LXI H, #237e
o16fa:  CALL cCHECK_ATH_BIT_OF_HL
o16fd:  JZ jo1738
        MVI A, #02
o1702:  CALL cCHECK_ATH_BIT_OF_HL
o1705:  JZ jo174e
        MVI A, #03
o170a:  CALL cSET_ATH_BIT_OF_HL
        MVI A, #f0
        STA PL4_SCORE_2
        STA PL4_SCORE_3
        DI
        LDA $237e
        PUSH PSW
        MVI A, #1f
        STA $237e
        LXI H, #1149
o1722:  CALL c0f3c
        MVI A, #2f
        STA $237e
        LXI H, #1149
o172d:  CALL c0f3c
        POP PSW
        STA $237e
        EI
o1735:  JMP jDECREASE_CREDIT
jo1738: CALL cSET_ATH_BIT_OF_HL ;o16fd
        MVI A, #f0
        STA PL2_SCORE_2
        STA PL2_SCORE_3
        MVI A, #f0
        STA SPREAD_4
        STA SPREAD_3
o174b:  JMP jDECREASE_CREDIT
jo174e: CALL cSET_ATH_BIT_OF_HL ;o1705
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
o176d:  JMP jDECREASE_CREDIT
        LDA $237e
        STA $23be
        ANI #0f
        MOV B,A
        LDA $239e
        ORA B
        STA $239e
o1780:  JMP jDECREASE_CREDIT
j1783:  LXI H, #12da ;o16ea
o1786:  CALL cPLAY_SOUND_2
j1789:  MVI A, #06 ;o1603,o1612,o161d,o16f2
o178b:  JMP j0376
jc178e: LXI H, #17a0 ;o01a5,o169f,o179c
        MVI C, #08
j1793:  MOV A,M ;o1798
        STAX D
        INX D
        INX H
        DCR C
o1798:  JNZ j1793
        DCR B
o179c:  JNZ jc178e
        RET

        DB #ff
        DB #1f
        DB #01,#04,#39
        DB #2b
        DB #37
        DB #37
c17a8:  LXI H, #235b ;jo0168,o163a
        MVI A, #00
        MVI D, #1f
j17af:  MOV M,A ;o17b2
        INX H
        DCR D
o17b2:  JNZ j17af
        STA $2246
        LXI H, #2380
        MVI A, #ff
        MVI D, #1a
j17bf:  MOV M,A ;o17c2
        INX H
        DCR D
o17c2:  JNZ j17bf
        LXI H, #23a0
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

c17ea:  LDA $237e ;o1880,o18fc
        ANI #02
        MVI A, #20
        RZ
        LXI H, GAME_STATE
        MVI A, #03
o17f7:  CALL cCHECK_ATH_BIT_OF_HL
        MVI A, #20
        RNZ
        LDA $2214
        CPI #01
        MVI A, #20
        RZ
        MVI A, #80
        RET

        LXI H, GAME_STATE2
        MVI A, #04
o180d:  CALL cCHECK_ATH_BIT_OF_HL
o1810:  JNZ jo1419
        LXI H, #2208
        MVI A, #ff
        ADD M
o1819:  JNC j1823
        MOV M,A
o181d:  JZ j182b
o1820:  JMP jo1419
j1823:  MVI A, #32 ;o1819
        STA $2208
o1828:  JMP jo1419
j182b:  MVI A, #ff ;o181d
        STA $2193
        MVI A, #00
        STA $220c
        STA $21c3
        STA $21a8
        STA $21a9
        LDA STATE_OUTLANE_1
        ORI #30
        STA STATE_OUTLANE_1
        LXI H, GAME_STATE
        MVI A, #02
o184b:  CALL cSET_ATH_BIT_OF_HL
        LXI H, GAME_STATE2
        MVI A, #04
o1853:  CALL cSET_ATH_BIT_OF_HL
        LXI H, #12e8
o1859:  CALL cPLAY_SOUND_2
o185c:  CALL c1ba8
        XCHG
        LXI H, #21c6
        MVI A, #10
o1865:  CALL cCOPY_FROM_HL_TO_DE
        LXI H, GAME_STATE
        MVI A, #00
o186d:  CALL cCHECK_ATH_BIT_OF_HL
o1870:  JNZ j187b
        MVI B, #39
o1875:  CALL co1d9c
o1878:  JNZ j1889
j187b:  MVI A, #02 ;o1870
        STA $21a0
o1880:  CALL c17ea
        STA $221c
o1886:  JMP jo1419
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
o18a6:  CALL cCOPY_FROM_HL_TO_DE
        MVI A, #04
j18ab:  PUSH PSW ;o18b6
        LXI H, #220d
        MVI A, #06
o18b1:  CALL c0dec
        POP PSW
        DCR A
o18b6:  JNZ j18ab
        LXI H, SPREAD_1
o18bc:  CALL c0e6f
        MVI A, #3c
        STA $21ae
        LXI H, #1335
o18c7:  CALL cPLAY_SOUND_2
o18ca:  JMP jo1419
        LXI H, #1165
o18d0:  CALL c0e99
o18d3:  JC j18ea
        LXI H, #1165
o18d9:  CALL cADD_BONUS_HL
        MVI A, #0a
        STA $21ae
        LXI H, #1332
o18e4:  CALL cPLAY_SOUND_2
o18e7:  JMP joEND_MAIN_LOOP
j18ea:  LXI H, #1165 ;o18d3
o18ed:  CALL c0e5c
        LXI H, #235b
o18f3:  CALL c0f3c
        LXI H, #235b
o18f9:  CALL c0e99
o18fc:  CALL c17ea
        STA $221c
        LDA $221c
        DCR A
        STA $221c
o1909:  JZ j1914
        MVI A, #02
        STA $21a0
o1911:  JMP joEND_MAIN_LOOP
j1914:  MVI A, #01 ;o1909
        STA $2212
        MVI A, #32
        STA STATE_OUTLANE_1
        LXI H, GAME_STATE2
        MVI A, #03
o1923:  CALL cCLEAR_ATH_BIT_OF_HL
        LXI H, BALL_IN_PLAY_hrm
        LDA BALLS_PER_GAME
        SUB M
o192d:  JP j193b
o1930:  CALL c1a3a
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
jo1949: CALL cCHECK_ATH_BIT_OF_HL ;o1952
o194c:  JNZ jo1955
        INR A
        CPI #08
o1952:  JNZ jo1949
jo1955: CALL cCLEAR_ATH_BIT_OF_HL ;o194c
        INR A
        MOV C,A
        SUI #04
o195c:  CALL cCHECK_ATH_BIT_OF_HL
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
o199d:  CALL cCLEAR_ATH_BIT_OF_HL
        ADI #04
        XCHG
o19a3:  CALL cSET_ATH_BIT_OF_HL
o19a6:  CALL c1a3a
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
j19bf:  LXI H, #2191 ;o197f
        MVI A, #00
o19c4:  CALL cCHECK_ATH_BIT_OF_HL
        MVI A, #01
o19c9:  JNZ j1a8a
        LDA GAME_STATE2
        ORI #c0
        STA GAME_STATE2
o19d4:  CALL c1db7
        LXI H, #23b6
        MVI A, #07
o19dc:  CALL cSET_ATH_BIT_OF_HL
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
        STA $21a3
o1a21:  JMP j1a2a
j1a24:  LXI H, #12ff ;o1a14
o1a27:  CALL cPLAY_SOUND_2
j1a2a:  MVI A, #00 ;o1a21
        STA BALL_IN_PLAY_1
        STA BALL_IN_PLAY_2
        MVI A, #fa
        STA $219e
o1a37:  JMP joEND_MAIN_LOOP
c1a3a:  LXI H, #1a56 ;o1930,o19a6
        LDA $2245
        ADD A
        LXI B, #0000
        MOV C,A
        DAD B
        MOV E,M
        INX H
        MOV D,M
        LXI H, #1a5e
        MOV A,C
        RAR
        MOV C,A
        DAD B
        MOV B,M
        XCHG
        LXI D, #0020
        RET

        DB #8c
        DB #23
        DB #8b
        DB #23
        DB #8b
        DB #23
        DB #8a
        DB #23
        DB #0f
        DB #f0
        DB #0f
        DB #f0
        LXI H, #2217
        DCR M
o1a66:  JZ jo1a71
        MVI A, #72
        STA $21a3
o1a6e:  JMP joEND_MAIN_LOOP
jo1a71: CALL c06d3 ;o1a66
        LDA $2247
        ANI #f7
        STA $2247
        MVI A, #07
        LXI H, HIGH_SCORE_DISP3
        LXI D, HIGH_SCORE_NOW
o1a84:  CALL cCOPY_FROM_HL_TO_DE
o1a87:  JMP joEND_MAIN_LOOP
j1a8a:  STA BALL_IN_PLAY_hrm ;o1944,o196d,o19c9
        STA BALL_IN_PLAY_1
        STA BALL_IN_PLAY_2
        MVI A, #04
        LXI H, #237e
jo1a98: CALL cSET_ATH_BIT_OF_HL ;o1960
        LDA BALLS_PER_GAME
        MOV C,A
        LDA BALL_IN_PLAY_hrm
        CMP C
o1aa3:  JNZ j1aae
        LXI H, GAME_STATE
        MVI A, #04
o1aab:  CALL cSET_ATH_BIT_OF_HL
j1aae:  LDA $237e ;o19bc,o1aa3
        STA $23be
        MOV B,A
        ANI #0f
        STA $239e
        LXI H, GAME_STATE
        MVI A, #00
o1abf:  CALL cCLEAR_ATH_BIT_OF_HL
        MVI B, #09
o1ac4:  CALL co1d81
        LXI H, #23b6
        MVI A, #04
o1acc:  CALL cCLEAR_ATH_BIT_OF_HL
        MVI A, #02
        STA $21a1
o1ad4:  JMP joEND_MAIN_LOOP
        LDA $2212
        DCR A
        STA $2212
o1ade:  JZ j1aef
        LXI H, #1321
o1ae4:  CALL cPLAY_SOUND_2
        MVI A, #a0
        STA $21a1
o1aec:  JMP joEND_MAIN_LOOP
j1aef:  LXI H, #1149 ;o1ade
o1af2:  CALL c0e6f
        LDA $21c9
        STA $2218
        LDA $21ce
        STA $2219
o1b01:  CALL c1ba8
        LXI D, #21c6
        MVI A, #10
o1b09:  CALL cCOPY_FROM_HL_TO_DE
        LXI H, #21c9
        LXI D, #21ce
        MVI A, #0a
o1b14:  CALL cCOPY_FROM_HL_TO_DE
        MVI B, #2b
o1b19:  CALL co1d76
        MVI B, #2c
o1b1e:  CALL co1d76
        MVI B, #04
o1b23:  CALL co1d76
        MVI B, #0c
o1b28:  CALL co1d76
        MVI B, #14
o1b2d:  CALL co1d76
        MVI B, #11
o1b32:  CALL co1d81
        MVI B, #38
o1b37:  CALL co1d81
        MVI B, #31
o1b3c:  CALL co1d81
        MVI B, #09
o1b41:  CALL co1d81
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
o1b64:  CALL co1d81
        LXI H, GAME_STATE2
        MVI A, #07
o1b6c:  CALL cSET_ATH_BIT_OF_HL
        LXI H, #1346
o1b72:  CALL cPLAY_SOUND_2
        LDA $2214
        DCR A
        STA $2214
        SUI #02
o1b7e:  JM jo1ba5
o1b81:  JNZ jo1ba5
        LDA $237e
        MVI B, #00
        ANI #0f
j1b8b:  RAR ;o1b90
o1b8c:  JNC j1b93
        INR B
o1b90:  JMP j1b8b
j1b93:  LDA CREDITS_1 ;o1b8c
        SUB B
o1b97:  JP jo1ba5
        MVI B, #00
o1b9c:  CALL co1d9c
o1b9f:  JNZ jo1ba5
o1ba2:  CALL co1d76
jo1ba5: JMP joEND_MAIN_LOOP ;o1b7e,o1b81,o1b97,o1b9f
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
        LDA STATE_OUTLANE_1
o1bd1:  JM j1bd9
        ANI #fd
o1bd6:  JMP j1bdb
j1bd9:  ORI #02 ;o1bd1
j1bdb:  STA STATE_OUTLANE_1 ;o1bd6
        LDA GAME_STATE2
        MOV B,A
        ANI #01
o1be4:  JZ j1c04
        MOV A,B
        ANI #fe
        STA GAME_STATE2
        EI
        LXI H, #224b
        LXI D, #2380
        MVI A, #34
o1bf6:  CALL cCOPY_FROM_HL_TO_DE
        LXI H, #226b
        LXI D, #23a0
        MVI A, #34
o1c01:  CALL cCOPY_FROM_HL_TO_DE
j1c04:  LDA $2215 ;o1be4
        ANI #20
o1c09:  JNZ j1cc3
        EI
        LXI H, HIGH_SCORE_START
        LXI D, HIGH_SCORE_DISP3
        MVI A, #07
o1c15:  CALL cWRITE_TO_RAM
        LXI H, #1189
        LDA $2247
        ANI #08
o1c20:  JNZ j1c26
        LXI H, HIGH_SCORE_DISP3
j1c26:  LXI D, HIGH_SCORE_NOW ;o1c20
        MVI A, #07
o1c2b:  CALL cCOPY_FROM_HL_TO_DE
        LDA GAME_STATE2
        ANI #40
o1c33:  JZ j1c4e
        LDA CREDITS_1
; seems pointless
        ORA A
        LXI H, #23b6
        MVI A, #06
o1c3f:  JNZ jo1c48
o1c42:  CALL cSET_ATH_BIT_OF_HL
o1c45:  JMP j01d2
jo1c48: CALL cCLEAR_ATH_BIT_OF_HL ;o1c3f
o1c4b:  JMP j01d2
j1c4e:  LDA $2191 ;o1c33
        ANI #01
        EI
o1c54:  JZ j01d2
        IN PRICE_TENS_07_PORT
        CPI #fe
o1c5b:  JNZ j1c65
        IN PRICE_CENTS_07_PORT
        CPI #fb
o1c62:  JZ j1cdc
j1c65:  LXI H, #2191 ;o1c5b
        MVI A, #00
o1c6a:  CALL cCLEAR_ATH_BIT_OF_HL
        STA $219f
o1c70:  JMP j01d2
j1c73:  LXI H, GAME_STATE2 ;o1bc2
        MVI A, #00
o1c78:  CALL cCHECK_ATH_BIT_OF_HL
o1c7b:  JNZ j022c
o1c7e:  CALL cSET_ATH_BIT_OF_HL
        LXI H, #2380
        LXI D, #224b
        MVI A, #80
o1c89:  CALL cCOPY_FROM_HL_TO_DE
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
o1ca6:  CALL cCOPY_FROM_HL_TO_DE
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
o1cc0:  JMP j022c
j1cc3:  LDA $2353 ;o1c09
        MOV B,A
        LDA $23f8
        SUB B
o1ccb:  JP j022c
        LXI H, GAME_STATE2
        MVI A, #06
o1cd3:  CALL cCHECK_ATH_BIT_OF_HL
o1cd6:  JZ j1cdc
o1cd9:  JMP j022c
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
o1d1f:  CALL cSET_ATH_BIT_OF_HL
        LDA $21c2
        CMA
        OUT DIP_SWITCH_PORT
        MVI A, #80
        STA $2193
        MVI A, #06
        STA $21ac
        MVI A, #00
        STA STATE_OUTLANE_1
        LDA GAME_STATE
        ANI #38
        ORI #80
        STA GAME_STATE
        LDA GAME_STATE2
        ANI #67
        STA GAME_STATE2
        LXI H, #2191
        MVI A, #01
o1d4e:  CALL cCLEAR_ATH_BIT_OF_HL
        LXI H, STATE_OUTLANE_1
        MVI A, #04
o1d56:  CALL cSET_ATH_BIT_OF_HL
        MVI A, #06
        STA $21a8
        MVI A, #05
        STA $2197
o1d63:  JMP j022c
        LXI H, #21c2
        MVI A, #05
o1d6b:  CALL cCLEAR_ATH_BIT_OF_HL
        DI
        CALL $137d
        EI
o1d73:  JMP joEND_MAIN_LOOP
co1d76: CALL c1da3 ;o0ad6,o0b23,o0b3b,o0b63,o0e95,o14e9,o1511,o151c,o1b19,o1b1e,o1b23,o1b28,o1b2d,o1ba2
o1d79:  CALL cSET_ATH_BIT_OF_HL
        DAD D
o1d7d:  CALL cSET_ATH_BIT_OF_HL
        RET

co1d81: CALL c1da3 ;o050c,o06e9,jo09da,o0b41,o0c2e,o0c33,o0d37,o0dbc,o14b1,jo1517,o159b,o1ac4,o1b32,o1b37,o1b3c,o1b41,o1b64
o1d84:  CALL cCLEAR_ATH_BIT_OF_HL
        DAD D
o1d88:  CALL cCHECK_ATH_BIT_OF_HL
        PUSH PSW
o1d8c:  CALL cCLEAR_ATH_BIT_OF_HL
        POP PSW
        RET

co1d91: CALL c1da3 ;jo0a14,o15a0
o1d94:  CALL cSET_ATH_BIT_OF_HL
        DAD D
o1d98:  CALL cCLEAR_ATH_BIT_OF_HL
        RET

co1d9c: CALL c1da3 ;o0a03,o0b1b,o0b5d,o0be1,o0c07,o0c14,o0c26,o0db6,o1501,o1509,o1595,o1875,o1b9c
o1d9f:  CALL cCHECK_ATH_BIT_OF_HL
        RET

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

c1db7:  LXI H, PL1_SCORE_1 ;o19d4
o1dba:  CALL c1fd4
        LXI H, PL2_SCORE_1
        PUSH H
o1dc1:  CALL c0e18
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
o1de0:  CALL c1fd4
        LXI H, PL3_SCORE_1
        PUSH H
o1de7:  CALL c0e18
        POP H
o1deb:  JC j1e04
        PUSH H
        LHLD $223f
o1df2:  CALL c1fd4
        POP H
        PUSH H
o1df7:  CALL c0e18
        POP H
o1dfb:  JC j1e0f
        SHLD $2241
o1e01:  JMP j1e17
j1e04:  PUSH H ;o1deb
o1e05:  CALL c1e6a
        POP H
        SHLD $223d
o1e0c:  JMP j1e17
j1e0f:  PUSH H ;o1dfb
o1e10:  CALL c1e6a
        POP H
        SHLD $223f
j1e17:  LHLD $223d ;o1e01,o1e0c
o1e1a:  CALL c1fd4
        LXI H, PL4_SCORE_1
        PUSH H
o1e21:  CALL c0e18
        POP H
o1e25:  JC j1e4e
        PUSH H
        LHLD $223f
o1e2c:  CALL c1fd4
        POP H
        PUSH H
o1e31:  CALL c0e18
        POP H
o1e35:  JC j1e59
        PUSH H
        LHLD $2241
o1e3c:  CALL c1fd4
        POP H
        PUSH H
o1e41:  CALL c0e18
        POP H
o1e45:  JC j1e77
        SHLD $2243
o1e4b:  JMP j1e82
j1e4e:  PUSH H ;o1e25
o1e4f:  CALL c1e64
        POP H
        SHLD $223d
o1e56:  JMP j1e82
j1e59:  PUSH H ;o1e35
o1e5a:  CALL c1e6a
        POP H
        SHLD $223f
o1e61:  JMP j1e82
c1e64:  LHLD $2241 ;o1e4f
        SHLD $2243
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
o1e85:  CALL c1fd4
        LHLD $223d
        PUSH H
o1e8c:  CALL c0e18
        POP H
o1e90:  CC c1f5e
        RC
        LXI H, #2231
o1e97:  CALL c1fd4
        LHLD $223d
        PUSH H
o1e9e:  CALL c0e18
        POP H
o1ea2:  CC c1f7e
        RC
        LXI H, #2235
o1ea9:  CALL c1fd4
        LHLD $223d
        PUSH H
o1eb0:  CALL c0e18
        POP H
o1eb4:  CC c1f8f
        RC
        LXI H, #2239
o1ebb:  CALL c1fd4
        LHLD $223d
        PUSH H
o1ec2:  CALL c0e18
        POP H
o1ec6:  CC c1fa0
        RET

        LXI H, #2231
o1ecd:  CALL c1fd4
        LHLD $223f
        PUSH H
o1ed4:  CALL c0e18
        POP H
o1ed8:  CC c1f7e
        RC
        LXI H, #2235
o1edf:  CALL c1fd4
        LHLD $223f
        PUSH H
o1ee6:  CALL c0e18
        POP H
o1eea:  CC c1f8f
        RC
        LXI H, #2239
o1ef1:  CALL c1fd4
        LHLD $223f
        PUSH H
o1ef8:  CALL c0e18
        POP H
o1efc:  CC c1fa0
        RET

        LXI H, #2235
o1f03:  CALL c1fd4
        LHLD $2241
        PUSH H
o1f0a:  CALL c0e18
        POP H
o1f0e:  CC c1f8f
        RC
        LXI H, #2239
o1f15:  CALL c1fd4
        LHLD $2241
        PUSH H
o1f1c:  CALL c0e18
        POP H
o1f20:  CC c1fa0
        RET

        LXI H, #2239
o1f27:  CALL c1fd4
        LHLD $2243
        PUSH H
o1f2e:  CALL c0e18
        POP H
o1f32:  CC c1fa0
        RET

c1f36:  PUSH PSW ;o1f61,o1f81,o1f92
        LXI H, #2235
        PUSH H
        LXI D, #2239
        MVI A, #07
o1f40:  CALL cCOPY_FROM_HL_TO_DE
        POP D
        POP PSW
        DCR A
        RZ
        PUSH PSW
        LXI H, #2231
        PUSH H
        MVI A, #07
o1f4e:  CALL cCOPY_FROM_HL_TO_DE
        POP D
        POP PSW
        DCR A
        RZ
        LXI H, HIGH_SCORE_START
        MVI A, #07
o1f5a:  CALL cCOPY_FROM_HL_TO_DE
        RET

c1f5e:  PUSH H ;o1e90
        MVI A, #03
o1f61:  CALL c1f36
        POP H
        LXI D, HIGH_SCORE_START
        MVI A, #07
o1f6a:  CALL cCOPY_FROM_HL_TO_DE
        LXI H, #1351
o1f70:  CALL cPLAY_SOUND_2
        LDA $2247
        ORI #08
        STA $2247
        ORA A
        CMC
        RET

c1f7e:  PUSH H ;o1ea2,o1ed8
        MVI A, #02
o1f81:  CALL c1f36
        POP H
        LXI D, #2231
        MVI A, #07
o1f8a:  CALL cCOPY_FROM_HL_TO_DE
        CMC
        RET

c1f8f:  PUSH H ;o1eb4,o1eea,o1f0e
        MVI A, #01
o1f92:  CALL c1f36
        POP H
        LXI D, #2235
        MVI A, #07
o1f9b:  CALL cCOPY_FROM_HL_TO_DE
        CMC
        RET

c1fa0:  LXI D, #2239 ;o1ec6,o1efc,o1f20,o1f32
        MVI A, #07
o1fa5:  CALL cCOPY_FROM_HL_TO_DE
        CMC
        RET

c1faa:  LXI H, #2231 ;o0707,o08f4
        PUSH H
        LXI D, HIGH_SCORE_START
        MVI A, #07
o1fb3:  CALL cCOPY_FROM_HL_TO_DE
        POP D
        LXI H, #2235
        PUSH H
        MVI A, #07
o1fbd:  CALL cCOPY_FROM_HL_TO_DE
        POP D
        LXI H, #2239
        PUSH H
        MVI A, #07
o1fc7:  CALL cCOPY_FROM_HL_TO_DE
        LXI H, #1181
        POP D
        MVI A, #07
o1fd0:  CALL cCOPY_FROM_HL_TO_DE
        RET

c1fd4:  LXI D, SPREAD_1 ;o1dba,o1de0,o1df2,o1e1a,o1e2c,o1e3c,o1e85,o1e97,o1ea9,o1ebb,o1ecd,o1edf,o1ef1,o1f03,o1f15,o1f27
        MVI A, #00
        MVI B, #04
j1fdb:  STAX D ;o1fde
        INX D
        DCR B
o1fde:  JNZ j1fdb
        LXI D, SPREAD_1
        MVI A, #07
o1fe6:  CALL cCOPY_FROM_HL_TO_DE
        MVI A, #07
        RET

        NOP
        NOP
        NOP
        MOV H,B
        INR L
        STAX B
        NOP
        NOP
        MOV C,H
        MOV C,A
        MOV C,A
        MOV D,B
        STA $b13e
        NOP
        NOP
        NOP
        MOV H,B
        SUB D
