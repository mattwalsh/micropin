PRICE_1 EQU 0x237f
PRICE_2 EQU 0x239f
PRICE_3 EQU 0x23bf
PRICE_4 EQU 0x23df
CREDITS_1 EQU 0x237a
CREDITS_2 EQU 0x239a
CREDITS_3 EQU 0x23ba
CREDITS_4 EQU 0x23da
BALL_IN_PLAY_hrm EQU 0x237b
BALL_IN_PLAY_1 EQU 0x239b
BALL_IN_PLAY_2 EQU 0x23bb
BALL_IN_PLAY_3 EQU 0x23db
BALLS_PER_GAME EQU 0x2213
DIP_SWITCHES EQU 0x2216

; INPUT PORTS
MYSTERY_PORT_1 EQU 0x1
PRICE_CENTS_07_PORT EQU 0x2
PRICE_TENS_07_PORT EQU 0x3
PRICE_89_CAB EQU 0x4
DIP_SWITCH_PORT EQU 0x5
o0000:  JMP j0040
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
        HLT
        HLT
        HLT
        HLT
        HLT
        HLT
        HLT
        HLT
        HLT
o0024:  JMP j006e
        HLT
        HLT
        HLT
        HLT
        MOV B,M
o002c:  JMP jo0324
        HLT
        HLT
        HLT
        HLT
        NOP
o0034:  JMP jo037e
        HLT
        HLT
        HLT
        HLT
        JNZ $00c3
        (LDHI) #76
j0040:  MVI A, #19 ;o0000
        STA PRICE_4
        MVI D, #05
j0047:  LXI H, #2710 ;o0053
j004a:  DCX H ;o004f
        OUT #0f
        MOV A,H
        ORA A
o004f:  JNZ j004a
        DCR D
o0053:  JNZ j0047
        IN PRICE_89_CAB
        ANI #20
o005a:  JZ j006e
        LXI H, #2000
j0060:  SUB A ;o0066
        MOV M,A
        INX H
        MVI A, #24
        CMP H
o0066:  JNZ j0060
        MVI A, #64
        STA $2240
j006e:  LXI SP, #2190 ;o0024,o005a
        MVI A, #07
j0073:  OUT #0e ;o0078
        OUT #0d
        DCR A
o0078:  JP j0073
        LXI H, #2197
        MVI C, #2d
j0080:  SUB A ;o0084
        MOV M,A
        INX H
        DCR C
o0084:  JNZ j0080
        MVI A, #05
        STA $21a3
        MVI A, #fe
        OUT #09
        MVI A, #02
        STA $2198
        MVI A, #ff
        STA $2193
        MVI A, #fc
        STA $2194
        LXI H, #21fb
        SHLD $21f9
        LXI H, #21b4
        SHLD $21be
        SHLD $21c0
        MVI A, #0f
        STA $21f8
        LDA $2190
        ORI #05
        STA $2190
        MVI A, #0c
        SIM
        IN PRICE_89_CAB
        ANI #20
o00c2:  JNZ j030b
o00c5:  CALL co02f3
o00c8:  JZ j0113
j00cb:  MVI A, #07 ;o0321
        STA $21c2
        CMA
        OUT #05
        MVI A, #06
        STA $21a6
j00d8:  EI ;o00dd
        LDA $21a6
        ORA A
o00dd:  JNZ j00d8
        MVI A, #28
        STA $21c2
        CMA
        OUT #05
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
j00fd:  EI ;o0102
        LDA $21a6
        ORA A
o0102:  JNZ j00fd
        MVI A, #ff
        OUT #05
        OUT #06
        OUT #07
        OUT #08
        DI
        CALL $13de
j0113:  IN PRICE_89_CAB ;o00c8,o02dc
        ANI #20
o0117:  JNZ jo0138
        LDA $2192
        ANI #df
        STA $2192
        IN PRICE_TENS_07_PORT
        CPI #fe
o0126:  JNZ j018f
        IN PRICE_CENTS_07_PORT
        CPI #fb
o012d:  JZ j027a
        CPI #f7
o0132:  JZ j02a4
o0135:  JMP j018f
jo0138: CALL c1822 ;o0117,o02a1
        MVI A, #d0
        STA $2192
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
o016d:  CALL c0f60
        MVI B, #01
        LXI D, #21c6
o0175:  CALL jc1808
        LXI H, #21c9
        LXI D, #21ce
        MVI A, #0a
o0180:  CALL c0f60
        LXI H, #2205
        MVI B, #13
        SUB A
j0189:  MOV M,A ;o018c
        INX H
        DCR B
o018c:  JNZ j0189
j018f:  DI ;o0126,o0135,o0280
        MVI A, #30
        STA $2194
        LDA $2192
        ANI #80
o019a:  JNZ j01a2
        MVI A, #00
        STA $2192
j01a2:  IN PRICE_CENTS_07_PORT ;o019a,o1c25,o1c2b,o1c34,o1c50
        MVI C, #00
        MVI B, #08
j01a8:  RAR ;o01b2
o01a9:  JNC j01bc
        EI
        INR C
        DCR B
o01af:  JZ j01b5
o01b2:  JMP j01a8
j01b5:  IN PRICE_89_CAB ;o01af
        RAR
o01b8:  JNC j01bc
        INR C
j01bc:  MOV D,C ;o01a9,o01b8
        IN PRICE_TENS_07_PORT
        MVI C, #00
        MVI B, #08
j01c3:  RAR ;o01cd
o01c4:  JNC j01d9
        EI
        INR C
        DCR B
o01ca:  JZ j01d0
o01cd:  JMP j01c3
j01d0:  IN PRICE_89_CAB ;o01ca
        RAR
        RAR
        RAR
o01d5:  JNC j01d9
        INR C
j01d9:  MOV A,C ;o01c4,o01d5
        EI
        RLC
        RLC
        RLC
        RLC
        ORA D
        STA PRICE_1
        STA PRICE_2
        STA PRICE_3
        EI
        IN DIP_SWITCH_PORT
        LXI H, DIP_SWITCHES
        MOV M,A
        MVI B, #03
        MVI A, #00
o01f4:  CALL c03e6
o01f7:  JNZ j0204
        INR B
        MVI A, #01
o01fd:  CALL c03e6
o0200:  JNZ j0204
        INR B
j0204:  MOV A,B ;o01f7,o0200
        STA BALLS_PER_GAME
j0208:  OUT #0f ;o026b,o1c5b,o1cb8,o1ce9,o1cf7,o1d64
        EI
        NOP
        EI
j020d:  NOP ;o14ac
        EI
        NOP
        DI
        LDA $21c2
        CMA
        OUT #05
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
o0238:  JZ j0257
o023b:  JM j0243
        CPI #08
o0240:  JC j024c
j0243:  LXI H, #21fb ;o023b
        SHLD $21f9
o0249:  JMP j0257
j024c:  DCX H ;o0240
        MOV A,M
        DCX H
        SHLD $21f9
        MOV L,M
        MOV H,A
o0254:  CALL c0fcd
j0257:  EI ;o0238,o0249
        LXI H, #2192
        MVI A, #07
o025d:  CALL c03e6
o0260:  JNZ j1bb4
        LDA $23b6
        ANI #7f
        STA $23b6
o026b:  JMP j0208
c026e:  XCHG ;o074a,o0d7c,o0e56,o0e65,o1518,o1626,o1947
        LHLD $21f9
        MOV M,E
        INX H
        MOV M,D
        INX H
        SHLD $21f9
        RET

j027a:  LDA $2191 ;o012d
        MOV B,A
        ANI #01
o0280:  JNZ j018f
        MOV A,B
        ORI #01
        STA $2191
        DI
        MVI A, #30
        STA $2194
        MVI A, #7d
        STA $219f
        MVI A, #3c
        STA $221f
        MVI A, #00
        STA $2220
        STA $2221
o02a1:  JMP jo0138
j02a4:  DI ;o0132
        LXI H, #23c0
        MVI B, #0c
j02aa:  MVI M, #88 ;o02ae
        INX H
        DCR B
o02ae:  JNZ j02aa
        MVI M, #f8
        INX H
        MVI B, #09
j02b6:  MVI M, #88 ;o02ba
        INX H
        DCR B
o02ba:  JNZ j02b6
        MVI M, #f8
        INX H
        MVI B, #07
j02c2:  MVI M, #88 ;o02c6
        INX H
        DCR B
o02c6:  JNZ j02c2
        MVI M, #ff
        INX H
        MVI M, #88
        MVI A, #00
        OUT #00
        OUT #01
        OUT #02
        OUT #03
        OUT #04
        OUT #0f
o02dc:  JMP j0113
c02df:  LXI D, #233b ;co02f3,o1416
        LXI B, #0000
        LXI H, #0000
j02e8:  LDAX D ;o02ef
        MOV C,A
        DAD B
        INX D
        MOV A,E
        CPI #5d
o02ef:  JNZ j02e8
        RET

co02f3: CALL c02df ;o00c5
        XCHG
        LHLD $2223
        MOV A,E
        CMP L
        RNZ
        ORA A
o02fe:  JZ j0304
j0301:  MOV A,D ;o0306
        CMP H
        RET

j0304:  MOV A,D ;o02fe
        ORA A
o0306:  JNZ j0301
        INR A
        RET

j030b:  LXI H, #11eb ;o00c2
        LXI D, #2228
        MVI A, #08
o0313:  CALL c0f60
        LXI H, #11e7
        LXI D, #222c
        MVI A, #08
o031e:  CALL c0f60
o0321:  JMP j00cb
jo0324: CALL c060e ;o002c
        LDA $2190
        ORI #80
        STA $2190
        SUB A
        STA $220c
        IN MYSTERY_PORT_1
        LXI D, #0000
j0338:  ORA A ;o0341
o0339:  JZ jo037a
        RAR
o033d:  JC j0344
        INR E
o0341:  JMP j0338
j0344:  MOV A,E ;o033d
        CMA
        OUT #0e
        CMA
        LXI H, #2193
o034c:  CALL c03e6
o034f:  JNZ jo037a
o0352:  CALL c060e
        LDA $2191
        ANI #02
o035a:  CNZ c03fa
o035d:  CALL c061a
o0360:  CALL c03ce
        XCHG
        DAD H
        LXI D, #03ae
        DAD D
        MOV A,M
        INX H
        MOV H,M
        MOV L,A
        PCHL
j036e:  LXI H, #2194 ;o05f0,o0887,o093c,o1448,o1805
o0371:  JMP jo0377
        LXI H, #2193
jo0377: CALL c03d9 ;o0371
jo037a: CALL c061a ;o0339,o034f,o0387,o039d,o047e,o0535,o053e,o070e,o074d,o07d1,o07e2,o07ea,o08c6,o08cf,o0987
        RET

jo037e: CALL c060e ;o0034
        LXI D, #0000
        IN #00
; switch handler routine
j0386:  ORA A ;o038f
o0387:  JZ jo037a
        RAR
o038b:  JC j0392
        INR E
o038f:  JMP j0386
j0392:  MOV A,E ;o038b
        CMA
        OUT #0d
        CMA
        LXI H, #2194
o039a:  CALL c03e6
o039d:  JNZ jo037a
o03a0:  CALL c03ce
        XCHG
        DAD H
        LXI D, #03be
        DAD D
        MOV A,M
        INX H
        MOV H,M
        MOV L,A
        PCHL
        JPO $e806
        MVI B, #ee
        MVI B, #f4
        MVI B, #fa
        MVI B, #00
        RLC
        MVI B, #07
        MOV A,D
        INX B
        (RSTV)
        DCR B
        DCR E
        INR D
        LHLD $7309
        INR B
        CMP C
        RLC
        MOV M,A
        (DSUB)
        MOV D,A
        MVI D, #73
        INR B
