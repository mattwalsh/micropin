l0000:  JMP l0040
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
l0024:  JMP l006e
        HLT
        HLT
        HLT
        HLT
        MOV B,M
l002c:  JMP l0324
        HLT
        HLT
        HLT
        HLT
        NOP
l0034:  JMP l037e
        HLT
        HLT
        HLT
        HLT
        JNZ $00c3
        (LDHI) #76
l0040:  MVI A, #19
        STA $23df
        MVI D, #05
l0047:  LXI H, #2710
l004a:  DCX H
        OUT #0f
        MOV A,H
        ORA A
l004f:  JNZ l004a
        DCR D
l0053:  JNZ l0047
        IN #04
        ANI #20
l005a:  JZ l006e
        LXI H, #2000
l0060:  SUB A
        MOV M,A
        INX H
        MVI A, #24
        CMP H
l0066:  JNZ l0060
        MVI A, #64
        STA $2240
l006e:  LXI SP, #2190
        MVI A, #07
l0073:  OUT #0e
        OUT #0d
        DCR A
l0078:  JP l0073
        LXI H, #2197
        MVI C, #2d
l0080:  SUB A
        MOV M,A
        INX H
        DCR C
l0084:  JNZ l0080
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
        IN #04
        ANI #20
l00c2:  JNZ l030b
l00c5:  CALL l02f3
l00c8:  JZ l0113
l00cb:  MVI A, #07
        STA $21c2
        CMA
        OUT #05
        MVI A, #06
        STA $21a6
l00d8:  EI
        LDA $21a6
        ORA A
l00dd:  JNZ l00d8
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
l00fd:  EI
        LDA $21a6
        ORA A
l0102:  JNZ l00fd
        MVI A, #ff
        OUT #05
        OUT #06
        OUT #07
        OUT #08
        DI
        CALL $13de
l0113:  IN #04
        ANI #20
l0117:  JNZ l0138
        LDA $2192
        ANI #df
        STA $2192
        IN #03
        CPI #fe
l0126:  JNZ l018f
        IN #02
        CPI #fb
l012d:  JZ l027a
        CPI #f7
l0132:  JZ l02a4
l0135:  JMP l018f
l0138:  CALL l1822
        MVI A, #d0
        STA $2192
        MVI A, #00
        STA $237e
        STA $239e
        STA $23be
        STA $237a
        STA $239a
        STA $23ba
        MVI A, #0f
        STA $237b
        STA $239b
        STA $23bb
        STA $2396
        STA $23b6
        LXI H, #23a3
        LXI D, #2320
        MVI A, #2e
l016d:  CALL l0f60
        MVI B, #01
        LXI D, #21c6
l0175:  CALL l1808
        LXI H, #21c9
        LXI D, #21ce
        MVI A, #0a
l0180:  CALL l0f60
        LXI H, #2205
        MVI B, #13
        SUB A
l0189:  MOV M,A
        INX H
        DCR B
l018c:  JNZ l0189
l018f:  DI
        MVI A, #30
        STA $2194
        LDA $2192
        ANI #80
l019a:  JNZ l01a2
        MVI A, #00
        STA $2192
l01a2:  IN #02
        MVI C, #00
        MVI B, #08
l01a8:  RAR
l01a9:  JNC l01bc
        EI
        INR C
        DCR B
l01af:  JZ l01b5
l01b2:  JMP l01a8
l01b5:  IN #04
        RAR
l01b8:  JNC l01bc
        INR C
l01bc:  MOV D,C
        IN #03
        MVI C, #00
        MVI B, #08
l01c3:  RAR
l01c4:  JNC l01d9
        EI
        INR C
        DCR B
l01ca:  JZ l01d0
l01cd:  JMP l01c3
l01d0:  IN #04
        RAR
        RAR
        RAR
l01d5:  JNC l01d9
        INR C
l01d9:  MOV A,C
        EI
        RLC
        RLC
        RLC
        RLC
        ORA D
        STA $237f
        STA $239f
        STA $23bf
        EI
        IN #05
        LXI H, #2216
        MOV M,A
        MVI B, #03
        MVI A, #00
l01f4:  CALL l03e6
l01f7:  JNZ l0204
        INR B
        MVI A, #01
l01fd:  CALL l03e6
l0200:  JNZ l0204
        INR B
l0204:  MOV A,B
        STA $2213
l0208:  OUT #0f
        EI
        NOP
        EI
l020d:  NOP
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
l0238:  JZ l0257
l023b:  JM l0243
        CPI #08
l0240:  JC l024c
l0243:  LXI H, #21fb
        SHLD $21f9
l0249:  JMP l0257
l024c:  DCX H
        MOV A,M
        DCX H
        SHLD $21f9
        MOV L,M
        MOV H,A
l0254:  CALL l0fcd
l0257:  EI
        LXI H, #2192
        MVI A, #07
l025d:  CALL l03e6
l0260:  JNZ l1bb4
        LDA $23b6
        ANI #7f
        STA $23b6
l026b:  JMP l0208
l026e:  XCHG
        LHLD $21f9
        MOV M,E
        INX H
        MOV M,D
        INX H
        SHLD $21f9
        RET

l027a:  LDA $2191
        MOV B,A
        ANI #01
l0280:  JNZ l018f
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
l02a1:  JMP l0138
l02a4:  DI
        LXI H, #23c0
        MVI B, #0c
l02aa:  MVI M, #88
        INX H
        DCR B
l02ae:  JNZ l02aa
        MVI M, #f8
        INX H
        MVI B, #09
l02b6:  MVI M, #88
        INX H
        DCR B
l02ba:  JNZ l02b6
        MVI M, #f8
        INX H
        MVI B, #07
l02c2:  MVI M, #88
        INX H
        DCR B
l02c6:  JNZ l02c2
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
l02dc:  JMP l0113
l02df:  LXI D, #233b
        LXI B, #0000
        LXI H, #0000
l02e8:  LDAX D
        MOV C,A
        DAD B
        INX D
        MOV A,E
        CPI #5d
l02ef:  JNZ l02e8
        RET

l02f3:  CALL l02df
        XCHG
        LHLD $2223
        MOV A,E
        CMP L
        RNZ
        ORA A
l02fe:  JZ l0304
l0301:  MOV A,D
        CMP H
        RET

l0304:  MOV A,D
        ORA A
l0306:  JNZ l0301
        INR A
        RET

l030b:  LXI H, #11eb
        LXI D, #2228
        MVI A, #08
l0313:  CALL l0f60
        LXI H, #11e7
        LXI D, #222c
        MVI A, #08
l031e:  CALL l0f60
l0321:  JMP l00cb
l0324:  CALL l060e
        LDA $2190
        ORI #80
        STA $2190
        SUB A
        STA $220c
        IN #01
        LXI D, #0000
l0338:  ORA A
l0339:  JZ l037a
        RAR
l033d:  JC l0344
        INR E
l0341:  JMP l0338
l0344:  MOV A,E
        CMA
        OUT #0e
        CMA
        LXI H, #2193
l034c:  CALL l03e6
l034f:  JNZ l037a
l0352:  CALL l060e
        LDA $2191
        ANI #02
l035a:  CNZ l03fa
l035d:  CALL l061a
l0360:  CALL l03ce
        XCHG
        DAD H
        LXI D, #03ae
        DAD D
        MOV A,M
        INX H
        MOV H,M
        MOV L,A
        PCHL
l036e:  LXI H, #2194
l0371:  JMP l0377
        LXI H, #2193
l0377:  CALL l03d9
l037a:  CALL l061a
        RET

l037e:  CALL l060e
        LXI D, #0000
        IN #00
l0386:  ORA A
l0387:  JZ l037a
        RAR
l038b:  JC l0392
        INR E
l038f:  JMP l0386
l0392:  MOV A,E
        CMA
        OUT #0d
        CMA
        LXI H, #2194
l039a:  CALL l03e6
l039d:  JNZ l037a
l03a0:  CALL l03ce
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
l03ce:  PUSH B
        MOV B,A
l03d0:  CALL l03f1
        MOV C,M
        ORA C
        MOV M,A
l03d6:  JMP l03ee
l03d9:  PUSH B
        MOV B,A
l03db:  CALL l03f1
        CMA
        MOV C,A
        MOV A,M
        ANA C
        MOV M,A
l03e3:  JMP l03ee
l03e6:  PUSH B
        MOV B,A
l03e8:  CALL l03f1
        MOV C,A
        MOV A,M
        ANA C
l03ee:  MOV A,B
        POP B
        RET

l03f1:  MOV C,A
        MVI A, #01
l03f4:  DCR C
        RM
        ADD A
l03f7:  JMP l03f4
l03fa:  LDA $2211
        MOV B,A
l03fe:  CALL l041f
l0401:  CALL l03e6
l0404:  JZ l040b
        XCHG
l0408:  CALL l03ce
l040b:  MOV A,B
        INR A
        CPI #05
l040f:  JNZ l0414
        MVI A, #00
l0414:  STA $2211
l0417:  CALL l041f
        XCHG
l041b:  CALL l03d9
        RET

l041f:  MVI D, #00
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

