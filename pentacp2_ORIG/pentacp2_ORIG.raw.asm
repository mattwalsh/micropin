l0000:  JMP l0040
l0003:  CALL l06b4
l0006:  JMP l0382
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
l0024:  JMP l0069
        HLT
        HLT
        HLT
        HLT
        MOV B,M
l002c:  JMP l0330
        HLT
        HLT
        HLT
        HLT
        NOP
l0034:  JMP l0386
        HLT
        HLT
        HLT
        HLT
l003b:  JNZ l00c3
        (LDHI) #76
l0040:  MVI A, #21
        STA $23da
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
l005a:  JZ l0069
        LXI H, #2000
l0060:  SUB A
        MOV M,A
        INX H
        MVI A, #24
        CMP H
l0066:  JNZ l0060
l0069:  LXI SP, #2190
        MVI A, #07
l006e:  OUT #0e
        OUT #0d
        DCR A
l0073:  JP l006e
        LXI H, #2197
        MVI C, #2d
l007b:  SUB A
        MOV M,A
        INX H
        DCR C
l007f:  JNZ l007b
        MVI A, #05
        STA $0000
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
l00bd:  JZ l00f5
        LXI H, #1181
l00c3:  LXI D, #222d
        MVI A, #08
l00c8:  CALL l0ecf
        LXI H, #117d
        LXI D, #2231
        MVI A, #08
l00d3:  CALL l0ecf
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
l00f2:  JMP l00fb
l00f5:  CALL l0317
l00f8:  JZ l0143
l00fb:  MVI A, #07
        STA $21c2
        CMA
        OUT #05
        MVI A, #06
        STA $21a6
l0108:  EI
        LDA $21a6
        ORA A
l010d:  JNZ l0108
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
l012d:  EI
        LDA $21a6
        ORA A
l0132:  JNZ l012d
        MVI A, #ff
        OUT #05
        OUT #06
        OUT #07
        OUT #08
        DI
        CALL $137d
l0143:  IN #04
        ANI #20
l0147:  JNZ l0168
        LDA $2192
        MVI A, #d0
        STA $2192
        IN #03
        CPI #fe
l0156:  JNZ l01bf
        IN #02
        CPI #fb
l015d:  JZ l029e
        CPI #f7
l0162:  JZ l02c8
l0165:  JMP l01bf
l0168:  CALL l17a8
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
l019d:  CALL l0ecf
        MVI B, #01
        LXI D, #21c6
l01a5:  CALL l178e
        LXI H, #21c9
        LXI D, #21ce
        MVI A, #0a
l01b0:  CALL l0ecf
        LXI H, #2205
        MVI B, #13
        SUB A
l01b9:  MOV M,A
        INX H
        DCR B
l01bc:  JNZ l01b9
l01bf:  DI
        MVI A, #30
        STA $2194
        LDA $2192
        ANI #80
l01ca:  JNZ l01d2
        MVI A, #00
        STA $2192
l01d2:  IN #02
        CMA
        MOV L,A
        IN #04
        CMA
        ANI #03
        MOV H,A
        MVI B, #0f
l01de:  DAD H
l01df:  JC l01e6
        DCR B
l01e3:  JNZ l01de
l01e6:  IN #03
        CMA
        MOV L,A
        IN #04
        CMA
        ANI #0c
        RAR
        RAR
        MOV H,A
        MVI C, #0f
l01f4:  DAD H
l01f5:  JC l01fc
        DCR C
l01f9:  JNZ l01f4
l01fc:  MOV A,C
        RAL
        RAL
        RAL
        RAL
        ANI #f0
        ADD B
        STA $237f
        STA $239f
        STA $23bf
        EI
        IN #05
        LXI H, #2216
        MOV M,A
        MVI B, #03
        MVI A, #00
l0218:  CALL l03ee
l021b:  JNZ l0228
        INR B
        MVI A, #01
l0221:  CALL l03ee
l0224:  JNZ l0228
        INR B
l0228:  MOV A,B
        STA $2213
l022c:  OUT #0f
        EI
        NOP
        EI
        NOP
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
l025c:  JZ l027b
l025f:  JM l0267
        CPI #08
l0264:  JC l0270
l0267:  LXI H, #21fb
        SHLD $21f9
l026d:  JMP l027b
l0270:  DCX H
        MOV A,M
        DCX H
        SHLD $21f9
        MOV L,M
        MOV H,A
l0278:  CALL l0f3c
l027b:  EI
        LXI H, #2192
        MVI A, #07
l0281:  CALL l03ee
l0284:  JNZ l1bb9
        LDA $23b6
        ANI #bf
        STA $23b6
l028f:  JMP l022c
l0292:  XCHG
        LHLD $21f9
        MOV M,E
        INX H
        MOV M,D
        INX H
        SHLD $21f9
        RET

l029e:  LDA $2191
        MOV B,A
        ANI #01
l02a4:  JNZ l01bf
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
l02c5:  JMP l0168
l02c8:  DI
        LXI H, #23c0
        MVI B, #0c
l02ce:  MVI M, #88
        INX H
        DCR B
l02d2:  JNZ l02ce
        MVI M, #f8
        INX H
        MVI B, #09
l02da:  MVI M, #88
        INX H
        DCR B
l02de:  JNZ l02da
        MVI M, #f8
        INX H
        MVI B, #07
l02e6:  MVI M, #88
        INX H
        DCR B
l02ea:  JNZ l02e6
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
l0300:  JMP l0143
l0303:  LXI D, #233b
        LXI B, #0000
        LXI H, #0000
l030c:  LDAX D
        MOV C,A
        DAD B
        INX D
        MOV A,E
        CPI #5d
l0313:  JNZ l030c
        RET

l0317:  CALL l0303
        XCHG
        LHLD $2224
        MOV A,E
        CMP L
        RNZ
        ORA A
l0322:  JZ l0328
l0325:  MOV A,D
        CMP H
        RET

l0328:  MOV A,D
        ORA A
l032a:  JNZ l0325
        INR A
        RET

        DCR L
l0330:  CALL l0624
        LDA $2190
        ORI #80
        STA $2190
        IN #01
        LXI D, #0000
l0340:  ORA A
l0341:  JZ l0382
        RAR
l0345:  JC l034c
        INR E
l0349:  JMP l0340
l034c:  MOV A,E
        CMA
        OUT #0e
        CMA
        LXI H, #2193
l0354:  CALL l03ee
l0357:  JNZ l0382
l035a:  CALL l0624
        LDA $2191
        ANI #02
l0362:  CNZ l0402
l0365:  CALL l0630
l0368:  CALL l03d6
        XCHG
        DAD H
        LXI D, #03b6
        DAD D
        MOV A,M
        INX H
        MOV H,M
        MOV L,A
        PCHL
l0376:  LXI H, #2194
l0379:  JMP l037f
        LXI H, #2193
l037f:  CALL l03e1
l0382:  CALL l0630
        RET

l0386:  CALL l0624
        LXI D, #0000
        IN #00
l038e:  ORA A
l038f:  JZ l0382
        RAR
l0393:  JC l039a
        INR E
l0397:  JMP l038e
l039a:  MOV A,E
        CMA
        OUT #0d
        CMA
        LXI H, #2194
l03a2:  CALL l03ee
l03a5:  JNZ l0382
l03a8:  CALL l03d6
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
        INX B
        NOP
        MOV A,E
        INR B
        STC
        (DSUB)
        DAD B
        DAD B
        EI
        DCR D
        MOV A,E
        INR B
l03d6:  PUSH B
        MOV B,A
l03d8:  CALL l03f9
        MOV C,M
        ORA C
        MOV M,A
l03de:  JMP l03f6
l03e1:  PUSH B
        MOV B,A
l03e3:  CALL l03f9
        CMA
        MOV C,A
        MOV A,M
        ANA C
        MOV M,A
l03eb:  JMP l03f6
l03ee:  PUSH B
        MOV B,A
l03f0:  CALL l03f9
        MOV C,A
        MOV A,M
        ANA C
l03f6:  MOV A,B
        POP B
        RET

l03f9:  MOV C,A
        MVI A, #01
l03fc:  DCR C
        RM
        ADD A
l03ff:  JMP l03fc
l0402:  LDA $2211
        MOV B,A
l0406:  CALL l0427
l0409:  CALL l03ee
l040c:  JZ l0413
        XCHG
l0410:  CALL l03d6
l0413:  MOV A,B
        INR A
        CPI #05
l0417:  JNZ l041c
        MVI A, #00
l041c:  STA $2211
l041f:  CALL l0427
        XCHG
l0423:  CALL l03e1
        RET

l0427:  MVI D, #00
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

l046a:  LDA $2192
        ANI #40
        RZ
        LDA $237a
        ORA A
l0474:  JZ l0479
        CMP A
        RET