c03ce:  PUSH B ;o0360,o03a0,o0408,o048b,o0523,o0632,o0721,o0960,o09db,o0aa7,o0ab6,o0add,o0b88,o0bd9,o0c2d,o0d0f,o0d2c,o0d32,o0de3,jo10fb,jo1130,o127b,o1296,o1306,o1422,o145c,o14fa,o15c4,o1620,o16b3,o1766,jo1794,jo17b2,o18b9,o18c1,o1a08,jo1a69,o1a7c,o1b67,o1c22,o1c5e,o1d20,o1d57,o1d7a,o1d7e,o1d95
        MOV B,A
o03d0:  CALL c03f1
        MOV C,M
        ORA C
        MOV M,A
o03d6:  JMP j03ee
c03d9:  PUSH B ;jo0377,o041b,o05af,jo0638,o0808,o0911,o09b4,o09ba,o09c0,o0a07,o0a25,o0ace,jo0ae3,o0b34,o0b42,o0c7c,o0c8c,jo1100,o113d,o1142,jo12a5,jo12d8,o13e3,o1442,o1452,jo1463,o150f,o159d,o1645,o1703,o170b,o1729,o1991,o199d,o19af,jo19d3,o1a9b,o1aa0,o1aad,jo1c28,o1c4a,o1d4f,o1d6c,o1d85,o1d8d,o1d99
        MOV B,A
o03db:  CALL c03f1
        CMA
        MOV C,A
        MOV A,M
        ANA C
        MOV M,A
o03e3:  JMP j03ee
c03e6:  PUSH B ;o01f4,o01fd,o025d,o034c,o039a,o0401,o05a4,o062c,o0645,o0660,o077a,o07ce,o07df,o07f2,o07fd,o08c3,o08fb,o0906,o0a1f,o0aac,o0ac8,o0af2,o0b2e,o0b3c,o0beb,o0c21,o0cc4,o0d09,o0d6a,o0fda,o0fe1,o0fe8,o1029,o10f4,o1129,o128e,o12aa,o1302,o143a,o1456,o14ff,o1509,o1597,o15a2,o15b3,o15be,o15e9,o161a,o1637,o163f,o165c,o169e,o16a6,o1756,o175e,o1865,o187b,o18db,o1997,jo19c7,o19da,o19f3,o1c58,o1cf1,o1d89,o1da0
        MOV B,A
o03e8:  CALL c03f1
        MOV C,A
        MOV A,M
        ANA C
j03ee:  MOV A,B ;o03d6,o03e3
        POP B
        RET

c03f1:  MOV C,A ;o03d0,o03db,o03e8
        MVI A, #01
j03f4:  DCR C ;o03f7
        RM
        ADD A
o03f7:  JMP j03f4
c03fa:  LDA $2211 ;o035a,o0c24,o15db
        MOV B,A
o03fe:  CALL c041f
o0401:  CALL c03e6
o0404:  JZ j040b
        XCHG
o0408:  CALL c03ce
j040b:  MOV A,B ;o0404
        INR A
        CPI #05
o040f:  JNZ j0414
        MVI A, #00
j0414:  STA $2211 ;o040f
o0417:  CALL c041f
        XCHG
o041b:  CALL c03d9
        RET

c041f:  MVI D, #00 ;o03fe,o0417
        MOV E,A
        LXI H, #0438
        DAD D
        MOV A,M
        LXI H, #043d
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

        INR B
        NOP
        LXI B, #0502
        CALL $cc21
        LXI H, #21cc
        CZ $ca21
        LXI H, #903a
        LXI H, #05f6
        STA $2190
        MVI A, #00
        STA $220c
        MVI A, #ff
        STA $2193
        LDA $2194
        ORI #30
        STA $2194
        RET

c0462:  LDA $2192 ;o047b,o057d
        ANI #40
        RZ
        LDA CREDITS_1
        ORA A
o046c:  JZ j0471
        CMP A
        RET

j0471:  DCR A ;o046c
        RET

        CALL $0447
        MVI A, #7d
        STA $21a2
o047b:  CALL c0462
o047e:  JNZ jo037a
        MVI A, #fa
        STA $219e
        LXI H, #23b6
        MVI A, #05
o048b:  CALL c03ce
        MVI A, #ff
        STA $2380
        STA $2381
        STA $2382
        LDA $233f
        ADI #08
        MOV B,A
        LDA $23e4
        SUB B
o04a3:  JM j0538
        LDA $2192
        ANI #40
o04ab:  JNZ j0538
        LDA $2194
        ORI #fc
        STA $2194
        MVI A, #00
        STA $21a3
        MVI A, #ff
        LXI H, #23c0
        MVI B, #20
j04c2:  MOV M,A ;o04c5
        INX H
        DCR B
o04c5:  JNZ j04c2
        OUT #00
        OUT #01
        OUT #02
        OUT #03
        OUT #04
        OUT #05
        OUT #06
        OUT #07
        OUT #08
        MVI A, #00
        MVI A, #0f
        STA $23cc
        STA $23d6
        STA $23de
        LDA $2190
        ANI #f7
        STA $2190
        LDA $2396
        ANI #ef
        STA $2396
        LDA $23b6
        ANI #ef
        STA $23b6
        MVI B, #30
o0501:  CALL co1d82
        MVI A, #d0
        STA $2192
        LDA BALLS_PER_GAME
        STA BALL_IN_PLAY_hrm
        LXI H, #237e
        MOV A,M
        ANI #0f
        MOV M,A
        MVI B, #ff
j0518:  RAR ;o051d
o0519:  JNC j0520
        INR B
o051d:  JMP j0518
j0520:  MOV A,B ;o0519
        ADI #04
o0523:  CALL c03ce
        MVI A, #01
        STA $2214
        MVI A, #28
        STA $221b
        MVI A, #02
        STA $219d
o0535:  JMP jo037a
j0538:  LXI H, #1345 ;o04a3,o04ab
o053b:  CALL c12e4
o053e:  JMP jo037a
        LDA $221b
        DCR A
        STA $221b
o0548:  JZ j055e
        MVI A, #14
        STA $219d
        MVI A, #fa
        STA $219e
        LXI H, #1342
o0558:  CALL c12e4
o055b:  JMP jo0608
j055e:  MVI A, #05 ;o0548
        STA $21a3
        MVI A, #01
        STA $21a0
        STA $221c
        LDA $2194
        ANI #33
        STA $2194
o0573:  JMP jo0608
        IN PRICE_89_CAB
        ANI #80
o057a:  JZ j0594
o057d:  CALL c0462
o0580:  JNZ j0594
        CALL $0447
        MVI A, #7d
        STA $21a2
        LXI H, #1345
o058e:  CALL c12e4
o0591:  JMP jo0608
j0594:  LDA $2194 ;o057a,o0580
        ANI #77
        STA $2194
o059c:  JMP jo0608
        LXI H, #2192
        MVI A, #07
o05a4:  CALL c03e6
o05a7:  JZ jo0608
        LXI H, #23b6
        MVI A, #05
o05af:  CALL c03d9
        MVI A, #f0
        STA $23a0
        STA $2380
        MVI A, #ff
        STA $23a1
        STA $2381
        STA $23a2
        STA $2382
o05c8:  JMP jo0608
        LXI H, #2197
        MVI C, #1a
j05d0:  MVI A, #ff ;o05dc
        ADD M
o05d3:  JNC j05da
        MOV M,A
o05d7:  JZ j05f3
j05da:  INX H ;o05d3,o060b
        DCR C
o05dc:  JNZ j05d0
        LDA $2198
        ORA A
o05e3:  JNZ j05e8
        MVI A, #01
j05e8:  ANI #3f ;o05e3
        STA $2198
        MVI A, #00
        DI
o05f0:  JMP j036e
j05f3:  DI ;o05d7
o05f4:  CALL c060e
        MVI A, #1a
        SUB C
        ADD A
        LXI D, #0000
        MOV E,A
        LXI H, #06ae
        DAD D
        MOV A,M
        INX H
        MOV H,M
        MOV L,A
        PCHL
jo0608: CALL c061a ;o055b,o0573,o0591,o059c,o05a7,o05c8,o0684,o06a5,o076a,o0772,o077d,o0785,o0800,o080b,o081e,o084f,o085f,o0874,o08e8,o08f3,o0909,o0914,o0927,o0a0a,o0a17,o0a2d,o0a3a,o0a45,o0b54,o0b77,o0b90,o0ba2,o0bd0,o0c27,o0c7f,o0c8f,o0d55,o0d8a,o0db7,o0e7a,o12a2,o12c1,o12d5,o12e1,o1558,o1587,o1955,o197f,o1a4b,o1a58,o1ab5,o1ac7,o1acf,o1ae7,jo1ba0,o1d74
o060b:  JMP j05da
c060e:  SHLD $2195 ;jo0324,o0352,jo037e,o05f4,o1467
        XTHL
        PUSH B
        PUSH D
        PUSH PSW
        PUSH H
        LHLD $2195
        RET

c061a:  POP H ;o035d,jo037a,jo0608,jo147a
        POP PSW
        POP D
        POP B
        XTHL
        RET

        LXI H, #21f8
        DCR M
; push A, SP, B, D, H
o0624:  JNZ j0640
        LXI H, #2191
        MVI A, #04
o062c:  CALL c03e6
o062f:  JNZ jo0638
o0632:  CALL c03ce
o0635:  JMP j063b
jo0638: CALL c03d9 ;o062f
j063b:  MVI A, #04 ;o0635
        STA $21f8
j0640:  LXI H, #2191 ;o0624
        MVI A, #04
o0645:  CALL c03e6
o0648:  JNZ j06a8
        LXI H, #2380
j064e:  LXI D, #23c0 ;o06ab
        MVI A, #40
o0653:  CALL c0f60
        MVI A, #05
        STA $21a3
        LXI H, #2191
        MVI A, #04
o0660:  CALL c03e6
o0663:  JZ j0687
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
o0684:  JMP jo0608
j0687:  LDA $21ce ;o0663
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
o06a5:  JMP jo0608
j06a8:  LXI H, #23a0 ;o0648
o06ab:  JMP j064e
        ADD D
        INR C
        ADC C
        STAX D
        MOV D,B
        RLC
; credit handler
        CMP B
        LDAX D
        LXI D, #570b
        DCX B
        MOV B,C
        DCR B
        SBB A
        DCR B
        LXI H, #7008
        DAD D
        JNC $761a
        DCR B
        RIM
        MVI B, #36
        DCR D
        ANA L
        DCX B
        MOV H,A
        INR C
        MOV B,D
        DCR C
        (LHLX)
        RLC
        ORI #08
        CP $1a09
        LDAX B
        MOV H,A
        DCR E
        MOV M,L
        RLC
        DCX SP
        DAD D
        MVI L, #0e
o06e0:  JNC jo1108
        NOP
        NOP
o06e5:  JMP j0711
        LXI D, #0001
o06eb:  JMP j0711
        LXI D, #0002
o06f1:  JMP j0711
        LXI D, #0003
o06f7:  JMP j0711
        LXI D, #0004
o06fd:  JMP j0711
        LXI D, #0005
o0703:  JMP j0711
        LDA $2191
        ORI #20
        STA $2191
o070e:  JMP jo037a
j0711:  LXI H, #0788 ;o06e5,o06eb,o06f1,o06f7,o06fd,o0703
        DAD D
        MOV A,M
        XCHG
        DAD H
        XCHG
        LXI H, #078f
        DAD D
        MOV B,M
        INX H
        MOV H,M
        MOV L,B
o0721:  CALL c03ce
        MVI A, #09
        STA $2199
        LDA $21c3
        CMA
        OUT #06
        LDA $21c4
        CMA
        OUT #07
        LXI H, #079d
        DAD D
        MOV B,M
        INX H
        MOV H,M
        MOV L,B
        PUSH D
o073e:  CALL c12e4
        POP D
        LXI H, #07ab
        DAD D
        MOV B,M
        INX H
        MOV H,M
        MOV L,B
o074a:  CALL c026e
o074d:  JMP jo037a
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
o076a:  JNZ jo0608
        MVI A, #06
        STA $21ad
o0772:  JMP jo0608
        LXI H, #2190
        MVI A, #02