l0462:  LDA $2192
        ANI #40
        RZ
        LDA $237a
        ORA A
l046c:  JZ l0471
        CMP A
        RET

l0471:  DCR A
        RET

        CALL $0447
        MVI A, #7d
        STA $21a2
l047b:  CALL l0462
l047e:  JNZ l037a
        MVI A, #fa
        STA $219e
        LXI H, #23b6
        MVI A, #05
l048b:  CALL l03ce
        MVI A, #ff
        STA $2380
        STA $2381
        STA $2382
        LDA $233f
        ADI #08
        MOV B,A
        LDA $23e4
        SUB B
l04a3:  JM l0538
        LDA $2192
        ANI #40
l04ab:  JNZ l0538
        LDA $2194
        ORI #fc
        STA $2194
        MVI A, #00
        STA $21a3
        MVI A, #ff
        LXI H, #23c0
        MVI B, #20
l04c2:  MOV M,A
        INX H
        DCR B
l04c5:  JNZ l04c2
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
l0501:  CALL l1d82
        MVI A, #d0
        STA $2192
        LDA $2213
        STA $237b
        LXI H, #237e
        MOV A,M
        ANI #0f
        MOV M,A
        MVI B, #ff
l0518:  RAR
l0519:  JNC l0520
        INR B
l051d:  JMP l0518
l0520:  MOV A,B
        ADI #04
l0523:  CALL l03ce
        MVI A, #01
        STA $2214
        MVI A, #28
        STA $221b
        MVI A, #02
        STA $219d
l0535:  JMP l037a
l0538:  LXI H, #1345
l053b:  CALL l12e4
l053e:  JMP l037a
        LDA $221b
        DCR A
        STA $221b
l0548:  JZ l055e
        MVI A, #14
        STA $219d
        MVI A, #fa
        STA $219e
        LXI H, #1342
l0558:  CALL l12e4
l055b:  JMP l0608
l055e:  MVI A, #05
        STA $21a3
        MVI A, #01
        STA $21a0
        STA $221c
        LDA $2194
        ANI #33
        STA $2194
l0573:  JMP l0608
        IN #04
        ANI #80
l057a:  JZ l0594
l057d:  CALL l0462
l0580:  JNZ l0594
        CALL $0447
        MVI A, #7d
        STA $21a2
        LXI H, #1345
l058e:  CALL l12e4
l0591:  JMP l0608
l0594:  LDA $2194
        ANI #77
        STA $2194
l059c:  JMP l0608
        LXI H, #2192
        MVI A, #07
l05a4:  CALL l03e6
l05a7:  JZ l0608
        LXI H, #23b6
        MVI A, #05
l05af:  CALL l03d9
        MVI A, #f0
        STA $23a0
        STA $2380
        MVI A, #ff
        STA $23a1
        STA $2381
        STA $23a2
        STA $2382
l05c8:  JMP l0608
        LXI H, #2197
        MVI C, #1a
l05d0:  MVI A, #ff
        ADD M
l05d3:  JNC l05da
        MOV M,A
l05d7:  JZ l05f3
l05da:  INX H
        DCR C
l05dc:  JNZ l05d0
        LDA $2198
        ORA A
l05e3:  JNZ l05e8
        MVI A, #01
l05e8:  ANI #3f
        STA $2198
        MVI A, #00
        DI
l05f0:  JMP l036e
l05f3:  DI
l05f4:  CALL l060e
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
l0608:  CALL l061a
l060b:  JMP l05da
l060e:  SHLD $2195
        XTHL
        PUSH B
        PUSH D
        PUSH PSW
        PUSH H
        LHLD $2195
        RET

l061a:  POP H
        POP PSW
        POP D
        POP B
        XTHL
        RET

        LXI H, #21f8
        DCR M
l0624:  JNZ l0640
        LXI H, #2191
        MVI A, #04
l062c:  CALL l03e6
l062f:  JNZ l0638
l0632:  CALL l03ce
l0635:  JMP l063b
l0638:  CALL l03d9
l063b:  MVI A, #04
        STA $21f8
l0640:  LXI H, #2191
        MVI A, #04
l0645:  CALL l03e6
l0648:  JNZ l06a8
        LXI H, #2380
l064e:  LXI D, #23c0
        MVI A, #40
l0653:  CALL l0f60
        MVI A, #05
        STA $21a3
        LXI H, #2191
        MVI A, #04
l0660:  CALL l03e6
l0663:  JZ l0687
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
l0684:  JMP l0608
l0687:  LDA $21ce
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
l06a5:  JMP l0608
l06a8:  LXI H, #23a0
l06ab:  JMP l064e
        ADD D
        INR C
        ADC C
        STAX D
        MOV D,B
        RLC
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
l06e0:  JNC l1108
        NOP
        NOP
l06e5:  JMP l0711
        LXI D, #0001
l06eb:  JMP l0711
        LXI D, #0002
l06f1:  JMP l0711
        LXI D, #0003
l06f7:  JMP l0711
        LXI D, #0004
l06fd:  JMP l0711
        LXI D, #0005
l0703:  JMP l0711
        LDA $2191
        ORI #20
        STA $2191
l070e:  JMP l037a
l0711:  LXI H, #0788
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
l0721:  CALL l03ce
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
l073e:  CALL l12e4
        POP D
        LXI H, #07ab
        DAD D
        MOV B,M
        INX H
        MOV H,M
        MOV L,B
l074a:  CALL l026e
l074d:  JMP l037a
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
l076a:  JNZ l0608
        MVI A, #06
        STA $21ad
l0772:  JMP l0608
        LXI H, #2190
        MVI A, #02
l077a:  CALL l03e6
l077d:  JNZ l0608
        MVI A, #80
        STA $2193
l0785:  JMP l0608
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
l07ce:  CALL l03e6
l07d1:  JNZ l037a
        LXI H, #13d1
l07d7:  CALL l12e4
        LXI H, #2191
        MVI A, #00
l07df:  CALL l03e6
l07e2:  JZ l037a
        MVI A, #7d
        STA $219f
l07ea:  JMP l037a
        LXI H, #21c3
        MVI A, #04
l07f2:  CALL l03e6
l07f5:  JNZ l080e
        LXI H, #2190
        MVI A, #02
l07fd:  CALL l03e6
l0800:  JNZ l0608
        MVI A, #04
        LXI H, #2194
l0808:  CALL l03d9
l080b:  JMP l0608
l080e:  LDA $21c3
        ANI #2f
        STA $21c3
        CMA
        OUT #06
        MVI A, #06
        STA $21a8
l081e:  JMP l0608
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
l083d:  JNZ l0862
        MVI A, #3c
        STA $221f
        LDA $2220
        INR A
        DAA
        STA $2220
        CPI #60
l084f:  JNZ l0608
        MVI A, #00
        STA $2220
        LDA $2221
        INR A
        DAA
        STA $2221
l085f:  JMP l0608
l0862:  LDA $2220
        STA $239a
        STA $23ba
        LDA $2221
        STA $239f
        STA $23bf
l0874:  JMP l0608
        LDA $2192
        ANI #fe
        MOV B,A
        ANI #80
l087f:  JZ l08ae
l0882:  CALL l088a
        MVI A, #05
l0887:  JMP l036e
l088a:  MOV A,B
        ANI #04
        LDA $2241
l0890:  JZ l0898
        ORI #01
l0895:  JMP l089a
l0898:  ANI #fe
l089a:  STA $2241
        MOV A,B
        ORI #04
        STA $2192
        MVI A, #02
        STA $21b0
        MVI A, #20
l08aa:  STA $2243
        RET

l08ae:  LDA $21c3
        ORI #20
        STA $21c3
        CMA
        OUT #06
        MVI A, #09
        STA $21a9
        LXI H, #2190
        MVI A, #05
l08c3:  CALL l03e6
l08c6:  JNZ l037a
        LXI H, #13d1
l08cc:  CALL l12e4
l08cf:  JMP l037a
        LDA $2243
        DCR A
l08d6:  JP l08eb
        IN #04
        ANI #40
l08dd:  JNZ l08ee
        LDA $2192
        ANI #fb
        STA $2192
l08e8:  JMP l0608
l08eb:  STA $2243
l08ee:  MVI A, #04
        STA $21b0
l08f3:  JMP l0608
        LXI H, #21c3
        MVI A, #05
l08fb:  CALL l03e6
l08fe:  JNZ l0917
        LXI H, #2190
        MVI A, #02
l0906:  CALL l03e6
l0909:  JNZ l0608
        LXI H, #2194
        MVI A, #05
l0911:  CALL l03d9
l0914:  JMP l0608
l0917:  LDA $21c3
        ANI #1f
        STA $21c3
        CMA
        OUT #06
        MVI A, #06
        STA $21a9
l0927:  JMP l0608
        IN #04
        ANI #10
l092e:  JZ l093f
        LDA $2192
        ANI #fe
        MOV B,A
l0937:  CALL l088a
        MVI A, #02
l093c:  JMP l036e
l093f:  LDA $2192
        ANI #20