l0479:  DCR A
        RET

        CALL $044f
        MVI A, #7d
        STA $21a2
l0483:  CALL l046a
l0486:  JNZ l0382
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
l04ab:  JM l0543
        LDA $2192
        ANI #40
l04b3:  JNZ l0543
        LDA $2194
        ORI #fc
        STA $2194
        LDA $2247
        ORI #40
        STA $2247
        MVI A, #ff
        LXI H, #23c0
        MVI B, #20
l04cd:  MOV M,A
        INX H
        DCR B
l04d0:  JNZ l04cd
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
        ANI #df
        STA $2396
        LDA $23b6
        ANI #df
        STA $23b6
        MVI B, #30
l050c:  CALL l1d81
        MVI A, #d0
        STA $2192
        LDA $2213
        STA $237b
        LXI H, #237e
        MOV A,M
        ANI #0f
        MOV M,A
        MVI B, #ff
l0523:  RAR
l0524:  JNC l052b
        INR B
l0528:  JMP l0523
l052b:  MOV A,B
        ADI #04
l052e:  CALL l03d6
        MVI A, #01
        STA $2214
        MVI A, #28
        STA $221b
        MVI A, #02
        STA $219d
l0540:  JMP l0382
l0543:  LXI H, #12c2
l0546:  CALL l1261
l0549:  JMP l0382
        LDA $221b
        DCR A
        STA $221b
l0553:  JZ l0569
        MVI A, #14
        STA $219d
        MVI A, #fa
        STA $219e
        LXI H, #12bf
l0563:  CALL l1261
l0566:  JMP l061e
l0569:  LDA $2247
        ANI #bf
        STA $2247
        MVI A, #01
        STA $21a0
        STA $221c
        LDA $2194
        ANI #33
        STA $2194
l0581:  JMP l061e
        IN #04
        ANI #80
l0588:  JZ l05a2
l058b:  CALL l046a
l058e:  JNZ l05a2
        CALL $044f
        MVI A, #7d
        STA $21a2
        LXI H, #12c2
l059c:  CALL l1261
l059f:  JMP l061e
l05a2:  LDA $2194
        ANI #77
        STA $2194
l05aa:  JMP l061e
        LXI H, #2192
        MVI A, #07
l05b2:  CALL l03ee
l05b5:  JZ l061e
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
l05d6:  JMP l061e
        LXI H, #2197
        MVI C, #1a
l05de:  MVI A, #ff
        ADD M
l05e1:  JNC l05e8
        MOV M,A
l05e5:  JZ l0609
l05e8:  INX H
        DCR C
l05ea:  JNZ l05de
        LDA $2198
        ORA A
l05f1:  JNZ l05f6
        MVI A, #01
l05f6:  ANI #3f
        STA $2198
        LDA $2247
        ANI #40
l0600:  CZ l0636
        MVI A, #00
        DI
l0606:  JMP l0376
l0609:  DI
l060a:  CALL l0624
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
l061e:  CALL l0630
l0621:  JMP l05e8
l0624:  SHLD $2195
        XTHL
        PUSH B
        PUSH D
        PUSH PSW
        PUSH H
        LHLD $2195
        RET

l0630:  POP H
        POP PSW
        POP D
        POP B
        XTHL
        RET

l0636:  LXI H, #21f8
        DCR M
l063a:  JNZ l0647
        MVI M, #14
        LDA $2247
        ADI #80
        STA $2247
l0647:  LDA $2247
        ANI #80
l064c:  JZ l067b
        LXI H, #23a0
        LXI D, #23c0
        MVI A, #40
l0657:  CALL l0ecf
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
l0678:  JMP l06a4
l067b:  LXI H, #2380
        LXI D, #23c0
        MVI A, #40
l0683:  CALL l0ecf
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
l06a4:  IN #04
        ANI #10
l06a8:  JNZ l06b4
        LDA $2192
        ORI #20
        STA $2192
        RET

l06b4:  LXI H, #2192
        MVI A, #05
l06b9:  CALL l03ee
        RZ
l06bd:  CALL l03e1
        LDA $237a
        CPI #99
        RZ
        LXI H, #21c5
        MVI A, #03
l06cb:  CALL l03d6
        MVI A, #09
        STA $21ab
l06d3:  MVI A, #06
        LXI H, #2376
l06d8:  CALL l03e1
        LXI H, #2396
l06de:  CALL l03e1
        LXI H, #23b6
l06e4:  CALL l03e1
        MVI B, #00
l06e9:  CALL l1d81
        LDA $237a
        INR A
        DAA
        STA $237a
        STA $239a
        STA $23ba
        LXI H, #1341
l06fd:  CALL l1261
        LXI H, #224a
        DCR M
        RNZ
        MVI M, #64
l0707:  CALL l1faa
        RET

        LXI H, #21c5
        MVI A, #03
l0710:  CALL l03ee
l0713:  JZ l0721
l0716:  CALL l03e1
        MVI A, #09
        STA $21ab
l071e:  JMP l061e
l0721:  LDA $2194
        ANI #bb
        STA $2194
l0729:  JMP l061e
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
        ADD H
        DCR B
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
l0763:  JMP l078f
        LXI D, #0001
l0769:  JMP l078f
        LXI D, #0002
l076f:  JMP l078f
        LXI D, #0003
l0775:  JMP l078f
        LXI D, #0004
l077b:  JMP l078f
        LXI D, #0005
l0781:  JMP l078f
        LDA $2191
        ORI #20
        STA $2191
l078c:  JMP l0382
l078f:  LXI H, #0806
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
l079f:  CALL l03d6
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
l07bc:  CALL l1261
        POP D
        LXI H, #0829
        DAD D
        MOV B,M
        INX H
        MOV H,M
        MOV L,B
l07c8:  CALL l0292
l07cb:  JMP l0382
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
l07e8:  JNZ l061e
        MVI A, #06
        STA $21ad
l07f0:  JMP l061e
        LXI H, #2190
        MVI A, #02
l07f8:  CALL l03ee
l07fb:  JNZ l061e
        MVI A, #80
        STA $2193
l0803:  JMP l061e
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
        LXI H, #2190
        MVI A, #05
l084c:  CALL l03ee
l084f:  JNZ l0382
        LXI H, #134e
l0855:  CALL l1261
        MVI A, #04
        STA $2222
        LXI H, #2191
        MVI A, #00
l0862:  CALL l03ee
l0865:  JZ l0382
        MVI A, #7d
        STA $219f
l086d:  JMP l0382
        LXI H, #21c3
        MVI A, #04
l0875:  CALL l03ee
l0878:  JNZ l0891
        LXI H, #2190
        MVI A, #02
l0880:  CALL l03ee
l0883:  JNZ l061e
        MVI A, #04
        LXI H, #2194
l088b:  CALL l03e1
l088e:  JMP l061e
l0891:  LDA $21c3
        ANI #2f
        STA $21c3
        CMA
        OUT #06
        MVI A, #06
        STA $21a8
l08a1:  JMP l061e
        LDA $2191
        ANI #01
l08a9:  JZ l08bc
        LDA $21c3
        ORI #30
        STA $21c3
        MVI A, #09
        STA $21a8
        STA $21a9
l08bc:  MVI A, #71
        STA $219f
        LDA $221f
        DCR A
        STA $221f
l08c8:  JNZ l061e
        MVI A, #3c
        STA $221f
        LDA $2220
        INR A
        DAA
        STA $2220
        CPI #60
l08da:  JNZ l061e
        MVI A, #00
        STA $2220
        LDA $2221
        INR A
        DAA
        STA $2221
        LDA $2222
        DCR A
        STA $2222
l08f1:  JNZ l061e
l08f4:  CALL l1faa
        MVI A, #64
        STA $224a
        MVI A, #04
        STA $2222
        MVI A, #00
        STA $219f
l0906:  JMP l061e
        LDA $21c3
        ORI #20
        STA $21c3
        CMA
        OUT #06
        MVI A, #09
        STA $21a9
        LXI H, #2190
        MVI A, #05
l091e:  CALL l03ee
l0921:  JNZ l0382
        LXI H, #134e
l0927:  CALL l1261
l092a:  JMP l0382
        LXI H, #21c3
        MVI A, #05
l0932:  CALL l03ee
l0935:  JNZ l094e
        LXI H, #2190
        MVI A, #02
l093d:  CALL l03ee
l0940:  JNZ l061e
        LXI H, #2194
        MVI A, #05
l0948:  CALL l03e1
l094b:  JMP l061e
l094e:  LDA $21c3
        ANI #1f
        STA $21c3
        CMA
        OUT #06
        MVI A, #06
        STA $21a9
l095e:  JMP l061e
        MVI B, #24
        MVI C, #00
l0965:  JMP l0999
        MVI B, #03
        MVI C, #01