o077a:  CALL c03e6
o077d:  JNZ jo0608
        MVI A, #80
        STA $2193
o0785:  JMP jo0608
        INX B
        NOP
        LXI B, #0302
        INR B
        STAX B
        JMP $c421
        LXI H, #21c4
        JMP $c421
        LXI H, #21c4
        CNZ $3021
        INX D
        INX SP
        INX D
        MVI M, #13
        DAD SP
        INX D
        INR A
        INX D
        CMC
        INX D
        MOV B,D
        INX D
        RC
        LXI D, #11dc
        RPO
        LXI D, #11d4
        RNC
        LXI D, #11d0
        CZ $3a11
        JMP $f621
        (ARHL)
        STA $21c3
        CMA
        OUT #06
        MVI A, #09
        STA $21a8
        LXI H, #2190
        MVI A, #05
o07ce:  CALL c03e6
o07d1:  JNZ jo037a
        LXI H, #13d1
o07d7:  CALL c12e4
        LXI H, #2191
        MVI A, #00
o07df:  CALL c03e6
o07e2:  JZ jo037a
        MVI A, #7d
        STA $219f
o07ea:  JMP jo037a
        LXI H, #21c3
        MVI A, #04
o07f2:  CALL c03e6
o07f5:  JNZ j080e
        LXI H, #2190
        MVI A, #02
o07fd:  CALL c03e6
o0800:  JNZ jo0608
        MVI A, #04
        LXI H, #2194
o0808:  CALL c03d9
o080b:  JMP jo0608
j080e:  LDA $21c3 ;o07f5
        ANI #2f
        STA $21c3
        CMA
        OUT #06
        MVI A, #06
        STA $21a8
o081e:  JMP jo0608
        LDA $21c3
        ORI #30
        STA $21c3
        MVI A, #09
        STA $21a8
        STA $21a9
        MVI A, #71
        STA $219f
        LDA $221f
        DCR A
        STA $221f
o083d:  JNZ j0862
        MVI A, #3c
        STA $221f
        LDA $2220
        INR A
        DAA
        STA $2220
        CPI #60
o084f:  JNZ jo0608
        MVI A, #00
        STA $2220
        LDA $2221
        INR A
        DAA
        STA $2221
o085f:  JMP jo0608
j0862:  LDA $2220 ;o083d
        STA CREDITS_2
        STA CREDITS_3
        LDA $2221
        STA PRICE_2
        STA PRICE_3
o0874:  JMP jo0608
        LDA $2192
        ANI #fe
        MOV B,A
        ANI #80
o087f:  JZ j08ae
o0882:  CALL c088a
        MVI A, #05
o0887:  JMP j036e
c088a:  MOV A,B ;o0882,o0937
        ANI #04
        LDA $2241
o0890:  JZ j0898
        ORI #01
o0895:  JMP j089a
j0898:  ANI #fe ;o0890
j089a:  STA $2241 ;o0895
        MOV A,B
        ORI #04
        STA $2192
        MVI A, #02
        STA $21b0
        MVI A, #20
j08aa:  STA $2243 ;o1332
        RET

j08ae:  LDA $21c3 ;o087f
        ORI #20
        STA $21c3
        CMA
        OUT #06
        MVI A, #09
        STA $21a9
        LXI H, #2190
        MVI A, #05
o08c3:  CALL c03e6
o08c6:  JNZ jo037a
        LXI H, #13d1
o08cc:  CALL c12e4
o08cf:  JMP jo037a
        LDA $2243
        DCR A
o08d6:  JP j08eb
        IN PRICE_89_CAB
        ANI #40
o08dd:  JNZ j08ee
        LDA $2192
        ANI #fb
        STA $2192
o08e8:  JMP jo0608
j08eb:  STA $2243 ;o08d6
j08ee:  MVI A, #04 ;o08dd
        STA $21b0
o08f3:  JMP jo0608
        LXI H, #21c3
        MVI A, #05
o08fb:  CALL c03e6
o08fe:  JNZ j0917
        LXI H, #2190
        MVI A, #02
o0906:  CALL c03e6
o0909:  JNZ jo0608
        LXI H, #2194
        MVI A, #05
o0911:  CALL c03d9
o0914:  JMP jo0608
j0917:  LDA $21c3 ;o08fe
        ANI #1f
        STA $21c3
        CMA
        OUT #06
        MVI A, #06
        STA $21a9
o0927:  JMP jo0608
        IN PRICE_89_CAB
        ANI #10
o092e:  JZ j093f
        LDA $2192
        ANI #fe
        MOV B,A
o0937:  CALL c088a
        MVI A, #02
o093c:  JMP j036e
j093f:  LDA $2192 ;o092e
        ANI #20
o0944:  JNZ jo0968
        MVI A, #00
        STA $237c
        STA $237d
        STA $239c
        STA $239d
        STA $23bc
        STA $23bd
        LXI H, #2192
        MVI A, #05
o0960:  CALL c03ce
        MVI A, #02
        STA $21aa
jo0968: CALL c098a ;o0944
        IN DIP_SWITCH_PORT
        ANI #80
        MVI A, #01
o0971:  JNZ j0976
        MVI A, #04
j0976:  STA $2242 ;o0971
        LDA $2194
        ORI #40
        STA $2194
        LXI H, #13c4
o0984:  CALL c12e4
o0987:  JMP jo037a
c098a:  LDA CREDITS_1 ;jo0968,o0a37
        CPI #99
        RZ
        LXI H, #237c
        LDA PRICE_1
        ADD M
        DAA
        STA $237c
        STA $239c
        STA $23bc
        INX H
        MVI A, #00
        ADC M
        DAA
        STA $237d
        STA $239d
        STA $23bd
        MVI A, #07
        LXI H, #2376
o09b4:  CALL c03d9
        LXI H, #2396
o09ba:  CALL c03d9
        LXI H, #23b6
o09c0:  CALL c03d9
        MVI B, #00
o09c5:  CALL co1d82
        LDA CREDITS_1
        INR A
        DAA
        STA CREDITS_1
        STA CREDITS_2
        STA CREDITS_3
        LXI H, #21c5
        MVI A, #03
o09db:  CALL c03ce
        MVI A, #09
        STA $21ab
        LDA $2240
        DCR A
        STA $2240
        RNZ
o09eb:  CALL c1fc4
        MVI A, #64
        STA $2240
        RET

        IN PRICE_89_CAB
        ANI #10
o09f8:  JZ j0a0d
        LXI H, #221d
        DCR M
o09ff:  JNZ j0a12
        LXI H, #2192
        MVI A, #05
o0a07:  CALL c03d9
o0a0a:  JMP jo0608
j0a0d:  MVI A, #40 ;o09f8
        STA $221d
j0a12:  MVI A, #04 ;o09ff
        STA $21aa
o0a17:  JMP jo0608
        LXI H, #21c5
        MVI A, #03
o0a1f:  CALL c03e6
o0a22:  JZ j0a30
o0a25:  CALL c03d9
        MVI A, #09
        STA $21ab
o0a2d:  JMP jo0608
j0a30:  LXI H, #2242 ;o0a22
        DCR M
o0a34:  JZ j0a3d
o0a37:  CALL c098a
o0a3a:  JMP jo0608
j0a3d:  LDA $2194 ;o0a34
        ANI #bb
        STA $2194
o0a45:  JMP jo0608
        MVI B, #24
        MVI C, #00
o0a4c:  JMP j0a80
        MVI B, #03
        MVI C, #01
o0a53:  JMP j0a80
        MVI B, #0b
        MVI C, #02
o0a5a:  JMP j0a80
        MVI B, #13
        MVI C, #03
o0a61:  JMP j0a80
        MVI B, #29
        MVI C, #04
o0a68:  JMP j0a80
        MVI A, #04
        STA $2197
        LXI H, #2208
        MVI A, #ff
        ADD M
o0a76:  JNC j0a95
        MOV M,A
o0a7a:  JZ j0cb7
o0a7d:  JMP jo147a
j0a80:  LXI H, #2208 ;o0a4c,o0a53,o0a5a,o0a61,o0a68
        MVI A, #ff
        ADD M
o0a86:  JNC j0a95
        MOV M,A
o0a8a:  JZ j0aa2
        MVI A, #04
        STA $2197
o0a92:  JMP jo147a
j0a95:  MVI A, #64 ;o0a76,o0a86
        STA $2208
        MVI A, #04
        STA $2197
o0a9f:  JMP jo147a
j0aa2:  LXI H, #2190 ;o0a8a
        MVI A, #07
o0aa7:  CALL c03ce
        MVI A, #02
o0aac:  CALL c03e6
o0aaf:  JZ jo0ac1
        MOV A,C
o0ab3:  CALL c0c47
o0ab6:  CALL c03ce
        MVI A, #06
        STA $21a6
o0abe:  JMP jo147a
jo0ac1: CALL co1d82 ;o0aaf
        MOV A,C
        LXI H, #21c7
o0ac8:  CALL c03e6
o0acb:  JZ jo0c2a
o0ace:  CALL c03d9
        LXI H, #2211
        CMP M
        LXI H, #2192
        MVI A, #01
o0ada:  JNZ jo0ae3
o0add:  CALL c03ce
o0ae0:  JMP j0ae6
jo0ae3: CALL c03d9 ;o0ada
j0ae6:  MOV A,C ;o0ae0
o0ae7:  CALL c0c47
o0aea:  CALL co1d9d
o0aed:  JZ jo0afb
        XCHG
        DAD D
o0af2:  CALL c03e6
        XCHG
        MVI A, #01
o0af8:  JZ j0b0b
jo0afb: CALL co1d92 ;o0aed
        LXI H, #1366
o0b01:  CALL c12e4
        MVI A, #c8
        STA $2208
        MVI A, #5a
j0b0b:  STA $219b ;o0af8
o0b0e:  JMP jo147a
        LXI H, #0cad
        LDA $21c8
        ADD A
        MVI D, #00
        MOV E,A
        DAD D
        MOV A,M
        INX H
        MOV H,M
        MOV L,A
o0b20:  CALL c0eed
        LXI H, #1360
o0b26:  CALL c12e4
        LXI H, #2192
        MVI A, #01
o0b2e:  CALL c03e6
o0b31:  JZ j0b7a
o0b34:  CALL c03d9
        LXI H, #2191
        MVI A, #01
o0b3c:  CALL c03e6
o0b3f:  JZ j0b7a
o0b42:  CALL c03d9
        MVI A, #fa
        STA $2208
        MVI A, #05
        STA $221a
        MVI A, #28
        STA $219c
o0b54:  JMP jo0608
        LXI H, #11f4
o0b5a:  CALL c0eed
        LXI H, #13b8
o0b60:  CALL c12e4
        LDA $221a
        DCR A
        STA $221a
o0b6a:  JZ j0b7a
        MVI A, #28
        STA $219c
        MVI A, #fa
        STA $2208
o0b77:  JMP jo0608
j0b7a:  LDA $21c7 ;o0b31,o0b3f,o0b6a
        CPI #00
o0b7f:  JZ j0b93
        LHLD $2209
        LDA $220b
o0b88:  CALL c03ce
        MVI A, #06
        STA $21a6
o0b90:  JMP jo0608
j0b93:  MVI A, #3c ;o0b7f
        STA $21a5
        MVI A, #64
        STA $2208
        MVI A, #00
        STA $2207
o0ba2:  JMP jo0608
        SUB A
        STA $2208
        LDA $2207
        INR A
        STA $2207
        CPI #06
o0bb2:  JZ j0bd3
        MVI D, #00
        MOV E,A
        LXI H, #0c91
        DAD D
        MOV B,M
o0bbd:  CALL co1d77
        LXI H, #1360
o0bc3:  CALL c12e4
        MVI A, #0f
        STA $21a5
        MVI A, #64
        STA $2208
o0bd0:  JMP jo0608
j0bd3:  LHLD $2209 ;o0bb2
        LDA $220b
o0bd9:  CALL c03ce
        MVI A, #06
        STA $21a6
        MVI A, #1f
        STA $21c7
        LXI H, #2190
        MVI A, #03