l0944:  JNZ l0968
        MVI A, #00
        STA $237c
        STA $237d
        STA $239c
        STA $239d
        STA $23bc
        STA $23bd
        LXI H, #2192
        MVI A, #05
l0960:  CALL l03ce
        MVI A, #02
        STA $21aa
l0968:  CALL l098a
        IN #05
        ANI #80
        MVI A, #01
l0971:  JNZ l0976
        MVI A, #04
l0976:  STA $2242
        LDA $2194
        ORI #40
        STA $2194
        LXI H, #13c4
l0984:  CALL l12e4
l0987:  JMP l037a
l098a:  LDA $237a
        CPI #99
        RZ
        LXI H, #237c
        LDA $237f
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
l09b4:  CALL l03d9
        LXI H, #2396
l09ba:  CALL l03d9
        LXI H, #23b6
l09c0:  CALL l03d9
        MVI B, #00
l09c5:  CALL l1d82
        LDA $237a
        INR A
        DAA
        STA $237a
        STA $239a
        STA $23ba
        LXI H, #21c5
        MVI A, #03
l09db:  CALL l03ce
        MVI A, #09
        STA $21ab
        LDA $2240
        DCR A
        STA $2240
        RNZ
l09eb:  CALL l1fc4
        MVI A, #64
        STA $2240
        RET

        IN #04
        ANI #10
l09f8:  JZ l0a0d
        LXI H, #221d
        DCR M
l09ff:  JNZ l0a12
        LXI H, #2192
        MVI A, #05
l0a07:  CALL l03d9
l0a0a:  JMP l0608
l0a0d:  MVI A, #40
        STA $221d
l0a12:  MVI A, #04
        STA $21aa
l0a17:  JMP l0608
        LXI H, #21c5
        MVI A, #03
l0a1f:  CALL l03e6
l0a22:  JZ l0a30
l0a25:  CALL l03d9
        MVI A, #09
        STA $21ab
l0a2d:  JMP l0608
l0a30:  LXI H, #2242
        DCR M
l0a34:  JZ l0a3d
l0a37:  CALL l098a
l0a3a:  JMP l0608
l0a3d:  LDA $2194
        ANI #bb
        STA $2194
l0a45:  JMP l0608
        MVI B, #24
        MVI C, #00
l0a4c:  JMP l0a80
        MVI B, #03
        MVI C, #01
l0a53:  JMP l0a80
        MVI B, #0b
        MVI C, #02
l0a5a:  JMP l0a80
        MVI B, #13
        MVI C, #03
l0a61:  JMP l0a80
        MVI B, #29
        MVI C, #04
l0a68:  JMP l0a80
        MVI A, #04
        STA $2197
        LXI H, #2208
        MVI A, #ff
        ADD M
l0a76:  JNC l0a95
        MOV M,A
l0a7a:  JZ l0cb7
l0a7d:  JMP l147a
l0a80:  LXI H, #2208
        MVI A, #ff
        ADD M
l0a86:  JNC l0a95
        MOV M,A
l0a8a:  JZ l0aa2
        MVI A, #04
        STA $2197
l0a92:  JMP l147a
l0a95:  MVI A, #64
        STA $2208
        MVI A, #04
        STA $2197
l0a9f:  JMP l147a
l0aa2:  LXI H, #2190
        MVI A, #07
l0aa7:  CALL l03ce
        MVI A, #02
l0aac:  CALL l03e6
l0aaf:  JZ l0ac1
        MOV A,C
l0ab3:  CALL l0c47
l0ab6:  CALL l03ce
        MVI A, #06
        STA $21a6
l0abe:  JMP l147a
l0ac1:  CALL l1d82
        MOV A,C
        LXI H, #21c7
l0ac8:  CALL l03e6
l0acb:  JZ l0c2a
l0ace:  CALL l03d9
        LXI H, #2211
        CMP M
        LXI H, #2192
        MVI A, #01
l0ada:  JNZ l0ae3
l0add:  CALL l03ce
l0ae0:  JMP l0ae6
l0ae3:  CALL l03d9
l0ae6:  MOV A,C
l0ae7:  CALL l0c47
l0aea:  CALL l1d9d
l0aed:  JZ l0afb
        XCHG
        DAD D
l0af2:  CALL l03e6
        XCHG
        MVI A, #01
l0af8:  JZ l0b0b
l0afb:  CALL l1d92
        LXI H, #1366
l0b01:  CALL l12e4
        MVI A, #c8
        STA $2208
        MVI A, #5a
l0b0b:  STA $219b
l0b0e:  JMP l147a
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
l0b20:  CALL l0eed
        LXI H, #1360
l0b26:  CALL l12e4
        LXI H, #2192
        MVI A, #01
l0b2e:  CALL l03e6
l0b31:  JZ l0b7a
l0b34:  CALL l03d9
        LXI H, #2191
        MVI A, #01
l0b3c:  CALL l03e6
l0b3f:  JZ l0b7a
l0b42:  CALL l03d9
        MVI A, #fa
        STA $2208
        MVI A, #05
        STA $221a
        MVI A, #28
        STA $219c
l0b54:  JMP l0608
        LXI H, #11f4
l0b5a:  CALL l0eed
        LXI H, #13b8
l0b60:  CALL l12e4
        LDA $221a
        DCR A
        STA $221a
l0b6a:  JZ l0b7a
        MVI A, #28
        STA $219c
        MVI A, #fa
        STA $2208
l0b77:  JMP l0608
l0b7a:  LDA $21c7
        CPI #00
l0b7f:  JZ l0b93
        LHLD $2209
        LDA $220b
l0b88:  CALL l03ce
        MVI A, #06
        STA $21a6
l0b90:  JMP l0608
l0b93:  MVI A, #3c
        STA $21a5
        MVI A, #64
        STA $2208
        MVI A, #00
        STA $2207
l0ba2:  JMP l0608
        SUB A
        STA $2208
        LDA $2207
        INR A
        STA $2207
        CPI #06
l0bb2:  JZ l0bd3
        MVI D, #00
        MOV E,A
        LXI H, #0c91
        DAD D
        MOV B,M
l0bbd:  CALL l1d77
        LXI H, #1360
l0bc3:  CALL l12e4
        MVI A, #0f
        STA $21a5
        MVI A, #64
        STA $2208
l0bd0:  JMP l0608
l0bd3:  LHLD $2209
        LDA $220b
l0bd9:  CALL l03ce
        MVI A, #06
        STA $21a6
        MVI A, #1f
        STA $21c7
        LXI H, #2190
        MVI A, #03
l0beb:  CALL l03e6
l0bee:  JNZ l0bfe
        MVI B, #31
l0bf3:  CALL l1d9d
l0bf6:  JNZ l0bfe
        MVI B, #09
l0bfb:  CALL l1d77
l0bfe:  LDA $21c8
        INR A
        CPI #05
l0c04:  JZ l0c1c
        STA $21c8
        MVI D, #00
        MOV E,A
        LXI H, #0c96
        DAD D
        MOV B,M
        PUSH H
l0c13:  CALL l1d77
        POP H
        DCX H
        MOV B,M
l0c19:  CALL l1d82
l0c1c:  LXI H, #2191
        MVI A, #01
l0c21:  CALL l03e6
l0c24:  CNZ l03fa
l0c27:  JMP l0608
l0c2a:  CALL l0c47
l0c2d:  CALL l03ce
        MVI A, #06
        STA $21a6
l0c35:  CALL l1d9d
l0c38:  JNZ l147a
l0c3b:  CALL l1d77
        LXI H, #1363
l0c41:  CALL l12e4
l0c44:  JMP l147a
l0c47:  MVI D, #00
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
l0c7c:  CALL l03d9
l0c7f:  JMP l0608
        MVI A, #00
        STA $2208
        LXI H, #2192
        MVI A, #03
l0c8c:  CALL l03d9
l0c8f:  JMP l0608
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
l0cb7:  MVI B, #39
l0cb9:  CALL l1d9d
l0cbc:  JZ l0dde
        LXI H, #2190
        MVI A, #02
l0cc4:  CALL l03e6
l0cc7:  JNZ l0dde
        LDA $220c
        CPI #00
l0ccf:  JNZ l0d3a
        LXI H, #235b
        LXI D, #220d
        MVI A, #06
l0cda:  CALL l0f60
        MVI B, #38
l0cdf:  CALL l1d9d
l0ce2:  JZ l0cea
        MVI A, #03
l0ce7:  JMP l0cf9
l0cea:  MVI B, #11
l0cec:  CALL l1d9d
l0cef:  JZ l0cf7
        MVI A, #02
l0cf4:  JMP l0cf9
l0cf7:  MVI A, #01
l0cf9:  STA $220c
        MVI B, #31
l0cfe:  CALL l1d9d
l0d01:  JZ l0d3a
        LXI H, #2190
        MVI A, #03
l0d09:  CALL l03e6
l0d0c:  JNZ l0d3a
l0d0f:  CALL l03ce
        MVI B, #31
l0d14:  CALL l1d82
        MVI B, #09
l0d19:  CALL l1d82
        LXI H, #13a4
l0d1f:  CALL l12e4
        MVI B, #30
l0d24:  CALL l1d77
        LXI H, #2396
        MVI A, #04