l096c:  JMP l0999
        MVI B, #0b
        MVI C, #02
l0973:  JMP l0999
        MVI B, #13
        MVI C, #03
l097a:  JMP l0999
        MVI B, #29
        MVI C, #04
l0981:  JMP l0999
        MVI A, #04
        STA $2197
        LXI H, #2208
        MVI A, #ff
        ADD M
l098f:  JNC l09ae
        MOV M,A
l0993:  JZ l0bdf
l0996:  JMP l1419
l0999:  LXI H, #2208
        MVI A, #ff
        ADD M
l099f:  JNC l09ae
        MOV M,A
l09a3:  JZ l09bb
        MVI A, #04
        STA $2197
l09ab:  JMP l1419
l09ae:  MVI A, #64
        STA $2208
        MVI A, #04
        STA $2197
l09b8:  JMP l1419
l09bb:  LXI H, #2190
        MVI A, #07
l09c0:  CALL l03d6
        MVI A, #02
l09c5:  CALL l03ee
l09c8:  JZ l09da
        MOV A,C
l09cc:  CALL l0b6f
l09cf:  CALL l03d6
        MVI A, #06
        STA $21a6
l09d7:  JMP l1419
l09da:  CALL l1d81
        MOV A,C
        LXI H, #21c7
l09e1:  CALL l03ee
l09e4:  JZ l0b52
l09e7:  CALL l03e1
        LXI H, #2211
        CMP M
        LXI H, #2192
        MVI A, #01
l09f3:  JNZ l09fc
l09f6:  CALL l03d6
l09f9:  JMP l09ff
l09fc:  CALL l03e1
l09ff:  MOV A,C
l0a00:  CALL l0b6f
l0a03:  CALL l1d9c
l0a06:  JZ l0a14
        XCHG
        DAD D
l0a0b:  CALL l03ee
        XCHG
        MVI A, #01
l0a11:  JZ l0a24
l0a14:  CALL l1d91
        LXI H, #12e3
l0a1a:  CALL l1261
        MVI A, #c8
        STA $2208
        MVI A, #5a
l0a24:  STA $219b
l0a27:  JMP l1419
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
l0a39:  CALL l0e5c
        LXI H, #12dd
l0a3f:  CALL l1261
        LXI H, #2192
        MVI A, #01
l0a47:  CALL l03ee
l0a4a:  JZ l0a93
l0a4d:  CALL l03e1
        LXI H, #2191
        MVI A, #01
l0a55:  CALL l03ee
l0a58:  JZ l0a93
l0a5b:  CALL l03e1
        MVI A, #fa
        STA $2208
        MVI A, #05
        STA $221a
        MVI A, #28
        STA $219c
l0a6d:  JMP l061e
        LXI H, #1171
l0a73:  CALL l0e5c
        LXI H, #1335
l0a79:  CALL l1261
        LDA $221a
        DCR A
        STA $221a
l0a83:  JZ l0a93
        MVI A, #28
        STA $219c
        MVI A, #fa
        STA $2208
l0a90:  JMP l061e
l0a93:  LDA $21c7
        CPI #00
l0a98:  JZ l0aac
        LHLD $2209
        LDA $220b
l0aa1:  CALL l03d6
        MVI A, #06
        STA $21a6
l0aa9:  JMP l061e
l0aac:  MVI A, #3c
        STA $21a5
        MVI A, #64
        STA $2208
        MVI A, #00
        STA $2207
l0abb:  JMP l061e
        SUB A
        STA $2208
        LDA $2207
        INR A
        STA $2207
        CPI #06
l0acb:  JZ l0aec
        MVI D, #00
        MOV E,A
        LXI H, #0bb9
        DAD D
        MOV B,M
l0ad6:  CALL l1d76
        LXI H, #12dd
l0adc:  CALL l1261
        MVI A, #0f
        STA $21a5
        MVI A, #64
        STA $2208
l0ae9:  JMP l061e
l0aec:  LHLD $2209
        LDA $220b
l0af2:  CALL l03d6
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
l0b0b:  JNZ l0b26
        LXI H, #2190
        MVI A, #03
l0b13:  CALL l03ee
l0b16:  JNZ l0b26
        MVI B, #31
l0b1b:  CALL l1d9c
l0b1e:  JNZ l0b26
        MVI B, #09
l0b23:  CALL l1d76
l0b26:  LDA $21c8
        INR A
        CPI #05
l0b2c:  JZ l0b44
        STA $21c8
        MVI D, #00
        MOV E,A
        LXI H, #0bbe
        DAD D
        MOV B,M
        PUSH H
l0b3b:  CALL l1d76
        POP H
        DCX H
        MOV B,M
l0b41:  CALL l1d81
l0b44:  LXI H, #2191
        MVI A, #01
l0b49:  CALL l03ee
l0b4c:  CNZ l0402
l0b4f:  JMP l061e
l0b52:  CALL l0b6f
l0b55:  CALL l03d6
        MVI A, #06
        STA $21a6
l0b5d:  CALL l1d9c
l0b60:  JNZ l1419
l0b63:  CALL l1d76
        LXI H, #12e0
l0b69:  CALL l1261
l0b6c:  JMP l1419
l0b6f:  MVI D, #00
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
l0ba4:  CALL l03e1
l0ba7:  JMP l061e
        MVI A, #00
        STA $2208
        LXI H, #2192
        MVI A, #03
l0bb4:  CALL l03e1
l0bb7:  JMP l061e
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
l0bdf:  MVI B, #39
l0be1:  CALL l1d9c
l0be4:  JZ l0d4d
        LXI H, #2190
        MVI A, #02
l0bec:  CALL l03ee
l0bef:  JNZ l0d4d
        LDA $220c
        ANI #03
l0bf7:  JNZ l0ca6
        LXI H, #235b
        LXI D, #220d
        MVI A, #06
l0c02:  CALL l0ecf
        MVI B, #38
l0c07:  CALL l1d9c
l0c0a:  JZ l0c12
        MVI A, #03
l0c0f:  JMP l0c21
l0c12:  MVI B, #11
l0c14:  CALL l1d9c
l0c17:  JZ l0c1f
        MVI A, #02
l0c1c:  JMP l0c21
l0c1f:  MVI A, #01
l0c21:  STA $220c
        MVI B, #31
l0c26:  CALL l1d9c
l0c29:  JZ l0ca6
        MVI B, #31
l0c2e:  CALL l1d81
        MVI B, #09
l0c33:  CALL l1d81
        LXI H, #1321
l0c39:  CALL l1261
        LXI H, #238a
        LDA $23be
        ANI #f0
        MOV C,A
        MVI E, #04
        MVI B, #4f
        CPI #80
l0c4b:  JZ l0c77
        INX H
        MVI E, #03
        MVI B, #03
        MOV A,M
        ANI #f0
        ORA B
        MOV B,A
        MOV A,C
        CPI #40
l0c5b:  JZ l0c77
        MVI E, #02
        MVI B, #20
        MOV A,M
        ANI #0f
        ORA B
        MOV B,A
        MOV A,C
        CPI #20
l0c6a:  JZ l0c77
        INX H
        MVI E, #01
        MVI B, #01
        MOV A,M
        ANI #f0
        ORA B
        MOV B,A
l0c77:  MOV M,B
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
l0c98:  CALL l03d6
        LXI H, #23b6
l0c9e:  CALL l03d6
        MVI A, #fa
l0ca3:  JMP l0ca8
l0ca6:  MVI A, #3c
l0ca8:  STA $21a7
l0cab:  JMP l1419
        LDA $2349
        MOV B,A
        LDA $23ee
        SUB B
l0cb6:  JM l0cc4
        LDA $2194
        ANI #fd
        STA $2194
l0cc1:  JMP l061e
l0cc4:  MVI A, #00
        STA $2197
        LDA $2194
        ORI #02
        STA $2194
        LXI H, #2190
        MVI A, #00
l0cd6:  CALL l03ee
l0cd9:  JNZ l0d29
        LXI H, #1165
l0cdf:  CALL l0e99
l0ce2:  JC l0cf9
        LXI H, #1165
l0ce8:  CALL l0292
        MVI A, #0a
        STA $21a7
        LXI H, #1332
l0cf3:  CALL l1261
l0cf6:  JMP l061e
l0cf9:  LXI H, #1165
l0cfc:  CALL l0e5c
        LXI H, #235b
l0d02:  CALL l0f3c
        LXI H, #235b
l0d08:  CALL l0e99
        LXI H, #220c
        DCR M
l0d0f:  JZ l0d29
l0d12:  JM l0d29
        LXI H, #220d
l0d18:  CALL l0e6f
        MVI A, #3c
        STA $21a7
        LXI H, #1335