o0beb:  CALL c03e6
o0bee:  JNZ j0bfe
        MVI B, #31
o0bf3:  CALL co1d9d
o0bf6:  JNZ j0bfe
        MVI B, #09
o0bfb:  CALL co1d77
j0bfe:  LDA $21c8 ;o0bee,o0bf6
        INR A
        CPI #05
o0c04:  JZ jc0c1c
        STA $21c8
        MVI D, #00
        MOV E,A
        LXI H, #0c96
        DAD D
        MOV B,M
        PUSH H
o0c13:  CALL co1d77
        POP H
        DCX H
        MOV B,M
o0c19:  CALL co1d82
jc0c1c: LXI H, #2191 ;o0c04,o133e
        MVI A, #01
o0c21:  CALL c03e6
o0c24:  CNZ c03fa
o0c27:  JMP jo0608
jo0c2a: CALL c0c47 ;o0acb
o0c2d:  CALL c03ce
        MVI A, #06
        STA $21a6
o0c35:  CALL co1d9d
o0c38:  JNZ jo147a
o0c3b:  CALL co1d77
        LXI H, #1363
o0c41:  CALL c12e4
o0c44:  JMP jo147a
c0c47:  MVI D, #00 ;o0ab3,o0ae7,jo0c2a
        MOV E,A
        LXI H, #0c9b
        DAD D
        MOV B,M
        LXI H, #0ca0
        DAD D
        ADD A
        MOV E,A
        MOV A,M
        STA $220b
        MOV C,A
        LXI H, #0ca5
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
o0c7c:  CALL c03d9
o0c7f:  JMP jo0608
        MVI A, #00
        STA $2208
        LXI H, #2192
        MVI A, #03
o0c8c:  CALL c03d9
o0c8f:  JMP jo0608
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
        JNZ $ec21
        LXI D, #11f0
        RM
        LXI D, #11fc
j0cb7:  MVI B, #39 ;o0a7a
o0cb9:  CALL co1d9d
o0cbc:  JZ j0dde
        LXI H, #2190
        MVI A, #02
o0cc4:  CALL c03e6
o0cc7:  JNZ j0dde
        LDA $220c
        CPI #00
o0ccf:  JNZ j0d3a
        LXI H, #235b
        LXI D, #220d
        MVI A, #06
o0cda:  CALL c0f60
        MVI B, #38
o0cdf:  CALL co1d9d
o0ce2:  JZ j0cea
        MVI A, #03
o0ce7:  JMP j0cf9
j0cea:  MVI B, #11 ;o0ce2
o0cec:  CALL co1d9d
o0cef:  JZ j0cf7
        MVI A, #02
o0cf4:  JMP j0cf9
j0cf7:  MVI A, #01 ;o0cef
j0cf9:  STA $220c ;o0ce7,o0cf4
        MVI B, #31
o0cfe:  CALL co1d9d
o0d01:  JZ j0d3a
        LXI H, #2190
        MVI A, #03
o0d09:  CALL c03e6
o0d0c:  JNZ j0d3a
o0d0f:  CALL c03ce
        MVI B, #31
o0d14:  CALL co1d82
        MVI B, #09
o0d19:  CALL co1d82
        LXI H, #13a4
o0d1f:  CALL c12e4
        MVI B, #30
o0d24:  CALL co1d77
        LXI H, #2396
        MVI A, #04
o0d2c:  CALL c03ce
        LXI H, #23b6
o0d32:  CALL c03ce
        MVI A, #fa
o0d37:  JMP j0d3c
j0d3a:  MVI A, #3c ;o0ccf,o0d01,o0d0c
j0d3c:  STA $21a7 ;o0d37
o0d3f:  JMP jo147a
        LDA $2349
        MOV B,A
        LDA $23ee
        SUB B
o0d4a:  JM j0d58
        LDA $2194
        ANI #fd
        STA $2194
o0d55:  JMP jo0608
j0d58:  MVI A, #00 ;o0d4a
        STA $2197
        LDA $2194
        ORI #02
        STA $2194
        LXI H, #2190
        MVI A, #00
o0d6a:  CALL c03e6
o0d6d:  JNZ j0dba
        LXI H, #11e8
o0d73:  CALL c0f2a
o0d76:  JC j0d8d
        LXI H, #11e8
o0d7c:  CALL c026e
        MVI A, #0a
        STA $21a7
        LXI H, #13b5
o0d87:  CALL c12e4
o0d8a:  JMP jo0608
j0d8d:  LXI H, #11e8 ;o0d76
o0d90:  CALL c0eed
        LXI H, #235b
o0d96:  CALL c0fcd
        LXI H, #235b
o0d9c:  CALL c0f2a
        LXI H, #220c
        DCR M
o0da3:  JZ j0dba
        LXI H, #220d
o0da9:  CALL c0f00
        MVI A, #3c
        STA $21a7
        LXI H, #13b8
jo0db4: CALL c12e4 ;o0ddb
o0db7:  JMP jo0608
j0dba:  LXI H, #21c5 ;o0d6d,o0da3
        MOV A,M
        ORI #02
        MOV M,A
        MVI A, #09
        STA $21a6
        MVI B, #39
o0dc8:  CALL co1d82
        LDA $2194
        ANI #fd
        STA $2194
        MVI A, #00
        STA $220c
        LXI H, #13b8
o0ddb:  JMP jo0db4
j0dde:  LXI H, #21c5 ;o0cbc,o0cc7
        MVI A, #01
o0de3:  CALL c03ce
        MVI A, #06
        STA $21a6
o0deb:  JMP jo147a
        MVI A, #2b
o0df0:  JMP j0e07
        MVI A, #2c
o0df5:  JMP j0e07
        MVI A, #04
o0dfa:  JMP j0e07
        MVI A, #0c
o0dff:  JMP j0e07
        MVI A, #14
o0e04:  JMP j0e07
j0e07:  STA $2225 ;o0df0,o0df5,o0dfa,o0dff,o0e04
        LDA $2190
        ANI #04
o0e0f:  JNZ jo147a
        LDA $21af
        ORA A
o0e16:  JNZ j0e26
        LDA $2191
        ANI #df
        STA $2191
        MVI A, #80
        STA $2193
j0e26:  MVI A, #03 ;o0e16
        STA $21af
o0e2b:  JMP jo147a
        LDA $2191
        ANI #20
o0e33:  JZ j0e72
        LDA $21c4
        ORI #04
        STA $21c4
        MVI A, #09
        STA $2199
        LDA $2225
        MOV B,A
o0e47:  CALL co1d9d
o0e4a:  JZ j0e72
o0e4d:  CALL co1d82
o0e50:  JZ j0e62
        LXI H, #11e8
o0e56:  CALL c026e
        LXI H, #1363
o0e5c:  CALL c12e4
o0e5f:  JMP j0e72
j0e62:  LXI H, #11f4 ;o0e50
o0e65:  CALL c026e
        XCHG
o0e69:  CALL c0eed
        LXI H, #1375
o0e6f:  CALL c12e4
j0e72:  LDA $2191 ;o0e33,o0e4a,o0e5f
        ANI #df
        STA $2191
o0e7a:  JMP jo0608
c0e7d:  LXI D, #21f3 ;o0efa,o1004,o1090,o191f
        ORA A
        PUSH PSW
j0e82:  SBI #02 ;o0e9c
o0e84:  JM j0e9f
        MOV B,A
        POP PSW
        LDAX D
        ADC M
        DAA
        STAX D
        PUSH PSW
        MOV A,B
        ORA A
o0e90:  JNZ j0e9a
        POP PSW
        MVI A, #00
        ADC A
        INX D
        STAX D
        RET

j0e9a:  INX H ;o0e90
        INX D
o0e9c:  JMP j0e82
j0e9f:  MOV A,M ;o0e84
        ANI #0f
        MOV B,A
        POP PSW
        LDAX D
        ADC B
        DAA
        STAX D
        RET

c0ea9:  MVI C, #00 ;o0f39,o1050,o1089,o10c0,o11b5,o1dc2,o1de8,o1df8,o1e22,o1e32,o1e42,o1e8d,o1e9f,o1eb1,o1ec3,o1ed5,o1ee7,o1ef9,o1f0b,o1f1d,o1f2f
        ORA A
        LXI D, #21f3
        PUSH PSW
j0eb0:  SBI #02 ;o0ecb
o0eb2:  JM j0ece
        MOV B,A
        POP PSW
        MVI A, #9a
        SBB M
j0eba:  XCHG ;o0ed8
        ADD M
        DAA
        CMC
        MOV M,A
        PUSH PSW
o0ec0:  JNZ j0edb
j0ec3:  MOV A,B ;o0edd
        ORA A
o0ec5:  JZ j0ee0
        XCHG
        INX D
        INX H
o0ecb:  JMP j0eb0
j0ece:  MOV A,M ;o0eb2
        ANI #0f
        MOV B,A
        POP PSW
        MVI A, #9a
        SBB B
        MVI B, #00
o0ed8:  JMP j0eba
j0edb:  MVI C, #ff ;o0ec0
o0edd:  JMP j0ec3
j0ee0:  MOV A,C ;o0ec5
        ORA A
o0ee2:  JZ j0ee9
        POP PSW
        RC
        ORA C
        RET

j0ee9:  POP PSW ;o0ee2
        ANI #00
        RET

c0eed:  LXI D, #21f3 ;o0b20,o0b5a,o0d90,o0e69,o15ab,o164b,o195b
        MVI A, #08
o0ef2:  CALL c0f60
        LXI H, #235b
        MVI A, #08
o0efa:  CALL c0e7d
        LXI H, #21f3
c0f00:  LXI D, #235b ;o0da9,o192a,o1aed
        MVI A, #08
o0f05:  CALL c0f60
        LXI H, #235b
        LXI D, #23a0
        MVI A, #06
o0f10:  CALL c0f7b
        LDA $2190
        ANI #01
        RNZ
        LXI H, #23a0
        LXI D, #2380
        MVI A, #06
o0f21:  CALL c0f60
        MVI B, #39
o0f26:  CALL co1d77
        RET

c0f2a:  PUSH H ;o0d73,o0d9c,o193e,o1967
        LXI H, #235b
        LXI D, #21f3
        MVI A, #08
o0f33:  CALL c0f60
        POP H
        MVI A, #08
o0f39:  CALL c0ea9
        PUSH PSW
        LXI H, #21f3
        LXI D, #235b
        MVI A, #08
o0f45:  CALL c0f60
        LXI H, #235b
        LXI D, #2380
        MVI A, #06
o0f50:  CALL c0f7b
        LXI H, #2380
        LXI D, #23a0
        MVI A, #06
o0f5b:  CALL c0f60
        POP PSW
        RET

c0f60:  ORA A ;o016d,o0180,o0313,o031e,o0653,o0cda,o0ef2,o0f05,o0f21,o0f33,o0f45,o0f5b,o0fd2,o100e,o1021,o1048,o1060,o1081,o109a,o10ad,o10b8,o10cf,o10e5,o114e,o1159,o11ad,o1693,o1716,o1721,o18d3,o1914,o1b04,o1b0f,o1bf7,o1c02,o1c71,o1c9e,o1f41,o1f4f,o1f5b,o1f6b,o1f82,o1f96,o1fa0,o1fcd,o1fd7,o1fe0,o1ff6
j0f61:  SBI #02 ;o0f6d
o0f63:  JM j0f71
        MOV B,A
        MOV A,M
        STAX D
        INX H
        INX D
        MOV A,B
        ORA A
o0f6d:  JNZ j0f61
        RET

j0f71:  MOV A,M ;o0f63
        ANI #0f
        MOV B,A
        LDAX D
        ANI #f0
        ORA B
        STAX D
        RET

c0f7b:  RRC ;o0f10,o0f50,o1016,o106a,o1073,o10a2,o10da,o1cd0,o1cdb
        PUSH PSW
o0f7d:  JNC j0f83
        INR A
        ANI #7f