l0d2c:  CALL l03ce
        LXI H, #23b6
l0d32:  CALL l03ce
        MVI A, #fa
l0d37:  JMP l0d3c
l0d3a:  MVI A, #3c
l0d3c:  STA $21a7
l0d3f:  JMP l147a
        LDA $2349
        MOV B,A
        LDA $23ee
        SUB B
l0d4a:  JM l0d58
        LDA $2194
        ANI #fd
        STA $2194
l0d55:  JMP l0608
l0d58:  MVI A, #00
        STA $2197
        LDA $2194
        ORI #02
        STA $2194
        LXI H, #2190
        MVI A, #00
l0d6a:  CALL l03e6
l0d6d:  JNZ l0dba
        LXI H, #11e8
l0d73:  CALL l0f2a
l0d76:  JC l0d8d
        LXI H, #11e8
l0d7c:  CALL l026e
        MVI A, #0a
        STA $21a7
        LXI H, #13b5
l0d87:  CALL l12e4
l0d8a:  JMP l0608
l0d8d:  LXI H, #11e8
l0d90:  CALL l0eed
        LXI H, #235b
l0d96:  CALL l0fcd
        LXI H, #235b
l0d9c:  CALL l0f2a
        LXI H, #220c
        DCR M
l0da3:  JZ l0dba
        LXI H, #220d
l0da9:  CALL l0f00
        MVI A, #3c
        STA $21a7
        LXI H, #13b8
l0db4:  CALL l12e4
l0db7:  JMP l0608
l0dba:  LXI H, #21c5
        MOV A,M
        ORI #02
        MOV M,A
        MVI A, #09
        STA $21a6
        MVI B, #39
l0dc8:  CALL l1d82
        LDA $2194
        ANI #fd
        STA $2194
        MVI A, #00
        STA $220c
        LXI H, #13b8
l0ddb:  JMP l0db4
l0dde:  LXI H, #21c5
        MVI A, #01
l0de3:  CALL l03ce
        MVI A, #06
        STA $21a6
l0deb:  JMP l147a
        MVI A, #2b
l0df0:  JMP l0e07
        MVI A, #2c
l0df5:  JMP l0e07
        MVI A, #04
l0dfa:  JMP l0e07
        MVI A, #0c
l0dff:  JMP l0e07
        MVI A, #14
l0e04:  JMP l0e07
l0e07:  STA $2225
        LDA $2190
        ANI #04
l0e0f:  JNZ l147a
        LDA $21af
        ORA A
l0e16:  JNZ l0e26
        LDA $2191
        ANI #df
        STA $2191
        MVI A, #80
        STA $2193
l0e26:  MVI A, #03
        STA $21af
l0e2b:  JMP l147a
        LDA $2191
        ANI #20
l0e33:  JZ l0e72
        LDA $21c4
        ORI #04
        STA $21c4
        MVI A, #09
        STA $2199
        LDA $2225
        MOV B,A
l0e47:  CALL l1d9d
l0e4a:  JZ l0e72
l0e4d:  CALL l1d82
l0e50:  JZ l0e62
        LXI H, #11e8
l0e56:  CALL l026e
        LXI H, #1363
l0e5c:  CALL l12e4
l0e5f:  JMP l0e72
l0e62:  LXI H, #11f4
l0e65:  CALL l026e
        XCHG
l0e69:  CALL l0eed
        LXI H, #1375
l0e6f:  CALL l12e4
l0e72:  LDA $2191
        ANI #df
        STA $2191
l0e7a:  JMP l0608
l0e7d:  LXI D, #21f3
        ORA A
        PUSH PSW
l0e82:  SBI #02
l0e84:  JM l0e9f
        MOV B,A
        POP PSW
        LDAX D
        ADC M
        DAA
        STAX D
        PUSH PSW
        MOV A,B
        ORA A
l0e90:  JNZ l0e9a
        POP PSW
        MVI A, #00
        ADC A
        INX D
        STAX D
        RET

l0e9a:  INX H
        INX D
l0e9c:  JMP l0e82
l0e9f:  MOV A,M
        ANI #0f
        MOV B,A
        POP PSW
        LDAX D
        ADC B
        DAA
        STAX D
        RET

l0ea9:  MVI C, #00
        ORA A
        LXI D, #21f3
        PUSH PSW
l0eb0:  SBI #02
l0eb2:  JM l0ece
        MOV B,A
        POP PSW
        MVI A, #9a
        SBB M
l0eba:  XCHG
        ADD M
        DAA
        CMC
        MOV M,A
        PUSH PSW
l0ec0:  JNZ l0edb
l0ec3:  MOV A,B
        ORA A
l0ec5:  JZ l0ee0
        XCHG
        INX D
        INX H
l0ecb:  JMP l0eb0
l0ece:  MOV A,M
        ANI #0f
        MOV B,A
        POP PSW
        MVI A, #9a
        SBB B
        MVI B, #00
l0ed8:  JMP l0eba
l0edb:  MVI C, #ff
l0edd:  JMP l0ec3
l0ee0:  MOV A,C
        ORA A
l0ee2:  JZ l0ee9
        POP PSW
        RC
        ORA C
        RET

l0ee9:  POP PSW
        ANI #00
        RET

l0eed:  LXI D, #21f3
        MVI A, #08
l0ef2:  CALL l0f60
        LXI H, #235b
        MVI A, #08
l0efa:  CALL l0e7d
        LXI H, #21f3
l0f00:  LXI D, #235b
        MVI A, #08
l0f05:  CALL l0f60
        LXI H, #235b
        LXI D, #23a0
        MVI A, #06
l0f10:  CALL l0f7b
        LDA $2190
        ANI #01
        RNZ
        LXI H, #23a0
        LXI D, #2380
        MVI A, #06
l0f21:  CALL l0f60
        MVI B, #39
l0f26:  CALL l1d77
        RET

l0f2a:  PUSH H
        LXI H, #235b
        LXI D, #21f3
        MVI A, #08
l0f33:  CALL l0f60
        POP H
        MVI A, #08
l0f39:  CALL l0ea9
        PUSH PSW
        LXI H, #21f3
        LXI D, #235b
        MVI A, #08
l0f45:  CALL l0f60
        LXI H, #235b
        LXI D, #2380
        MVI A, #06
l0f50:  CALL l0f7b
        LXI H, #2380
        LXI D, #23a0
        MVI A, #06
l0f5b:  CALL l0f60
        POP PSW
        RET

l0f60:  ORA A
l0f61:  SBI #02
l0f63:  JM l0f71
        MOV B,A
        MOV A,M
        STAX D
        INX H
        INX D
        MOV A,B
        ORA A
l0f6d:  JNZ l0f61
        RET

l0f71:  MOV A,M
        ANI #0f
        MOV B,A
        LDAX D
        ANI #f0
        ORA B
        STAX D
        RET

l0f7b:  RRC
        PUSH PSW
l0f7d:  JNC l0f83
        INR A
        ANI #7f
l0f83:  MOV C,A
        DCR C
        MVI B, #00
        DAD B
        XCHG
        DAD B
        XCHG
        POP PSW
l0f8c:  JC l0fa5
        MOV A,M
l0f90:  ORA A
l0f91:  JZ l0fbb
        ANI #f0
        MOV A,M
l0f97:  JNZ l0f9c
        ORI #f0
l0f9c:  STAX D
        DCX H
        DCX D
        MOV A,M
        DCR C
l0fa1:  JP l0f9c
        RET

l0fa5:  LDAX D
        ANI #f0
        MOV B,A
        MOV A,M
        ANI #0f
l0fac:  JNZ l0fc5
        ORI #0f
        ORA B
l0fb2:  STAX D
        DCX H
        DCX D
        DCR C
        MOV A,M
l0fb7:  JP l0f90
        RET

l0fbb:  MOV A,C
        DCR A
l0fbd:  JM l0fc9
        MVI A, #ff
l0fc2:  JMP l0fb2
l0fc5:  ORA B
l0fc6:  JMP l0f9c
l0fc9:  MVI A, #f0
        STAX D
        RET

l0fcd:  LXI D, #21f3
        MVI A, #08
l0fd2:  CALL l0f60
        LXI H, #237e
        MVI A, #04
l0fda:  CALL l03e6
l0fdd:  JNZ l1160
        INR A
l0fe1:  CALL l03e6
l0fe4:  JNZ l1177
        INR A
l0fe8:  CALL l03e6
l0feb:  JNZ l118e
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
l1002:  MVI A, #08
l1004:  CALL l0e7d
        POP D
        PUSH D
        LXI H, #21f3
        MVI A, #08
l100e:  CALL l0f60
        POP H
        POP D
        PUSH D
        MVI A, #06
l1016:  CALL l0f7b
        POP D
        LXI H, #0020
        DAD D
        XCHG
        MVI A, #06
l1021:  CALL l0f60
        LXI H, #237e
        MVI A, #03
l1029:  CALL l03e6
l102c:  JNZ l108d
        POP H
        POP H
        POP H
        LDA $237e
        ANI #0f
        CPI #03
        RNZ
        LDA $2216
        ANI #08
        RNZ
        LXI H, #2363
        LXI D, #21f3
        MVI A, #07