l0d23:  CALL l1261
l0d26:  JMP l061e
l0d29:  LXI H, #21c5
        MOV A,M
        ORI #02
        MOV M,A
        MVI A, #09
        STA $21a6
        MVI B, #39
l0d37:  CALL l1d81
        LDA $2194
        ANI #fd
        STA $2194
        MVI A, #00
        STA $220c
        LXI H, #1335
l0d4a:  JMP l0d23
l0d4d:  LXI H, #21c5
        MVI A, #01
l0d52:  CALL l03d6
        MVI A, #06
        STA $21a6
l0d5a:  JMP l1419
        MVI A, #2b
l0d5f:  JMP l0d76
        MVI A, #2c
l0d64:  JMP l0d76
        MVI A, #04
l0d69:  JMP l0d76
        MVI A, #0c
l0d6e:  JMP l0d76
        MVI A, #14
l0d73:  JMP l0d76
l0d76:  STA $2226
        LDA $2190
        ANI #04
l0d7e:  JNZ l1419
        LDA $21af
        ORA A
l0d85:  JNZ l0d95
        LDA $2191
        ANI #df
        STA $2191
        MVI A, #80
        STA $2193
l0d95:  MVI A, #03
        STA $21af
l0d9a:  JMP l1419
        LDA $2191
        ANI #20
l0da2:  JZ l0de1
        LDA $21c4
        ORI #04
        STA $21c4
        MVI A, #09
        STA $2199
        LDA $2226
        MOV B,A
l0db6:  CALL l1d9c
l0db9:  JZ l0de1
l0dbc:  CALL l1d81
l0dbf:  JZ l0dd1
        LXI H, #1165
l0dc5:  CALL l0292
        LXI H, #12e0
l0dcb:  CALL l1261
l0dce:  JMP l0de1
l0dd1:  LXI H, #1171
l0dd4:  CALL l0292
        XCHG
l0dd8:  CALL l0e5c
        LXI H, #12f2
l0dde:  CALL l1261
l0de1:  LDA $2191
        ANI #df
        STA $2191
l0de9:  JMP l061e
l0dec:  LXI D, #21f3
        ORA A
        PUSH PSW
l0df1:  SBI #02
l0df3:  JM l0e0e
        MOV B,A
        POP PSW
        LDAX D
        ADC M
        DAA
        STAX D
        PUSH PSW
        MOV A,B
        ORA A
l0dff:  JNZ l0e09
        POP PSW
        MVI A, #00
        ADC A
        INX D
        STAX D
        RET

l0e09:  INX H
        INX D
l0e0b:  JMP l0df1
l0e0e:  MOV A,M
        ANI #0f
        MOV B,A
        POP PSW
        LDAX D
        ADC B
        DAA
        STAX D
        RET

l0e18:  MVI C, #00
        ORA A
        LXI D, #21f3
        PUSH PSW
l0e1f:  SBI #02
l0e21:  JM l0e3d
        MOV B,A
        POP PSW
        MVI A, #9a
        SBB M
l0e29:  XCHG
        ADD M
        DAA
        CMC
        MOV M,A
        PUSH PSW
l0e2f:  JNZ l0e4a
l0e32:  MOV A,B
        ORA A
l0e34:  JZ l0e4f
        XCHG
        INX D
        INX H
l0e3a:  JMP l0e1f
l0e3d:  MOV A,M
        ANI #0f
        MOV B,A
        POP PSW
        MVI A, #9a
        SBB B
        MVI B, #00
l0e47:  JMP l0e29
l0e4a:  MVI C, #ff
l0e4c:  JMP l0e32
l0e4f:  MOV A,C
        ORA A
l0e51:  JZ l0e58
        POP PSW
        RC
        ORA C
        RET

l0e58:  POP PSW
        ANI #00
        RET

l0e5c:  LXI D, #21f3
        MVI A, #08
l0e61:  CALL l0ecf
        LXI H, #235b
        MVI A, #08
l0e69:  CALL l0dec
        LXI H, #21f3
l0e6f:  LXI D, #235b
        MVI A, #08
l0e74:  CALL l0ecf
        LXI H, #235b
        LXI D, #23a0
        MVI A, #06
l0e7f:  CALL l0eea
        LDA $2190
        ANI #01
        RNZ
        LXI H, #23a0
        LXI D, #2380
        MVI A, #06
l0e90:  CALL l0ecf
        MVI B, #39
l0e95:  CALL l1d76
        RET

l0e99:  PUSH H
        LXI H, #235b
        LXI D, #21f3
        MVI A, #08
l0ea2:  CALL l0ecf
        POP H
        MVI A, #08
l0ea8:  CALL l0e18
        PUSH PSW
        LXI H, #21f3
        LXI D, #235b
        MVI A, #08
l0eb4:  CALL l0ecf
        LXI H, #235b
        LXI D, #2380
        MVI A, #06
l0ebf:  CALL l0eea
        LXI H, #2380
        LXI D, #23a0
        MVI A, #06
l0eca:  CALL l0ecf
        POP PSW
        RET

l0ecf:  ORA A
l0ed0:  SBI #02
l0ed2:  JM l0ee0
        MOV B,A
        MOV A,M
        STAX D
        INX H
        INX D
        MOV A,B
        ORA A
l0edc:  JNZ l0ed0
        RET

l0ee0:  MOV A,M
        ANI #0f
        MOV B,A
        LDAX D
        ANI #f0
        ORA B
        STAX D
        RET

l0eea:  RRC
        PUSH PSW
l0eec:  JNC l0ef2
        INR A
        ANI #7f
l0ef2:  MOV C,A
        DCR C
        MVI B, #00
        DAD B
        XCHG
        DAD B
        XCHG
        POP PSW
l0efb:  JC l0f14
        MOV A,M
l0eff:  ORA A
l0f00:  JZ l0f2a
        ANI #f0
        MOV A,M
l0f06:  JNZ l0f0b
        ORI #f0
l0f0b:  STAX D
        DCX H
        DCX D
        MOV A,M
        DCR C
l0f10:  JP l0f0b
        RET

l0f14:  LDAX D
        ANI #f0
        MOV B,A
        MOV A,M
        ANI #0f
l0f1b:  JNZ l0f34
        ORI #0f
        ORA B
l0f21:  STAX D
        DCX H
        DCX D
        DCR C
        MOV A,M
l0f26:  JP l0eff
        RET

l0f2a:  MOV A,C
        DCR A
l0f2c:  JM l0f38
        MVI A, #ff
l0f31:  JMP l0f21
l0f34:  ORA B
l0f35:  JMP l0f0b
l0f38:  MVI A, #f0
        STAX D
        RET

l0f3c:  LXI D, #21f3
        MVI A, #08
l0f41:  CALL l0ecf
        LXI H, #237e
        MVI A, #04
l0f49:  CALL l03ee
l0f4c:  JNZ l10dd
        INR A
l0f50:  CALL l03ee
l0f53:  JNZ l10f4
        INR A
l0f57:  CALL l03ee
l0f5a:  JNZ l110b
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
l0f71:  MVI A, #08
l0f73:  CALL l0dec
        POP D
        PUSH D
        LXI H, #21f3
        MVI A, #08
l0f7d:  CALL l0ecf
        POP H
        POP D
        PUSH D
        MVI A, #06
l0f85:  CALL l0eea
        POP D
        PUSH D
        LXI H, #0020
        DAD D
        XCHG
        MVI A, #06
l0f91:  CALL l0ecf
        POP D
        LDA $21f6
        ANI #0f
l0f9a:  JZ l0fa5
        LXI H, #1189
        MVI A, #06
l0fa2:  CALL l0ecf
l0fa5:  LXI H, #237e
        MVI A, #03
l0faa:  CALL l03ee
l0fad:  JNZ l1008
        POP H
        POP H
        POP H
        LDA $237e
        ANI #0f
        CPI #03
        RNZ
        LXI H, #2363
        LXI D, #21f3
        MVI A, #07
l0fc3:  CALL l0ecf
        LXI H, #236b
        MVI A, #07
l0fcb:  CALL l0e18
        PUSH PSW
l0fcf:  CC l0ff4
        LXI H, #21f3
        LXI D, #2377
        PUSH D
        MVI A, #06
l0fdb:  CALL l0ecf
        POP H
        PUSH H
        LXI D, #2397
        MVI A, #06
l0fe5:  CALL l0eea
        POP H
        LXI D, #23b7
        MVI A, #06
l0fee:  CALL l0eea
l0ff1:  JMP l1052
l0ff4:  LXI H, #236b
        LXI D, #21f3
        MVI A, #07
l0ffc:  CALL l0ecf
        LXI H, #2363
        MVI A, #07
l1004:  CALL l0e18
        RET

l1008:  POP H
        MVI A, #08
l100b:  CALL l0dec
        LXI H, #21f3
        POP D
        PUSH D
        MVI A, #07