j0f83:  MOV C,A ;o0f7d
        DCR C
        MVI B, #00
        DAD B
        XCHG
        DAD B
        XCHG
        POP PSW
o0f8c:  JC j0fa5
        MOV A,M
j0f90:  ORA A ;o0fb7
o0f91:  JZ j0fbb
        ANI #f0
        MOV A,M
o0f97:  JNZ j0f9c
        ORI #f0
j0f9c:  STAX D ;o0f97,o0fa1,o0fc6
        DCX H
        DCX D
        MOV A,M
        DCR C
o0fa1:  JP j0f9c
        RET

j0fa5:  LDAX D ;o0f8c
        ANI #f0
        MOV B,A
        MOV A,M
        ANI #0f
o0fac:  JNZ j0fc5
        ORI #0f
        ORA B
j0fb2:  STAX D ;o0fc2
        DCX H
        DCX D
        DCR C
        MOV A,M
o0fb7:  JP j0f90
        RET

j0fbb:  MOV A,C ;o0f91
        DCR A
o0fbd:  JM j0fc9
        MVI A, #ff
o0fc2:  JMP j0fb2
j0fc5:  ORA B ;o0fac
o0fc6:  JMP j0f9c
j0fc9:  MVI A, #f0 ;o0fbd
        STAX D
        RET

c0fcd:  LXI D, #21f3 ;o0254,o0d96,o177e,o1789,o1961
        MVI A, #08
o0fd2:  CALL c0f60
        LXI H, #237e
        MVI A, #04
o0fda:  CALL c03e6
o0fdd:  JNZ j1160
        INR A
o0fe1:  CALL c03e6
o0fe4:  JNZ j1177
        INR A
o0fe8:  CALL c03e6
o0feb:  JNZ j118e
        LXI H, #2393
        PUSH H
        LXI H, #2373
        PUSH H
        LXI H, #236b
        PUSH H
        LXI H, #2390
        PUSH H
        LXI H, #236f
        PUSH H
j1002:  MVI A, #08 ;o1174,o118b,o11a2
o1004:  CALL c0e7d
        POP D
        PUSH D
        LXI H, #21f3
        MVI A, #08
o100e:  CALL c0f60
        POP H
        POP D
        PUSH D
        MVI A, #06
o1016:  CALL c0f7b
        POP D
        LXI H, #0020
        DAD D
        XCHG
        MVI A, #06
o1021:  CALL c0f60
        LXI H, #237e
        MVI A, #03
o1029:  CALL c03e6
o102c:  JNZ j108d
        POP H
        POP H
        POP H
        LDA $237e
        ANI #0f
        CPI #03
        RNZ
        LDA DIP_SWITCHES
        ANI #08
        RNZ
        LXI H, #2363
        LXI D, #21f3
        MVI A, #07
o1048:  CALL c0f60
        LXI H, #236b
        MVI A, #07
o1050:  CALL c0ea9
        PUSH PSW
o1054:  CC c1079
        LXI H, #21f3
        LXI D, #2377
        PUSH D
        MVI A, #06
o1060:  CALL c0f60
        POP H
        PUSH H
        LXI D, #2397
        MVI A, #06
o106a:  CALL c0f7b
        POP H
        LXI D, #23b7
        MVI A, #06
o1073:  CALL c0f7b
o1076:  JMP j10e8
c1079:  LXI H, #236b ;o1054
        LXI D, #21f3
        MVI A, #07
o1081:  CALL c0f60
        LXI H, #2363
        MVI A, #07
o1089:  CALL c0ea9
        RET

j108d:  POP H ;o102c
        MVI A, #08
o1090:  CALL c0e7d
        LXI H, #21f3
        POP D
        PUSH D
        MVI A, #07
o109a:  CALL c0f60
        POP H
        POP D
        PUSH D
        MVI A, #07
o10a2:  CALL c0f7b
        POP D
        LXI H, #0020
        DAD D
        XCHG
        MVI A, #07
o10ad:  CALL c0f60
        LXI H, #2367
        LXI D, #21f3
        MVI A, #07
o10b8:  CALL c0f60
        LXI H, #2373
        MVI A, #07
o10c0:  CALL c0ea9
        PUSH PSW
o10c4:  JC j11a5
j10c7:  LXI H, #21f3 ;o11b8
        LXI D, #2377
        MVI A, #06
o10cf:  CALL c0f60
        LXI H, #2377
        LXI D, #2397
        MVI A, #06
o10da:  CALL c0f7b
        LXI H, #2397
        LXI D, #23b7
        MVI A, #06
o10e5:  CALL c0f60
j10e8:  POP PSW ;o1076
o10e9:  JZ j1138
o10ec:  JC j1124
        LXI H, #236a
        MVI A, #04
o10f4:  CALL c03e6
o10f7:  JZ jo10fb
        RET

jo10fb: CALL c03ce ;o10f7
        MVI A, #05
jo1100: CALL c03d9 ;o1135
        PUSH H
        PUSH B
        LXI H, #1399
jo1108: CALL c12e4 ;o06e0
        LXI H, #21a7
        MOV A,M
        ORA A
o1110:  JZ j1115
        MVI M, #7d
j1115:  LXI H, #21ae ;o1110
        MOV A,M
        ORA A
o111a:  JZ j111f
        MVI M, #7d
j111f:  POP B ;o111a
        POP H
o1121:  JMP j11bb
j1124:  LXI H, #236a ;o10ec
        MVI A, #05
o1129:  CALL c03e6
o112c:  JZ jo1130
        RET

jo1130: CALL c03ce ;o112c
        MVI A, #04
o1135:  JMP jo1100
j1138:  LXI H, #236a ;o10e9
        MVI A, #04
o113d:  CALL c03d9
        MVI A, #05
o1142:  CALL c03d9
        PUSH H
        LXI H, #1208
        LXI D, #2397
        MVI A, #06
o114e:  CALL c0f60
        LXI H, #1208
        LXI D, #23b7
        MVI A, #06
o1159:  CALL c0f60
        POP H
o115d:  JMP j11bb
j1160:  LXI H, #2389 ;o0fdd
        PUSH H
        LXI H, #2367
        PUSH H
        LXI H, #235f
        PUSH H
        LXI H, #2386
        PUSH H
        LXI H, #2363
        PUSH H
o1174:  JMP j1002
j1177:  LXI H, #2393 ;o0fe4
        PUSH H
        LXI H, #2373
        PUSH H
        LXI H, #236f
        PUSH H
        LXI H, #238d
        PUSH H
        LXI H, #236b
        PUSH H
o118b:  JMP j1002
j118e:  LXI H, #2389 ;o0feb
        PUSH H
        LXI H, #2367
        PUSH H
        LXI H, #2363
        PUSH H
        LXI H, #2383
        PUSH H
        LXI H, #235f
        PUSH H
o11a2:  JMP j1002
j11a5:  LXI H, #2373 ;o10c4
        LXI D, #21f3
        MVI A, #07
o11ad:  CALL c0f60
        LXI H, #2367
        MVI A, #07
o11b5:  CALL c0ea9
o11b8:  JMP j10c7
j11bb:  MOV A,M ;o1121,o115d
        ANI #30
        MOV B,A
        LDA $238c
        ANI #0f
        ORA B
        STA $238c
        STA $23ac
        RET

        NOP
        NOP
        NOP
        NOP
        LXI B, #0000
        NOP
        (ARHL)
        NOP
        NOP
        NOP
        DCR H
        NOP
        NOP
        NOP
        MOV D,B
        NOP
        NOP
        NOP
        NOP
        LXI B, #0000
        NOP
        DCR B
        NOP
        NOP
        NOP
        (ARHL)
        NOP
        NOP
        NOP
        RIM
        NOP
        NOP
        NOP
        MOV B,B
        NOP
        NOP
        NOP
        MOV D,B
        NOP
        NOP
        NOP
        MOV H,B
        NOP
        NOP
        NOP
        ADD B
        NOP
        NOP
        NOP
        NOP
        LXI B, #0000
        MOV D,B
        STAX B
        NOP
        RP
        RST 7
        RST 7
        RST 7
        RST 7
        RST 7
        RST 7
        RST 7
c1210:  MVI A, #ff ;o12be,o12de
        OUT #09
        LXI D, #132f
        MOV A,L
        SUB E
        MOV A,H
        SBB D
        RM
        LXI D, #13dd
        MOV A,E
        SUB L
        MOV A,D
        SBB H
        RM
        MOV A,M
        CMA
        OUT #0a
        INX H
        MOV A,M
        CMA
        OUT #09
        CMA
        SHLD $21b1
        LXI D, #127f
        CPI #00
o1236:  JZ j1272
        CPI #02
o123b:  JZ j1271
        CPI #04
o1240:  JZ j1270
        CPI #08
o1245:  JZ j126f
        CPI #0c
o124a:  JZ j126e
        CPI #10
o124f:  JZ j126d
        CPI #2c
o1254:  JZ j126c
        CPI #28
o1259:  JZ j126b
        CPI #24
o125e:  JZ j126a
        CPI #20
o1263:  JZ j1269
o1266:  JMP j1272
j1269:  INX D ;o1263
j126a:  INX D ;o125e
j126b:  INX D ;o1259
j126c:  INX D ;o1254
j126d:  INX D ;o124f
j126e:  INX D ;o124a
j126f:  INX D ;o1245
j1270:  INX D ;o1240
j1271:  INX D ;o123b
j1272:  LDAX D ;o1236,o1266
        STA $2198
        LXI H, #2190
        MVI A, #05
o127b:  CALL c03ce
        RZ
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
o128e:  CALL c03e6
o1291:  JNZ jo12a5
        MVI A, #06
o1296:  CALL c03ce
        MVI A, #fe
        OUT #09
        MVI A, #02
        STA $2198
o12a2:  JMP jo0608
jo12a5: CALL c03d9 ;o1291
        MVI A, #06
o12aa:  CALL c03e6
o12ad:  JNZ jo12d8
        MVI A, #ff
        OUT #09
        LHLD $21b1
        INX H
        MOV A,M
        CPI #ff
o12bb:  JZ j12c4
o12be:  CALL c1210
o12c1:  JMP jo0608
j12c4:  LDA $21b3 ;o12bb
        CPI #00
o12c9:  JNZ jo12db
        MVI A, #ff
        OUT #09
        MVI A, #0c
        STA $2198
o12d5:  JMP jo0608
jo12d8: CALL c03d9 ;o12ad
jo12db: CALL c130f ;o12c9
o12de:  CALL c1210
o12e1:  JMP jo0608
c12e4:  XCHG ;o053b,o0558,o058e,o073e,o07d7,o08cc,o0984,o0b01,o0b26,o0b60,o0bc3,o0c41,o0d1f,o0d87,jo0db4,o0e5c,o0e6f,jo1108,o151e,o1550,o15e1,o1602,o162c,o1651,o1800,o18c7,o1935,o1952,o1a2e,o1adf,o1b6d,o1fba,o1fc0
        LHLD $21be
        LXI B, #21be
        MOV A,C
        STA $21b3
        SUB L
o12f0:  JNZ j12f6
        LXI H, #21b4
j12f6:  MOV M,E ;o12f0
        INX H
        MOV M,D
        INX H
        SHLD $21be
        LXI H, #2190
        MVI A, #05
o1302:  CALL c03e6
        RNZ
o1306:  CALL c03ce
        MVI A, #01
        STA $2198
        RET

c130f:  LHLD $21c0 ;jo12db
        LXI B, #21be
        MOV A,C
        SUB L
o1317:  JNZ j131d
        LXI H, #21b4
j131d:  MOV E,M ;o1317
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
        RZ
        (DSUB)
o1332:  (JK) j08aa
        RST 7
        ADD L
        (DSUB)
        RST 7
        MOV H,L
        (DSUB)
        RST 7
        INR E
        INR C
o133e:  CM jc0c1c
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
        MOV B,E
        INR C
        MOV D,L
        INR C
        MOV H,L
        INR C
        MOV M,D
        INR C
        RST 7
        CPI #21
        SUB C
        LXI H, #033e