l1048:  CALL l0f60
        LXI H, #236b
        MVI A, #07
l1050:  CALL l0ea9
        PUSH PSW
l1054:  CC l1079
        LXI H, #21f3
        LXI D, #2377
        PUSH D
        MVI A, #06
l1060:  CALL l0f60
        POP H
        PUSH H
        LXI D, #2397
        MVI A, #06
l106a:  CALL l0f7b
        POP H
        LXI D, #23b7
        MVI A, #06
l1073:  CALL l0f7b
l1076:  JMP l10e8
l1079:  LXI H, #236b
        LXI D, #21f3
        MVI A, #07
l1081:  CALL l0f60
        LXI H, #2363
        MVI A, #07
l1089:  CALL l0ea9
        RET

l108d:  POP H
        MVI A, #08
l1090:  CALL l0e7d
        LXI H, #21f3
        POP D
        PUSH D
        MVI A, #07
l109a:  CALL l0f60
        POP H
        POP D
        PUSH D
        MVI A, #07
l10a2:  CALL l0f7b
        POP D
        LXI H, #0020
        DAD D
        XCHG
        MVI A, #07
l10ad:  CALL l0f60
        LXI H, #2367
        LXI D, #21f3
        MVI A, #07
l10b8:  CALL l0f60
        LXI H, #2373
        MVI A, #07
l10c0:  CALL l0ea9
        PUSH PSW
l10c4:  JC l11a5
l10c7:  LXI H, #21f3
        LXI D, #2377
        MVI A, #06
l10cf:  CALL l0f60
        LXI H, #2377
        LXI D, #2397
        MVI A, #06
l10da:  CALL l0f7b
        LXI H, #2397
        LXI D, #23b7
        MVI A, #06
l10e5:  CALL l0f60
l10e8:  POP PSW
l10e9:  JZ l1138
l10ec:  JC l1124
        LXI H, #236a
        MVI A, #04
l10f4:  CALL l03e6
l10f7:  JZ l10fb
        RET

l10fb:  CALL l03ce
        MVI A, #05
l1100:  CALL l03d9
        PUSH H
        PUSH B
        LXI H, #1399
l1108:  CALL l12e4
        LXI H, #21a7
        MOV A,M
        ORA A
l1110:  JZ l1115
        MVI M, #7d
l1115:  LXI H, #21ae
        MOV A,M
        ORA A
l111a:  JZ l111f
        MVI M, #7d
l111f:  POP B
        POP H
l1121:  JMP l11bb
l1124:  LXI H, #236a
        MVI A, #05
l1129:  CALL l03e6
l112c:  JZ l1130
        RET

l1130:  CALL l03ce
        MVI A, #04
l1135:  JMP l1100
l1138:  LXI H, #236a
        MVI A, #04
l113d:  CALL l03d9
        MVI A, #05
l1142:  CALL l03d9
        PUSH H
        LXI H, #1208
        LXI D, #2397
        MVI A, #06
l114e:  CALL l0f60
        LXI H, #1208
        LXI D, #23b7
        MVI A, #06
l1159:  CALL l0f60
        POP H
l115d:  JMP l11bb
l1160:  LXI H, #2389
        PUSH H
        LXI H, #2367
        PUSH H
        LXI H, #235f
        PUSH H
        LXI H, #2386
        PUSH H
        LXI H, #2363
        PUSH H
l1174:  JMP l1002
l1177:  LXI H, #2393
        PUSH H
        LXI H, #2373
        PUSH H
        LXI H, #236f
        PUSH H
        LXI H, #238d
        PUSH H
        LXI H, #236b
        PUSH H
l118b:  JMP l1002
l118e:  LXI H, #2389
        PUSH H
        LXI H, #2367
        PUSH H
        LXI H, #2363
        PUSH H
        LXI H, #2383
        PUSH H
        LXI H, #235f
        PUSH H
l11a2:  JMP l1002
l11a5:  LXI H, #2373
        LXI D, #21f3
        MVI A, #07
l11ad:  CALL l0f60
        LXI H, #2367
        MVI A, #07
l11b5:  CALL l0ea9
l11b8:  JMP l10c7
l11bb:  MOV A,M
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
l1210:  MVI A, #ff
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
l1236:  JZ l1272
        CPI #02
l123b:  JZ l1271
        CPI #04
l1240:  JZ l1270
        CPI #08
l1245:  JZ l126f
        CPI #0c
l124a:  JZ l126e
        CPI #10
l124f:  JZ l126d
        CPI #2c
l1254:  JZ l126c
        CPI #28
l1259:  JZ l126b
        CPI #24
l125e:  JZ l126a
        CPI #20
l1263:  JZ l1269
l1266:  JMP l1272
l1269:  INX D
l126a:  INX D
l126b:  INX D
l126c:  INX D
l126d:  INX D
l126e:  INX D
l126f:  INX D
l1270:  INX D
l1271:  INX D
l1272:  LDAX D
        STA $2198
        LXI H, #2190
        MVI A, #05
l127b:  CALL l03ce
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
l128e:  CALL l03e6
l1291:  JNZ l12a5
        MVI A, #06
l1296:  CALL l03ce
        MVI A, #fe
        OUT #09
        MVI A, #02
        STA $2198
l12a2:  JMP l0608
l12a5:  CALL l03d9
        MVI A, #06
l12aa:  CALL l03e6
l12ad:  JNZ l12d8
        MVI A, #ff
        OUT #09
        LHLD $21b1
        INX H
        MOV A,M
        CPI #ff
l12bb:  JZ l12c4
l12be:  CALL l1210
l12c1:  JMP l0608
l12c4:  LDA $21b3
        CPI #00
l12c9:  JNZ l12db
        MVI A, #ff
        OUT #09
        MVI A, #0c
        STA $2198
l12d5:  JMP l0608
l12d8:  CALL l03d9
l12db:  CALL l130f
l12de:  CALL l1210
l12e1:  JMP l0608
l12e4:  XCHG
        LHLD $21be
        LXI B, #21be
        MOV A,C
        STA $21b3
        SUB L
l12f0:  JNZ l12f6
        LXI H, #21b4
l12f6:  MOV M,E
        INX H
        MOV M,D
        INX H
        SHLD $21be
        LXI H, #2190
        MVI A, #05
l1302:  CALL l03e6
        RNZ
l1306:  CALL l03ce
        MVI A, #01
        STA $2198
        RET

l130f:  LHLD $21c0
        LXI B, #21be
        MOV A,C
        SUB L
l1317:  JNZ l131d
        LXI H, #21b4
l131d:  MOV E,M
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
l1332:  (JK) l08aa
        RST 7
        ADD L
        (DSUB)
        RST 7
        MOV H,L
        (DSUB)
        RST 7
        INR E
        INR C
l133e:  CM l0c1c
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
l13e3:  CALL l03d9
        OUT #0f
        LXI H, #23e0
        LXI D, #233b
l13ee:  MOV B,M
        LDAX D
        ADI #04
        SUB B
l13f3:  JP l13f8
        CMA
        INR A
l13f8:  CPI #03
l13fa:  JC l1405
        LDA $2191
        ORI #08
        STA $2191
l1405:  MOV A,B
        SUI #04
        STAX D
        INX D
        INR L
l140b:  JNZ l13ee
        LDA $2191
        ANI #08
        JNZ $13de
l1416:  CALL l02df
        SHLD $2223
        RET

        LXI H, #2191
        MVI A, #06
l1422:  CALL l03ce
        LXI H, #23e0
        LXI D, #233b
l142b:  LDAX D
        SUB M
l142d:  JP l144b
l1430:  INX D
        INR L
l1432:  JNZ l142b
        LXI H, #2191
        MVI A, #06
l143a:  CALL l03e6
l143d:  JZ l1445
        MVI A, #05
l1442:  CALL l03d9
l1445:  MVI A, #01
        DI
l1448:  JMP l036e
l144b:  DI
        PUSH H
        LXI H, #2191
        MVI A, #06
l1452:  CALL l03d9
        INR A
l1456:  CALL l03e6
l1459:  JNZ l1463
l145c:  CALL l03ce
        POP H
l1460:  JMP l147d
l1463:  CALL l03d9
        POP H
l1467:  CALL l060e
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
l147a:  CALL l061a
l147d:  JMP l1430
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
l14ac:  (JK) l020d
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
l14c4:  JMP l14f5
        MVI C, #01
        MVI B, #2a
l14cb:  JMP l14f5
        MVI C, #02
        MVI B, #10
l14d2:  JMP l14f5
        MVI C, #03
        MVI B, #1a
l14d9:  JMP l14f5
        MVI C, #04
        MVI B, #01
l14e0:  JMP l14f5
        MVI C, #05
        MVI B, #19
l14e7:  JMP l14f5
        MVI C, #06
        MVI B, #21
        POP B
        PUSH PSW
        INR D
        MVI C, #07
        MVI B, #0a
l14f5:  LXI H, #2090
        MVI A, #07
l14fa:  CALL l03ce
        MVI A, #02