l1015:  CALL l0ecf
        POP H
        POP D
        LXI H, #2367
        LXI D, #21f3
        MVI A, #07
l1022:  CALL l0ecf
        LXI H, #2373
        MVI A, #07
l102a:  CALL l0e18
        PUSH PSW
l102e:  JC l1122
l1031:  LXI H, #21f3
        LXI D, #2377
        MVI A, #06
l1039:  CALL l0ecf
        LXI H, #2377
        LXI D, #2397
        MVI A, #06
l1044:  CALL l0eea
        LXI H, #2397
        LXI D, #23b7
        MVI A, #06
l104f:  CALL l0ecf
l1052:  LDA $21f6
        ANI #0f
l1057:  JZ l1065
        LXI H, #1189
        LXI D, #2397
        MVI A, #06
l1062:  CALL l0ecf
l1065:  POP PSW
l1066:  JZ l10b5
l1069:  JC l10a1
        LXI H, #236a
        MVI A, #04
l1071:  CALL l03ee
l1074:  JZ l1078
        RET

l1078:  CALL l03d6
        MVI A, #05
l107d:  CALL l03e1
        PUSH H
        PUSH B
        LXI H, #1316
l1085:  CALL l1261
        LXI H, #21a7
        MOV A,M
        ORA A
l108d:  JZ l1092
        MVI M, #7d
l1092:  LXI H, #21ae
        MOV A,M
        ORA A
l1097:  JZ l109c
        MVI M, #7d
l109c:  POP B
        POP H
l109e:  JMP l1138
l10a1:  LXI H, #236a
        MVI A, #05
l10a6:  CALL l03ee
l10a9:  JZ l10ad
        RET

l10ad:  CALL l03d6
        MVI A, #04
l10b2:  JMP l107d
l10b5:  LXI H, #236a
        MVI A, #04
l10ba:  CALL l03e1
        MVI A, #05
l10bf:  CALL l03e1
        PUSH H
        LXI H, #1185
        LXI D, #2397
        MVI A, #06
l10cb:  CALL l0ecf
        LXI H, #1185
        LXI D, #23b7
        MVI A, #06
l10d6:  CALL l0ecf
        POP H
l10da:  JMP l1138
l10dd:  LXI H, #2389
        PUSH H
        LXI H, #2367
        PUSH H
        LXI H, #235f
        PUSH H
        LXI H, #2386
        PUSH H
        LXI H, #2363
        PUSH H
l10f1:  JMP l0f71
l10f4:  LXI H, #2393
        PUSH H
        LXI H, #2373
        PUSH H
        LXI H, #236f
        PUSH H
        LXI H, #238d
        PUSH H
        LXI H, #236b
        PUSH H
l1108:  JMP l0f71
l110b:  LXI H, #2389
        PUSH H
        LXI H, #2367
        PUSH H
        LXI H, #2363
        PUSH H
        LXI H, #2383
        PUSH H
        LXI H, #235f
        PUSH H
l111f:  JMP l0f71
l1122:  LXI H, #2373
        LXI D, #21f3
        MVI A, #07
l112a:  CALL l0ecf
        LXI H, #2367
        MVI A, #07
l1132:  CALL l0e18
l1135:  JMP l1031
l1138:  MOV A,M
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
l118d:  MVI A, #ff
        OUT #09
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
        OUT #0a
        INX H
        MOV A,M
        CMA
        OUT #09
        CMA
        SHLD $21b1
        LXI D, #11fc
        CPI #00
l11b3:  JZ l11ef
        CPI #02
l11b8:  JZ l11ee
        CPI #04
l11bd:  JZ l11ed
        CPI #08
l11c2:  JZ l11ec
        CPI #0c
l11c7:  JZ l11eb
        CPI #10
l11cc:  JZ l11ea
        CPI #2c
l11d1:  JZ l11e9
        CPI #28
l11d6:  JZ l11e8
        CPI #24
l11db:  JZ l11e7
        CPI #20
l11e0:  JZ l11e6
l11e3:  JMP l11ef
l11e6:  INX D
l11e7:  INX D
l11e8:  INX D
l11e9:  INX D
l11ea:  INX D
l11eb:  INX D
l11ec:  INX D
l11ed:  INX D
l11ee:  INX D
l11ef:  LDAX D
        STA $2198
        LXI H, #2190
        MVI A, #05
l11f8:  CALL l03d6
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
l120b:  CALL l03ee
l120e:  JNZ l1222
        MVI A, #06
l1213:  CALL l03d6
        MVI A, #fe
        OUT #09
        MVI A, #02
        STA $2198
l121f:  JMP l061e
l1222:  CALL l03e1
        MVI A, #06
l1227:  CALL l03ee
l122a:  JNZ l1255
        MVI A, #ff
        OUT #09
        LHLD $21b1
        INX H
        MOV A,M
        CPI #ff
l1238:  JZ l1241
l123b:  CALL l118d
l123e:  JMP l061e
l1241:  LDA $21b3
        CPI #00
l1246:  JNZ l1258
        MVI A, #ff
        OUT #09
        MVI A, #0c
        STA $2198
l1252:  JMP l061e
l1255:  CALL l03e1
l1258:  CALL l128c
l125b:  CALL l118d
l125e:  JMP l061e
l1261:  XCHG
        LHLD $21be
        LXI B, #21be
        MOV A,C
        STA $21b3
        SUB L
l126d:  JNZ l1273
        LXI H, #21b4
l1273:  MOV M,E
        INX H
        MOV M,D
        INX H
        SHLD $21be
        LXI H, #2190
        MVI A, #05
l127f:  CALL l03ee
        RNZ
l1283:  CALL l03d6
        MVI A, #01
        STA $2198
        RET

l128c:  LHLD $21c0
        LXI B, #21be
        MOV A,C
        SUB L
l1294:  JNZ l129a
        LXI H, #21b4
l129a:  MOV E,M
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
l1382:  CALL l03e1
        OUT #0f
        LXI H, #23e0
        LXI D, #233b
l138d:  MOV B,M
        LDAX D
        ADI #04
        SUB B
l1392:  JP l1397
        CMA
        INR A
l1397:  CPI #03
l1399:  JC l13a4
        LDA $2191
        ORI #08
        STA $2191
l13a4:  MOV A,B
        SUI #04
        STAX D
        INX D
        INR L
l13aa:  JNZ l138d
        LDA $2191
        ANI #08
        JNZ $137d
l13b5:  CALL l0303
        SHLD $2224
        RET

        LXI H, #2191
        MVI A, #06
l13c1:  CALL l03d6
        LXI H, #23e0
        LXI D, #233b
l13ca:  LDAX D
        SUB M
l13cc:  JP l13ea
l13cf:  INX D
        INR L
l13d1:  JNZ l13ca
        LXI H, #2191
        MVI A, #06
l13d9:  CALL l03ee
l13dc:  JZ l13e4
        MVI A, #07
l13e1:  CALL l03e1
l13e4:  MVI A, #01
        DI
l13e7:  JMP l0376
l13ea:  DI
        PUSH H
        LXI H, #2191
        MVI A, #06
l13f1:  CALL l03e1
        INR A
l13f5:  CALL l03ee
l13f8:  JNZ l1402
l13fb:  CALL l03d6
        POP H
l13ff:  JMP l141c
l1402:  CALL l03e1
        POP H
l1406:  CALL l0624
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
l1419:  CALL l0630
l141c:  JMP l13cf
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
        XRA H
        DCR D
        SUI #15
        MVI C, #00
        MVI B, #02
l1463:  JMP l1494
        MVI C, #01
        MVI B, #2a
l146a:  JMP l1494
        MVI C, #02
        MVI B, #10
l1471:  JMP l1494
        MVI C, #03
        MVI B, #1a
l1478:  JMP l1494
        MVI C, #04
        MVI B, #01
l147f:  JMP l1494
        MVI C, #05
        MVI B, #19
l1486:  JMP l1494
        MVI C, #06
        MVI B, #21
l148d:  JMP l1494
        MVI C, #07
        MVI B, #0a
l1494:  LXI H, #2190
        MVI A, #07
l1499:  CALL l03d6
        MVI A, #02
l149e:  CALL l03ee
l14a1:  JNZ l1419
        MOV A,C
        LXI H, #21c6
l14a8:  CALL l03ee
l14ab:  JZ l1419
l14ae:  CALL l03e1
l14b1:  CALL l1d81
        LXI H, #1161
l14b7:  CALL l0292
        LXI H, #12d7
l14bd:  CALL l1261
        LDA $21c6
        CPI #00
l14c5:  JNZ l1419
        MVI A, #3d
        STA $21a4
        MVI A, #00
        STA $2205
l14d2:  JMP l1419
        LDA $2205
        INR A
        STA $2205
        CPI #09