o13e3:  CALL c03d9
        OUT #0f
        LXI H, #23e0
        LXI D, #233b
j13ee:  MOV B,M ;o140b
        LDAX D
        ADI #04
        SUB B
o13f3:  JP j13f8
        CMA
        INR A
j13f8:  CPI #03 ;o13f3
o13fa:  JC j1405
        LDA $2191
        ORI #08
        STA $2191
j1405:  MOV A,B ;o13fa
        SUI #04
        STAX D
        INX D
        INR L
o140b:  JNZ j13ee
        LDA $2191
        ANI #08
        JNZ $13de
o1416:  CALL c02df
        SHLD $2223
        RET

        LXI H, #2191
        MVI A, #06
o1422:  CALL c03ce
        LXI H, #23e0
        LXI D, #233b
j142b:  LDAX D ;o1432
        SUB M
o142d:  JP j144b
j1430:  INX D ;jo147d
        INR L
o1432:  JNZ j142b
        LXI H, #2191
        MVI A, #06
o143a:  CALL c03e6
o143d:  JZ j1445
        MVI A, #05
o1442:  CALL c03d9
j1445:  MVI A, #01 ;o143d
        DI
o1448:  JMP j036e
j144b:  DI ;o142d
        PUSH H
        LXI H, #2191
        MVI A, #06
o1452:  CALL c03d9
        INR A
o1456:  CALL c03e6
o1459:  JNZ jo1463
o145c:  CALL c03ce
        POP H
o1460:  JMP jo147d
jo1463: CALL c03d9 ;o1459
        POP H
o1467:  CALL c060e
        MOV A,L
        SUI #e0
        MOV L,A
        MVI H, #00
        DAD H
        LXI D, #1480
        DAD D
        MOV A,M
        INX H
        MOV H,M
        MOV L,A
        PCHL
jo147a: CALL c061a ;o0a7d,o0a92,o0a9f,o0abe,o0b0e,o0c38,o0c44,o0d3f,o0deb,o0e0f,o0e2b,o1502,o150c,o1526,o1533,o159a,o15a5,o1605,o161d,o162f,o163a,o1642,o1654,o187e,o188e,o1896,o18f4,o1938
jo147d: JMP j1430 ;o1460
        STA $7a16
        INR D
        MOV A,D
        INR D
        MOV A,D
        INR D
        MOV A,D
        INR D
        MOV A,D
        INR D
        MOV A,D
        INR D
        MOV A,D
        INR D
        (DSUB)
        MVI D, #c7
        INR D
        ACI #14
        XTHL
        INR D
        PUSH D
        INR D
        CC $6b14
        LDAX B
        SUB D
        DCR D
        JPE $f114
        INR D
        MOV H,H
        LDAX B
        RNZ
        INR D
        MOV E,L
        LDAX B
        RM
        DCR C
o14ac:  (JK) j020d
        MVI C, #76
        (RLDE)
        MOV D,M
        LDAX B
        DI
        DCR C
        MOV C,A
        LDAX B
        XRI #0d
        MOV C,B
        LDAX B
        (DSUB)
        MVI D, #32
        MVI D, #0e
        NOP
        MVI B, #02
o14c4:  JMP j14f5
        MVI C, #01
        MVI B, #2a
o14cb:  JMP j14f5
        MVI C, #02
        MVI B, #10
o14d2:  JMP j14f5
        MVI C, #03
        MVI B, #1a
o14d9:  JMP j14f5
        MVI C, #04
        MVI B, #01
o14e0:  JMP j14f5
        MVI C, #05
        MVI B, #19
o14e7:  JMP j14f5
        MVI C, #06
        MVI B, #21
        POP B
        PUSH PSW
        INR D
        MVI C, #07
        MVI B, #0a
j14f5:  LXI H, #2090 ;o14c4,o14cb,o14d2,o14d9,o14e0,o14e7
        MVI A, #07
o14fa:  CALL c03ce
        MVI A, #02
o14ff:  CALL c03e6
o1502:  JNZ jo147a
        MOV A,C
        LXI H, #21c6
o1509:  CALL c03e6
o150c:  JZ jo147a
o150f:  CALL c03d9
o1512:  CALL co1d82
        LXI H, #11e4
o1518:  CALL c026e
        LXI H, #135a
o151e:  CALL c12e4
        LDA $21c6
        CPI #00
o1526:  JNZ jo147a
        MVI A, #3d
        STA $21a4
        MVI A, #00
        STA $2205
o1533:  JMP jo147a
        LDA $2205
        INR A
        STA $2205
        CPI #09
o153f:  JZ j155b
        MVI D, #00
        MOV E,A
        LXI H, #1589
        DAD D
        MOV B,M
o154a:  CALL co1d77
        LXI H, #135a
o1550:  CALL c12e4
        MVI A, #0a
        STA $21a4
o1558:  JMP jo0608
j155b:  MVI B, #11 ;o153f
o155d:  CALL co1d9d
o1560:  JNZ jo1573
        MVI B, #38
o1565:  CALL co1d9d
o1568:  JNZ j157e
        MVI B, #11
o156d:  CALL co1d77
o1570:  JMP j157e
jo1573: CALL co1d82 ;o1560
        MVI B, #38
o1578:  CALL co1d77
o157b:  JMP j157e
j157e:  MVI A, #ff ;o1568,o1570,o157b
        STA $21c6
        SUB A
        STA $2205
o1587:  JMP jo0608
        STAX B
        LHLD $1a10
        LXI B, #2119
        LDAX B
        LXI H, #2190
        MVI A, #07
o1597:  CALL c03e6
o159a:  JZ jo147a
o159d:  CALL c03d9
        MVI A, #02
o15a2:  CALL c03e6
o15a5:  JNZ jo147a
        LXI H, #1200
o15ab:  CALL c0eed
        LXI H, #2190
        MVI A, #04
o15b3:  CALL c03e6
o15b6:  JZ j15e4
        LXI H, #2191
        MVI A, #01
o15be:  CALL c03e6
o15c1:  JNZ j15e4
o15c4:  CALL c03ce
        LDA $21c7
        MVI B, #ff
j15cc:  INR B ;o15ce
        RAR
o15ce:  JNC j15cc
        MOV A,B
        DCR A
o15d3:  JP j15d8
        MVI A, #04
j15d8:  STA $2211 ;o15d3
o15db:  CALL c03fa
        LXI H, #13bb
o15e1:  CALL c12e4
j15e4:  LXI H, #2190 ;o15b6,o15c1
        MVI A, #03
o15e9:  CALL c03e6
o15ec:  JNZ j15ff
        MVI B, #09
o15f1:  CALL co1d9d
o15f4:  JZ j15ff
o15f7:  CALL co1d82
        MVI B, #31
o15fc:  CALL co1d92
j15ff:  LXI H, #1370 ;o15ec,o15f4
o1602:  CALL c12e4
o1605:  JMP jo147a
        MVI A, #ff
        STA $2193
        LDA $2194
        ORI #30
        STA $2194
        LXI H, #2190
        MVI A, #02
o161a:  CALL c03e6
o161d:  JNZ jo147a
o1620:  CALL c03ce
        LXI H, #11e8
o1626:  CALL c026e
        LXI H, #13ce
o162c:  CALL c12e4
o162f:  JMP jo147a
        LXI H, #2190
        MVI A, #02
o1637:  CALL c03e6
o163a:  JNZ jo147a
        MVI A, #07
o163f:  CALL c03e6
o1642:  JZ jo147a
o1645:  CALL c03d9
        LXI H, #11e8
o164b:  CALL c0eed
        LXI H, #13b8
o1651:  CALL c12e4
o1654:  JMP jo147a
        LXI H, #2192
        MVI A, #00
o165c:  CALL c03e6
o165f:  JNZ j1803
        LDA CREDITS_1
        ORA A
o1666:  JNZ j167c
        LDA $239e
        ANI #08
o166e:  JNZ j1803
        LDA $23b6
        ORI #80
        STA $23b6
o1679:  JMP j1803
j167c:  LDA BALL_IN_PLAY_hrm ;o1666
        ANI #0f
        CPI #01
o1683:  JZ j1749
        CPI #00
o1688:  JZ j1749
        LXI H, #23a3
        LXI D, #2320
        MVI A, #2e
o1693:  CALL c0f60
o1696:  CALL c1822
        LXI H, #2192
        MVI A, #04
o169e:  CALL c03e6
o16a1:  JZ j16b1
        MVI A, #07
o16a6:  CALL c03e6
o16a9:  JZ j16b1
        MVI A, #01
o16ae:  JMP j16cd
j16b1:  MVI A, #06 ;o16a1,o16a9
o16b3:  CALL c03ce
        LDA $2190
        ORI #05
        STA $2190
        MVI A, #ff
        STA $2193
        LDA $2194
        ORI #30
        STA $2194
        MVI A, #00
j16cd:  STA BALL_IN_PLAY_hrm ;o16ae
        STA BALL_IN_PLAY_1
; decrease credits
        STA BALL_IN_PLAY_2
        MVI A, #11
        STA $237e
        STA $23be
        MVI A, #01
        STA $239e
        MVI A, #f0
        STA $2386
        STA $23a6
        STA $2380
        STA $23a0
        MVI A, #00
        STA $2214
        LXI D, #21d3
        MVI B, #04
o16fb:  CALL jc1808
        LXI H, #2192
        MVI A, #06
o1703:  CALL c03d9
        LXI H, #23b6
        MVI A, #06
o170b:  CALL c03d9
        LXI H, #21d3
        LXI D, #21c6
        MVI A, #10
o1716:  CALL c0f60
        LXI H, #21c9
        LXI D, #21ce
        MVI A, #0a
o1721:  CALL c0f60
        LXI H, #2190
        MVI A, #04
o1729:  CALL c03d9
j172c:  LDA CREDITS_1 ;o17e4
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
o1746:  JMP j17e7
j1749:  LDA $237e ;o1683,o1688
        ANI #08
o174e:  JNZ j1803
j1751:  MVI A, #01 ;o17fa
        LXI H, #237e
o1756:  CALL c03e6
o1759:  JZ jo1794
        MVI A, #02
o175e:  CALL c03e6
o1761:  JZ jo17b2
        MVI A, #03
o1766:  CALL c03ce
        MVI A, #f0
        STA $2390
        STA $23b0
        DI
        LDA $237e
        PUSH PSW
        MVI A, #1f
        STA $237e
        LXI H, #11cc
o177e:  CALL c0fcd
        MVI A, #2f
        STA $237e
        LXI H, #11cc
o1789:  CALL c0fcd
        POP PSW
        STA $237e
        EI
o1791:  JMP j17d4
jo1794: CALL c03ce ;o1759
        MVI A, #f0
        STA $238d
        STA $23ad
        LDA DIP_SWITCHES
        ANI #08
o17a4:  JNZ j17d4
        MVI A, #f0
        STA $2397
        STA $23b7
o17af:  JMP j17d4
jo17b2: CALL c03ce ;o1761
        MVI A, #f0
        STA $2383
        STA $23a3
        MVI A, #ff
        STA $2397
        STA $2398
        STA $2399
        STA $23b7
        STA $23b8
        STA $23b9
o17d1:  JMP j17d4
j17d4:  LDA $237e ;o1791,o17a4,o17af,o17d1
        STA $23be
        ANI #0f
        MOV B,A
        LDA $239e
        ORA B
        STA $239e
o17e4:  JMP j172c
j17e7:  IN DIP_SWITCH_PORT ;o1746
        ANI #80
o17eb:  JNZ j17fd
        LDA CREDITS_1
        ORA A
o17f2:  JZ j17fd
        LDA $237e
        ANI #08
o17fa:  JZ j1751
j17fd:  LXI H, #135d ;o17eb,o17f2
o1800:  CALL c12e4
j1803:  MVI A, #06 ;o165f,o166e,o1679,o174e
o1805:  JMP j036e
jc1808: LXI H, #181a ;o0175,o16fb,o1816
        MVI C, #08