l14ff:  CALL l03e6
l1502:  JNZ l147a
        MOV A,C
        LXI H, #21c6
l1509:  CALL l03e6
l150c:  JZ l147a
l150f:  CALL l03d9
l1512:  CALL l1d82
        LXI H, #11e4
l1518:  CALL l026e
        LXI H, #135a
l151e:  CALL l12e4
        LDA $21c6
        CPI #00
l1526:  JNZ l147a
        MVI A, #3d
        STA $21a4
        MVI A, #00
        STA $2205
l1533:  JMP l147a
        LDA $2205
        INR A
        STA $2205
        CPI #09
l153f:  JZ l155b
        MVI D, #00
        MOV E,A
        LXI H, #1589
        DAD D
        MOV B,M
l154a:  CALL l1d77
        LXI H, #135a
l1550:  CALL l12e4
        MVI A, #0a
        STA $21a4
l1558:  JMP l0608
l155b:  MVI B, #11
l155d:  CALL l1d9d
l1560:  JNZ l1573
        MVI B, #38
l1565:  CALL l1d9d
l1568:  JNZ l157e
        MVI B, #11
l156d:  CALL l1d77
l1570:  JMP l157e
l1573:  CALL l1d82
        MVI B, #38
l1578:  CALL l1d77
l157b:  JMP l157e
l157e:  MVI A, #ff
        STA $21c6
        SUB A
        STA $2205
l1587:  JMP l0608
        STAX B
        LHLD $1a10
        LXI B, #2119
        LDAX B
        LXI H, #2190
        MVI A, #07
l1597:  CALL l03e6
l159a:  JZ l147a
l159d:  CALL l03d9
        MVI A, #02
l15a2:  CALL l03e6
l15a5:  JNZ l147a
        LXI H, #1200
l15ab:  CALL l0eed
        LXI H, #2190
        MVI A, #04
l15b3:  CALL l03e6
l15b6:  JZ l15e4
        LXI H, #2191
        MVI A, #01
l15be:  CALL l03e6
l15c1:  JNZ l15e4
l15c4:  CALL l03ce
        LDA $21c7
        MVI B, #ff
l15cc:  INR B
        RAR
l15ce:  JNC l15cc
        MOV A,B
        DCR A
l15d3:  JP l15d8
        MVI A, #04
l15d8:  STA $2211
l15db:  CALL l03fa
        LXI H, #13bb
l15e1:  CALL l12e4
l15e4:  LXI H, #2190
        MVI A, #03
l15e9:  CALL l03e6
l15ec:  JNZ l15ff
        MVI B, #09
l15f1:  CALL l1d9d
l15f4:  JZ l15ff
l15f7:  CALL l1d82
        MVI B, #31
l15fc:  CALL l1d92
l15ff:  LXI H, #1370
l1602:  CALL l12e4
l1605:  JMP l147a
        MVI A, #ff
        STA $2193
        LDA $2194
        ORI #30
        STA $2194
        LXI H, #2190
        MVI A, #02
l161a:  CALL l03e6
l161d:  JNZ l147a
l1620:  CALL l03ce
        LXI H, #11e8
l1626:  CALL l026e
        LXI H, #13ce
l162c:  CALL l12e4
l162f:  JMP l147a
        LXI H, #2190
        MVI A, #02
l1637:  CALL l03e6
l163a:  JNZ l147a
        MVI A, #07
l163f:  CALL l03e6
l1642:  JZ l147a
l1645:  CALL l03d9
        LXI H, #11e8
l164b:  CALL l0eed
        LXI H, #13b8
l1651:  CALL l12e4
l1654:  JMP l147a
        LXI H, #2192
        MVI A, #00
l165c:  CALL l03e6
l165f:  JNZ l1803
        LDA $237a
        ORA A
l1666:  JNZ l167c
        LDA $239e
        ANI #08
l166e:  JNZ l1803
        LDA $23b6
        ORI #80
        STA $23b6
l1679:  JMP l1803
l167c:  LDA $237b
        ANI #0f
        CPI #01
l1683:  JZ l1749
        CPI #00
l1688:  JZ l1749
        LXI H, #23a3
        LXI D, #2320
        MVI A, #2e
l1693:  CALL l0f60
l1696:  CALL l1822
        LXI H, #2192
        MVI A, #04
l169e:  CALL l03e6
l16a1:  JZ l16b1
        MVI A, #07
l16a6:  CALL l03e6
l16a9:  JZ l16b1
        MVI A, #01
l16ae:  JMP l16cd
l16b1:  MVI A, #06
l16b3:  CALL l03ce
        LDA $2190
        ORI #05
        STA $2190
        MVI A, #ff
        STA $2193
        LDA $2194
        ORI #30
        STA $2194
        MVI A, #00
l16cd:  STA $237b
        STA $239b
        STA $23bb
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
l16fb:  CALL l1808
        LXI H, #2192
        MVI A, #06
l1703:  CALL l03d9
        LXI H, #23b6
        MVI A, #06
l170b:  CALL l03d9
        LXI H, #21d3
        LXI D, #21c6
        MVI A, #10
l1716:  CALL l0f60
        LXI H, #21c9
        LXI D, #21ce
        MVI A, #0a
l1721:  CALL l0f60
        LXI H, #2190
        MVI A, #04
l1729:  CALL l03d9
l172c:  LDA $237a
        ADI #99
        DAA
        STA $237a
        STA $239a
        STA $23ba
        LDA $2214
        MOV B,A
        LDA $2213
        ADD B
        STA $2214
l1746:  JMP l17e7
l1749:  LDA $237e
        ANI #08
l174e:  JNZ l1803
l1751:  MVI A, #01
        LXI H, #237e
l1756:  CALL l03e6
l1759:  JZ l1794
        MVI A, #02
l175e:  CALL l03e6
l1761:  JZ l17b2
        MVI A, #03
l1766:  CALL l03ce
        MVI A, #f0
        STA $2390
        STA $23b0
        DI
        LDA $237e
        PUSH PSW
        MVI A, #1f
        STA $237e
        LXI H, #11cc
l177e:  CALL l0fcd
        MVI A, #2f
        STA $237e
        LXI H, #11cc
l1789:  CALL l0fcd
        POP PSW
        STA $237e
        EI
l1791:  JMP l17d4
l1794:  CALL l03ce
        MVI A, #f0
        STA $238d
        STA $23ad
        LDA $2216
        ANI #08
l17a4:  JNZ l17d4
        MVI A, #f0
        STA $2397
        STA $23b7
l17af:  JMP l17d4
l17b2:  CALL l03ce
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
l17d1:  JMP l17d4
l17d4:  LDA $237e
        STA $23be
        ANI #0f
        MOV B,A
        LDA $239e
        ORA B
        STA $239e
l17e4:  JMP l172c
l17e7:  IN #05
        ANI #80
l17eb:  JNZ l17fd
        LDA $237a
        ORA A
l17f2:  JZ l17fd
        LDA $237e
        ANI #08
l17fa:  JZ l1751
l17fd:  LXI H, #135d
l1800:  CALL l12e4
l1803:  MVI A, #06
l1805:  JMP l036e
l1808:  LXI H, #181a
        MVI C, #08
l180d:  MOV A,M
        STAX D
        INX D
        INX H
        DCR C
l1812:  JNZ l180d
        DCR B
l1816:  JNZ l1808
        RET

        RST 7
        RAR
        LXI B, #3904
        DCX H
        STC
        STC
l1822:  LXI H, #235b
        MVI A, #00
        MVI D, #1f
l1829:  MOV M,A
        INX H
        DCR D
l182c:  JNZ l1829
        LXI H, #2380
        MVI A, #ff
        MVI D, #1a
l1836:  MOV M,A
        INX H
        DCR D
l1839:  JNZ l1836
        LXI H, #23a0
        MVI A, #ff
        MVI D, #1a
l1843:  MOV M,A
        INX H
        DCR D
l1846:  JNZ l1843
        MVI A, #0f
        STA $238c
        STA $23ac
        STA $2396
        STA $23b6
        RET

l1858:  LDA $237e
        ANI #02
        MVI A, #20
        RZ
        LXI H, #2190
        MVI A, #03
l1865:  CALL l03e6
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
l187b:  CALL l03e6
l187e:  JNZ l147a
        LXI H, #2208
        MVI A, #ff
        ADD M
l1887:  JNC l1891
        MOV M,A
l188b:  JZ l1899
l188e:  JMP l147a
l1891:  MVI A, #32
        STA $2208
l1896:  JMP l147a
l1899:  MVI A, #ff
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
l18b9:  CALL l03ce
        LXI H, #2192
        MVI A, #04
l18c1:  CALL l03ce
        LXI H, #136b
l18c7:  CALL l12e4
l18ca:  CALL l1ba3
        XCHG
        LXI H, #21c6
        MVI A, #10
l18d3:  CALL l0f60
        LXI H, #2190
        MVI A, #00
l18db:  CALL l03e6
l18de:  JNZ l18e9
        MVI B, #39
l18e3:  CALL l1d9d
l18e6:  JNZ l18f7
l18e9:  MVI A, #02
        STA $21a0