l14de:  JZ l14fa
        MVI D, #00
        MOV E,A
        LXI H, #152d
        DAD D
        MOV B,M
l14e9:  CALL l1d76
        LXI H, #12d7
l14ef:  CALL l1261
        MVI A, #0a
        STA $21a4
l14f7:  JMP l061e
l14fa:  MVI A, #00
        STA $220c
        MVI B, #11
l1501:  CALL l1d9c
l1504:  JNZ l1517
        MVI B, #38
l1509:  CALL l1d9c
l150c:  JNZ l1522
        MVI B, #11
l1511:  CALL l1d76
l1514:  JMP l1522
l1517:  CALL l1d81
        MVI B, #38
l151c:  CALL l1d76
l151f:  JMP l1522
l1522:  MVI A, #ff
        STA $21c6
        SUB A
        STA $2205
l152b:  JMP l061e
        STAX B
        LHLD $1a10
        LXI B, #2119
        LDAX B
        LXI H, #2190
        MVI A, #07
l153b:  CALL l03ee
l153e:  JZ l1419
l1541:  CALL l03e1
        MVI A, #02
l1546:  CALL l03ee
l1549:  JNZ l1419
        LXI H, #117d
l154f:  CALL l0e5c
        LXI H, #2190
        MVI A, #04
l1557:  CALL l03ee
l155a:  JZ l1588
        LXI H, #2191
        MVI A, #01
l1562:  CALL l03ee
l1565:  JNZ l1588
l1568:  CALL l03d6
        LDA $21c7
        MVI B, #ff
l1570:  INR B
        RAR
l1572:  JNC l1570
        MOV A,B
        DCR A
l1577:  JP l157c
        MVI A, #04
l157c:  STA $2211
l157f:  CALL l0402
        LXI H, #1338
l1585:  CALL l1261
l1588:  LXI H, #2190
        MVI A, #03
l158d:  CALL l03ee
l1590:  JNZ l15a3
        MVI B, #09
l1595:  CALL l1d9c
l1598:  JZ l15a3
l159b:  CALL l1d81
        MVI B, #31
l15a0:  CALL l1d91
l15a3:  LXI H, #12ed
l15a6:  CALL l1261
l15a9:  JMP l1419
        MVI A, #ff
        STA $2193
        LDA $2194
        ORI #30
        STA $2194
        LXI H, #2190
        MVI A, #02
l15be:  CALL l03ee
l15c1:  JNZ l1419
l15c4:  CALL l03d6
        LXI H, #1165
l15ca:  CALL l0292
        LXI H, #134b
l15d0:  CALL l1261
l15d3:  JMP l1419
        LXI H, #2190
        MVI A, #02
l15db:  CALL l03ee
l15de:  JNZ l1419
        MVI A, #07
l15e3:  CALL l03ee
l15e6:  JZ l1419
l15e9:  CALL l03e1
        LXI H, #1165
l15ef:  CALL l0e5c
        LXI H, #1335
l15f5:  CALL l1261
l15f8:  JMP l1419
        LXI H, #2192
        MVI A, #00
l1600:  CALL l03ee
l1603:  JNZ l1789
        LDA $237a
        ORA A
l160a:  JNZ l1620
        LDA $239e
        ANI #08
l1612:  JNZ l1789
        LDA $23b6
        ORI #40
        STA $23b6
l161d:  JMP l1789
l1620:  LDA $237b
        ANI #0f
        CPI #01
l1627:  JZ l16ed
        CPI #00
l162c:  JZ l16ed
        LXI H, #23a3
        LXI D, #2320
        MVI A, #2e
l1637:  CALL l0ecf
l163a:  CALL l17a8
        LXI H, #2192
        MVI A, #04
l1642:  CALL l03ee
l1645:  JZ l1655
        MVI A, #07
l164a:  CALL l03ee
l164d:  JZ l1655
        MVI A, #01
l1652:  JMP l1671
l1655:  MVI A, #06
l1657:  CALL l03d6
        LDA $2190
        ORI #05
        STA $2190
        MVI A, #ff
        STA $2193
        LDA $2194
        ORI #30
        STA $2194
        MVI A, #00
l1671:  STA $237b
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
l169f:  CALL l178e
        LXI H, #2192
        MVI A, #06
l16a7:  CALL l03e1
        LDA $23b6
        ANI #7f
        STA $23b6
        LXI H, #21d3
        LXI D, #21c6
        MVI A, #10
l16ba:  CALL l0ecf
        LXI H, #21c9
        LXI D, #21ce
        MVI A, #0a
l16c5:  CALL l0ecf
        LDA $2190
        ANI #e7
        STA $2190
l16d0:  LDA $237a
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
l16ea:  JMP l1783
l16ed:  LDA $237e
        ANI #08
l16f2:  JNZ l1789
        MVI A, #01
        LXI H, #237e
l16fa:  CALL l03ee
l16fd:  JZ l1738
        MVI A, #02
l1702:  CALL l03ee
l1705:  JZ l174e
        MVI A, #03
l170a:  CALL l03d6
        MVI A, #f0
        STA $2390
        STA $23b0
        DI
        LDA $237e
        PUSH PSW
        MVI A, #1f
        STA $237e
        LXI H, #1149
l1722:  CALL l0f3c
        MVI A, #2f
        STA $237e
        LXI H, #1149
l172d:  CALL l0f3c
        POP PSW
        STA $237e
        EI
l1735:  JMP l16d0
l1738:  CALL l03d6
        MVI A, #f0
        STA $238d
        STA $23ad
        MVI A, #f0
        STA $2397
        STA $23b7
l174b:  JMP l16d0
l174e:  CALL l03d6
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
l176d:  JMP l16d0
        LDA $237e
        STA $23be
        ANI #0f
        MOV B,A
        LDA $239e
        ORA B
        STA $239e
l1780:  JMP l16d0
l1783:  LXI H, #12da
l1786:  CALL l1261
l1789:  MVI A, #06
l178b:  JMP l0376
l178e:  LXI H, #17a0
        MVI C, #08
l1793:  MOV A,M
        STAX D
        INX D
        INX H
        DCR C
l1798:  JNZ l1793
        DCR B
l179c:  JNZ l178e
        RET

        RST 7
        RAR
        LXI B, #3904
        DCX H
        STC
        STC
l17a8:  LXI H, #235b
        MVI A, #00
        MVI D, #1f
l17af:  MOV M,A
        INX H
        DCR D
l17b2:  JNZ l17af
        STA $2246
        LXI H, #2380
        MVI A, #ff
        MVI D, #1a
l17bf:  MOV M,A
        INX H
        DCR D
l17c2:  JNZ l17bf
        LXI H, #23a0
        MVI A, #ff
        MVI D, #1a
l17cc:  MOV M,A
        INX H
        DCR D
l17cf:  JNZ l17cc
        MVI A, #0f
        STA $238c
        STA $23ac
        STA $2396
        STA $23b6
        LXI H, #ffff
        SHLD $239c
        SHLD $23bc
        RET

l17ea:  LDA $237e
        ANI #02
        MVI A, #20
        RZ
        LXI H, #2190
        MVI A, #03
l17f7:  CALL l03ee
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
l180d:  CALL l03ee
l1810:  JNZ l1419
        LXI H, #2208
        MVI A, #ff
        ADD M
l1819:  JNC l1823
        MOV M,A
l181d:  JZ l182b
l1820:  JMP l1419
l1823:  MVI A, #32
        STA $2208
l1828:  JMP l1419
l182b:  MVI A, #ff
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
l184b:  CALL l03d6
        LXI H, #2192
        MVI A, #04
l1853:  CALL l03d6
        LXI H, #12e8
l1859:  CALL l1261
l185c:  CALL l1ba8
        XCHG
        LXI H, #21c6
        MVI A, #10
l1865:  CALL l0ecf
        LXI H, #2190
        MVI A, #00
l186d:  CALL l03ee
l1870:  JNZ l187b
        MVI B, #39
l1875:  CALL l1d9c
l1878:  JNZ l1889
l187b:  MVI A, #02
        STA $21a0
l1880:  CALL l17ea
        STA $221c
l1886:  JMP l1419
l1889:  LHLD $235c
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
l18a6:  CALL l0ecf
        MVI A, #04
l18ab:  PUSH PSW
        LXI H, #220d
        MVI A, #06
l18b1:  CALL l0dec
        POP PSW
        DCR A
l18b6:  JNZ l18ab
        LXI H, #21f3
l18bc:  CALL l0e6f
        MVI A, #3c
        STA $21ae
        LXI H, #1335
l18c7:  CALL l1261
l18ca:  JMP l1419
        LXI H, #1165
l18d0:  CALL l0e99
l18d3:  JC l18ea
        LXI H, #1165
l18d9:  CALL l0292
        MVI A, #0a
        STA $21ae
        LXI H, #1332