j180d:  MOV A,M ;o1812
        STAX D
        INX D
        INX H
        DCR C
o1812:  JNZ j180d
        DCR B
o1816:  JNZ jc1808
        RET

        RST 7
        RAR
        LXI B, #3904
        DCX H
        STC
        STC
c1822:  LXI H, #235b ;jo0138,o1696
        MVI A, #00
        MVI D, #1f
j1829:  MOV M,A ;o182c
        INX H
        DCR D
o182c:  JNZ j1829
        LXI H, #2380
        MVI A, #ff
        MVI D, #1a
j1836:  MOV M,A ;o1839
        INX H
        DCR D
o1839:  JNZ j1836
        LXI H, #23a0
        MVI A, #ff
        MVI D, #1a
j1843:  MOV M,A ;o1846
        INX H
        DCR D
o1846:  JNZ j1843
        MVI A, #0f
        STA $238c
        STA $23ac
        STA $2396
        STA $23b6
        RET

c1858:  LDA $237e ;o18ee,o196a
        ANI #02
        MVI A, #20
        RZ
        LXI H, #2190
        MVI A, #03
o1865:  CALL c03e6
        MVI A, #20
        RNZ
        LDA $2214
        CPI #01
        MVI A, #20
        RZ
        MVI A, #80
        RET

        LXI H, #2192
        MVI A, #04
o187b:  CALL c03e6
o187e:  JNZ jo147a
        LXI H, #2208
        MVI A, #ff
        ADD M
o1887:  JNC j1891
        MOV M,A
o188b:  JZ j1899
o188e:  JMP jo147a
j1891:  MVI A, #32 ;o1887
        STA $2208
o1896:  JMP jo147a
j1899:  MVI A, #ff ;o188b
        STA $2193
        MVI A, #00
        STA $220c
        STA $21c3
        STA $21a8
        STA $21a9
        LDA $2194
        ORI #30
        STA $2194
        LXI H, #2190
        MVI A, #02
o18b9:  CALL c03ce
        LXI H, #2192
        MVI A, #04
o18c1:  CALL c03ce
        LXI H, #136b
o18c7:  CALL c12e4
o18ca:  CALL c1ba3
        XCHG
        LXI H, #21c6
        MVI A, #10
o18d3:  CALL c0f60
        LXI H, #2190
        MVI A, #00
o18db:  CALL c03e6
o18de:  JNZ j18e9
        MVI B, #39
o18e3:  CALL co1d9d
o18e6:  JNZ j18f7
j18e9:  MVI A, #02 ;o18de
        STA $21a0
o18ee:  CALL c1858
        STA $221c
o18f4:  JMP jo147a
j18f7:  LHLD $235c ;o18e6
        DAD H
        DAD H
        DAD H
        DAD H
        SHLD $21f3
        LHLD $235d
        DAD H
        DAD H
        DAD H
        DAD H
        MOV A,H
        STA $21f5
        LXI H, #21f3
        LXI D, #220d
        MVI A, #06
o1914:  CALL c0f60
        MVI A, #04
j1919:  PUSH PSW ;o1924
        LXI H, #220d
        MVI A, #06
o191f:  CALL c0e7d
        POP PSW
        DCR A
o1924:  JNZ j1919
        LXI H, #21f3
o192a:  CALL c0f00
        MVI A, #3c
        STA $21ae
        LXI H, #13b8
o1935:  CALL c12e4
o1938:  JMP jo147a
        LXI H, #11e8
o193e:  CALL c0f2a
o1941:  JC j1958
        LXI H, #11e8
o1947:  CALL c026e
        MVI A, #0a
        STA $21ae
        LXI H, #13b5
o1952:  CALL c12e4
o1955:  JMP jo0608
j1958:  LXI H, #11e8 ;o1941
o195b:  CALL c0eed
        LXI H, #235b
o1961:  CALL c0fcd
        LXI H, #235b
o1967:  CALL c0f2a
o196a:  CALL c1858
        STA $221c
        LDA $221c
        DCR A
        STA $221c
o1977:  JZ j1982
        MVI A, #02
        STA $21a0
o197f:  JMP jo0608
j1982:  MVI A, #01 ;o1977
        STA $2212
        MVI A, #32
        STA $2194
        LXI H, #2192
        MVI A, #03
o1991:  CALL c03d9
        LXI H, #2190
o1997:  CALL c03e6
o199a:  JZ j19b9
o199d:  CALL c03d9
        MVI A, #02
        STA $2212
        MVI B, #30
o19a7:  CALL co1d92
        LXI H, #2396
        MVI A, #04
o19af:  CALL c03d9
        LXI H, #2214
        INR M
o19b6:  JMP j1a8a
j19b9:  LDA BALL_IN_PLAY_hrm ;o199a
        ORA A
        MVI A, #01
        LXI H, #237e
o19c2:  JZ j1a5b
        MVI A, #04
jo19c7: CALL c03e6 ;o19d0
o19ca:  JNZ jo19d3
        INR A
        CPI #08
o19d0:  JNZ jo19c7
jo19d3: CALL c03d9 ;o19ca
        INR A
        MOV C,A
        SUI #04
o19da:  CALL c03e6
        MOV A,C
o19de:  JNZ jo1a69
        LDA BALLS_PER_GAME
        INR A
        MOV B,A
        LDA BALL_IN_PLAY_hrm
        INR A
        CMP B
o19eb:  JNZ j1a5b
        LXI H, #2191
        MVI A, #00
o19f3:  CALL c03e6
        MVI A, #01
o19f8:  JNZ j1a5b
        LDA $2192
        ORI #c0
        STA $2192
        LXI H, #23b6
        MVI A, #06
o1a08:  CALL c03ce
        LDA $23ac
        ANI #30
o1a10:  JZ j1a1c
        CPI #10
        MVI A, #05
o1a17:  JZ j1a1c
        MVI A, #0a
j1a1c:  STA $23be ;o1a10,o1a17
        SUB A
        STA $239e
        LDA $238c
        ANI #0f
        STA $238c
        LXI H, #1382
o1a2e:  CALL c12e4
        MVI A, #00
        STA BALL_IN_PLAY_1
        STA BALL_IN_PLAY_2
        MVI A, #fa
        STA $219e
        LDA DIP_SWITCHES
        ANI #04
o1a43:  CZ c1db8
        MVI B, #00
o1a48:  CALL co1d9d
o1a4b:  JZ jo0608
        MVI A, #7d
        STA $219a
        MVI A, #2d
        STA $2217
o1a58:  JMP jo0608
j1a5b:  STA BALL_IN_PLAY_hrm ;o19c2,o19eb,o19f8
        STA BALL_IN_PLAY_1
        STA BALL_IN_PLAY_2
        MVI A, #04
        LXI H, #237e
jo1a69: CALL c03ce ;o19de
        LDA BALLS_PER_GAME
        MOV C,A
        LDA BALL_IN_PLAY_hrm
        CMP C
o1a74:  JNZ j1a8a
        LXI H, #2190
        MVI A, #04
o1a7c:  CALL c03ce
        MVI B, #00
o1a81:  CALL co1d9d
o1a84:  JZ j1a8a
o1a87:  CALL co1d92
j1a8a:  LDA $237e ;o19b6,o1a74,o1a84
        STA $23be
        MOV B,A
        ANI #0f
        STA $239e
        LXI H, #2190
        MVI A, #00
o1a9b:  CALL c03d9
        MVI A, #03
o1aa0:  CALL c03d9
        MVI B, #09
o1aa5:  CALL co1d82
        LXI H, #23b6
        MVI A, #05
o1aad:  CALL c03d9
        MVI A, #02
        STA $21a1
o1ab5:  JMP jo0608
        LDA $2217
        DCR A
        STA $2217
o1abf:  JNZ j1aca
        MVI B, #00
o1ac4:  CALL co1d82
o1ac7:  JMP jo0608
j1aca:  MVI A, #7d ;o1abf
        STA $219a
o1acf:  JMP jo0608
        LDA $2212
        DCR A
        STA $2212
o1ad9:  JZ j1aea
        LXI H, #13a4
o1adf:  CALL c12e4
        MVI A, #a0
        STA $21a1
o1ae7:  JMP jo0608
j1aea:  LXI H, #11cc ;o1ad9
o1aed:  CALL c0f00
        LDA $21c9
        STA $2218
        LDA $21ce
        STA $2219
o1afc:  CALL c1ba3
        LXI D, #21c6
        MVI A, #10
o1b04:  CALL c0f60
        LXI H, #21c9
        LXI D, #21ce
        MVI A, #0a
o1b0f:  CALL c0f60
        MVI B, #2b
o1b14:  CALL co1d77
        MVI B, #2c
o1b19:  CALL co1d77
        MVI B, #04
o1b1e:  CALL co1d77
        MVI B, #0c
o1b23:  CALL co1d77
        MVI B, #14
o1b28:  CALL co1d77
        MVI B, #11
o1b2d:  CALL co1d82
        MVI B, #38
o1b32:  CALL co1d82
        MVI B, #31
o1b37:  CALL co1d82
        MVI B, #09
o1b3c:  CALL co1d82
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
o1b5f:  CALL co1d82
        LXI H, #2192
        MVI A, #07
o1b67:  CALL c03ce
        LXI H, #13c9
o1b6d:  CALL c12e4
        LDA $2214
        DCR A
        STA $2214
        SUI #02
o1b79:  JM jo1ba0
o1b7c:  JNZ jo1ba0
        LDA $237e
        MVI B, #00
        ANI #0f
j1b86:  RAR ;o1b8b
o1b87:  JNC j1b8e
        INR B
o1b8b:  JMP j1b86
j1b8e:  LDA CREDITS_1 ;o1b87
        SUB B
o1b92:  JP jo1ba0
        MVI B, #00
o1b97:  CALL co1d9d
o1b9a:  JNZ jo1ba0
o1b9d:  CALL co1d77
jo1ba0: JMP jo0608 ;o1b79,o1b7c,o1b92,o1b9a
c1ba3:  LDA $237e ;o18ca,o1afc
        ANI #f0
        LXI H, #21eb
        LXI D, #fff8
j1bae:  RAL ;o1bb1
        RC
        DAD D
o1bb1:  JMP j1bae
j1bb4:  EI ;o0260
        LXI H, #2215
        IN PRICE_89_CAB
        MOV M,A
        LDA $2192
        ANI #04
o1bc0:  JNZ j1c53
        DI
        LDA $2353
        MOV B,A
        LDA $23f8
        SUB B
        LDA $2194
o1bcf:  JM j1bd7
        ANI #dd
o1bd4:  JMP j1bdb
j1bd7:  ORI #02 ;o1bcf
        ANI #df
j1bdb:  STA $2194 ;o1bd4
        LDA $2192
        ANI #01
        EI
o1be4:  JZ j1c05
        LDA $2192
        ANI #fe
        STA $2192
        LXI H, #2244
        LXI D, #2380
        MVI A, #34
o1bf7:  CALL c0f60
        LXI H, #2264
        LXI D, #23a0
        MVI A, #34
o1c02:  CALL c0f60
j1c05:  LDA $2215 ;o1be4
        ANI #20
o1c0a:  JNZ j1ce1
        EI
        LDA $2192
        ANI #40
o1c13:  JZ j1c2e
        LDA CREDITS_1
        ORA A
        LXI H, #23b6
        MVI A, #07
o1c1f:  JNZ jo1c28
o1c22:  CALL c03ce
o1c25:  JMP j01a2
jo1c28: CALL c03d9 ;o1c1f
o1c2b:  JMP j01a2
j1c2e:  LDA $2191 ;o1c13
        ANI #01
        EI
o1c34:  JZ j01a2
        IN PRICE_TENS_07_PORT
; seems pointless
        CPI #fe
o1c3b:  JNZ j1c45
        IN PRICE_CENTS_07_PORT
        CPI #fb
o1c42:  JZ j1cfa
j1c45:  LXI H, #2191 ;o1c3b
        MVI A, #00