l18ee:  CALL l1858
        STA $221c
l18f4:  JMP l147a
l18f7:  LHLD $235c
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
l1914:  CALL l0f60
        MVI A, #04
l1919:  PUSH PSW
        LXI H, #220d
        MVI A, #06
l191f:  CALL l0e7d
        POP PSW
        DCR A
l1924:  JNZ l1919
        LXI H, #21f3
l192a:  CALL l0f00
        MVI A, #3c
        STA $21ae
        LXI H, #13b8
l1935:  CALL l12e4
l1938:  JMP l147a
        LXI H, #11e8
l193e:  CALL l0f2a
l1941:  JC l1958
        LXI H, #11e8
l1947:  CALL l026e
        MVI A, #0a
        STA $21ae
        LXI H, #13b5
l1952:  CALL l12e4
l1955:  JMP l0608
l1958:  LXI H, #11e8
l195b:  CALL l0eed
        LXI H, #235b
l1961:  CALL l0fcd
        LXI H, #235b
l1967:  CALL l0f2a
l196a:  CALL l1858
        STA $221c
        LDA $221c
        DCR A
        STA $221c
l1977:  JZ l1982
        MVI A, #02
        STA $21a0
l197f:  JMP l0608
l1982:  MVI A, #01
        STA $2212
        MVI A, #32
        STA $2194
        LXI H, #2192
        MVI A, #03
l1991:  CALL l03d9
        LXI H, #2190
l1997:  CALL l03e6
l199a:  JZ l19b9
l199d:  CALL l03d9
        MVI A, #02
        STA $2212
        MVI B, #30
l19a7:  CALL l1d92
        LXI H, #2396
        MVI A, #04
l19af:  CALL l03d9
        LXI H, #2214
        INR M
l19b6:  JMP l1a8a
l19b9:  LDA $237b
        ORA A
        MVI A, #01
        LXI H, #237e
l19c2:  JZ l1a5b
        MVI A, #04
l19c7:  CALL l03e6
l19ca:  JNZ l19d3
        INR A
        CPI #08
l19d0:  JNZ l19c7
l19d3:  CALL l03d9
        INR A
        MOV C,A
        SUI #04
l19da:  CALL l03e6
        MOV A,C
l19de:  JNZ l1a69
        LDA $2213
        INR A
        MOV B,A
        LDA $237b
        INR A
        CMP B
l19eb:  JNZ l1a5b
        LXI H, #2191
        MVI A, #00
l19f3:  CALL l03e6
        MVI A, #01
l19f8:  JNZ l1a5b
        LDA $2192
        ORI #c0
        STA $2192
        LXI H, #23b6
        MVI A, #06
l1a08:  CALL l03ce
        LDA $23ac
        ANI #30
l1a10:  JZ l1a1c
        CPI #10
        MVI A, #05
l1a17:  JZ l1a1c
        MVI A, #0a
l1a1c:  STA $23be
        SUB A
        STA $239e
        LDA $238c
        ANI #0f
        STA $238c
        LXI H, #1382
l1a2e:  CALL l12e4
        MVI A, #00
        STA $239b
        STA $23bb
        MVI A, #fa
        STA $219e
        LDA $2216
        ANI #04
l1a43:  CZ l1db8
        MVI B, #00
l1a48:  CALL l1d9d
l1a4b:  JZ l0608
        MVI A, #7d
        STA $219a
        MVI A, #2d
        STA $2217
l1a58:  JMP l0608
l1a5b:  STA $237b
        STA $239b
        STA $23bb
        MVI A, #04
        LXI H, #237e
l1a69:  CALL l03ce
        LDA $2213
        MOV C,A
        LDA $237b
        CMP C
l1a74:  JNZ l1a8a
        LXI H, #2190
        MVI A, #04
l1a7c:  CALL l03ce
        MVI B, #00
l1a81:  CALL l1d9d
l1a84:  JZ l1a8a
l1a87:  CALL l1d92
l1a8a:  LDA $237e
        STA $23be
        MOV B,A
        ANI #0f
        STA $239e
        LXI H, #2190
        MVI A, #00
l1a9b:  CALL l03d9
        MVI A, #03
l1aa0:  CALL l03d9
        MVI B, #09
l1aa5:  CALL l1d82
        LXI H, #23b6
        MVI A, #05
l1aad:  CALL l03d9
        MVI A, #02
        STA $21a1
l1ab5:  JMP l0608
        LDA $2217
        DCR A
        STA $2217
l1abf:  JNZ l1aca
        MVI B, #00
l1ac4:  CALL l1d82
l1ac7:  JMP l0608
l1aca:  MVI A, #7d
        STA $219a
l1acf:  JMP l0608
        LDA $2212
        DCR A
        STA $2212
l1ad9:  JZ l1aea
        LXI H, #13a4
l1adf:  CALL l12e4
        MVI A, #a0
        STA $21a1
l1ae7:  JMP l0608
l1aea:  LXI H, #11cc
l1aed:  CALL l0f00
        LDA $21c9
        STA $2218
        LDA $21ce
        STA $2219
l1afc:  CALL l1ba3
        LXI D, #21c6
        MVI A, #10
l1b04:  CALL l0f60
        LXI H, #21c9
        LXI D, #21ce
        MVI A, #0a
l1b0f:  CALL l0f60
        MVI B, #2b
l1b14:  CALL l1d77
        MVI B, #2c
l1b19:  CALL l1d77
        MVI B, #04
l1b1e:  CALL l1d77
        MVI B, #0c
l1b23:  CALL l1d77
        MVI B, #14
l1b28:  CALL l1d77
        MVI B, #11
l1b2d:  CALL l1d82
        MVI B, #38
l1b32:  CALL l1d82
        MVI B, #31
l1b37:  CALL l1d82
        MVI B, #09
l1b3c:  CALL l1d82
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
l1b5f:  CALL l1d82
        LXI H, #2192
        MVI A, #07
l1b67:  CALL l03ce
        LXI H, #13c9
l1b6d:  CALL l12e4
        LDA $2214
        DCR A
        STA $2214
        SUI #02
l1b79:  JM l1ba0
l1b7c:  JNZ l1ba0
        LDA $237e
        MVI B, #00
        ANI #0f
l1b86:  RAR
l1b87:  JNC l1b8e
        INR B
l1b8b:  JMP l1b86
l1b8e:  LDA $237a
        SUB B
l1b92:  JP l1ba0
        MVI B, #00
l1b97:  CALL l1d9d
l1b9a:  JNZ l1ba0
l1b9d:  CALL l1d77
l1ba0:  JMP l0608
l1ba3:  LDA $237e
        ANI #f0
        LXI H, #21eb
        LXI D, #fff8
l1bae:  RAL
        RC
        DAD D
l1bb1:  JMP l1bae
l1bb4:  EI
        LXI H, #2215
        IN #04
        MOV M,A
        LDA $2192
        ANI #04
l1bc0:  JNZ l1c53
        DI
        LDA $2353
        MOV B,A
        LDA $23f8
        SUB B
        LDA $2194
l1bcf:  JM l1bd7
        ANI #dd
l1bd4:  JMP l1bdb
l1bd7:  ORI #02
        ANI #df
l1bdb:  STA $2194
        LDA $2192
        ANI #01
        EI
l1be4:  JZ l1c05
        LDA $2192
        ANI #fe
        STA $2192
        LXI H, #2244
        LXI D, #2380
        MVI A, #34
l1bf7:  CALL l0f60
        LXI H, #2264
        LXI D, #23a0
        MVI A, #34
l1c02:  CALL l0f60
l1c05:  LDA $2215
        ANI #20
l1c0a:  JNZ l1ce1
        EI
        LDA $2192
        ANI #40
l1c13:  JZ l1c2e
        LDA $237a
        ORA A
        LXI H, #23b6
        MVI A, #07
l1c1f:  JNZ l1c28
l1c22:  CALL l03ce
l1c25:  JMP l01a2
l1c28:  CALL l03d9
l1c2b:  JMP l01a2
l1c2e:  LDA $2191
        ANI #01
        EI
l1c34:  JZ l01a2
        IN #03
        CPI #fe
l1c3b:  JNZ l1c45
        IN #02
        CPI #fb
l1c42:  JZ l1cfa
l1c45:  LXI H, #2191
        MVI A, #00
l1c4a:  CALL l03d9
        STA $219f
l1c50:  JMP l01a2
l1c53:  LXI H, #2192
        MVI A, #00
l1c58:  CALL l03e6
l1c5b:  JNZ l0208
l1c5e:  CALL l03ce
        LDA $2241
        ANI #01
l1c66:  JNZ l1c74
        LXI H, #2380
        LXI D, #2244
        MVI A, #80
l1c71:  CALL l0f60
l1c74:  MVI A, #ff
        LXI H, #2383
        MVI B, #17
l1c7b:  MOV M,A
        INX H
        DCR B
l1c7e:  JNZ l1c7b
        MVI A, #0f
        STA $238c
        LDA $2216
        ANI #04
l1c8b:  JNZ l1c96
        LDA $2241
        ANI #01