l18e4:  CALL l1261
l18e7:  JMP l061e
l18ea:  LXI H, #1165
l18ed:  CALL l0e5c
        LXI H, #235b
l18f3:  CALL l0f3c
        LXI H, #235b
l18f9:  CALL l0e99
l18fc:  CALL l17ea
        STA $221c
        LDA $221c
        DCR A
        STA $221c
l1909:  JZ l1914
        MVI A, #02
        STA $21a0
l1911:  JMP l061e
l1914:  MVI A, #01
        STA $2212
        MVI A, #32
        STA $2194
        LXI H, #2192
        MVI A, #03
l1923:  CALL l03e1
        LXI H, #237b
        LDA $2213
        SUB M
l192d:  JP l193b
l1930:  CALL l1a3a
        MOV A,M
        ORA B
        MOV M,A
        DAD D
        MOV M,A
l1938:  JMP l1976
l193b:  LDA $237b
        ORA A
        MVI A, #01
        LXI H, #237e
l1944:  JZ l1a8a
        MVI A, #04
l1949:  CALL l03ee
l194c:  JNZ l1955
        INR A
        CPI #08
l1952:  JNZ l1949
l1955:  CALL l03e1
        INR A
        MOV C,A
        SUI #04
l195c:  CALL l03ee
        MOV A,C
l1960:  JNZ l1a98
        LDA $2213
        INR A
        MOV B,A
        LDA $237b
        INR A
        CMP B
l196d:  JNZ l1a8a
        STA $237b
        STA $23bb
l1976:  MVI A, #ff
        STA $239b
        LDA $2246
        ORA A
l197f:  JZ l19bf
        LXI H, #237e
        MOV B,A
        MOV A,M
        ANI #0f
        MOV M,A
        MOV A,B
        MVI B, #00
l198d:  RAR
l198e:  JC l1995
        INR B
l1992:  JMP l198d
l1995:  XCHG
        LXI H, #2246
        MOV A,B
        STA $2245
l199d:  CALL l03e1
        ADI #04
        XCHG
l19a3:  CALL l03d6
l19a6:  CALL l1a3a
        MOV A,M
        ORA B
        MOV M,A
        LDA $2396
        ANI #df
        STA $2396
        LDA $2190
        ORI #08
        STA $2190
l19bc:  JMP l1aae
l19bf:  LXI H, #2191
        MVI A, #00
l19c4:  CALL l03ee
        MVI A, #01
l19c9:  JNZ l1a8a
        LDA $2192
        ORI #c0
        STA $2192
l19d4:  CALL l1db7
        LXI H, #23b6
        MVI A, #07
l19dc:  CALL l03d6
        LDA $2396
        ANI #cf
        STA $2396
        LDA $23b6
        ANI #cf
        STA $23b6
        LDA $23ac
        ANI #30
l19f4:  JZ l1a00
        CPI #10
        MVI A, #05
l19fb:  JZ l1a00
        MVI A, #0a
l1a00:  STA $23be
        SUB A
        STA $239e
        LDA $238c
        ANI #0f
        STA $238c
        LDA $2247
        ANI #08
l1a14:  JZ l1a24
        MVI A, #04
        STA $2217
        MVI A, #7a
        STA $21a3
l1a21:  JMP l1a2a
l1a24:  LXI H, #12ff
l1a27:  CALL l1261
l1a2a:  MVI A, #00
        STA $239b
        STA $23bb
        MVI A, #fa
        STA $219e
l1a37:  JMP l061e
l1a3a:  LXI H, #1a56
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

        ADC H
        INX H
        ADC E
        INX H
        ADC E
        INX H
        ADC D
        INX H
        RRC
        RP
        RRC
        RP
        LXI H, #2217
        DCR M
l1a66:  JZ l1a71
        MVI A, #72
        STA $21a3
l1a6e:  JMP l061e
l1a71:  CALL l06d3
        LDA $2247
        ANI #f7
        STA $2247
        MVI A, #07
        LXI H, #23b3
        LXI D, #2393
l1a84:  CALL l0ecf
l1a87:  JMP l061e
l1a8a:  STA $237b
        STA $239b
        STA $23bb
        MVI A, #04
        LXI H, #237e
l1a98:  CALL l03d6
        LDA $2213
        MOV C,A
        LDA $237b
        CMP C
l1aa3:  JNZ l1aae
        LXI H, #2190
        MVI A, #04
l1aab:  CALL l03d6
l1aae:  LDA $237e
        STA $23be
        MOV B,A
        ANI #0f
        STA $239e
        LXI H, #2190
        MVI A, #00
l1abf:  CALL l03e1
        MVI B, #09
l1ac4:  CALL l1d81
        LXI H, #23b6
        MVI A, #04
l1acc:  CALL l03e1
        MVI A, #02
        STA $21a1
l1ad4:  JMP l061e
        LDA $2212
        DCR A
        STA $2212
l1ade:  JZ l1aef
        LXI H, #1321
l1ae4:  CALL l1261
        MVI A, #a0
        STA $21a1
l1aec:  JMP l061e
l1aef:  LXI H, #1149
l1af2:  CALL l0e6f
        LDA $21c9
        STA $2218
        LDA $21ce
        STA $2219
l1b01:  CALL l1ba8
        LXI D, #21c6
        MVI A, #10
l1b09:  CALL l0ecf
        LXI H, #21c9
        LXI D, #21ce
        MVI A, #0a
l1b14:  CALL l0ecf
        MVI B, #2b
l1b19:  CALL l1d76
        MVI B, #2c
l1b1e:  CALL l1d76
        MVI B, #04
l1b23:  CALL l1d76
        MVI B, #0c
l1b28:  CALL l1d76
        MVI B, #14
l1b2d:  CALL l1d76
        MVI B, #11
l1b32:  CALL l1d81
        MVI B, #38
l1b37:  CALL l1d81
        MVI B, #31
l1b3c:  CALL l1d81
        MVI B, #09
l1b41:  CALL l1d81
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
l1b64:  CALL l1d81
        LXI H, #2192
        MVI A, #07
l1b6c:  CALL l03d6
        LXI H, #1346
l1b72:  CALL l1261
        LDA $2214
        DCR A
        STA $2214
        SUI #02
l1b7e:  JM l1ba5
l1b81:  JNZ l1ba5
        LDA $237e
        MVI B, #00
        ANI #0f
l1b8b:  RAR
l1b8c:  JNC l1b93
        INR B
l1b90:  JMP l1b8b
l1b93:  LDA $237a
        SUB B
l1b97:  JP l1ba5
        MVI B, #00
l1b9c:  CALL l1d9c
l1b9f:  JNZ l1ba5
l1ba2:  CALL l1d76
l1ba5:  JMP l061e
l1ba8:  LDA $237e
        ANI #f0
        LXI H, #21eb
        LXI D, #fff8
l1bb3:  RAL
        RC
        DAD D
l1bb6:  JMP l1bb3
l1bb9:  EI
        LXI H, #2215
        IN #04
        MOV M,A
        ANI #40
l1bc2:  JNZ l1c73
        DI
        LDA $2353
        MOV B,A
        LDA $23f8
        SUB B
        LDA $2194
l1bd1:  JM l1bd9
        ANI #fd
l1bd6:  JMP l1bdb
l1bd9:  ORI #02
l1bdb:  STA $2194
        LDA $2192
        MOV B,A
        ANI #01
l1be4:  JZ l1c04
        MOV A,B
        ANI #fe
        STA $2192
        EI
        LXI H, #224b
        LXI D, #2380
        MVI A, #34
l1bf6:  CALL l0ecf
        LXI H, #226b
        LXI D, #23a0
        MVI A, #34
l1c01:  CALL l0ecf
l1c04:  LDA $2215
        ANI #20
l1c09:  JNZ l1cc3
        EI
        LXI H, #222d
        LXI D, #23b3
        MVI A, #07
l1c15:  CALL l0eea
        LXI H, #1189
        LDA $2247
        ANI #08
l1c20:  JNZ l1c26
        LXI H, #23b3
l1c26:  LXI D, #2393
        MVI A, #07
l1c2b:  CALL l0ecf
        LDA $2192
        ANI #40
l1c33:  JZ l1c4e
        LDA $237a
        ORA A
        LXI H, #23b6
        MVI A, #06
l1c3f:  JNZ l1c48
l1c42:  CALL l03d6
l1c45:  JMP l01d2
l1c48:  CALL l03e1
l1c4b:  JMP l01d2
l1c4e:  LDA $2191
        ANI #01
        EI
l1c54:  JZ l01d2
        IN #03
        CPI #fe
l1c5b:  JNZ l1c65
        IN #02
        CPI #fb
l1c62:  JZ l1cdc
l1c65:  LXI H, #2191
        MVI A, #00