o1c4a:  CALL c03d9
        STA $219f
o1c50:  JMP j01a2
j1c53:  LXI H, #2192 ;o1bc0
        MVI A, #00
o1c58:  CALL c03e6
o1c5b:  JNZ j0208
o1c5e:  CALL c03ce
        LDA $2241
        ANI #01
o1c66:  JNZ j1c74
        LXI H, #2380
        LXI D, #2244
        MVI A, #80
o1c71:  CALL c0f60
j1c74:  MVI A, #ff ;o1c66
        LXI H, #2383
        MVI B, #17
j1c7b:  MOV M,A ;o1c7e
        INX H
        DCR B
o1c7e:  JNZ j1c7b
        MVI A, #0f
        STA $238c
        LDA DIP_SWITCHES
        ANI #04
o1c8b:  JNZ j1c96
        LDA $2241
        ANI #01
o1c93:  JNZ j1cbb
j1c96:  LXI H, #2320 ;o1c8b
        LXI D, #23a3
        MVI A, #2e
o1c9e:  CALL c0f60
j1ca1:  LDA $225a ;o1cde
        ORI #0f
        STA $2396
        LDA $227a
        ANI #f0
        MOV B,A
        LDA $23b6
        ANI #0f
        ORA B
        STA $23b6
o1cb8:  JMP j0208
j1cbb:  LXI H, #23a3 ;o1c93
        MVI C, #17
        MVI A, #ff
j1cc2:  MOV M,A ;o1cc5
        INX H
        DCR C
o1cc5:  JNZ j1cc2
        LXI D, #23a9
        LXI H, #2228
        MVI A, #08
o1cd0:  CALL c0f7b
        LXI D, #23b3
        LXI H, #222c
        MVI A, #08
o1cdb:  CALL c0f7b
o1cde:  JMP j1ca1
j1ce1:  LDA $2353 ;o1c0a
        MOV B,A
        LDA $23f8
        SUB B
o1ce9:  JP j0208
        LXI H, #2192
        MVI A, #06
o1cf1:  CALL c03e6
o1cf4:  JZ j1cfa
o1cf7:  JMP j0208
j1cfa:  LDA $237e ;o1c42,o1cf4
        STA $239e
        LDA $23ac
        STA $238c
        MVI B, #30
o1d08:  CALL co1d82
        LDA $2396
        ANI #cf
        STA $2396
        LDA $23b6
        ANI #cf
        STA $23b6
        LXI H, #21c2
        MVI A, #05
o1d20:  CALL c03ce
        LDA $21c2
        CMA
        OUT #05
        MVI A, #80
        STA $2193
        MVI A, #06
        STA $21ac
        MVI A, #00
        STA $2194
        LDA $2190
        ANI #30
        ORI #80
        STA $2190
        LDA $2192
        ANI #67
        STA $2192
        LXI H, #2191
        MVI A, #01
o1d4f:  CALL c03d9
        LXI H, #2194
        MVI A, #04
o1d57:  CALL c03ce
        MVI A, #06
        STA $21a8
        MVI A, #05
        STA $2197
o1d64:  JMP j0208
        LXI H, #21c2
        MVI A, #05
o1d6c:  CALL c03d9
        DI
        CALL $13de
        EI
o1d74:  JMP jo0608
co1d77: CALL c1da4 ;o0bbd,o0bfb,o0c13,o0c3b,o0d24,o0f26,o154a,o156d,o1578,o1b14,o1b19,o1b1e,o1b23,o1b28,o1b9d
o1d7a:  CALL c03ce
        DAD D
o1d7e:  CALL c03ce
        RET

co1d82: CALL c1da4 ;o0501,o09c5,jo0ac1,o0c19,o0d14,o0d19,o0dc8,o0e4d,o1512,jo1573,o15f7,o1aa5,o1ac4,o1b2d,o1b32,o1b37,o1b3c,o1b5f,o1d08
o1d85:  CALL c03d9
        DAD D
o1d89:  CALL c03e6
        PUSH PSW
o1d8d:  CALL c03d9
        POP PSW
        RET

co1d92: CALL c1da4 ;jo0afb,o15fc,o19a7,o1a87
o1d95:  CALL c03ce
        DAD D
o1d99:  CALL c03d9
        RET

co1d9d: CALL c1da4 ;o0aea,o0bf3,o0c35,o0cb9,o0cdf,o0cec,o0cfe,o0e47,o155d,o1565,o15f1,o18e3,o1a48,o1a81,o1b97
o1da0:  CALL c03e6
        RET

c1da4:  LXI H, #21c9 ;co1d77,co1d82,co1d92,co1d9d
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

c1db8:  LXI H, #2363 ;o1a43
o1dbb:  CALL c1fe4
        LXI H, #236b
        PUSH H
o1dc2:  CALL c0ea9
        POP H
o1dc6:  JNC j1dd5
        SHLD $2238
        LXI H, #2363
        SHLD $223a
o1dd2:  JMP j1dde
j1dd5:  SHLD $223a ;o1dc6
        LXI H, #2363
        SHLD $2238
j1dde:  LHLD $2238 ;o1dd2
o1de1:  CALL c1fe4
        LXI H, #235f
        PUSH H
o1de8:  CALL c0ea9
        POP H
o1dec:  JC j1e05
        PUSH H
        LHLD $223a
o1df3:  CALL c1fe4
        POP H
        PUSH H
o1df8:  CALL c0ea9
        POP H
o1dfc:  JC j1e10
        SHLD $223c
o1e02:  JMP j1e18
j1e05:  PUSH H ;o1dec
o1e06:  CALL c1e6b
        POP H
        SHLD $2238
o1e0d:  JMP j1e18
j1e10:  PUSH H ;o1dfc
o1e11:  CALL c1e6b
        POP H
        SHLD $223a
j1e18:  LHLD $2238 ;o1e02,o1e0d
o1e1b:  CALL c1fe4
        LXI H, #236f
        PUSH H
o1e22:  CALL c0ea9
        POP H
o1e26:  JC j1e4f
        PUSH H
        LHLD $223a
o1e2d:  CALL c1fe4
        POP H
        PUSH H
o1e32:  CALL c0ea9
        POP H
o1e36:  JC j1e5a
        PUSH H
        LHLD $223c
o1e3d:  CALL c1fe4
        POP H
        PUSH H
o1e42:  CALL c0ea9
        POP H
o1e46:  JC j1e78
        SHLD $223e
o1e4c:  JMP j1e83
j1e4f:  PUSH H ;o1e26
o1e50:  CALL c1e65
        POP H
        SHLD $2238
o1e57:  JMP j1e83
j1e5a:  PUSH H ;o1e36
o1e5b:  CALL c1e6b
        POP H
        SHLD $223a
o1e62:  JMP j1e83
c1e65:  LHLD $223c ;o1e50
        SHLD $223e
c1e6b:  LHLD $223a ;o1e06,o1e11,o1e5b
        SHLD $223c
        LHLD $2238
        SHLD $223a
        RET

j1e78:  PUSH H ;o1e46
        LHLD $223c
        SHLD $223e
        POP H
        SHLD $223c
j1e83:  LXI H, #2228 ;o1e4c,o1e57,o1e62
o1e86:  CALL c1fe4
        LHLD $2238
        PUSH H
o1e8d:  CALL c0ea9
        POP H
o1e91:  CC c1f5f
        RC
        LXI H, #222c
o1e98:  CALL c1fe4
        LHLD $2238
        PUSH H
o1e9f:  CALL c0ea9
        POP H
o1ea3:  CC c1f76
        RC
        LXI H, #2230
o1eaa:  CALL c1fe4
        LHLD $2238
        PUSH H
o1eb1:  CALL c0ea9
        POP H
o1eb5:  CC c1f8a
        RC
        LXI H, #2234
o1ebc:  CALL c1fe4
        LHLD $2238
        PUSH H
o1ec3:  CALL c0ea9
        POP H
o1ec7:  CC c1f9b
        RET

        LXI H, #222c
o1ece:  CALL c1fe4
        LHLD $223a
        PUSH H
o1ed5:  CALL c0ea9
        POP H
o1ed9:  CC c1f76
        RC
        LXI H, #2230
o1ee0:  CALL c1fe4
        LHLD $223a
        PUSH H
o1ee7:  CALL c0ea9
        POP H
o1eeb:  CC c1f8a
        RC
        LXI H, #2234
o1ef2:  CALL c1fe4
        LHLD $223a
        PUSH H
o1ef9:  CALL c0ea9
        POP H
o1efd:  CC c1f9b
        RET

        LXI H, #2230
o1f04:  CALL c1fe4
        LHLD $223c
        PUSH H
o1f0b:  CALL c0ea9
        POP H
o1f0f:  CC c1f8a
        RC
        LXI H, #2234
o1f16:  CALL c1fe4
        LHLD $223c
        PUSH H
o1f1d:  CALL c0ea9
        POP H
o1f21:  CC c1f9b
        RET

        LXI H, #2234
o1f28:  CALL c1fe4
        LHLD $223e
        PUSH H
o1f2f:  CALL c0ea9
        POP H
o1f33:  CC c1f9b
        RET

c1f37:  PUSH PSW ;o1f62,o1f79,o1f8d
        LXI H, #2230
        PUSH H
        LXI D, #2234
        MVI A, #07
o1f41:  CALL c0f60
        POP D
        POP PSW
        DCR A
        RZ
        PUSH PSW
        LXI H, #222c
        PUSH H
        MVI A, #07
o1f4f:  CALL c0f60
        POP D
        POP PSW
        DCR A
        RZ
        LXI H, #2228
        MVI A, #07
o1f5b:  CALL c0f60
        RET

c1f5f:  PUSH H ;o1e91
        MVI A, #03
o1f62:  CALL c1f37
        POP H
        LXI D, #2228
        MVI A, #07
o1f6b:  CALL c0f60
o1f6e:  CALL c1fa5
o1f71:  CALL c1fa5
        CMC
        RET

c1f76:  PUSH H ;o1ea3,o1ed9
        MVI A, #02
o1f79:  CALL c1f37
        POP H
        LXI D, #222c
        MVI A, #07
o1f82:  CALL c0f60
o1f85:  CALL c1fa5
        CMC
        RET

c1f8a:  PUSH H ;o1eb5,o1eeb,o1f0f
        MVI A, #01
o1f8d:  CALL c1f37
        POP H
        LXI D, #2230
        MVI A, #07
o1f96:  CALL c0f60
        CMC
        RET

c1f9b:  LXI D, #2234 ;o1ec7,o1efd,o1f21,o1f33
        MVI A, #07
o1fa0:  CALL c0f60
        CMC
        RET

c1fa5:  LDA CREDITS_1 ;o1f6e,o1f71,o1f85
        CPI #99
        RZ
        ORA A
        INR A
        DAA
        STA CREDITS_1
        STA CREDITS_2
        STA CREDITS_3
        LXI H, #13d4
o1fba:  CALL c12e4
        LXI H, #13c4
o1fc0:  CALL c12e4
        RET

c1fc4:  LXI H, #222c ;o09eb
        PUSH H
        LXI D, #2228
        MVI A, #07
o1fcd:  CALL c0f60
        POP D
        LXI H, #2230
        PUSH H
        MVI A, #07
o1fd7:  CALL c0f60
        POP D
        LXI H, #2234
        MVI A, #07
o1fe0:  CALL c0f60
        RET

c1fe4:  LXI D, #21f3 ;o1dbb,o1de1,o1df3,o1e1b,o1e2d,o1e3d,o1e86,o1e98,o1eaa,o1ebc,o1ece,o1ee0,o1ef2,o1f04,o1f16,o1f28
        MVI A, #00
        MVI B, #04
j1feb:  STAX D ;o1fee
        INX D
        DCR B
o1fee:  JNZ j1feb
        LXI D, #21f3
        MVI A, #07
o1ff6:  CALL c0f60
        MVI A, #07
        RET

        NOP
        ADD C
        PCHL
        LXI B, #0000