l1c93:  JNZ l1cbb
l1c96:  LXI H, #2320
        LXI D, #23a3
        MVI A, #2e
l1c9e:  CALL l0f60
l1ca1:  LDA $225a
        ORI #0f
        STA $2396
        LDA $227a
        ANI #f0
        MOV B,A
        LDA $23b6
        ANI #0f
        ORA B
        STA $23b6
l1cb8:  JMP l0208
l1cbb:  LXI H, #23a3
        MVI C, #17
        MVI A, #ff
l1cc2:  MOV M,A
        INX H
        DCR C
l1cc5:  JNZ l1cc2
        LXI D, #23a9
        LXI H, #2228
        MVI A, #08
l1cd0:  CALL l0f7b
        LXI D, #23b3
        LXI H, #222c
        MVI A, #08
l1cdb:  CALL l0f7b
l1cde:  JMP l1ca1
l1ce1:  LDA $2353
        MOV B,A
        LDA $23f8
        SUB B
l1ce9:  JP l0208
        LXI H, #2192
        MVI A, #06
l1cf1:  CALL l03e6
l1cf4:  JZ l1cfa
l1cf7:  JMP l0208
l1cfa:  LDA $237e
        STA $239e
        LDA $23ac
        STA $238c
        MVI B, #30
l1d08:  CALL l1d82
        LDA $2396
        ANI #cf
        STA $2396
        LDA $23b6
        ANI #cf
        STA $23b6
        LXI H, #21c2
        MVI A, #05
l1d20:  CALL l03ce
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
l1d4f:  CALL l03d9
        LXI H, #2194
        MVI A, #04
l1d57:  CALL l03ce
        MVI A, #06
        STA $21a8
        MVI A, #05
        STA $2197
l1d64:  JMP l0208
        LXI H, #21c2
        MVI A, #05
l1d6c:  CALL l03d9
        DI
        CALL $13de
        EI
l1d74:  JMP l0608
l1d77:  CALL l1da4
l1d7a:  CALL l03ce
        DAD D
l1d7e:  CALL l03ce
        RET

l1d82:  CALL l1da4
l1d85:  CALL l03d9
        DAD D
l1d89:  CALL l03e6
        PUSH PSW
l1d8d:  CALL l03d9
        POP PSW
        RET

l1d92:  CALL l1da4
l1d95:  CALL l03ce
        DAD D
l1d99:  CALL l03d9
        RET

l1d9d:  CALL l1da4
l1da0:  CALL l03e6
        RET

l1da4:  LXI H, #21c9
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

l1db8:  LXI H, #2363
l1dbb:  CALL l1fe4
        LXI H, #236b
        PUSH H
l1dc2:  CALL l0ea9
        POP H
l1dc6:  JNC l1dd5
        SHLD $2238
        LXI H, #2363
        SHLD $223a
l1dd2:  JMP l1dde
l1dd5:  SHLD $223a
        LXI H, #2363
        SHLD $2238
l1dde:  LHLD $2238
l1de1:  CALL l1fe4
        LXI H, #235f
        PUSH H
l1de8:  CALL l0ea9
        POP H
l1dec:  JC l1e05
        PUSH H
        LHLD $223a
l1df3:  CALL l1fe4
        POP H
        PUSH H
l1df8:  CALL l0ea9
        POP H
l1dfc:  JC l1e10
        SHLD $223c
l1e02:  JMP l1e18
l1e05:  PUSH H
l1e06:  CALL l1e6b
        POP H
        SHLD $2238
l1e0d:  JMP l1e18
l1e10:  PUSH H
l1e11:  CALL l1e6b
        POP H
        SHLD $223a
l1e18:  LHLD $2238
l1e1b:  CALL l1fe4
        LXI H, #236f
        PUSH H
l1e22:  CALL l0ea9
        POP H
l1e26:  JC l1e4f
        PUSH H
        LHLD $223a
l1e2d:  CALL l1fe4
        POP H
        PUSH H
l1e32:  CALL l0ea9
        POP H
l1e36:  JC l1e5a
        PUSH H
        LHLD $223c
l1e3d:  CALL l1fe4
        POP H
        PUSH H
l1e42:  CALL l0ea9
        POP H
l1e46:  JC l1e78
        SHLD $223e
l1e4c:  JMP l1e83
l1e4f:  PUSH H
l1e50:  CALL l1e65
        POP H
        SHLD $2238
l1e57:  JMP l1e83
l1e5a:  PUSH H
l1e5b:  CALL l1e6b
        POP H
        SHLD $223a
l1e62:  JMP l1e83
l1e65:  LHLD $223c
        SHLD $223e
l1e6b:  LHLD $223a
        SHLD $223c
        LHLD $2238
        SHLD $223a
        RET

l1e78:  PUSH H
        LHLD $223c
        SHLD $223e
        POP H
        SHLD $223c
l1e83:  LXI H, #2228
l1e86:  CALL l1fe4
        LHLD $2238
        PUSH H
l1e8d:  CALL l0ea9
        POP H
l1e91:  CC l1f5f
        RC
        LXI H, #222c
l1e98:  CALL l1fe4
        LHLD $2238
        PUSH H
l1e9f:  CALL l0ea9
        POP H
l1ea3:  CC l1f76
        RC
        LXI H, #2230
l1eaa:  CALL l1fe4
        LHLD $2238
        PUSH H
l1eb1:  CALL l0ea9
        POP H
l1eb5:  CC l1f8a
        RC
        LXI H, #2234
l1ebc:  CALL l1fe4
        LHLD $2238
        PUSH H
l1ec3:  CALL l0ea9
        POP H
l1ec7:  CC l1f9b
        RET

        LXI H, #222c
l1ece:  CALL l1fe4
        LHLD $223a
        PUSH H
l1ed5:  CALL l0ea9
        POP H
l1ed9:  CC l1f76
        RC
        LXI H, #2230
l1ee0:  CALL l1fe4
        LHLD $223a
        PUSH H
l1ee7:  CALL l0ea9
        POP H
l1eeb:  CC l1f8a
        RC
        LXI H, #2234
l1ef2:  CALL l1fe4
        LHLD $223a
        PUSH H
l1ef9:  CALL l0ea9
        POP H
l1efd:  CC l1f9b
        RET

        LXI H, #2230
l1f04:  CALL l1fe4
        LHLD $223c
        PUSH H
l1f0b:  CALL l0ea9
        POP H
l1f0f:  CC l1f8a
        RC
        LXI H, #2234
l1f16:  CALL l1fe4
        LHLD $223c
        PUSH H
l1f1d:  CALL l0ea9
        POP H
l1f21:  CC l1f9b
        RET

        LXI H, #2234
l1f28:  CALL l1fe4
        LHLD $223e
        PUSH H
l1f2f:  CALL l0ea9
        POP H
l1f33:  CC l1f9b
        RET

l1f37:  PUSH PSW
        LXI H, #2230
        PUSH H
        LXI D, #2234
        MVI A, #07
l1f41:  CALL l0f60
        POP D
        POP PSW
        DCR A
        RZ
        PUSH PSW
        LXI H, #222c
        PUSH H
        MVI A, #07
l1f4f:  CALL l0f60
        POP D
        POP PSW
        DCR A
        RZ
        LXI H, #2228
        MVI A, #07
l1f5b:  CALL l0f60
        RET

l1f5f:  PUSH H
        MVI A, #03
l1f62:  CALL l1f37
        POP H
        LXI D, #2228
        MVI A, #07
l1f6b:  CALL l0f60
l1f6e:  CALL l1fa5
l1f71:  CALL l1fa5
        CMC
        RET

l1f76:  PUSH H
        MVI A, #02
l1f79:  CALL l1f37
        POP H
        LXI D, #222c
        MVI A, #07
l1f82:  CALL l0f60
l1f85:  CALL l1fa5
        CMC
        RET

l1f8a:  PUSH H
        MVI A, #01
l1f8d:  CALL l1f37
        POP H
        LXI D, #2230
        MVI A, #07
l1f96:  CALL l0f60
        CMC
        RET

l1f9b:  LXI D, #2234
        MVI A, #07
l1fa0:  CALL l0f60
        CMC
        RET

l1fa5:  LDA $237a
        CPI #99
        RZ
        ORA A
        INR A
        DAA
        STA $237a
        STA $239a
        STA $23ba
        LXI H, #13d4
l1fba:  CALL l12e4
        LXI H, #13c4
l1fc0:  CALL l12e4
        RET

l1fc4:  LXI H, #222c
        PUSH H
        LXI D, #2228
        MVI A, #07
l1fcd:  CALL l0f60
        POP D
        LXI H, #2230
        PUSH H
        MVI A, #07
l1fd7:  CALL l0f60
        POP D
        LXI H, #2234
        MVI A, #07
l1fe0:  CALL l0f60
        RET

l1fe4:  LXI D, #21f3
        MVI A, #00
        MVI B, #04
l1feb:  STAX D
        INX D
        DCR B
l1fee:  JNZ l1feb
        LXI D, #21f3
        MVI A, #07
l1ff6:  CALL l0f60
        MVI A, #07
        RET

        NOP
        ADD C
        PCHL
        LXI B, #0000