l1c6a:  CALL l03e1
        STA $219f
l1c70:  JMP l01d2
l1c73:  LXI H, #2192
        MVI A, #00
l1c78:  CALL l03ee
l1c7b:  JNZ l022c
l1c7e:  CALL l03d6
        LXI H, #2380
        LXI D, #224b
        MVI A, #80
l1c89:  CALL l0ecf
        MVI A, #ff
        LXI H, #2383
        MVI B, #17
l1c93:  MOV M,A
        INX H
        DCR B
l1c96:  JNZ l1c93
        MVI A, #0f
        STA $238c
        LXI H, #2320
        LXI D, #23a3
        MVI A, #2e
l1ca6:  CALL l0ecf
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
l1cc0:  JMP l022c
l1cc3:  LDA $2353
        MOV B,A
        LDA $23f8
        SUB B
l1ccb:  JP l022c
        LXI H, #2192
        MVI A, #06
l1cd3:  CALL l03ee
l1cd6:  JZ l1cdc
l1cd9:  JMP l022c
l1cdc:  LDA $237e
        STA $239e
        LDA $23ac
        STA $238c
        LDA $23bb
        STA $239b
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
l1d1f:  CALL l03d6
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
        ANI #38
        ORI #80
        STA $2190
        LDA $2192
        ANI #67
        STA $2192
        LXI H, #2191
        MVI A, #01
l1d4e:  CALL l03e1
        LXI H, #2194
        MVI A, #04
l1d56:  CALL l03d6
        MVI A, #06
        STA $21a8
        MVI A, #05
        STA $2197
l1d63:  JMP l022c
        LXI H, #21c2
        MVI A, #05
l1d6b:  CALL l03e1
        DI
        CALL $137d
        EI
l1d73:  JMP l061e
l1d76:  CALL l1da3
l1d79:  CALL l03d6
        DAD D
l1d7d:  CALL l03d6
        RET

l1d81:  CALL l1da3
l1d84:  CALL l03e1
        DAD D
l1d88:  CALL l03ee
        PUSH PSW
l1d8c:  CALL l03e1
        POP PSW
        RET

l1d91:  CALL l1da3
l1d94:  CALL l03d6
        DAD D
l1d98:  CALL l03e1
        RET

l1d9c:  CALL l1da3
l1d9f:  CALL l03ee
        RET

l1da3:  LXI H, #21c9
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

l1db7:  LXI H, #2363
l1dba:  CALL l1fd4
        LXI H, #236b
        PUSH H
l1dc1:  CALL l0e18
        POP H
l1dc5:  JNC l1dd4
        SHLD $223d
        LXI H, #2363
        SHLD $223f
l1dd1:  JMP l1ddd
l1dd4:  SHLD $223f
        LXI H, #2363
        SHLD $223d
l1ddd:  LHLD $223d
l1de0:  CALL l1fd4
        LXI H, #235f
        PUSH H
l1de7:  CALL l0e18
        POP H
l1deb:  JC l1e04
        PUSH H
        LHLD $223f
l1df2:  CALL l1fd4
        POP H
        PUSH H
l1df7:  CALL l0e18
        POP H
l1dfb:  JC l1e0f
        SHLD $2241
l1e01:  JMP l1e17
l1e04:  PUSH H
l1e05:  CALL l1e6a
        POP H
        SHLD $223d
l1e0c:  JMP l1e17
l1e0f:  PUSH H
l1e10:  CALL l1e6a
        POP H
        SHLD $223f
l1e17:  LHLD $223d
l1e1a:  CALL l1fd4
        LXI H, #236f
        PUSH H
l1e21:  CALL l0e18
        POP H
l1e25:  JC l1e4e
        PUSH H
        LHLD $223f
l1e2c:  CALL l1fd4
        POP H
        PUSH H
l1e31:  CALL l0e18
        POP H
l1e35:  JC l1e59
        PUSH H
        LHLD $2241
l1e3c:  CALL l1fd4
        POP H
        PUSH H
l1e41:  CALL l0e18
        POP H
l1e45:  JC l1e77
        SHLD $2243
l1e4b:  JMP l1e82
l1e4e:  PUSH H
l1e4f:  CALL l1e64
        POP H
        SHLD $223d
l1e56:  JMP l1e82
l1e59:  PUSH H
l1e5a:  CALL l1e6a
        POP H
        SHLD $223f
l1e61:  JMP l1e82
l1e64:  LHLD $2241
        SHLD $2243
l1e6a:  LHLD $223f
        SHLD $2241
        LHLD $223d
        SHLD $223f
        RET

l1e77:  PUSH H
        LHLD $2241
        SHLD $2243
        POP H
        SHLD $2241
l1e82:  LXI H, #222d
l1e85:  CALL l1fd4
        LHLD $223d
        PUSH H
l1e8c:  CALL l0e18
        POP H
l1e90:  CC l1f5e
        RC
        LXI H, #2231
l1e97:  CALL l1fd4
        LHLD $223d
        PUSH H
l1e9e:  CALL l0e18
        POP H
l1ea2:  CC l1f7e
        RC
        LXI H, #2235
l1ea9:  CALL l1fd4
        LHLD $223d
        PUSH H
l1eb0:  CALL l0e18
        POP H
l1eb4:  CC l1f8f
        RC
        LXI H, #2239
l1ebb:  CALL l1fd4
        LHLD $223d
        PUSH H
l1ec2:  CALL l0e18
        POP H
l1ec6:  CC l1fa0
        RET

        LXI H, #2231
l1ecd:  CALL l1fd4
        LHLD $223f
        PUSH H
l1ed4:  CALL l0e18
        POP H
l1ed8:  CC l1f7e
        RC
        LXI H, #2235
l1edf:  CALL l1fd4
        LHLD $223f
        PUSH H
l1ee6:  CALL l0e18
        POP H
l1eea:  CC l1f8f
        RC
        LXI H, #2239
l1ef1:  CALL l1fd4
        LHLD $223f
        PUSH H
l1ef8:  CALL l0e18
        POP H
l1efc:  CC l1fa0
        RET

        LXI H, #2235
l1f03:  CALL l1fd4
        LHLD $2241
        PUSH H
l1f0a:  CALL l0e18
        POP H
l1f0e:  CC l1f8f
        RC
        LXI H, #2239
l1f15:  CALL l1fd4
        LHLD $2241
        PUSH H
l1f1c:  CALL l0e18
        POP H
l1f20:  CC l1fa0
        RET

        LXI H, #2239
l1f27:  CALL l1fd4
        LHLD $2243
        PUSH H
l1f2e:  CALL l0e18
        POP H
l1f32:  CC l1fa0
        RET

l1f36:  PUSH PSW
        LXI H, #2235
        PUSH H
        LXI D, #2239
        MVI A, #07
l1f40:  CALL l0ecf
        POP D
        POP PSW
        DCR A
        RZ
        PUSH PSW
        LXI H, #2231
        PUSH H
        MVI A, #07
l1f4e:  CALL l0ecf
        POP D
        POP PSW
        DCR A
        RZ
        LXI H, #222d
        MVI A, #07
l1f5a:  CALL l0ecf
        RET

l1f5e:  PUSH H
        MVI A, #03
l1f61:  CALL l1f36
        POP H
        LXI D, #222d
        MVI A, #07
l1f6a:  CALL l0ecf
        LXI H, #1351
l1f70:  CALL l1261
        LDA $2247
        ORI #08
        STA $2247
        ORA A
        CMC
        RET

l1f7e:  PUSH H
        MVI A, #02
l1f81:  CALL l1f36
        POP H
        LXI D, #2231
        MVI A, #07
l1f8a:  CALL l0ecf
        CMC
        RET

l1f8f:  PUSH H
        MVI A, #01
l1f92:  CALL l1f36
        POP H
        LXI D, #2235
        MVI A, #07
l1f9b:  CALL l0ecf
        CMC
        RET

l1fa0:  LXI D, #2239
        MVI A, #07
l1fa5:  CALL l0ecf
        CMC
        RET

l1faa:  LXI H, #2231
        PUSH H
        LXI D, #222d
        MVI A, #07
l1fb3:  CALL l0ecf
        POP D
        LXI H, #2235
        PUSH H
        MVI A, #07
l1fbd:  CALL l0ecf
        POP D
        LXI H, #2239
        PUSH H
        MVI A, #07
l1fc7:  CALL l0ecf
        LXI H, #1181
        POP D
        MVI A, #07
l1fd0:  CALL l0ecf
        RET

l1fd4:  LXI D, #21f3
        MVI A, #00
        MVI B, #04
l1fdb:  STAX D
        INX D
        DCR B
l1fde:  JNZ l1fdb
        LXI D, #21f3
        MVI A, #07
l1fe6:  CALL l0ecf
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
