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
$0000 o0000:   c3 40 00 JMP j0040
$0003          76       HLT
$0004          76       HLT
$0005          76       HLT
$0006          76       HLT
$0007          76       HLT
$0008          76       HLT
$0009          76       HLT
$000a          76       HLT
$000b          76       HLT
$000c          76       HLT
$000d          76       HLT
$000e          76       HLT
$000f          76       HLT
$0010          76       HLT
$0011          76       HLT
$0012          76       HLT
$0013          76       HLT
$0014          76       HLT
$0015          76       HLT
$0016          76       HLT
$0017          76       HLT
$0018          76       HLT
$0019          76       HLT
$001a          76       HLT
$001b          76       HLT
$001c          76       HLT
$001d          76       HLT
$001e          76       HLT
$001f          76       HLT
$0020          76       HLT
$0021          76       HLT
$0022          76       HLT
$0023          76       HLT
$0024 o0024:   c3 6e 00 JMP j006e
$0027          76       HLT
$0028          76       HLT
$0029          76       HLT
$002a          76       HLT
$002b          46       MOV B,M
$002c o002c:   c3 24 03 JMP jo0324
$002f          76       HLT
$0030          76       HLT
$0031          76       HLT
$0032          76       HLT
$0033          00       NOP
$0034 o0034:   c3 7e 03 JMP jo037e
$0037          76       HLT
$0038          76       HLT
$0039          76       HLT
$003a          76       HLT
$003b          c2 c3 00 JNZ $00c3
$003e          28 76    (LDHI) #76
$0040 j0040:   3e 19    MVI A, #19 ;o0000
$0042          32 df 23 STA PRICE_4
$0045          16 05    MVI D, #05
$0047 j0047:   21 10 27 LXI H, #2710 ;o0053
$004a j004a:   2b       DCX H ;o004f
$004b          d3 0f    OUT #0f
$004d          7c       MOV A,H
$004e          b7       ORA A
$004f o004f:   c2 4a 00 JNZ j004a
$0052          15       DCR D
$0053 o0053:   c2 47 00 JNZ j0047
$0056          db 04    IN PRICE_89_CAB
$0058          e6 20    ANI #20
$005a o005a:   ca 6e 00 JZ j006e
$005d          21 00 20 LXI H, #2000
$0060 j0060:   97       SUB A ;o0066
$0061          77       MOV M,A
$0062          23       INX H
$0063          3e 24    MVI A, #24
$0065          bc       CMP H
$0066 o0066:   c2 60 00 JNZ j0060
$0069          3e 64    MVI A, #64
$006b          32 40 22 STA $2240
$006e j006e:   31 90 21 LXI SP, #2190 ;o0024,o005a
$0071          3e 07    MVI A, #07
$0073 j0073:   d3 0e    OUT #0e ;o0078
$0075          d3 0d    OUT #0d
$0077          3d       DCR A
$0078 o0078:   f2 73 00 JP j0073
$007b          21 97 21 LXI H, #2197
$007e          0e 2d    MVI C, #2d
$0080 j0080:   97       SUB A ;o0084
$0081          77       MOV M,A
$0082          23       INX H
$0083          0d       DCR C
$0084 o0084:   c2 80 00 JNZ j0080
$0087          3e 05    MVI A, #05
$0089          32 a3 21 STA $21a3
$008c          3e fe    MVI A, #fe
$008e          d3 09    OUT #09
$0090          3e 02    MVI A, #02
$0092          32 98 21 STA $2198
$0095          3e ff    MVI A, #ff
$0097          32 93 21 STA $2193
$009a          3e fc    MVI A, #fc
$009c          32 94 21 STA $2194
$009f          21 fb 21 LXI H, #21fb
$00a2          22 f9 21 SHLD $21f9
$00a5          21 b4 21 LXI H, #21b4
$00a8          22 be 21 SHLD $21be
$00ab          22 c0 21 SHLD $21c0
$00ae          3e 0f    MVI A, #0f
$00b0          32 f8 21 STA $21f8
$00b3          3a 90 21 LDA $2190
$00b6          f6 05    ORI #05
$00b8          32 90 21 STA $2190
$00bb          3e 0c    MVI A, #0c
$00bd          30       SIM
$00be          db 04    IN PRICE_89_CAB
$00c0          e6 20    ANI #20
$00c2 o00c2:   c2 0b 03 JNZ j030b
$00c5 o00c5:   cd f3 02 CALL co02f3
$00c8 o00c8:   ca 13 01 JZ j0113
$00cb j00cb:   3e 07    MVI A, #07 ;o0321
$00cd          32 c2 21 STA $21c2
$00d0          2f       CMA
$00d1          d3 05    OUT #05
$00d3          3e 06    MVI A, #06
$00d5          32 a6 21 STA $21a6
$00d8 j00d8:   fb       EI ;o00dd
$00d9          3a a6 21 LDA $21a6
$00dc          b7       ORA A
$00dd o00dd:   c2 d8 00 JNZ j00d8
$00e0          3e 28    MVI A, #28
$00e2          32 c2 21 STA $21c2
$00e5          2f       CMA
$00e6          d3 05    OUT #05
$00e8          3e 20    MVI A, #20
$00ea          32 c4 21 STA $21c4
$00ed          2f       CMA
$00ee          d3 07    OUT #07
$00f0          3e 02    MVI A, #02
$00f2          32 c5 21 STA $21c5
$00f5          2f       CMA
$00f6          d3 08    OUT #08
$00f8          3e 06    MVI A, #06
$00fa          32 a6 21 STA $21a6
$00fd j00fd:   fb       EI ;o0102
$00fe          3a a6 21 LDA $21a6
$0101          b7       ORA A
$0102 o0102:   c2 fd 00 JNZ j00fd
$0105          3e ff    MVI A, #ff
$0107          d3 05    OUT #05
$0109          d3 06    OUT #06
$010b          d3 07    OUT #07
$010d          d3 08    OUT #08
$010f          f3       DI
$0110          cd de 13 CALL $13de
$0113 j0113:   db 04    IN PRICE_89_CAB ;o00c8,o02dc
$0115          e6 20    ANI #20
$0117 o0117:   c2 38 01 JNZ jo0138
$011a          3a 92 21 LDA $2192
$011d          e6 df    ANI #df
$011f          32 92 21 STA $2192
$0122          db 03    IN PRICE_TENS_07_PORT
$0124          fe fe    CPI #fe
$0126 o0126:   c2 8f 01 JNZ j018f
$0129          db 02    IN PRICE_CENTS_07_PORT
$012b          fe fb    CPI #fb
$012d o012d:   ca 7a 02 JZ j027a
$0130          fe f7    CPI #f7
$0132 o0132:   ca a4 02 JZ j02a4
$0135 o0135:   c3 8f 01 JMP j018f
$0138 jo0138:  cd 22 18 CALL c1822 ;o0117,o02a1
$013b          3e d0    MVI A, #d0
$013d          32 92 21 STA $2192
$0140          3e 00    MVI A, #00
$0142          32 7e 23 STA $237e
$0145          32 9e 23 STA $239e
$0148          32 be 23 STA $23be
$014b          32 7a 23 STA CREDITS_1
$014e          32 9a 23 STA CREDITS_2
$0151          32 ba 23 STA CREDITS_3
$0154          3e 0f    MVI A, #0f
$0156          32 7b 23 STA BALL_IN_PLAY_hrm
$0159          32 9b 23 STA BALL_IN_PLAY_1
$015c          32 bb 23 STA BALL_IN_PLAY_2
$015f          32 96 23 STA $2396
$0162          32 b6 23 STA $23b6
$0165          21 a3 23 LXI H, #23a3
$0168          11 20 23 LXI D, #2320
$016b          3e 2e    MVI A, #2e
$016d o016d:   cd 60 0f CALL c0f60
$0170          06 01    MVI B, #01
$0172          11 c6 21 LXI D, #21c6
$0175 o0175:   cd 08 18 CALL jc1808
$0178          21 c9 21 LXI H, #21c9
$017b          11 ce 21 LXI D, #21ce
$017e          3e 0a    MVI A, #0a
$0180 o0180:   cd 60 0f CALL c0f60
$0183          21 05 22 LXI H, #2205
$0186          06 13    MVI B, #13
$0188          97       SUB A
$0189 j0189:   77       MOV M,A ;o018c
$018a          23       INX H
$018b          05       DCR B
$018c o018c:   c2 89 01 JNZ j0189
$018f j018f:   f3       DI ;o0126,o0135,o0280
$0190          3e 30    MVI A, #30
$0192          32 94 21 STA $2194
$0195          3a 92 21 LDA $2192
$0198          e6 80    ANI #80
$019a o019a:   c2 a2 01 JNZ j01a2
$019d          3e 00    MVI A, #00
$019f          32 92 21 STA $2192
$01a2 j01a2:   db 02    IN PRICE_CENTS_07_PORT ;o019a,o1c25,o1c2b,o1c34,o1c50
$01a4          0e 00    MVI C, #00
$01a6          06 08    MVI B, #08
$01a8 j01a8:   1f       RAR ;o01b2
$01a9 o01a9:   d2 bc 01 JNC j01bc
$01ac          fb       EI
$01ad          0c       INR C
$01ae          05       DCR B
$01af o01af:   ca b5 01 JZ j01b5
$01b2 o01b2:   c3 a8 01 JMP j01a8
$01b5 j01b5:   db 04    IN PRICE_89_CAB ;o01af
$01b7          1f       RAR
$01b8 o01b8:   d2 bc 01 JNC j01bc
$01bb          0c       INR C
$01bc j01bc:   51       MOV D,C ;o01a9,o01b8
$01bd          db 03    IN PRICE_TENS_07_PORT
$01bf          0e 00    MVI C, #00
$01c1          06 08    MVI B, #08
$01c3 j01c3:   1f       RAR ;o01cd
$01c4 o01c4:   d2 d9 01 JNC j01d9
$01c7          fb       EI
$01c8          0c       INR C
$01c9          05       DCR B
$01ca o01ca:   ca d0 01 JZ j01d0
$01cd o01cd:   c3 c3 01 JMP j01c3
$01d0 j01d0:   db 04    IN PRICE_89_CAB ;o01ca
$01d2          1f       RAR
$01d3          1f       RAR
$01d4          1f       RAR
$01d5 o01d5:   d2 d9 01 JNC j01d9
$01d8          0c       INR C
$01d9 j01d9:   79       MOV A,C ;o01c4,o01d5
$01da          fb       EI
$01db          07       RLC
$01dc          07       RLC
$01dd          07       RLC
$01de          07       RLC
$01df          b2       ORA D
$01e0          32 7f 23 STA PRICE_1
$01e3          32 9f 23 STA PRICE_2
$01e6          32 bf 23 STA PRICE_3
$01e9          fb       EI
$01ea          db 05    IN DIP_SWITCH_PORT
$01ec          21 16 22 LXI H, DIP_SWITCHES
$01ef          77       MOV M,A
$01f0          06 03    MVI B, #03
$01f2          3e 00    MVI A, #00
$01f4 o01f4:   cd e6 03 CALL c03e6
$01f7 o01f7:   c2 04 02 JNZ j0204
$01fa          04       INR B
$01fb          3e 01    MVI A, #01
$01fd o01fd:   cd e6 03 CALL c03e6
$0200 o0200:   c2 04 02 JNZ j0204
$0203          04       INR B
$0204 j0204:   78       MOV A,B ;o01f7,o0200
$0205          32 13 22 STA BALLS_PER_GAME
$0208 j0208:   d3 0f    OUT #0f ;o026b,o1c5b,o1cb8,o1ce9,o1cf7,o1d64
$020a          fb       EI
$020b          00       NOP
$020c          fb       EI
$020d j020d:   00       NOP ;o14ac
$020e          fb       EI
$020f          00       NOP
$0210          f3       DI
$0211          3a c2 21 LDA $21c2
$0214          2f       CMA
$0215          d3 05    OUT #05
$0217          3a c3 21 LDA $21c3
$021a          2f       CMA
$021b          d3 06    OUT #06
$021d          3a c4 21 LDA $21c4
$0220          2f       CMA
$0221          d3 07    OUT #07
$0223          3a c5 21 LDA $21c5
$0226          2f       CMA
$0227          d3 08    OUT #08
$0229          fb       EI
$022a          00       NOP
$022b          fb       EI
$022c          00       NOP
$022d          fb       EI
$022e          00       NOP
$022f          f3       DI
$0230          2a f9 21 LHLD $21f9
$0233          11 fb 21 LXI D, #21fb
$0236          7d       MOV A,L
$0237          93       SUB E
$0238 o0238:   ca 57 02 JZ j0257
$023b o023b:   fa 43 02 JM j0243
$023e          fe 08    CPI #08
$0240 o0240:   da 4c 02 JC j024c
$0243 j0243:   21 fb 21 LXI H, #21fb ;o023b
$0246          22 f9 21 SHLD $21f9
$0249 o0249:   c3 57 02 JMP j0257
$024c j024c:   2b       DCX H ;o0240
$024d          7e       MOV A,M
$024e          2b       DCX H
$024f          22 f9 21 SHLD $21f9
$0252          6e       MOV L,M
$0253          67       MOV H,A
$0254 o0254:   cd cd 0f CALL c0fcd
$0257 j0257:   fb       EI ;o0238,o0249
$0258          21 92 21 LXI H, #2192
$025b          3e 07    MVI A, #07
$025d o025d:   cd e6 03 CALL c03e6
$0260 o0260:   c2 b4 1b JNZ j1bb4
$0263          3a b6 23 LDA $23b6
$0266          e6 7f    ANI #7f
$0268          32 b6 23 STA $23b6
$026b o026b:   c3 08 02 JMP j0208
 
$026e c026e:   eb       XCHG ;o074a,o0d7c,o0e56,o0e65,o1518,o1626,o1947
$026f          2a f9 21 LHLD $21f9
$0272          73       MOV M,E
$0273          23       INX H
$0274          72       MOV M,D
$0275          23       INX H
$0276          22 f9 21 SHLD $21f9
$0279          c9       RET

$027a j027a:   3a 91 21 LDA $2191 ;o012d
$027d          47       MOV B,A
$027e          e6 01    ANI #01
$0280 o0280:   c2 8f 01 JNZ j018f
$0283          78       MOV A,B
$0284          f6 01    ORI #01
$0286          32 91 21 STA $2191
$0289          f3       DI
$028a          3e 30    MVI A, #30
$028c          32 94 21 STA $2194
$028f          3e 7d    MVI A, #7d
$0291          32 9f 21 STA $219f
$0294          3e 3c    MVI A, #3c
$0296          32 1f 22 STA $221f
$0299          3e 00    MVI A, #00
$029b          32 20 22 STA $2220
$029e          32 21 22 STA $2221
$02a1 o02a1:   c3 38 01 JMP jo0138
$02a4 j02a4:   f3       DI ;o0132
$02a5          21 c0 23 LXI H, #23c0
$02a8          06 0c    MVI B, #0c
$02aa j02aa:   36 88    MVI M, #88 ;o02ae
$02ac          23       INX H
$02ad          05       DCR B
$02ae o02ae:   c2 aa 02 JNZ j02aa
$02b1          36 f8    MVI M, #f8
$02b3          23       INX H
$02b4          06 09    MVI B, #09
$02b6 j02b6:   36 88    MVI M, #88 ;o02ba
$02b8          23       INX H
$02b9          05       DCR B
$02ba o02ba:   c2 b6 02 JNZ j02b6
$02bd          36 f8    MVI M, #f8
$02bf          23       INX H
$02c0          06 07    MVI B, #07
$02c2 j02c2:   36 88    MVI M, #88 ;o02c6
$02c4          23       INX H
$02c5          05       DCR B
$02c6 o02c6:   c2 c2 02 JNZ j02c2
$02c9          36 ff    MVI M, #ff
$02cb          23       INX H
$02cc          36 88    MVI M, #88
$02ce          3e 00    MVI A, #00
$02d0          d3 00    OUT #00
$02d2          d3 01    OUT #01
$02d4          d3 02    OUT #02
$02d6          d3 03    OUT #03
$02d8          d3 04    OUT #04
$02da          d3 0f    OUT #0f
$02dc o02dc:   c3 13 01 JMP j0113
 
$02df c02df:   11 3b 23 LXI D, #233b ;co02f3,o1416
$02e2          01 00 00 LXI B, #0000
$02e5          21 00 00 LXI H, #0000
$02e8 j02e8:   1a       LDAX D ;o02ef
$02e9          4f       MOV C,A
$02ea          09       DAD B
$02eb          13       INX D
$02ec          7b       MOV A,E
$02ed          fe 5d    CPI #5d
$02ef o02ef:   c2 e8 02 JNZ j02e8
$02f2          c9       RET

 
$02f3 co02f3:  cd df 02 CALL c02df ;o00c5
$02f6          eb       XCHG
$02f7          2a 23 22 LHLD $2223
$02fa          7b       MOV A,E
$02fb          bd       CMP L
$02fc          c0       RNZ
$02fd          b7       ORA A
$02fe o02fe:   ca 04 03 JZ j0304
$0301 j0301:   7a       MOV A,D ;o0306
$0302          bc       CMP H
$0303          c9       RET

$0304 j0304:   7a       MOV A,D ;o02fe
$0305          b7       ORA A
$0306 o0306:   c2 01 03 JNZ j0301
$0309          3c       INR A
$030a          c9       RET

$030b j030b:   21 eb 11 LXI H, #11eb ;o00c2
$030e          11 28 22 LXI D, #2228
$0311          3e 08    MVI A, #08
$0313 o0313:   cd 60 0f CALL c0f60
$0316          21 e7 11 LXI H, #11e7
$0319          11 2c 22 LXI D, #222c
$031c          3e 08    MVI A, #08
$031e o031e:   cd 60 0f CALL c0f60
$0321 o0321:   c3 cb 00 JMP j00cb
$0324 jo0324:  cd 0e 06 CALL c060e ;o002c
$0327          3a 90 21 LDA $2190
$032a          f6 80    ORI #80
$032c          32 90 21 STA $2190
$032f          97       SUB A
$0330          32 0c 22 STA $220c
$0333          db 01    IN MYSTERY_PORT_1
$0335          11 00 00 LXI D, #0000
$0338 j0338:   b7       ORA A ;o0341
$0339 o0339:   ca 7a 03 JZ jo037a
$033c          1f       RAR
$033d o033d:   da 44 03 JC j0344
$0340          1c       INR E
$0341 o0341:   c3 38 03 JMP j0338
$0344 j0344:   7b       MOV A,E ;o033d
$0345          2f       CMA
$0346          d3 0e    OUT #0e
$0348          2f       CMA
$0349          21 93 21 LXI H, #2193
$034c o034c:   cd e6 03 CALL c03e6
$034f o034f:   c2 7a 03 JNZ jo037a
$0352 o0352:   cd 0e 06 CALL c060e
$0355          3a 91 21 LDA $2191
$0358          e6 02    ANI #02
$035a o035a:   c4 fa 03 CNZ c03fa
$035d o035d:   cd 1a 06 CALL c061a
$0360 o0360:   cd ce 03 CALL c03ce
$0363          eb       XCHG
$0364          29       DAD H
$0365          11 ae 03 LXI D, #03ae
$0368          19       DAD D
$0369          7e       MOV A,M
$036a          23       INX H
$036b          66       MOV H,M
$036c          6f       MOV L,A
$036d          e9       PCHL
$036e j036e:   21 94 21 LXI H, #2194 ;o05f0,o0887,o093c,o1448,o1805
$0371 o0371:   c3 77 03 JMP jo0377
$0374          21 93 21 LXI H, #2193
$0377 jo0377:  cd d9 03 CALL c03d9 ;o0371
$037a jo037a:  cd 1a 06 CALL c061a ;o0339,o034f,o0387,o039d,o047e,o0535,o053e,o070e,o074d,o07d1,o07e2,o07ea,o08c6,o08cf,o0987
$037d          c9       RET

$037e jo037e:  cd 0e 06 CALL c060e ;o0034
$0381          11 00 00 LXI D, #0000
$0384          db 00    IN #00
; switch handler routine
$0386 j0386:   b7       ORA A ;o038f
$0387 o0387:   ca 7a 03 JZ jo037a
$038a          1f       RAR
$038b o038b:   da 92 03 JC j0392
$038e          1c       INR E
$038f o038f:   c3 86 03 JMP j0386
$0392 j0392:   7b       MOV A,E ;o038b
$0393          2f       CMA
$0394          d3 0d    OUT #0d
$0396          2f       CMA
$0397          21 94 21 LXI H, #2194
$039a o039a:   cd e6 03 CALL c03e6
$039d o039d:   c2 7a 03 JNZ jo037a
$03a0 o03a0:   cd ce 03 CALL c03ce
$03a3          eb       XCHG
$03a4          29       DAD H
$03a5          11 be 03 LXI D, #03be
$03a8          19       DAD D
$03a9          7e       MOV A,M
$03aa          23       INX H
$03ab          66       MOV H,M
$03ac          6f       MOV L,A
$03ad          e9       PCHL
$03ae          e2 06 e8 JPO $e806
$03b1          06 ee    MVI B, #ee
$03b3          06 f4    MVI B, #f4
$03b5          06 fa    MVI B, #fa
$03b7          06 00    MVI B, #00
$03b9          07       RLC
$03ba          06 07    MVI B, #07
$03bc          7a       MOV A,D
$03bd          03       INX B
$03be          cb       (RSTV)
$03bf          05       DCR B
$03c0          1d       DCR E
$03c1          14       INR D
$03c2          2a 09 73 LHLD $7309
$03c5          04       INR B
$03c6          b9       CMP C
$03c7          07       RLC
$03c8          77       MOV M,A
$03c9          08       (DSUB)
$03ca          57       MOV D,A
$03cb          16 73    MVI D, #73
$03cd          04       INR B
 
$03ce c03ce:   c5       PUSH B ;o0360,o03a0,o0408,o048b,o0523,o0632,o0721,o0960,o09db,o0aa7,o0ab6,o0add,o0b88,o0bd9,o0c2d,o0d0f,o0d2c,o0d32,o0de3,jo10fb,jo1130,o127b,o1296,o1306,o1422,o145c,o14fa,o15c4,o1620,o16b3,o1766,jo1794,jo17b2,o18b9,o18c1,o1a08,jo1a69,o1a7c,o1b67,o1c22,o1c5e,o1d20,o1d57,o1d7a,o1d7e,o1d95
$03cf          47       MOV B,A
$03d0 o03d0:   cd f1 03 CALL c03f1
$03d3          4e       MOV C,M
$03d4          b1       ORA C
$03d5          77       MOV M,A
$03d6 o03d6:   c3 ee 03 JMP j03ee
 
$03d9 c03d9:   c5       PUSH B ;jo0377,o041b,o05af,jo0638,o0808,o0911,o09b4,o09ba,o09c0,o0a07,o0a25,o0ace,jo0ae3,o0b34,o0b42,o0c7c,o0c8c,jo1100,o113d,o1142,jo12a5,jo12d8,o13e3,o1442,o1452,jo1463,o150f,o159d,o1645,o1703,o170b,o1729,o1991,o199d,o19af,jo19d3,o1a9b,o1aa0,o1aad,jo1c28,o1c4a,o1d4f,o1d6c,o1d85,o1d8d,o1d99
$03da          47       MOV B,A
$03db o03db:   cd f1 03 CALL c03f1
$03de          2f       CMA
$03df          4f       MOV C,A
$03e0          7e       MOV A,M
$03e1          a1       ANA C
$03e2          77       MOV M,A
$03e3 o03e3:   c3 ee 03 JMP j03ee
 
$03e6 c03e6:   c5       PUSH B ;o01f4,o01fd,o025d,o034c,o039a,o0401,o05a4,o062c,o0645,o0660,o077a,o07ce,o07df,o07f2,o07fd,o08c3,o08fb,o0906,o0a1f,o0aac,o0ac8,o0af2,o0b2e,o0b3c,o0beb,o0c21,o0cc4,o0d09,o0d6a,o0fda,o0fe1,o0fe8,o1029,o10f4,o1129,o128e,o12aa,o1302,o143a,o1456,o14ff,o1509,o1597,o15a2,o15b3,o15be,o15e9,o161a,o1637,o163f,o165c,o169e,o16a6,o1756,o175e,o1865,o187b,o18db,o1997,jo19c7,o19da,o19f3,o1c58,o1cf1,o1d89,o1da0
$03e7          47       MOV B,A
$03e8 o03e8:   cd f1 03 CALL c03f1
$03eb          4f       MOV C,A
$03ec          7e       MOV A,M
$03ed          a1       ANA C
$03ee j03ee:   78       MOV A,B ;o03d6,o03e3
$03ef          c1       POP B
$03f0          c9       RET

 
$03f1 c03f1:   4f       MOV C,A ;o03d0,o03db,o03e8
$03f2          3e 01    MVI A, #01
$03f4 j03f4:   0d       DCR C ;o03f7
$03f5          f8       RM
$03f6          87       ADD A
$03f7 o03f7:   c3 f4 03 JMP j03f4
 
$03fa c03fa:   3a 11 22 LDA $2211 ;o035a,o0c24,o15db
$03fd          47       MOV B,A
$03fe o03fe:   cd 1f 04 CALL c041f
$0401 o0401:   cd e6 03 CALL c03e6
$0404 o0404:   ca 0b 04 JZ j040b
$0407          eb       XCHG
$0408 o0408:   cd ce 03 CALL c03ce
$040b j040b:   78       MOV A,B ;o0404
$040c          3c       INR A
$040d          fe 05    CPI #05
$040f o040f:   c2 14 04 JNZ j0414
$0412          3e 00    MVI A, #00
$0414 j0414:   32 11 22 STA $2211 ;o040f
$0417 o0417:   cd 1f 04 CALL c041f
$041a          eb       XCHG
$041b o041b:   cd d9 03 CALL c03d9
$041e          c9       RET

 
$041f c041f:   16 00    MVI D, #00 ;o03fe,o0417
$0421          5f       MOV E,A
$0422          21 38 04 LXI H, #0438
$0425          19       DAD D
$0426          7e       MOV A,M
$0427          21 3d 04 LXI H, #043d
$042a          eb       XCHG
$042b          29       DAD H
$042c          19       DAD D
$042d          4e       MOV C,M
$042e          23       INX H
$042f          66       MOV H,M
$0430          69       MOV L,C
$0431          11 05 00 LXI D, #0005
$0434          eb       XCHG
$0435          19       DAD D
$0436          eb       XCHG
$0437          c9       RET

$0438          04       INR B
$0439          00       NOP
$043a          01 02 05 LXI B, #0502
$043d          cd 21 cc CALL $cc21
$0440          21 cc 21 LXI H, #21cc
$0443          cc 21 ca CZ $ca21
$0446          21 3a 90 LXI H, #903a
$0449          21 f6 05 LXI H, #05f6
$044c          32 90 21 STA $2190
$044f          3e 00    MVI A, #00
$0451          32 0c 22 STA $220c
$0454          3e ff    MVI A, #ff
$0456          32 93 21 STA $2193
$0459          3a 94 21 LDA $2194
$045c          f6 30    ORI #30
$045e          32 94 21 STA $2194
$0461          c9       RET

 
$0462 c0462:   3a 92 21 LDA $2192 ;o047b,o057d
$0465          e6 40    ANI #40
$0467          c8       RZ
$0468          3a 7a 23 LDA CREDITS_1
$046b          b7       ORA A
$046c o046c:   ca 71 04 JZ j0471
$046f          bf       CMP A
$0470          c9       RET

$0471 j0471:   3d       DCR A ;o046c
$0472          c9       RET

$0473          cd 47 04 CALL $0447
$0476          3e 7d    MVI A, #7d
$0478          32 a2 21 STA $21a2
$047b o047b:   cd 62 04 CALL c0462
$047e o047e:   c2 7a 03 JNZ jo037a
$0481          3e fa    MVI A, #fa
$0483          32 9e 21 STA $219e
$0486          21 b6 23 LXI H, #23b6
$0489          3e 05    MVI A, #05
$048b o048b:   cd ce 03 CALL c03ce
$048e          3e ff    MVI A, #ff
$0490          32 80 23 STA $2380
$0493          32 81 23 STA $2381
$0496          32 82 23 STA $2382
$0499          3a 3f 23 LDA $233f
$049c          c6 08    ADI #08
$049e          47       MOV B,A
$049f          3a e4 23 LDA $23e4
$04a2          90       SUB B
$04a3 o04a3:   fa 38 05 JM j0538
$04a6          3a 92 21 LDA $2192
$04a9          e6 40    ANI #40
$04ab o04ab:   c2 38 05 JNZ j0538
$04ae          3a 94 21 LDA $2194
$04b1          f6 fc    ORI #fc
$04b3          32 94 21 STA $2194
$04b6          3e 00    MVI A, #00
$04b8          32 a3 21 STA $21a3
$04bb          3e ff    MVI A, #ff
$04bd          21 c0 23 LXI H, #23c0
$04c0          06 20    MVI B, #20
$04c2 j04c2:   77       MOV M,A ;o04c5
$04c3          23       INX H
$04c4          05       DCR B
$04c5 o04c5:   c2 c2 04 JNZ j04c2
$04c8          d3 00    OUT #00
$04ca          d3 01    OUT #01
$04cc          d3 02    OUT #02
$04ce          d3 03    OUT #03
$04d0          d3 04    OUT #04
$04d2          d3 05    OUT #05
$04d4          d3 06    OUT #06
$04d6          d3 07    OUT #07
$04d8          d3 08    OUT #08
$04da          3e 00    MVI A, #00
$04dc          3e 0f    MVI A, #0f
$04de          32 cc 23 STA $23cc
$04e1          32 d6 23 STA $23d6
$04e4          32 de 23 STA $23de
$04e7          3a 90 21 LDA $2190
$04ea          e6 f7    ANI #f7
$04ec          32 90 21 STA $2190
$04ef          3a 96 23 LDA $2396
$04f2          e6 ef    ANI #ef
$04f4          32 96 23 STA $2396
$04f7          3a b6 23 LDA $23b6
$04fa          e6 ef    ANI #ef
$04fc          32 b6 23 STA $23b6
$04ff          06 30    MVI B, #30
$0501 o0501:   cd 82 1d CALL co1d82
$0504          3e d0    MVI A, #d0
$0506          32 92 21 STA $2192
$0509          3a 13 22 LDA BALLS_PER_GAME
$050c          32 7b 23 STA BALL_IN_PLAY_hrm
$050f          21 7e 23 LXI H, #237e
$0512          7e       MOV A,M
$0513          e6 0f    ANI #0f
$0515          77       MOV M,A
$0516          06 ff    MVI B, #ff
$0518 j0518:   1f       RAR ;o051d
$0519 o0519:   d2 20 05 JNC j0520
$051c          04       INR B
$051d o051d:   c3 18 05 JMP j0518
$0520 j0520:   78       MOV A,B ;o0519
$0521          c6 04    ADI #04
$0523 o0523:   cd ce 03 CALL c03ce
$0526          3e 01    MVI A, #01
$0528          32 14 22 STA $2214
$052b          3e 28    MVI A, #28
$052d          32 1b 22 STA $221b
$0530          3e 02    MVI A, #02
$0532          32 9d 21 STA $219d
$0535 o0535:   c3 7a 03 JMP jo037a
$0538 j0538:   21 45 13 LXI H, #1345 ;o04a3,o04ab
$053b o053b:   cd e4 12 CALL c12e4
$053e o053e:   c3 7a 03 JMP jo037a
$0541          3a 1b 22 LDA $221b
$0544          3d       DCR A
$0545          32 1b 22 STA $221b
$0548 o0548:   ca 5e 05 JZ j055e
$054b          3e 14    MVI A, #14
$054d          32 9d 21 STA $219d
$0550          3e fa    MVI A, #fa
$0552          32 9e 21 STA $219e
$0555          21 42 13 LXI H, #1342
$0558 o0558:   cd e4 12 CALL c12e4
$055b o055b:   c3 08 06 JMP jo0608
$055e j055e:   3e 05    MVI A, #05 ;o0548
$0560          32 a3 21 STA $21a3
$0563          3e 01    MVI A, #01
$0565          32 a0 21 STA $21a0
$0568          32 1c 22 STA $221c
$056b          3a 94 21 LDA $2194
$056e          e6 33    ANI #33
$0570          32 94 21 STA $2194
$0573 o0573:   c3 08 06 JMP jo0608
$0576          db 04    IN PRICE_89_CAB
$0578          e6 80    ANI #80
$057a o057a:   ca 94 05 JZ j0594
$057d o057d:   cd 62 04 CALL c0462
$0580 o0580:   c2 94 05 JNZ j0594
$0583          cd 47 04 CALL $0447
$0586          3e 7d    MVI A, #7d
$0588          32 a2 21 STA $21a2
$058b          21 45 13 LXI H, #1345
$058e o058e:   cd e4 12 CALL c12e4
$0591 o0591:   c3 08 06 JMP jo0608
$0594 j0594:   3a 94 21 LDA $2194 ;o057a,o0580
$0597          e6 77    ANI #77
$0599          32 94 21 STA $2194
$059c o059c:   c3 08 06 JMP jo0608
$059f          21 92 21 LXI H, #2192
$05a2          3e 07    MVI A, #07
$05a4 o05a4:   cd e6 03 CALL c03e6
$05a7 o05a7:   ca 08 06 JZ jo0608
$05aa          21 b6 23 LXI H, #23b6
$05ad          3e 05    MVI A, #05
$05af o05af:   cd d9 03 CALL c03d9
$05b2          3e f0    MVI A, #f0
$05b4          32 a0 23 STA $23a0
$05b7          32 80 23 STA $2380
$05ba          3e ff    MVI A, #ff
$05bc          32 a1 23 STA $23a1
$05bf          32 81 23 STA $2381
$05c2          32 a2 23 STA $23a2
$05c5          32 82 23 STA $2382
$05c8 o05c8:   c3 08 06 JMP jo0608
$05cb          21 97 21 LXI H, #2197
$05ce          0e 1a    MVI C, #1a
$05d0 j05d0:   3e ff    MVI A, #ff ;o05dc
$05d2          86       ADD M
$05d3 o05d3:   d2 da 05 JNC j05da
$05d6          77       MOV M,A
$05d7 o05d7:   ca f3 05 JZ j05f3
$05da j05da:   23       INX H ;o05d3,o060b
$05db          0d       DCR C
$05dc o05dc:   c2 d0 05 JNZ j05d0
$05df          3a 98 21 LDA $2198
$05e2          b7       ORA A
$05e3 o05e3:   c2 e8 05 JNZ j05e8
$05e6          3e 01    MVI A, #01
$05e8 j05e8:   e6 3f    ANI #3f ;o05e3
$05ea          32 98 21 STA $2198
$05ed          3e 00    MVI A, #00
$05ef          f3       DI
$05f0 o05f0:   c3 6e 03 JMP j036e
$05f3 j05f3:   f3       DI ;o05d7
$05f4 o05f4:   cd 0e 06 CALL c060e
$05f7          3e 1a    MVI A, #1a
$05f9          91       SUB C
$05fa          87       ADD A
$05fb          11 00 00 LXI D, #0000
$05fe          5f       MOV E,A
$05ff          21 ae 06 LXI H, #06ae
$0602          19       DAD D
$0603          7e       MOV A,M
$0604          23       INX H
$0605          66       MOV H,M
$0606          6f       MOV L,A
$0607          e9       PCHL
$0608 jo0608:  cd 1a 06 CALL c061a ;o055b,o0573,o0591,o059c,o05a7,o05c8,o0684,o06a5,o076a,o0772,o077d,o0785,o0800,o080b,o081e,o084f,o085f,o0874,o08e8,o08f3,o0909,o0914,o0927,o0a0a,o0a17,o0a2d,o0a3a,o0a45,o0b54,o0b77,o0b90,o0ba2,o0bd0,o0c27,o0c7f,o0c8f,o0d55,o0d8a,o0db7,o0e7a,o12a2,o12c1,o12d5,o12e1,o1558,o1587,o1955,o197f,o1a4b,o1a58,o1ab5,o1ac7,o1acf,o1ae7,jo1ba0,o1d74
$060b o060b:   c3 da 05 JMP j05da
 
$060e c060e:   22 95 21 SHLD $2195 ;jo0324,o0352,jo037e,o05f4,o1467
$0611          e3       XTHL
$0612          c5       PUSH B
$0613          d5       PUSH D
$0614          f5       PUSH PSW
$0615          e5       PUSH H
$0616          2a 95 21 LHLD $2195
$0619          c9       RET

 
$061a c061a:   e1       POP H ;o035d,jo037a,jo0608,jo147a
$061b          f1       POP PSW
$061c          d1       POP D
$061d          c1       POP B
$061e          e3       XTHL
$061f          c9       RET

$0620          21 f8 21 LXI H, #21f8
$0623          35       DCR M
; push A, SP, B, D, H
$0624 o0624:   c2 40 06 JNZ j0640
$0627          21 91 21 LXI H, #2191
$062a          3e 04    MVI A, #04
$062c o062c:   cd e6 03 CALL c03e6
$062f o062f:   c2 38 06 JNZ jo0638
$0632 o0632:   cd ce 03 CALL c03ce
$0635 o0635:   c3 3b 06 JMP j063b
$0638 jo0638:  cd d9 03 CALL c03d9 ;o062f
$063b j063b:   3e 04    MVI A, #04 ;o0635
$063d          32 f8 21 STA $21f8
$0640 j0640:   21 91 21 LXI H, #2191 ;o0624
$0643          3e 04    MVI A, #04
$0645 o0645:   cd e6 03 CALL c03e6
$0648 o0648:   c2 a8 06 JNZ j06a8
$064b          21 80 23 LXI H, #2380
$064e j064e:   11 c0 23 LXI D, #23c0 ;o06ab
$0651          3e 40    MVI A, #40
$0653 o0653:   cd 60 0f CALL c0f60
$0656          3e 05    MVI A, #05
$0658          32 a3 21 STA $21a3
$065b          21 91 21 LXI H, #2191
$065e          3e 04    MVI A, #04
$0660 o0660:   cd e6 03 CALL c03e6
$0663 o0663:   ca 87 06 JZ j0687
$0666          3a c9 21 LDA $21c9
$0669          2f       CMA
$066a          d3 00    OUT #00
$066c          3a ca 21 LDA $21ca
$066f          2f       CMA
$0670          d3 01    OUT #01
$0672          3a cb 21 LDA $21cb
$0675          2f       CMA
$0676          d3 02    OUT #02
$0678          3a cc 21 LDA $21cc
$067b          2f       CMA
$067c          d3 03    OUT #03
$067e          3a cd 21 LDA $21cd
$0681          2f       CMA
$0682          d3 04    OUT #04
$0684 o0684:   c3 08 06 JMP jo0608
$0687 j0687:   3a ce 21 LDA $21ce ;o0663
$068a          2f       CMA
$068b          d3 00    OUT #00
$068d          3a cf 21 LDA $21cf
$0690          2f       CMA
$0691          d3 01    OUT #01
$0693          3a d0 21 LDA $21d0
$0696          2f       CMA
$0697          d3 02    OUT #02
$0699          3a d1 21 LDA $21d1
$069c          2f       CMA
$069d          d3 03    OUT #03
$069f          3a d2 21 LDA $21d2
$06a2          2f       CMA
$06a3          d3 04    OUT #04
$06a5 o06a5:   c3 08 06 JMP jo0608
$06a8 j06a8:   21 a0 23 LXI H, #23a0 ;o0648
$06ab o06ab:   c3 4e 06 JMP j064e
$06ae          82       ADD D
$06af          0c       INR C
$06b0          89       ADC C
$06b1          12       STAX D
$06b2          50       MOV D,B
$06b3          07       RLC
; credit handler
$06b4          b8       CMP B
$06b5          1a       LDAX D
$06b6          11 0b 57 LXI D, #570b
$06b9          0b       DCX B
$06ba          41       MOV B,C
$06bb          05       DCR B
$06bc          9f       SBB A
$06bd          05       DCR B
$06be          21 08 70 LXI H, #7008
$06c1          19       DAD D
$06c2          d2 1a 76 JNC $761a
$06c5          05       DCR B
$06c6          20       RIM
$06c7          06 36    MVI B, #36
$06c9          15       DCR D
$06ca          a5       ANA L
$06cb          0b       DCX B
$06cc          67       MOV H,A
$06cd          0c       INR C
$06ce          42       MOV B,D
$06cf          0d       DCR C
$06d0          ed       (LHLX)
$06d1          07       RLC
$06d2          f6 08    ORI #08
$06d4          f4 09 1a CP $1a09
$06d7          0a       LDAX B
$06d8          67       MOV H,A
$06d9          1d       DCR E
$06da          75       MOV M,L
$06db          07       RLC
$06dc          3b       DCX SP
$06dd          19       DAD D
$06de          2e 0e    MVI L, #0e
$06e0 o06e0:   d2 08 11 JNC jo1108
$06e3          00       NOP
$06e4          00       NOP
$06e5 o06e5:   c3 11 07 JMP j0711
$06e8          11 01 00 LXI D, #0001
$06eb o06eb:   c3 11 07 JMP j0711
$06ee          11 02 00 LXI D, #0002
$06f1 o06f1:   c3 11 07 JMP j0711
$06f4          11 03 00 LXI D, #0003
$06f7 o06f7:   c3 11 07 JMP j0711
$06fa          11 04 00 LXI D, #0004
$06fd o06fd:   c3 11 07 JMP j0711
$0700          11 05 00 LXI D, #0005
$0703 o0703:   c3 11 07 JMP j0711
$0706          3a 91 21 LDA $2191
$0709          f6 20    ORI #20
$070b          32 91 21 STA $2191
$070e o070e:   c3 7a 03 JMP jo037a
$0711 j0711:   21 88 07 LXI H, #0788 ;o06e5,o06eb,o06f1,o06f7,o06fd,o0703
$0714          19       DAD D
$0715          7e       MOV A,M
$0716          eb       XCHG
$0717          29       DAD H
$0718          eb       XCHG
$0719          21 8f 07 LXI H, #078f
$071c          19       DAD D
$071d          46       MOV B,M
$071e          23       INX H
$071f          66       MOV H,M
$0720          68       MOV L,B
$0721 o0721:   cd ce 03 CALL c03ce
$0724          3e 09    MVI A, #09
$0726          32 99 21 STA $2199
$0729          3a c3 21 LDA $21c3
$072c          2f       CMA
$072d          d3 06    OUT #06
$072f          3a c4 21 LDA $21c4
$0732          2f       CMA
$0733          d3 07    OUT #07
$0735          21 9d 07 LXI H, #079d
$0738          19       DAD D
$0739          46       MOV B,M
$073a          23       INX H
$073b          66       MOV H,M
$073c          68       MOV L,B
$073d          d5       PUSH D
$073e o073e:   cd e4 12 CALL c12e4
$0741          d1       POP D
$0742          21 ab 07 LXI H, #07ab
$0745          19       DAD D
$0746          46       MOV B,M
$0747          23       INX H
$0748          66       MOV H,M
$0749          68       MOV L,B
$074a o074a:   cd 6e 02 CALL c026e
$074d o074d:   c3 7a 03 JMP jo037a
$0750          3a c3 21 LDA $21c3
$0753          e6 30    ANI #30
$0755          32 c3 21 STA $21c3
$0758          2f       CMA
$0759          d3 06    OUT #06
$075b          3a c4 21 LDA $21c4
$075e          e6 20    ANI #20
$0760          32 c4 21 STA $21c4
$0763          2f       CMA
$0764          d3 07    OUT #07
$0766          3a ad 21 LDA $21ad
$0769          b7       ORA A
$076a o076a:   c2 08 06 JNZ jo0608
$076d          3e 06    MVI A, #06
$076f          32 ad 21 STA $21ad
$0772 o0772:   c3 08 06 JMP jo0608
$0775          21 90 21 LXI H, #2190
$0778          3e 02    MVI A, #02
$077a o077a:   cd e6 03 CALL c03e6
$077d o077d:   c2 08 06 JNZ jo0608
$0780          3e 80    MVI A, #80
$0782          32 93 21 STA $2193
$0785 o0785:   c3 08 06 JMP jo0608
$0788          03       INX B
$0789          00       NOP
$078a          01 02 03 LXI B, #0302
$078d          04       INR B
$078e          02       STAX B
$078f          c3 21 c4 JMP $c421
$0792          21 c4 21 LXI H, #21c4
$0795          c3 21 c4 JMP $c421
$0798          21 c4 21 LXI H, #21c4
$079b          c4 21 30 CNZ $3021
$079e          13       INX D
$079f          33       INX SP
$07a0          13       INX D
$07a1          36 13    MVI M, #13
$07a3          39       DAD SP
$07a4          13       INX D
$07a5          3c       INR A
$07a6          13       INX D
$07a7          3f       CMC
$07a8          13       INX D
$07a9          42       MOV B,D
$07aa          13       INX D
$07ab          d8       RC
$07ac          11 dc 11 LXI D, #11dc
$07af          e0       RPO
$07b0          11 d4 11 LXI D, #11d4
$07b3          d0       RNC
$07b4          11 d0 11 LXI D, #11d0
$07b7          cc 11 3a CZ $3a11
$07ba          c3 21 f6 JMP $f621
$07bd          10       (ARHL)
$07be          32 c3 21 STA $21c3
$07c1          2f       CMA
$07c2          d3 06    OUT #06
$07c4          3e 09    MVI A, #09
$07c6          32 a8 21 STA $21a8
$07c9          21 90 21 LXI H, #2190
$07cc          3e 05    MVI A, #05
$07ce o07ce:   cd e6 03 CALL c03e6
$07d1 o07d1:   c2 7a 03 JNZ jo037a
$07d4          21 d1 13 LXI H, #13d1
$07d7 o07d7:   cd e4 12 CALL c12e4
$07da          21 91 21 LXI H, #2191
$07dd          3e 00    MVI A, #00
$07df o07df:   cd e6 03 CALL c03e6
$07e2 o07e2:   ca 7a 03 JZ jo037a
$07e5          3e 7d    MVI A, #7d
$07e7          32 9f 21 STA $219f
$07ea o07ea:   c3 7a 03 JMP jo037a
$07ed          21 c3 21 LXI H, #21c3
$07f0          3e 04    MVI A, #04
$07f2 o07f2:   cd e6 03 CALL c03e6
$07f5 o07f5:   c2 0e 08 JNZ j080e
$07f8          21 90 21 LXI H, #2190
$07fb          3e 02    MVI A, #02
$07fd o07fd:   cd e6 03 CALL c03e6
$0800 o0800:   c2 08 06 JNZ jo0608
$0803          3e 04    MVI A, #04
$0805          21 94 21 LXI H, #2194
$0808 o0808:   cd d9 03 CALL c03d9
$080b o080b:   c3 08 06 JMP jo0608
$080e j080e:   3a c3 21 LDA $21c3 ;o07f5
$0811          e6 2f    ANI #2f
$0813          32 c3 21 STA $21c3
$0816          2f       CMA
$0817          d3 06    OUT #06
$0819          3e 06    MVI A, #06
$081b          32 a8 21 STA $21a8
$081e o081e:   c3 08 06 JMP jo0608
$0821          3a c3 21 LDA $21c3
$0824          f6 30    ORI #30
$0826          32 c3 21 STA $21c3
$0829          3e 09    MVI A, #09
$082b          32 a8 21 STA $21a8
$082e          32 a9 21 STA $21a9
$0831          3e 71    MVI A, #71
$0833          32 9f 21 STA $219f
$0836          3a 1f 22 LDA $221f
$0839          3d       DCR A
$083a          32 1f 22 STA $221f
$083d o083d:   c2 62 08 JNZ j0862
$0840          3e 3c    MVI A, #3c
$0842          32 1f 22 STA $221f
$0845          3a 20 22 LDA $2220
$0848          3c       INR A
$0849          27       DAA
$084a          32 20 22 STA $2220
$084d          fe 60    CPI #60
$084f o084f:   c2 08 06 JNZ jo0608
$0852          3e 00    MVI A, #00
$0854          32 20 22 STA $2220
$0857          3a 21 22 LDA $2221
$085a          3c       INR A
$085b          27       DAA
$085c          32 21 22 STA $2221
$085f o085f:   c3 08 06 JMP jo0608
$0862 j0862:   3a 20 22 LDA $2220 ;o083d
$0865          32 9a 23 STA CREDITS_2
$0868          32 ba 23 STA CREDITS_3
$086b          3a 21 22 LDA $2221
$086e          32 9f 23 STA PRICE_2
$0871          32 bf 23 STA PRICE_3
$0874 o0874:   c3 08 06 JMP jo0608
$0877          3a 92 21 LDA $2192
$087a          e6 fe    ANI #fe
$087c          47       MOV B,A
$087d          e6 80    ANI #80
$087f o087f:   ca ae 08 JZ j08ae
$0882 o0882:   cd 8a 08 CALL c088a
$0885          3e 05    MVI A, #05
$0887 o0887:   c3 6e 03 JMP j036e
 
$088a c088a:   78       MOV A,B ;o0882,o0937
$088b          e6 04    ANI #04
$088d          3a 41 22 LDA $2241
$0890 o0890:   ca 98 08 JZ j0898
$0893          f6 01    ORI #01
$0895 o0895:   c3 9a 08 JMP j089a
$0898 j0898:   e6 fe    ANI #fe ;o0890
$089a j089a:   32 41 22 STA $2241 ;o0895
$089d          78       MOV A,B
$089e          f6 04    ORI #04
$08a0          32 92 21 STA $2192
$08a3          3e 02    MVI A, #02
$08a5          32 b0 21 STA $21b0
$08a8          3e 20    MVI A, #20
$08aa j08aa:   32 43 22 STA $2243 ;o1332
$08ad          c9       RET

$08ae j08ae:   3a c3 21 LDA $21c3 ;o087f
$08b1          f6 20    ORI #20
$08b3          32 c3 21 STA $21c3
$08b6          2f       CMA
$08b7          d3 06    OUT #06
$08b9          3e 09    MVI A, #09
$08bb          32 a9 21 STA $21a9
$08be          21 90 21 LXI H, #2190
$08c1          3e 05    MVI A, #05
$08c3 o08c3:   cd e6 03 CALL c03e6
$08c6 o08c6:   c2 7a 03 JNZ jo037a
$08c9          21 d1 13 LXI H, #13d1
$08cc o08cc:   cd e4 12 CALL c12e4
$08cf o08cf:   c3 7a 03 JMP jo037a
$08d2          3a 43 22 LDA $2243
$08d5          3d       DCR A
$08d6 o08d6:   f2 eb 08 JP j08eb
$08d9          db 04    IN PRICE_89_CAB
$08db          e6 40    ANI #40
$08dd o08dd:   c2 ee 08 JNZ j08ee
$08e0          3a 92 21 LDA $2192
$08e3          e6 fb    ANI #fb
$08e5          32 92 21 STA $2192
$08e8 o08e8:   c3 08 06 JMP jo0608
$08eb j08eb:   32 43 22 STA $2243 ;o08d6
$08ee j08ee:   3e 04    MVI A, #04 ;o08dd
$08f0          32 b0 21 STA $21b0
$08f3 o08f3:   c3 08 06 JMP jo0608
$08f6          21 c3 21 LXI H, #21c3
$08f9          3e 05    MVI A, #05
$08fb o08fb:   cd e6 03 CALL c03e6
$08fe o08fe:   c2 17 09 JNZ j0917
$0901          21 90 21 LXI H, #2190
$0904          3e 02    MVI A, #02
$0906 o0906:   cd e6 03 CALL c03e6
$0909 o0909:   c2 08 06 JNZ jo0608
$090c          21 94 21 LXI H, #2194
$090f          3e 05    MVI A, #05
$0911 o0911:   cd d9 03 CALL c03d9
$0914 o0914:   c3 08 06 JMP jo0608
$0917 j0917:   3a c3 21 LDA $21c3 ;o08fe
$091a          e6 1f    ANI #1f
$091c          32 c3 21 STA $21c3
$091f          2f       CMA
$0920          d3 06    OUT #06
$0922          3e 06    MVI A, #06
$0924          32 a9 21 STA $21a9
$0927 o0927:   c3 08 06 JMP jo0608
$092a          db 04    IN PRICE_89_CAB
$092c          e6 10    ANI #10
$092e o092e:   ca 3f 09 JZ j093f
$0931          3a 92 21 LDA $2192
$0934          e6 fe    ANI #fe
$0936          47       MOV B,A
$0937 o0937:   cd 8a 08 CALL c088a
$093a          3e 02    MVI A, #02
$093c o093c:   c3 6e 03 JMP j036e
$093f j093f:   3a 92 21 LDA $2192 ;o092e
$0942          e6 20    ANI #20
$0944 o0944:   c2 68 09 JNZ jo0968
$0947          3e 00    MVI A, #00
$0949          32 7c 23 STA $237c
$094c          32 7d 23 STA $237d
$094f          32 9c 23 STA $239c
$0952          32 9d 23 STA $239d
$0955          32 bc 23 STA $23bc
$0958          32 bd 23 STA $23bd
$095b          21 92 21 LXI H, #2192
$095e          3e 05    MVI A, #05
$0960 o0960:   cd ce 03 CALL c03ce
$0963          3e 02    MVI A, #02
$0965          32 aa 21 STA $21aa
$0968 jo0968:  cd 8a 09 CALL c098a ;o0944
$096b          db 05    IN DIP_SWITCH_PORT
$096d          e6 80    ANI #80
$096f          3e 01    MVI A, #01
$0971 o0971:   c2 76 09 JNZ j0976
$0974          3e 04    MVI A, #04
$0976 j0976:   32 42 22 STA $2242 ;o0971
$0979          3a 94 21 LDA $2194
$097c          f6 40    ORI #40
$097e          32 94 21 STA $2194
$0981          21 c4 13 LXI H, #13c4
$0984 o0984:   cd e4 12 CALL c12e4
$0987 o0987:   c3 7a 03 JMP jo037a
 
$098a c098a:   3a 7a 23 LDA CREDITS_1 ;jo0968,o0a37
$098d          fe 99    CPI #99
$098f          c8       RZ
$0990          21 7c 23 LXI H, #237c
$0993          3a 7f 23 LDA PRICE_1
$0996          86       ADD M
$0997          27       DAA
$0998          32 7c 23 STA $237c
$099b          32 9c 23 STA $239c
$099e          32 bc 23 STA $23bc
$09a1          23       INX H
$09a2          3e 00    MVI A, #00
$09a4          8e       ADC M
$09a5          27       DAA
$09a6          32 7d 23 STA $237d
$09a9          32 9d 23 STA $239d
$09ac          32 bd 23 STA $23bd
$09af          3e 07    MVI A, #07
$09b1          21 76 23 LXI H, #2376
$09b4 o09b4:   cd d9 03 CALL c03d9
$09b7          21 96 23 LXI H, #2396
$09ba o09ba:   cd d9 03 CALL c03d9
$09bd          21 b6 23 LXI H, #23b6
$09c0 o09c0:   cd d9 03 CALL c03d9
$09c3          06 00    MVI B, #00
$09c5 o09c5:   cd 82 1d CALL co1d82
$09c8          3a 7a 23 LDA CREDITS_1
$09cb          3c       INR A
$09cc          27       DAA
$09cd          32 7a 23 STA CREDITS_1
$09d0          32 9a 23 STA CREDITS_2
$09d3          32 ba 23 STA CREDITS_3
$09d6          21 c5 21 LXI H, #21c5
$09d9          3e 03    MVI A, #03
$09db o09db:   cd ce 03 CALL c03ce
$09de          3e 09    MVI A, #09
$09e0          32 ab 21 STA $21ab
$09e3          3a 40 22 LDA $2240
$09e6          3d       DCR A
$09e7          32 40 22 STA $2240
$09ea          c0       RNZ
$09eb o09eb:   cd c4 1f CALL c1fc4
$09ee          3e 64    MVI A, #64
$09f0          32 40 22 STA $2240
$09f3          c9       RET

$09f4          db 04    IN PRICE_89_CAB
$09f6          e6 10    ANI #10
$09f8 o09f8:   ca 0d 0a JZ j0a0d
$09fb          21 1d 22 LXI H, #221d
$09fe          35       DCR M
$09ff o09ff:   c2 12 0a JNZ j0a12
$0a02          21 92 21 LXI H, #2192
$0a05          3e 05    MVI A, #05
$0a07 o0a07:   cd d9 03 CALL c03d9
$0a0a o0a0a:   c3 08 06 JMP jo0608
$0a0d j0a0d:   3e 40    MVI A, #40 ;o09f8
$0a0f          32 1d 22 STA $221d
$0a12 j0a12:   3e 04    MVI A, #04 ;o09ff
$0a14          32 aa 21 STA $21aa
$0a17 o0a17:   c3 08 06 JMP jo0608
$0a1a          21 c5 21 LXI H, #21c5
$0a1d          3e 03    MVI A, #03
$0a1f o0a1f:   cd e6 03 CALL c03e6
$0a22 o0a22:   ca 30 0a JZ j0a30
$0a25 o0a25:   cd d9 03 CALL c03d9
$0a28          3e 09    MVI A, #09
$0a2a          32 ab 21 STA $21ab
$0a2d o0a2d:   c3 08 06 JMP jo0608
$0a30 j0a30:   21 42 22 LXI H, #2242 ;o0a22
$0a33          35       DCR M
$0a34 o0a34:   ca 3d 0a JZ j0a3d
$0a37 o0a37:   cd 8a 09 CALL c098a
$0a3a o0a3a:   c3 08 06 JMP jo0608
$0a3d j0a3d:   3a 94 21 LDA $2194 ;o0a34
$0a40          e6 bb    ANI #bb
$0a42          32 94 21 STA $2194
$0a45 o0a45:   c3 08 06 JMP jo0608
$0a48          06 24    MVI B, #24
$0a4a          0e 00    MVI C, #00
$0a4c o0a4c:   c3 80 0a JMP j0a80
$0a4f          06 03    MVI B, #03
$0a51          0e 01    MVI C, #01
$0a53 o0a53:   c3 80 0a JMP j0a80
$0a56          06 0b    MVI B, #0b
$0a58          0e 02    MVI C, #02
$0a5a o0a5a:   c3 80 0a JMP j0a80
$0a5d          06 13    MVI B, #13
$0a5f          0e 03    MVI C, #03
$0a61 o0a61:   c3 80 0a JMP j0a80
$0a64          06 29    MVI B, #29
$0a66          0e 04    MVI C, #04
$0a68 o0a68:   c3 80 0a JMP j0a80
$0a6b          3e 04    MVI A, #04
$0a6d          32 97 21 STA $2197
$0a70          21 08 22 LXI H, #2208
$0a73          3e ff    MVI A, #ff
$0a75          86       ADD M
$0a76 o0a76:   d2 95 0a JNC j0a95
$0a79          77       MOV M,A
$0a7a o0a7a:   ca b7 0c JZ j0cb7
$0a7d o0a7d:   c3 7a 14 JMP jo147a
$0a80 j0a80:   21 08 22 LXI H, #2208 ;o0a4c,o0a53,o0a5a,o0a61,o0a68
$0a83          3e ff    MVI A, #ff
$0a85          86       ADD M
$0a86 o0a86:   d2 95 0a JNC j0a95
$0a89          77       MOV M,A
$0a8a o0a8a:   ca a2 0a JZ j0aa2
$0a8d          3e 04    MVI A, #04
$0a8f          32 97 21 STA $2197
$0a92 o0a92:   c3 7a 14 JMP jo147a
$0a95 j0a95:   3e 64    MVI A, #64 ;o0a76,o0a86
$0a97          32 08 22 STA $2208
$0a9a          3e 04    MVI A, #04
$0a9c          32 97 21 STA $2197
$0a9f o0a9f:   c3 7a 14 JMP jo147a
$0aa2 j0aa2:   21 90 21 LXI H, #2190 ;o0a8a
$0aa5          3e 07    MVI A, #07
$0aa7 o0aa7:   cd ce 03 CALL c03ce
$0aaa          3e 02    MVI A, #02
$0aac o0aac:   cd e6 03 CALL c03e6
$0aaf o0aaf:   ca c1 0a JZ jo0ac1
$0ab2          79       MOV A,C
$0ab3 o0ab3:   cd 47 0c CALL c0c47
$0ab6 o0ab6:   cd ce 03 CALL c03ce
$0ab9          3e 06    MVI A, #06
$0abb          32 a6 21 STA $21a6
$0abe o0abe:   c3 7a 14 JMP jo147a
$0ac1 jo0ac1:  cd 82 1d CALL co1d82 ;o0aaf
$0ac4          79       MOV A,C
$0ac5          21 c7 21 LXI H, #21c7
$0ac8 o0ac8:   cd e6 03 CALL c03e6
$0acb o0acb:   ca 2a 0c JZ jo0c2a
$0ace o0ace:   cd d9 03 CALL c03d9
$0ad1          21 11 22 LXI H, #2211
$0ad4          be       CMP M
$0ad5          21 92 21 LXI H, #2192
$0ad8          3e 01    MVI A, #01
$0ada o0ada:   c2 e3 0a JNZ jo0ae3
$0add o0add:   cd ce 03 CALL c03ce
$0ae0 o0ae0:   c3 e6 0a JMP j0ae6
$0ae3 jo0ae3:  cd d9 03 CALL c03d9 ;o0ada
$0ae6 j0ae6:   79       MOV A,C ;o0ae0
$0ae7 o0ae7:   cd 47 0c CALL c0c47
$0aea o0aea:   cd 9d 1d CALL co1d9d
$0aed o0aed:   ca fb 0a JZ jo0afb
$0af0          eb       XCHG
$0af1          19       DAD D
$0af2 o0af2:   cd e6 03 CALL c03e6
$0af5          eb       XCHG
$0af6          3e 01    MVI A, #01
$0af8 o0af8:   ca 0b 0b JZ j0b0b
$0afb jo0afb:  cd 92 1d CALL co1d92 ;o0aed
$0afe          21 66 13 LXI H, #1366
$0b01 o0b01:   cd e4 12 CALL c12e4
$0b04          3e c8    MVI A, #c8
$0b06          32 08 22 STA $2208
$0b09          3e 5a    MVI A, #5a
$0b0b j0b0b:   32 9b 21 STA $219b ;o0af8
$0b0e o0b0e:   c3 7a 14 JMP jo147a
$0b11          21 ad 0c LXI H, #0cad
$0b14          3a c8 21 LDA $21c8
$0b17          87       ADD A
$0b18          16 00    MVI D, #00
$0b1a          5f       MOV E,A
$0b1b          19       DAD D
$0b1c          7e       MOV A,M
$0b1d          23       INX H
$0b1e          66       MOV H,M
$0b1f          6f       MOV L,A
$0b20 o0b20:   cd ed 0e CALL c0eed
$0b23          21 60 13 LXI H, #1360
$0b26 o0b26:   cd e4 12 CALL c12e4
$0b29          21 92 21 LXI H, #2192
$0b2c          3e 01    MVI A, #01
$0b2e o0b2e:   cd e6 03 CALL c03e6
$0b31 o0b31:   ca 7a 0b JZ j0b7a
$0b34 o0b34:   cd d9 03 CALL c03d9
$0b37          21 91 21 LXI H, #2191
$0b3a          3e 01    MVI A, #01
$0b3c o0b3c:   cd e6 03 CALL c03e6
$0b3f o0b3f:   ca 7a 0b JZ j0b7a
$0b42 o0b42:   cd d9 03 CALL c03d9
$0b45          3e fa    MVI A, #fa
$0b47          32 08 22 STA $2208
$0b4a          3e 05    MVI A, #05
$0b4c          32 1a 22 STA $221a
$0b4f          3e 28    MVI A, #28
$0b51          32 9c 21 STA $219c
$0b54 o0b54:   c3 08 06 JMP jo0608
$0b57          21 f4 11 LXI H, #11f4
$0b5a o0b5a:   cd ed 0e CALL c0eed
$0b5d          21 b8 13 LXI H, #13b8
$0b60 o0b60:   cd e4 12 CALL c12e4
$0b63          3a 1a 22 LDA $221a
$0b66          3d       DCR A
$0b67          32 1a 22 STA $221a
$0b6a o0b6a:   ca 7a 0b JZ j0b7a
$0b6d          3e 28    MVI A, #28
$0b6f          32 9c 21 STA $219c
$0b72          3e fa    MVI A, #fa
$0b74          32 08 22 STA $2208
$0b77 o0b77:   c3 08 06 JMP jo0608
$0b7a j0b7a:   3a c7 21 LDA $21c7 ;o0b31,o0b3f,o0b6a
$0b7d          fe 00    CPI #00
$0b7f o0b7f:   ca 93 0b JZ j0b93
$0b82          2a 09 22 LHLD $2209
$0b85          3a 0b 22 LDA $220b
$0b88 o0b88:   cd ce 03 CALL c03ce
$0b8b          3e 06    MVI A, #06
$0b8d          32 a6 21 STA $21a6
$0b90 o0b90:   c3 08 06 JMP jo0608
$0b93 j0b93:   3e 3c    MVI A, #3c ;o0b7f
$0b95          32 a5 21 STA $21a5
$0b98          3e 64    MVI A, #64
$0b9a          32 08 22 STA $2208
$0b9d          3e 00    MVI A, #00
$0b9f          32 07 22 STA $2207
$0ba2 o0ba2:   c3 08 06 JMP jo0608
$0ba5          97       SUB A
$0ba6          32 08 22 STA $2208
$0ba9          3a 07 22 LDA $2207
$0bac          3c       INR A
$0bad          32 07 22 STA $2207
$0bb0          fe 06    CPI #06
$0bb2 o0bb2:   ca d3 0b JZ j0bd3
$0bb5          16 00    MVI D, #00
$0bb7          5f       MOV E,A
$0bb8          21 91 0c LXI H, #0c91
$0bbb          19       DAD D
$0bbc          46       MOV B,M
$0bbd o0bbd:   cd 77 1d CALL co1d77
$0bc0          21 60 13 LXI H, #1360
$0bc3 o0bc3:   cd e4 12 CALL c12e4
$0bc6          3e 0f    MVI A, #0f
$0bc8          32 a5 21 STA $21a5
$0bcb          3e 64    MVI A, #64
$0bcd          32 08 22 STA $2208
$0bd0 o0bd0:   c3 08 06 JMP jo0608
$0bd3 j0bd3:   2a 09 22 LHLD $2209 ;o0bb2
$0bd6          3a 0b 22 LDA $220b
$0bd9 o0bd9:   cd ce 03 CALL c03ce
$0bdc          3e 06    MVI A, #06
$0bde          32 a6 21 STA $21a6
$0be1          3e 1f    MVI A, #1f
$0be3          32 c7 21 STA $21c7
$0be6          21 90 21 LXI H, #2190
$0be9          3e 03    MVI A, #03
$0beb o0beb:   cd e6 03 CALL c03e6
$0bee o0bee:   c2 fe 0b JNZ j0bfe
$0bf1          06 31    MVI B, #31
$0bf3 o0bf3:   cd 9d 1d CALL co1d9d
$0bf6 o0bf6:   c2 fe 0b JNZ j0bfe
$0bf9          06 09    MVI B, #09
$0bfb o0bfb:   cd 77 1d CALL co1d77
$0bfe j0bfe:   3a c8 21 LDA $21c8 ;o0bee,o0bf6
$0c01          3c       INR A
$0c02          fe 05    CPI #05
$0c04 o0c04:   ca 1c 0c JZ jc0c1c
$0c07          32 c8 21 STA $21c8
$0c0a          16 00    MVI D, #00
$0c0c          5f       MOV E,A
$0c0d          21 96 0c LXI H, #0c96
$0c10          19       DAD D
$0c11          46       MOV B,M
$0c12          e5       PUSH H
$0c13 o0c13:   cd 77 1d CALL co1d77
$0c16          e1       POP H
$0c17          2b       DCX H
$0c18          46       MOV B,M
$0c19 o0c19:   cd 82 1d CALL co1d82
 
$0c1c jc0c1c:  21 91 21 LXI H, #2191 ;o0c04,o133e
$0c1f          3e 01    MVI A, #01
$0c21 o0c21:   cd e6 03 CALL c03e6
$0c24 o0c24:   c4 fa 03 CNZ c03fa
$0c27 o0c27:   c3 08 06 JMP jo0608
$0c2a jo0c2a:  cd 47 0c CALL c0c47 ;o0acb
$0c2d o0c2d:   cd ce 03 CALL c03ce
$0c30          3e 06    MVI A, #06
$0c32          32 a6 21 STA $21a6
$0c35 o0c35:   cd 9d 1d CALL co1d9d
$0c38 o0c38:   c2 7a 14 JNZ jo147a
$0c3b o0c3b:   cd 77 1d CALL co1d77
$0c3e          21 63 13 LXI H, #1363
$0c41 o0c41:   cd e4 12 CALL c12e4
$0c44 o0c44:   c3 7a 14 JMP jo147a
 
$0c47 c0c47:   16 00    MVI D, #00 ;o0ab3,o0ae7,jo0c2a
$0c49          5f       MOV E,A
$0c4a          21 9b 0c LXI H, #0c9b
$0c4d          19       DAD D
$0c4e          46       MOV B,M
$0c4f          21 a0 0c LXI H, #0ca0
$0c52          19       DAD D
$0c53          87       ADD A
$0c54          5f       MOV E,A
$0c55          7e       MOV A,M
$0c56          32 0b 22 STA $220b
$0c59          4f       MOV C,A
$0c5a          21 a5 0c LXI H, #0ca5
$0c5d          19       DAD D
$0c5e          7e       MOV A,M
$0c5f          23       INX H
$0c60          66       MOV H,M
$0c61          6f       MOV L,A
$0c62          22 09 22 SHLD $2209
$0c65          79       MOV A,C
$0c66          c9       RET

$0c67          3e 00    MVI A, #00
$0c69          32 c2 21 STA $21c2
$0c6c          3a c4 21 LDA $21c4
$0c6f          e6 1f    ANI #1f
$0c71          32 c4 21 STA $21c4
$0c74          2f       CMA
$0c75          d3 07    OUT #07
$0c77          21 c5 21 LXI H, #21c5
$0c7a          3e 01    MVI A, #01
$0c7c o0c7c:   cd d9 03 CALL c03d9
$0c7f o0c7f:   c3 08 06 JMP jo0608
$0c82          3e 00    MVI A, #00
$0c84          32 08 22 STA $2208
$0c87          21 92 21 LXI H, #2192
$0c8a          3e 03    MVI A, #03
$0c8c o0c8c:   cd d9 03 CALL c03d9
$0c8f o0c8f:   c3 08 06 JMP jo0608
$0c92          24       INR H
$0c93          03       INX B
$0c94          0b       DCX B
$0c95          13       INX D
$0c96          29       DAD H
$0c97          23       INX H
$0c98          1c       INR E
$0c99          1b       DCX D
$0c9a          12       STAX D
$0c9b          2b       DCX H
$0c9c          2c       INR L
$0c9d          04       INR B
$0c9e          0c       INR C
$0c9f          14       INR D
$0ca0          03       INX B
$0ca1          05       DCR B
$0ca2          02       STAX B
$0ca3          00       NOP
$0ca4          01 c2 21 LXI B, #21c2
$0ca7          c4 21 c2 CNZ $c221
$0caa          21 c2 21 LXI H, #21c2
$0cad          c2 21 ec JNZ $ec21
$0cb0          11 f0 11 LXI D, #11f0
$0cb3          f8       RM
$0cb4          11 fc 11 LXI D, #11fc
$0cb7 j0cb7:   06 39    MVI B, #39 ;o0a7a
$0cb9 o0cb9:   cd 9d 1d CALL co1d9d
$0cbc o0cbc:   ca de 0d JZ j0dde
$0cbf          21 90 21 LXI H, #2190
$0cc2          3e 02    MVI A, #02
$0cc4 o0cc4:   cd e6 03 CALL c03e6
$0cc7 o0cc7:   c2 de 0d JNZ j0dde
$0cca          3a 0c 22 LDA $220c
$0ccd          fe 00    CPI #00
$0ccf o0ccf:   c2 3a 0d JNZ j0d3a
$0cd2          21 5b 23 LXI H, #235b
$0cd5          11 0d 22 LXI D, #220d
$0cd8          3e 06    MVI A, #06
$0cda o0cda:   cd 60 0f CALL c0f60
$0cdd          06 38    MVI B, #38
$0cdf o0cdf:   cd 9d 1d CALL co1d9d
$0ce2 o0ce2:   ca ea 0c JZ j0cea
$0ce5          3e 03    MVI A, #03
$0ce7 o0ce7:   c3 f9 0c JMP j0cf9
$0cea j0cea:   06 11    MVI B, #11 ;o0ce2
$0cec o0cec:   cd 9d 1d CALL co1d9d
$0cef o0cef:   ca f7 0c JZ j0cf7
$0cf2          3e 02    MVI A, #02
$0cf4 o0cf4:   c3 f9 0c JMP j0cf9
$0cf7 j0cf7:   3e 01    MVI A, #01 ;o0cef
$0cf9 j0cf9:   32 0c 22 STA $220c ;o0ce7,o0cf4
$0cfc          06 31    MVI B, #31
$0cfe o0cfe:   cd 9d 1d CALL co1d9d
$0d01 o0d01:   ca 3a 0d JZ j0d3a
$0d04          21 90 21 LXI H, #2190
$0d07          3e 03    MVI A, #03
$0d09 o0d09:   cd e6 03 CALL c03e6
$0d0c o0d0c:   c2 3a 0d JNZ j0d3a
$0d0f o0d0f:   cd ce 03 CALL c03ce
$0d12          06 31    MVI B, #31
$0d14 o0d14:   cd 82 1d CALL co1d82
$0d17          06 09    MVI B, #09
$0d19 o0d19:   cd 82 1d CALL co1d82
$0d1c          21 a4 13 LXI H, #13a4
$0d1f o0d1f:   cd e4 12 CALL c12e4
$0d22          06 30    MVI B, #30
$0d24 o0d24:   cd 77 1d CALL co1d77
$0d27          21 96 23 LXI H, #2396
$0d2a          3e 04    MVI A, #04
$0d2c o0d2c:   cd ce 03 CALL c03ce
$0d2f          21 b6 23 LXI H, #23b6
$0d32 o0d32:   cd ce 03 CALL c03ce
$0d35          3e fa    MVI A, #fa
$0d37 o0d37:   c3 3c 0d JMP j0d3c
$0d3a j0d3a:   3e 3c    MVI A, #3c ;o0ccf,o0d01,o0d0c
$0d3c j0d3c:   32 a7 21 STA $21a7 ;o0d37
$0d3f o0d3f:   c3 7a 14 JMP jo147a
$0d42          3a 49 23 LDA $2349
$0d45          47       MOV B,A
$0d46          3a ee 23 LDA $23ee
$0d49          90       SUB B
$0d4a o0d4a:   fa 58 0d JM j0d58
$0d4d          3a 94 21 LDA $2194
$0d50          e6 fd    ANI #fd
$0d52          32 94 21 STA $2194
$0d55 o0d55:   c3 08 06 JMP jo0608
$0d58 j0d58:   3e 00    MVI A, #00 ;o0d4a
$0d5a          32 97 21 STA $2197
$0d5d          3a 94 21 LDA $2194
$0d60          f6 02    ORI #02
$0d62          32 94 21 STA $2194
$0d65          21 90 21 LXI H, #2190
$0d68          3e 00    MVI A, #00
$0d6a o0d6a:   cd e6 03 CALL c03e6
$0d6d o0d6d:   c2 ba 0d JNZ j0dba
$0d70          21 e8 11 LXI H, #11e8
$0d73 o0d73:   cd 2a 0f CALL c0f2a
$0d76 o0d76:   da 8d 0d JC j0d8d
$0d79          21 e8 11 LXI H, #11e8
$0d7c o0d7c:   cd 6e 02 CALL c026e
$0d7f          3e 0a    MVI A, #0a
$0d81          32 a7 21 STA $21a7
$0d84          21 b5 13 LXI H, #13b5
$0d87 o0d87:   cd e4 12 CALL c12e4
$0d8a o0d8a:   c3 08 06 JMP jo0608
$0d8d j0d8d:   21 e8 11 LXI H, #11e8 ;o0d76
$0d90 o0d90:   cd ed 0e CALL c0eed
$0d93          21 5b 23 LXI H, #235b
$0d96 o0d96:   cd cd 0f CALL c0fcd
$0d99          21 5b 23 LXI H, #235b
$0d9c o0d9c:   cd 2a 0f CALL c0f2a
$0d9f          21 0c 22 LXI H, #220c
$0da2          35       DCR M
$0da3 o0da3:   ca ba 0d JZ j0dba
$0da6          21 0d 22 LXI H, #220d
$0da9 o0da9:   cd 00 0f CALL c0f00
$0dac          3e 3c    MVI A, #3c
$0dae          32 a7 21 STA $21a7
$0db1          21 b8 13 LXI H, #13b8
$0db4 jo0db4:  cd e4 12 CALL c12e4 ;o0ddb
$0db7 o0db7:   c3 08 06 JMP jo0608
$0dba j0dba:   21 c5 21 LXI H, #21c5 ;o0d6d,o0da3
$0dbd          7e       MOV A,M
$0dbe          f6 02    ORI #02
$0dc0          77       MOV M,A
$0dc1          3e 09    MVI A, #09
$0dc3          32 a6 21 STA $21a6
$0dc6          06 39    MVI B, #39
$0dc8 o0dc8:   cd 82 1d CALL co1d82
$0dcb          3a 94 21 LDA $2194
$0dce          e6 fd    ANI #fd
$0dd0          32 94 21 STA $2194
$0dd3          3e 00    MVI A, #00
$0dd5          32 0c 22 STA $220c
$0dd8          21 b8 13 LXI H, #13b8
$0ddb o0ddb:   c3 b4 0d JMP jo0db4
$0dde j0dde:   21 c5 21 LXI H, #21c5 ;o0cbc,o0cc7
$0de1          3e 01    MVI A, #01
$0de3 o0de3:   cd ce 03 CALL c03ce
$0de6          3e 06    MVI A, #06
$0de8          32 a6 21 STA $21a6
$0deb o0deb:   c3 7a 14 JMP jo147a
$0dee          3e 2b    MVI A, #2b
$0df0 o0df0:   c3 07 0e JMP j0e07
$0df3          3e 2c    MVI A, #2c
$0df5 o0df5:   c3 07 0e JMP j0e07
$0df8          3e 04    MVI A, #04
$0dfa o0dfa:   c3 07 0e JMP j0e07
$0dfd          3e 0c    MVI A, #0c
$0dff o0dff:   c3 07 0e JMP j0e07
$0e02          3e 14    MVI A, #14
$0e04 o0e04:   c3 07 0e JMP j0e07
$0e07 j0e07:   32 25 22 STA $2225 ;o0df0,o0df5,o0dfa,o0dff,o0e04
$0e0a          3a 90 21 LDA $2190
$0e0d          e6 04    ANI #04
$0e0f o0e0f:   c2 7a 14 JNZ jo147a
$0e12          3a af 21 LDA $21af
$0e15          b7       ORA A
$0e16 o0e16:   c2 26 0e JNZ j0e26
$0e19          3a 91 21 LDA $2191
$0e1c          e6 df    ANI #df
$0e1e          32 91 21 STA $2191
$0e21          3e 80    MVI A, #80
$0e23          32 93 21 STA $2193
$0e26 j0e26:   3e 03    MVI A, #03 ;o0e16
$0e28          32 af 21 STA $21af
$0e2b o0e2b:   c3 7a 14 JMP jo147a
$0e2e          3a 91 21 LDA $2191
$0e31          e6 20    ANI #20
$0e33 o0e33:   ca 72 0e JZ j0e72
$0e36          3a c4 21 LDA $21c4
$0e39          f6 04    ORI #04
$0e3b          32 c4 21 STA $21c4
$0e3e          3e 09    MVI A, #09
$0e40          32 99 21 STA $2199
$0e43          3a 25 22 LDA $2225
$0e46          47       MOV B,A
$0e47 o0e47:   cd 9d 1d CALL co1d9d
$0e4a o0e4a:   ca 72 0e JZ j0e72
$0e4d o0e4d:   cd 82 1d CALL co1d82
$0e50 o0e50:   ca 62 0e JZ j0e62
$0e53          21 e8 11 LXI H, #11e8
$0e56 o0e56:   cd 6e 02 CALL c026e
$0e59          21 63 13 LXI H, #1363
$0e5c o0e5c:   cd e4 12 CALL c12e4
$0e5f o0e5f:   c3 72 0e JMP j0e72
$0e62 j0e62:   21 f4 11 LXI H, #11f4 ;o0e50
$0e65 o0e65:   cd 6e 02 CALL c026e
$0e68          eb       XCHG
$0e69 o0e69:   cd ed 0e CALL c0eed
$0e6c          21 75 13 LXI H, #1375
$0e6f o0e6f:   cd e4 12 CALL c12e4
$0e72 j0e72:   3a 91 21 LDA $2191 ;o0e33,o0e4a,o0e5f
$0e75          e6 df    ANI #df
$0e77          32 91 21 STA $2191
$0e7a o0e7a:   c3 08 06 JMP jo0608
 
$0e7d c0e7d:   11 f3 21 LXI D, #21f3 ;o0efa,o1004,o1090,o191f
$0e80          b7       ORA A
$0e81          f5       PUSH PSW
$0e82 j0e82:   de 02    SBI #02 ;o0e9c
$0e84 o0e84:   fa 9f 0e JM j0e9f
$0e87          47       MOV B,A
$0e88          f1       POP PSW
$0e89          1a       LDAX D
$0e8a          8e       ADC M
$0e8b          27       DAA
$0e8c          12       STAX D
$0e8d          f5       PUSH PSW
$0e8e          78       MOV A,B
$0e8f          b7       ORA A
$0e90 o0e90:   c2 9a 0e JNZ j0e9a
$0e93          f1       POP PSW
$0e94          3e 00    MVI A, #00
$0e96          8f       ADC A
$0e97          13       INX D
$0e98          12       STAX D
$0e99          c9       RET

$0e9a j0e9a:   23       INX H ;o0e90
$0e9b          13       INX D
$0e9c o0e9c:   c3 82 0e JMP j0e82
$0e9f j0e9f:   7e       MOV A,M ;o0e84
$0ea0          e6 0f    ANI #0f
$0ea2          47       MOV B,A
$0ea3          f1       POP PSW
$0ea4          1a       LDAX D
$0ea5          88       ADC B
$0ea6          27       DAA
$0ea7          12       STAX D
$0ea8          c9       RET

 
$0ea9 c0ea9:   0e 00    MVI C, #00 ;o0f39,o1050,o1089,o10c0,o11b5,o1dc2,o1de8,o1df8,o1e22,o1e32,o1e42,o1e8d,o1e9f,o1eb1,o1ec3,o1ed5,o1ee7,o1ef9,o1f0b,o1f1d,o1f2f
$0eab          b7       ORA A
$0eac          11 f3 21 LXI D, #21f3
$0eaf          f5       PUSH PSW
$0eb0 j0eb0:   de 02    SBI #02 ;o0ecb
$0eb2 o0eb2:   fa ce 0e JM j0ece
$0eb5          47       MOV B,A
$0eb6          f1       POP PSW
$0eb7          3e 9a    MVI A, #9a
$0eb9          9e       SBB M
$0eba j0eba:   eb       XCHG ;o0ed8
$0ebb          86       ADD M
$0ebc          27       DAA
$0ebd          3f       CMC
$0ebe          77       MOV M,A
$0ebf          f5       PUSH PSW
$0ec0 o0ec0:   c2 db 0e JNZ j0edb
$0ec3 j0ec3:   78       MOV A,B ;o0edd
$0ec4          b7       ORA A
$0ec5 o0ec5:   ca e0 0e JZ j0ee0
$0ec8          eb       XCHG
$0ec9          13       INX D
$0eca          23       INX H
$0ecb o0ecb:   c3 b0 0e JMP j0eb0
$0ece j0ece:   7e       MOV A,M ;o0eb2
$0ecf          e6 0f    ANI #0f
$0ed1          47       MOV B,A
$0ed2          f1       POP PSW
$0ed3          3e 9a    MVI A, #9a
$0ed5          98       SBB B
$0ed6          06 00    MVI B, #00
$0ed8 o0ed8:   c3 ba 0e JMP j0eba
$0edb j0edb:   0e ff    MVI C, #ff ;o0ec0
$0edd o0edd:   c3 c3 0e JMP j0ec3
$0ee0 j0ee0:   79       MOV A,C ;o0ec5
$0ee1          b7       ORA A
$0ee2 o0ee2:   ca e9 0e JZ j0ee9
$0ee5          f1       POP PSW
$0ee6          d8       RC
$0ee7          b1       ORA C
$0ee8          c9       RET

$0ee9 j0ee9:   f1       POP PSW ;o0ee2
$0eea          e6 00    ANI #00
$0eec          c9       RET

 
$0eed c0eed:   11 f3 21 LXI D, #21f3 ;o0b20,o0b5a,o0d90,o0e69,o15ab,o164b,o195b
$0ef0          3e 08    MVI A, #08
$0ef2 o0ef2:   cd 60 0f CALL c0f60
$0ef5          21 5b 23 LXI H, #235b
$0ef8          3e 08    MVI A, #08
$0efa o0efa:   cd 7d 0e CALL c0e7d
$0efd          21 f3 21 LXI H, #21f3
 
$0f00 c0f00:   11 5b 23 LXI D, #235b ;o0da9,o192a,o1aed
$0f03          3e 08    MVI A, #08
$0f05 o0f05:   cd 60 0f CALL c0f60
$0f08          21 5b 23 LXI H, #235b
$0f0b          11 a0 23 LXI D, #23a0
$0f0e          3e 06    MVI A, #06
$0f10 o0f10:   cd 7b 0f CALL c0f7b
$0f13          3a 90 21 LDA $2190
$0f16          e6 01    ANI #01
$0f18          c0       RNZ
$0f19          21 a0 23 LXI H, #23a0
$0f1c          11 80 23 LXI D, #2380
$0f1f          3e 06    MVI A, #06
$0f21 o0f21:   cd 60 0f CALL c0f60
$0f24          06 39    MVI B, #39
$0f26 o0f26:   cd 77 1d CALL co1d77
$0f29          c9       RET

 
$0f2a c0f2a:   e5       PUSH H ;o0d73,o0d9c,o193e,o1967
$0f2b          21 5b 23 LXI H, #235b
$0f2e          11 f3 21 LXI D, #21f3
$0f31          3e 08    MVI A, #08
$0f33 o0f33:   cd 60 0f CALL c0f60
$0f36          e1       POP H
$0f37          3e 08    MVI A, #08
$0f39 o0f39:   cd a9 0e CALL c0ea9
$0f3c          f5       PUSH PSW
$0f3d          21 f3 21 LXI H, #21f3
$0f40          11 5b 23 LXI D, #235b
$0f43          3e 08    MVI A, #08
$0f45 o0f45:   cd 60 0f CALL c0f60
$0f48          21 5b 23 LXI H, #235b
$0f4b          11 80 23 LXI D, #2380
$0f4e          3e 06    MVI A, #06
$0f50 o0f50:   cd 7b 0f CALL c0f7b
$0f53          21 80 23 LXI H, #2380
$0f56          11 a0 23 LXI D, #23a0
$0f59          3e 06    MVI A, #06
$0f5b o0f5b:   cd 60 0f CALL c0f60
$0f5e          f1       POP PSW
$0f5f          c9       RET

 
$0f60 c0f60:   b7       ORA A ;o016d,o0180,o0313,o031e,o0653,o0cda,o0ef2,o0f05,o0f21,o0f33,o0f45,o0f5b,o0fd2,o100e,o1021,o1048,o1060,o1081,o109a,o10ad,o10b8,o10cf,o10e5,o114e,o1159,o11ad,o1693,o1716,o1721,o18d3,o1914,o1b04,o1b0f,o1bf7,o1c02,o1c71,o1c9e,o1f41,o1f4f,o1f5b,o1f6b,o1f82,o1f96,o1fa0,o1fcd,o1fd7,o1fe0,o1ff6
$0f61 j0f61:   de 02    SBI #02 ;o0f6d
$0f63 o0f63:   fa 71 0f JM j0f71
$0f66          47       MOV B,A
$0f67          7e       MOV A,M
$0f68          12       STAX D
$0f69          23       INX H
$0f6a          13       INX D
$0f6b          78       MOV A,B
$0f6c          b7       ORA A
$0f6d o0f6d:   c2 61 0f JNZ j0f61
$0f70          c9       RET

$0f71 j0f71:   7e       MOV A,M ;o0f63
$0f72          e6 0f    ANI #0f
$0f74          47       MOV B,A
$0f75          1a       LDAX D
$0f76          e6 f0    ANI #f0
$0f78          b0       ORA B
$0f79          12       STAX D
$0f7a          c9       RET

 
$0f7b c0f7b:   0f       RRC ;o0f10,o0f50,o1016,o106a,o1073,o10a2,o10da,o1cd0,o1cdb
$0f7c          f5       PUSH PSW
$0f7d o0f7d:   d2 83 0f JNC j0f83
$0f80          3c       INR A
$0f81          e6 7f    ANI #7f
$0f83 j0f83:   4f       MOV C,A ;o0f7d
$0f84          0d       DCR C
$0f85          06 00    MVI B, #00
$0f87          09       DAD B
$0f88          eb       XCHG
$0f89          09       DAD B
$0f8a          eb       XCHG
$0f8b          f1       POP PSW
$0f8c o0f8c:   da a5 0f JC j0fa5
$0f8f          7e       MOV A,M
$0f90 j0f90:   b7       ORA A ;o0fb7
$0f91 o0f91:   ca bb 0f JZ j0fbb
$0f94          e6 f0    ANI #f0
$0f96          7e       MOV A,M
$0f97 o0f97:   c2 9c 0f JNZ j0f9c
$0f9a          f6 f0    ORI #f0
$0f9c j0f9c:   12       STAX D ;o0f97,o0fa1,o0fc6
$0f9d          2b       DCX H
$0f9e          1b       DCX D
$0f9f          7e       MOV A,M
$0fa0          0d       DCR C
$0fa1 o0fa1:   f2 9c 0f JP j0f9c
$0fa4          c9       RET

$0fa5 j0fa5:   1a       LDAX D ;o0f8c
$0fa6          e6 f0    ANI #f0
$0fa8          47       MOV B,A
$0fa9          7e       MOV A,M
$0faa          e6 0f    ANI #0f
$0fac o0fac:   c2 c5 0f JNZ j0fc5
$0faf          f6 0f    ORI #0f
$0fb1          b0       ORA B
$0fb2 j0fb2:   12       STAX D ;o0fc2
$0fb3          2b       DCX H
$0fb4          1b       DCX D
$0fb5          0d       DCR C
$0fb6          7e       MOV A,M
$0fb7 o0fb7:   f2 90 0f JP j0f90
$0fba          c9       RET

$0fbb j0fbb:   79       MOV A,C ;o0f91
$0fbc          3d       DCR A
$0fbd o0fbd:   fa c9 0f JM j0fc9
$0fc0          3e ff    MVI A, #ff
$0fc2 o0fc2:   c3 b2 0f JMP j0fb2
$0fc5 j0fc5:   b0       ORA B ;o0fac
$0fc6 o0fc6:   c3 9c 0f JMP j0f9c
$0fc9 j0fc9:   3e f0    MVI A, #f0 ;o0fbd
$0fcb          12       STAX D
$0fcc          c9       RET

 
$0fcd c0fcd:   11 f3 21 LXI D, #21f3 ;o0254,o0d96,o177e,o1789,o1961
$0fd0          3e 08    MVI A, #08
$0fd2 o0fd2:   cd 60 0f CALL c0f60
$0fd5          21 7e 23 LXI H, #237e
$0fd8          3e 04    MVI A, #04
$0fda o0fda:   cd e6 03 CALL c03e6
$0fdd o0fdd:   c2 60 11 JNZ j1160
$0fe0          3c       INR A
$0fe1 o0fe1:   cd e6 03 CALL c03e6
$0fe4 o0fe4:   c2 77 11 JNZ j1177
$0fe7          3c       INR A
$0fe8 o0fe8:   cd e6 03 CALL c03e6
$0feb o0feb:   c2 8e 11 JNZ j118e
$0fee          21 93 23 LXI H, #2393
$0ff1          e5       PUSH H
$0ff2          21 73 23 LXI H, #2373
$0ff5          e5       PUSH H
$0ff6          21 6b 23 LXI H, #236b
$0ff9          e5       PUSH H
$0ffa          21 90 23 LXI H, #2390
$0ffd          e5       PUSH H
$0ffe          21 6f 23 LXI H, #236f
$1001          e5       PUSH H
$1002 j1002:   3e 08    MVI A, #08 ;o1174,o118b,o11a2
$1004 o1004:   cd 7d 0e CALL c0e7d
$1007          d1       POP D
$1008          d5       PUSH D
$1009          21 f3 21 LXI H, #21f3
$100c          3e 08    MVI A, #08
$100e o100e:   cd 60 0f CALL c0f60
$1011          e1       POP H
$1012          d1       POP D
$1013          d5       PUSH D
$1014          3e 06    MVI A, #06
$1016 o1016:   cd 7b 0f CALL c0f7b
$1019          d1       POP D
$101a          21 20 00 LXI H, #0020
$101d          19       DAD D
$101e          eb       XCHG
$101f          3e 06    MVI A, #06
$1021 o1021:   cd 60 0f CALL c0f60
$1024          21 7e 23 LXI H, #237e
$1027          3e 03    MVI A, #03
$1029 o1029:   cd e6 03 CALL c03e6
$102c o102c:   c2 8d 10 JNZ j108d
$102f          e1       POP H
$1030          e1       POP H
$1031          e1       POP H
$1032          3a 7e 23 LDA $237e
$1035          e6 0f    ANI #0f
$1037          fe 03    CPI #03
$1039          c0       RNZ
$103a          3a 16 22 LDA DIP_SWITCHES
$103d          e6 08    ANI #08
$103f          c0       RNZ
$1040          21 63 23 LXI H, #2363
$1043          11 f3 21 LXI D, #21f3
$1046          3e 07    MVI A, #07
$1048 o1048:   cd 60 0f CALL c0f60
$104b          21 6b 23 LXI H, #236b
$104e          3e 07    MVI A, #07
$1050 o1050:   cd a9 0e CALL c0ea9
$1053          f5       PUSH PSW
$1054 o1054:   dc 79 10 CC c1079
$1057          21 f3 21 LXI H, #21f3
$105a          11 77 23 LXI D, #2377
$105d          d5       PUSH D
$105e          3e 06    MVI A, #06
$1060 o1060:   cd 60 0f CALL c0f60
$1063          e1       POP H
$1064          e5       PUSH H
$1065          11 97 23 LXI D, #2397
$1068          3e 06    MVI A, #06
$106a o106a:   cd 7b 0f CALL c0f7b
$106d          e1       POP H
$106e          11 b7 23 LXI D, #23b7
$1071          3e 06    MVI A, #06
$1073 o1073:   cd 7b 0f CALL c0f7b
$1076 o1076:   c3 e8 10 JMP j10e8
 
$1079 c1079:   21 6b 23 LXI H, #236b ;o1054
$107c          11 f3 21 LXI D, #21f3
$107f          3e 07    MVI A, #07
$1081 o1081:   cd 60 0f CALL c0f60
$1084          21 63 23 LXI H, #2363
$1087          3e 07    MVI A, #07
$1089 o1089:   cd a9 0e CALL c0ea9
$108c          c9       RET

$108d j108d:   e1       POP H ;o102c
$108e          3e 08    MVI A, #08
$1090 o1090:   cd 7d 0e CALL c0e7d
$1093          21 f3 21 LXI H, #21f3
$1096          d1       POP D
$1097          d5       PUSH D
$1098          3e 07    MVI A, #07
$109a o109a:   cd 60 0f CALL c0f60
$109d          e1       POP H
$109e          d1       POP D
$109f          d5       PUSH D
$10a0          3e 07    MVI A, #07
$10a2 o10a2:   cd 7b 0f CALL c0f7b
$10a5          d1       POP D
$10a6          21 20 00 LXI H, #0020
$10a9          19       DAD D
$10aa          eb       XCHG
$10ab          3e 07    MVI A, #07
$10ad o10ad:   cd 60 0f CALL c0f60
$10b0          21 67 23 LXI H, #2367
$10b3          11 f3 21 LXI D, #21f3
$10b6          3e 07    MVI A, #07
$10b8 o10b8:   cd 60 0f CALL c0f60
$10bb          21 73 23 LXI H, #2373
$10be          3e 07    MVI A, #07
$10c0 o10c0:   cd a9 0e CALL c0ea9
$10c3          f5       PUSH PSW
$10c4 o10c4:   da a5 11 JC j11a5
$10c7 j10c7:   21 f3 21 LXI H, #21f3 ;o11b8
$10ca          11 77 23 LXI D, #2377
$10cd          3e 06    MVI A, #06
$10cf o10cf:   cd 60 0f CALL c0f60
$10d2          21 77 23 LXI H, #2377
$10d5          11 97 23 LXI D, #2397
$10d8          3e 06    MVI A, #06
$10da o10da:   cd 7b 0f CALL c0f7b
$10dd          21 97 23 LXI H, #2397
$10e0          11 b7 23 LXI D, #23b7
$10e3          3e 06    MVI A, #06
$10e5 o10e5:   cd 60 0f CALL c0f60
$10e8 j10e8:   f1       POP PSW ;o1076
$10e9 o10e9:   ca 38 11 JZ j1138
$10ec o10ec:   da 24 11 JC j1124
$10ef          21 6a 23 LXI H, #236a
$10f2          3e 04    MVI A, #04
$10f4 o10f4:   cd e6 03 CALL c03e6
$10f7 o10f7:   ca fb 10 JZ jo10fb
$10fa          c9       RET

$10fb jo10fb:  cd ce 03 CALL c03ce ;o10f7
$10fe          3e 05    MVI A, #05
$1100 jo1100:  cd d9 03 CALL c03d9 ;o1135
$1103          e5       PUSH H
$1104          c5       PUSH B
$1105          21 99 13 LXI H, #1399
$1108 jo1108:  cd e4 12 CALL c12e4 ;o06e0
$110b          21 a7 21 LXI H, #21a7
$110e          7e       MOV A,M
$110f          b7       ORA A
$1110 o1110:   ca 15 11 JZ j1115
$1113          36 7d    MVI M, #7d
$1115 j1115:   21 ae 21 LXI H, #21ae ;o1110
$1118          7e       MOV A,M
$1119          b7       ORA A
$111a o111a:   ca 1f 11 JZ j111f
$111d          36 7d    MVI M, #7d
$111f j111f:   c1       POP B ;o111a
$1120          e1       POP H
$1121 o1121:   c3 bb 11 JMP j11bb
$1124 j1124:   21 6a 23 LXI H, #236a ;o10ec
$1127          3e 05    MVI A, #05
$1129 o1129:   cd e6 03 CALL c03e6
$112c o112c:   ca 30 11 JZ jo1130
$112f          c9       RET

$1130 jo1130:  cd ce 03 CALL c03ce ;o112c
$1133          3e 04    MVI A, #04
$1135 o1135:   c3 00 11 JMP jo1100
$1138 j1138:   21 6a 23 LXI H, #236a ;o10e9
$113b          3e 04    MVI A, #04
$113d o113d:   cd d9 03 CALL c03d9
$1140          3e 05    MVI A, #05
$1142 o1142:   cd d9 03 CALL c03d9
$1145          e5       PUSH H
$1146          21 08 12 LXI H, #1208
$1149          11 97 23 LXI D, #2397
$114c          3e 06    MVI A, #06
$114e o114e:   cd 60 0f CALL c0f60
$1151          21 08 12 LXI H, #1208
$1154          11 b7 23 LXI D, #23b7
$1157          3e 06    MVI A, #06
$1159 o1159:   cd 60 0f CALL c0f60
$115c          e1       POP H
$115d o115d:   c3 bb 11 JMP j11bb
$1160 j1160:   21 89 23 LXI H, #2389 ;o0fdd
$1163          e5       PUSH H
$1164          21 67 23 LXI H, #2367
$1167          e5       PUSH H
$1168          21 5f 23 LXI H, #235f
$116b          e5       PUSH H
$116c          21 86 23 LXI H, #2386
$116f          e5       PUSH H
$1170          21 63 23 LXI H, #2363
$1173          e5       PUSH H
$1174 o1174:   c3 02 10 JMP j1002
$1177 j1177:   21 93 23 LXI H, #2393 ;o0fe4
$117a          e5       PUSH H
$117b          21 73 23 LXI H, #2373
$117e          e5       PUSH H
$117f          21 6f 23 LXI H, #236f
$1182          e5       PUSH H
$1183          21 8d 23 LXI H, #238d
$1186          e5       PUSH H
$1187          21 6b 23 LXI H, #236b
$118a          e5       PUSH H
$118b o118b:   c3 02 10 JMP j1002
$118e j118e:   21 89 23 LXI H, #2389 ;o0feb
$1191          e5       PUSH H
$1192          21 67 23 LXI H, #2367
$1195          e5       PUSH H
$1196          21 63 23 LXI H, #2363
$1199          e5       PUSH H
$119a          21 83 23 LXI H, #2383
$119d          e5       PUSH H
$119e          21 5f 23 LXI H, #235f
$11a1          e5       PUSH H
$11a2 o11a2:   c3 02 10 JMP j1002
$11a5 j11a5:   21 73 23 LXI H, #2373 ;o10c4
$11a8          11 f3 21 LXI D, #21f3
$11ab          3e 07    MVI A, #07
$11ad o11ad:   cd 60 0f CALL c0f60
$11b0          21 67 23 LXI H, #2367
$11b3          3e 07    MVI A, #07
$11b5 o11b5:   cd a9 0e CALL c0ea9
$11b8 o11b8:   c3 c7 10 JMP j10c7
$11bb j11bb:   7e       MOV A,M ;o1121,o115d
$11bc          e6 30    ANI #30
$11be          47       MOV B,A
$11bf          3a 8c 23 LDA $238c
$11c2          e6 0f    ANI #0f
$11c4          b0       ORA B
$11c5          32 8c 23 STA $238c
$11c8          32 ac 23 STA $23ac
$11cb          c9       RET

$11cc          00       NOP
$11cd          00       NOP
$11ce          00       NOP
$11cf          00       NOP
$11d0          01 00 00 LXI B, #0000
$11d3          00       NOP
$11d4          10       (ARHL)
$11d5          00       NOP
$11d6          00       NOP
$11d7          00       NOP
$11d8          25       DCR H
$11d9          00       NOP
$11da          00       NOP
$11db          00       NOP
$11dc          50       MOV D,B
$11dd          00       NOP
$11de          00       NOP
$11df          00       NOP
$11e0          00       NOP
$11e1          01 00 00 LXI B, #0000
$11e4          00       NOP
$11e5          05       DCR B
$11e6          00       NOP
$11e7          00       NOP
$11e8          00       NOP
$11e9          10       (ARHL)
$11ea          00       NOP
$11eb          00       NOP
$11ec          00       NOP
$11ed          20       RIM
$11ee          00       NOP
$11ef          00       NOP
$11f0          00       NOP
$11f1          40       MOV B,B
$11f2          00       NOP
$11f3          00       NOP
$11f4          00       NOP
$11f5          50       MOV D,B
$11f6          00       NOP
$11f7          00       NOP
$11f8          00       NOP
$11f9          60       MOV H,B
$11fa          00       NOP
$11fb          00       NOP
$11fc          00       NOP
$11fd          80       ADD B
$11fe          00       NOP
$11ff          00       NOP
$1200          00       NOP
$1201          00       NOP
$1202          01 00 00 LXI B, #0000
$1205          50       MOV D,B
$1206          02       STAX B
$1207          00       NOP
$1208          f0       RP
$1209          ff       RST 7
$120a          ff       RST 7
$120b          ff       RST 7
$120c          ff       RST 7
$120d          ff       RST 7
$120e          ff       RST 7
$120f          ff       RST 7
 
$1210 c1210:   3e ff    MVI A, #ff ;o12be,o12de
$1212          d3 09    OUT #09
$1214          11 2f 13 LXI D, #132f
$1217          7d       MOV A,L
$1218          93       SUB E
$1219          7c       MOV A,H
$121a          9a       SBB D
$121b          f8       RM
$121c          11 dd 13 LXI D, #13dd
$121f          7b       MOV A,E
$1220          95       SUB L
$1221          7a       MOV A,D
$1222          9c       SBB H
$1223          f8       RM
$1224          7e       MOV A,M
$1225          2f       CMA
$1226          d3 0a    OUT #0a
$1228          23       INX H
$1229          7e       MOV A,M
$122a          2f       CMA
$122b          d3 09    OUT #09
$122d          2f       CMA
$122e          22 b1 21 SHLD $21b1
$1231          11 7f 12 LXI D, #127f
$1234          fe 00    CPI #00
$1236 o1236:   ca 72 12 JZ j1272
$1239          fe 02    CPI #02
$123b o123b:   ca 71 12 JZ j1271
$123e          fe 04    CPI #04
$1240 o1240:   ca 70 12 JZ j1270
$1243          fe 08    CPI #08
$1245 o1245:   ca 6f 12 JZ j126f
$1248          fe 0c    CPI #0c
$124a o124a:   ca 6e 12 JZ j126e
$124d          fe 10    CPI #10
$124f o124f:   ca 6d 12 JZ j126d
$1252          fe 2c    CPI #2c
$1254 o1254:   ca 6c 12 JZ j126c
$1257          fe 28    CPI #28
$1259 o1259:   ca 6b 12 JZ j126b
$125c          fe 24    CPI #24
$125e o125e:   ca 6a 12 JZ j126a
$1261          fe 20    CPI #20
$1263 o1263:   ca 69 12 JZ j1269
$1266 o1266:   c3 72 12 JMP j1272
$1269 j1269:   13       INX D ;o1263
$126a j126a:   13       INX D ;o125e
$126b j126b:   13       INX D ;o1259
$126c j126c:   13       INX D ;o1254
$126d j126d:   13       INX D ;o124f
$126e j126e:   13       INX D ;o124a
$126f j126f:   13       INX D ;o1245
$1270 j1270:   13       INX D ;o1240
$1271 j1271:   13       INX D ;o123b
$1272 j1272:   1a       LDAX D ;o1236,o1266
$1273          32 98 21 STA $2198
$1276          21 90 21 LXI H, #2190
$1279          3e 05    MVI A, #05
$127b o127b:   cd ce 03 CALL c03ce
$127e          c8       RZ
$127f          0d       DCR C
$1280          0a       LDAX B
$1281          0e 0a    MVI C, #0a
$1283          18       (RLDE)
$1284          20       RIM
$1285          0a       LDAX B
$1286          05       DCR B
$1287          02       STAX B
$1288          32 21 90 STA $9021
$128b          21 3e 05 LXI H, #053e
$128e o128e:   cd e6 03 CALL c03e6
$1291 o1291:   c2 a5 12 JNZ jo12a5
$1294          3e 06    MVI A, #06
$1296 o1296:   cd ce 03 CALL c03ce
$1299          3e fe    MVI A, #fe
$129b          d3 09    OUT #09
$129d          3e 02    MVI A, #02
$129f          32 98 21 STA $2198
$12a2 o12a2:   c3 08 06 JMP jo0608
$12a5 jo12a5:  cd d9 03 CALL c03d9 ;o1291
$12a8          3e 06    MVI A, #06
$12aa o12aa:   cd e6 03 CALL c03e6
$12ad o12ad:   c2 d8 12 JNZ jo12d8
$12b0          3e ff    MVI A, #ff
$12b2          d3 09    OUT #09
$12b4          2a b1 21 LHLD $21b1
$12b7          23       INX H
$12b8          7e       MOV A,M
$12b9          fe ff    CPI #ff
$12bb o12bb:   ca c4 12 JZ j12c4
$12be o12be:   cd 10 12 CALL c1210
$12c1 o12c1:   c3 08 06 JMP jo0608
$12c4 j12c4:   3a b3 21 LDA $21b3 ;o12bb
$12c7          fe 00    CPI #00
$12c9 o12c9:   c2 db 12 JNZ jo12db
$12cc          3e ff    MVI A, #ff
$12ce          d3 09    OUT #09
$12d0          3e 0c    MVI A, #0c
$12d2          32 98 21 STA $2198
$12d5 o12d5:   c3 08 06 JMP jo0608
$12d8 jo12d8:  cd d9 03 CALL c03d9 ;o12ad
$12db jo12db:  cd 0f 13 CALL c130f ;o12c9
$12de o12de:   cd 10 12 CALL c1210
$12e1 o12e1:   c3 08 06 JMP jo0608
 
$12e4 c12e4:   eb       XCHG ;o053b,o0558,o058e,o073e,o07d7,o08cc,o0984,o0b01,o0b26,o0b60,o0bc3,o0c41,o0d1f,o0d87,jo0db4,o0e5c,o0e6f,jo1108,o151e,o1550,o15e1,o1602,o162c,o1651,o1800,o18c7,o1935,o1952,o1a2e,o1adf,o1b6d,o1fba,o1fc0
$12e5          2a be 21 LHLD $21be
$12e8          01 be 21 LXI B, #21be
$12eb          79       MOV A,C
$12ec          32 b3 21 STA $21b3
$12ef          95       SUB L
$12f0 o12f0:   c2 f6 12 JNZ j12f6
$12f3          21 b4 21 LXI H, #21b4
$12f6 j12f6:   73       MOV M,E ;o12f0
$12f7          23       INX H
$12f8          72       MOV M,D
$12f9          23       INX H
$12fa          22 be 21 SHLD $21be
$12fd          21 90 21 LXI H, #2190
$1300          3e 05    MVI A, #05
$1302 o1302:   cd e6 03 CALL c03e6
$1305          c0       RNZ
$1306 o1306:   cd ce 03 CALL c03ce
$1309          3e 01    MVI A, #01
$130b          32 98 21 STA $2198
$130e          c9       RET

 
$130f c130f:   2a c0 21 LHLD $21c0 ;jo12db
$1312          01 be 21 LXI B, #21be
$1315          79       MOV A,C
$1316          95       SUB L
$1317 o1317:   c2 1d 13 JNZ j131d
$131a          21 b4 21 LXI H, #21b4
$131d j131d:   5e       MOV E,M ;o1317
$131e          23       INX H
$131f          56       MOV D,M
$1320          23       INX H
$1321          22 c0 21 SHLD $21c0
$1324          d5       PUSH D
$1325          7d       MOV A,L
$1326          2a be 21 LHLD $21be
$1329          95       SUB L
$132a          32 b3 21 STA $21b3
$132d          e1       POP H
$132e          c9       RET

$132f          ff       RST 7
$1330          c8       RZ
$1331          08       (DSUB)
$1332 o1332:   fd aa 08 (JK) j08aa
$1335          ff       RST 7
$1336          85       ADD L
$1337          08       (DSUB)
$1338          ff       RST 7
$1339          65       MOV H,L
$133a          08       (DSUB)
$133b          ff       RST 7
$133c          1c       INR E
$133d          0c       INR C
$133e o133e:   fc 1c 0c CM jc0c1c
$1341          ff       RST 7
$1342          1c       INR E
$1343          00       NOP
$1344          ff       RST 7
$1345          43       MOV B,E
$1346          08       (DSUB)
$1347          87       ADD A
$1348          08       (DSUB)
$1349          43       MOV B,E
$134a          08       (DSUB)
$134b          87       ADD A
$134c          08       (DSUB)
$134d          43       MOV B,E
$134e          08       (DSUB)
$134f          87       ADD A
$1350          08       (DSUB)
$1351          43       MOV B,E
$1352          08       (DSUB)
$1353          87       ADD A
$1354          08       (DSUB)
$1355          43       MOV B,E
$1356          08       (DSUB)
$1357          87       ADD A
$1358          08       (DSUB)
$1359          ff       RST 7
$135a          55       MOV D,L
$135b          08       (DSUB)
$135c          ff       RST 7
$135d          3c       INR A
$135e          08       (DSUB)
$135f          ff       RST 7
$1360          2b       DCX H
$1361          08       (DSUB)
$1362          ff       RST 7
$1363          22 08 ff SHLD $ff08
$1366          22 28 1e SHLD $1e28
$1369          0c       INR C
$136a          ff       RST 7
$136b          15       DCR D
$136c          02       STAX B
$136d          15       DCR D
$136e          0c       INR C
$136f          ff       RST 7
$1370          4c       MOV C,H
$1371          08       (DSUB)
$1372          65       MOV H,L
$1373          0c       INR C
$1374          ff       RST 7
$1375          78       MOV A,B
$1376          28 50    (LDHI) #50
$1378          28 78    (LDHI) #78
$137a          28 50    (LDHI) #50
$137c          28 78    (LDHI) #78
$137e          28 50    (LDHI) #50
$1380          28 ff    (LDHI) #ff
$1382          55       MOV D,L
$1383          08       (DSUB)
$1384          65       MOV H,L
$1385          08       (DSUB)
$1386          78       MOV A,B
$1387          08       (DSUB)
$1388          78       MOV A,B
$1389          00       NOP
$138a          55       MOV D,L
$138b          08       (DSUB)
$138c          65       MOV H,L
$138d          08       (DSUB)
$138e          78       MOV A,B
$138f          08       (DSUB)
$1390          78       MOV A,B
$1391          00       NOP
$1392          55       MOV D,L
$1393          08       (DSUB)
$1394          65       MOV H,L
$1395          08       (DSUB)
$1396          78       MOV A,B
$1397          08       (DSUB)
$1398          ff       RST 7
$1399          43       MOV B,E
$139a          20       RIM
$139b          43       MOV B,E
$139c          08       (DSUB)
$139d          55       MOV D,L
$139e          08       (DSUB)
$139f          65       MOV H,L
$13a0          08       (DSUB)
$13a1          72       MOV M,D
$13a2          0c       INR C
$13a3          ff       RST 7
$13a4          43       MOV B,E
$13a5          04       INR B
$13a6          43       MOV B,E
$13a7          04       INR B
$13a8          43       MOV B,E
$13a9          00       NOP
$13aa          43       MOV B,E
$13ab          04       INR B
$13ac          43       MOV B,E
$13ad          04       INR B
$13ae          43       MOV B,E
$13af          00       NOP
$13b0          43       MOV B,E
$13b1          04       INR B
$13b2          43       MOV B,E
$13b3          04       INR B
$13b4          ff       RST 7
$13b5          c6 08    ADI #08
$13b7          ff       RST 7
$13b8          4c       MOV C,H
$13b9          0c       INR C
$13ba          ff       RST 7
$13bb          ca 08 ca JZ $ca08
$13be          08       (DSUB)
$13bf          ca 08 ca JZ $ca08
$13c2          0c       INR C
$13c3          ff       RST 7
$13c4          78       MOV A,B
$13c5          28 65    (LDHI) #65
$13c7          04       INR B
$13c8          ff       RST 7
$13c9          a0       ANA B
$13ca          2c       INR L
$13cb          a0       ANA B
$13cc          0c       INR C
$13cd          ff       RST 7
$13ce          15       DCR D
$13cf          0c       INR C
$13d0          ff       RST 7
$13d1          ca 00 ff JZ $ff00
$13d4          43       MOV B,E
$13d5          0c       INR C
$13d6          55       MOV D,L
$13d7          0c       INR C
$13d8          65       MOV H,L
$13d9          0c       INR C
$13da          72       MOV M,D
$13db          0c       INR C
$13dc          ff       RST 7
$13dd          fe 21    CPI #21
$13df          91       SUB C
$13e0          21 3e 03 LXI H, #033e
$13e3 o13e3:   cd d9 03 CALL c03d9
$13e6          d3 0f    OUT #0f
$13e8          21 e0 23 LXI H, #23e0
$13eb          11 3b 23 LXI D, #233b
$13ee j13ee:   46       MOV B,M ;o140b
$13ef          1a       LDAX D
$13f0          c6 04    ADI #04
$13f2          90       SUB B
$13f3 o13f3:   f2 f8 13 JP j13f8
$13f6          2f       CMA
$13f7          3c       INR A
$13f8 j13f8:   fe 03    CPI #03 ;o13f3
$13fa o13fa:   da 05 14 JC j1405
$13fd          3a 91 21 LDA $2191
$1400          f6 08    ORI #08
$1402          32 91 21 STA $2191
$1405 j1405:   78       MOV A,B ;o13fa
$1406          d6 04    SUI #04
$1408          12       STAX D
$1409          13       INX D
$140a          2c       INR L
$140b o140b:   c2 ee 13 JNZ j13ee
$140e          3a 91 21 LDA $2191
$1411          e6 08    ANI #08
$1413          c2 de 13 JNZ $13de
$1416 o1416:   cd df 02 CALL c02df
$1419          22 23 22 SHLD $2223
$141c          c9       RET

$141d          21 91 21 LXI H, #2191
$1420          3e 06    MVI A, #06
$1422 o1422:   cd ce 03 CALL c03ce
$1425          21 e0 23 LXI H, #23e0
$1428          11 3b 23 LXI D, #233b
$142b j142b:   1a       LDAX D ;o1432
$142c          96       SUB M
$142d o142d:   f2 4b 14 JP j144b
$1430 j1430:   13       INX D ;jo147d
$1431          2c       INR L
$1432 o1432:   c2 2b 14 JNZ j142b
$1435          21 91 21 LXI H, #2191
$1438          3e 06    MVI A, #06
$143a o143a:   cd e6 03 CALL c03e6
$143d o143d:   ca 45 14 JZ j1445
$1440          3e 05    MVI A, #05
$1442 o1442:   cd d9 03 CALL c03d9
$1445 j1445:   3e 01    MVI A, #01 ;o143d
$1447          f3       DI
$1448 o1448:   c3 6e 03 JMP j036e
$144b j144b:   f3       DI ;o142d
$144c          e5       PUSH H
$144d          21 91 21 LXI H, #2191
$1450          3e 06    MVI A, #06
$1452 o1452:   cd d9 03 CALL c03d9
$1455          3c       INR A
$1456 o1456:   cd e6 03 CALL c03e6
$1459 o1459:   c2 63 14 JNZ jo1463
$145c o145c:   cd ce 03 CALL c03ce
$145f          e1       POP H
$1460 o1460:   c3 7d 14 JMP jo147d
$1463 jo1463:  cd d9 03 CALL c03d9 ;o1459
$1466          e1       POP H
$1467 o1467:   cd 0e 06 CALL c060e
$146a          7d       MOV A,L
$146b          d6 e0    SUI #e0
$146d          6f       MOV L,A
$146e          26 00    MVI H, #00
$1470          29       DAD H
$1471          11 80 14 LXI D, #1480
$1474          19       DAD D
$1475          7e       MOV A,M
$1476          23       INX H
$1477          66       MOV H,M
$1478          6f       MOV L,A
$1479          e9       PCHL
$147a jo147a:  cd 1a 06 CALL c061a ;o0a7d,o0a92,o0a9f,o0abe,o0b0e,o0c38,o0c44,o0d3f,o0deb,o0e0f,o0e2b,o1502,o150c,o1526,o1533,o159a,o15a5,o1605,o161d,o162f,o163a,o1642,o1654,o187e,o188e,o1896,o18f4,o1938
$147d jo147d:  c3 30 14 JMP j1430 ;o1460
$1480          32 16 7a STA $7a16
$1483          14       INR D
$1484          7a       MOV A,D
$1485          14       INR D
$1486          7a       MOV A,D
$1487          14       INR D
$1488          7a       MOV A,D
$1489          14       INR D
$148a          7a       MOV A,D
$148b          14       INR D
$148c          7a       MOV A,D
$148d          14       INR D
$148e          7a       MOV A,D
$148f          14       INR D
$1490          08       (DSUB)
$1491          16 c7    MVI D, #c7
$1493          14       INR D
$1494          ce 14    ACI #14
$1496          e3       XTHL
$1497          14       INR D
$1498          d5       PUSH D
$1499          14       INR D
$149a          dc 14 6b CC $6b14
$149d          0a       LDAX B
$149e          92       SUB D
$149f          15       DCR D
$14a0          ea 14 f1 JPE $f114
$14a3          14       INR D
$14a4          64       MOV H,H
$14a5          0a       LDAX B
$14a6          c0       RNZ
$14a7          14       INR D
$14a8          5d       MOV E,L
$14a9          0a       LDAX B
$14aa          f8       RM
$14ab          0d       DCR C
$14ac o14ac:   fd 0d 02 (JK) j020d
$14af          0e 76    MVI C, #76
$14b1          18       (RLDE)
$14b2          56       MOV D,M
$14b3          0a       LDAX B
$14b4          f3       DI
$14b5          0d       DCR C
$14b6          4f       MOV C,A
$14b7          0a       LDAX B
$14b8          ee 0d    XRI #0d
$14ba          48       MOV C,B
$14bb          0a       LDAX B
$14bc          08       (DSUB)
$14bd          16 32    MVI D, #32
$14bf          16 0e    MVI D, #0e
$14c1          00       NOP
$14c2          06 02    MVI B, #02
$14c4 o14c4:   c3 f5 14 JMP j14f5
$14c7          0e 01    MVI C, #01
$14c9          06 2a    MVI B, #2a
$14cb o14cb:   c3 f5 14 JMP j14f5
$14ce          0e 02    MVI C, #02
$14d0          06 10    MVI B, #10
$14d2 o14d2:   c3 f5 14 JMP j14f5
$14d5          0e 03    MVI C, #03
$14d7          06 1a    MVI B, #1a
$14d9 o14d9:   c3 f5 14 JMP j14f5
$14dc          0e 04    MVI C, #04
$14de          06 01    MVI B, #01
$14e0 o14e0:   c3 f5 14 JMP j14f5
$14e3          0e 05    MVI C, #05
$14e5          06 19    MVI B, #19
$14e7 o14e7:   c3 f5 14 JMP j14f5
$14ea          0e 06    MVI C, #06
$14ec          06 21    MVI B, #21
$14ee          c1       POP B
$14ef          f5       PUSH PSW
$14f0          14       INR D
$14f1          0e 07    MVI C, #07
$14f3          06 0a    MVI B, #0a
$14f5 j14f5:   21 90 20 LXI H, #2090 ;o14c4,o14cb,o14d2,o14d9,o14e0,o14e7
$14f8          3e 07    MVI A, #07
$14fa o14fa:   cd ce 03 CALL c03ce
$14fd          3e 02    MVI A, #02
$14ff o14ff:   cd e6 03 CALL c03e6
$1502 o1502:   c2 7a 14 JNZ jo147a
$1505          79       MOV A,C
$1506          21 c6 21 LXI H, #21c6
$1509 o1509:   cd e6 03 CALL c03e6
$150c o150c:   ca 7a 14 JZ jo147a
$150f o150f:   cd d9 03 CALL c03d9
$1512 o1512:   cd 82 1d CALL co1d82
$1515          21 e4 11 LXI H, #11e4
$1518 o1518:   cd 6e 02 CALL c026e
$151b          21 5a 13 LXI H, #135a
$151e o151e:   cd e4 12 CALL c12e4
$1521          3a c6 21 LDA $21c6
$1524          fe 00    CPI #00
$1526 o1526:   c2 7a 14 JNZ jo147a
$1529          3e 3d    MVI A, #3d
$152b          32 a4 21 STA $21a4
$152e          3e 00    MVI A, #00
$1530          32 05 22 STA $2205
$1533 o1533:   c3 7a 14 JMP jo147a
$1536          3a 05 22 LDA $2205
$1539          3c       INR A
$153a          32 05 22 STA $2205
$153d          fe 09    CPI #09
$153f o153f:   ca 5b 15 JZ j155b
$1542          16 00    MVI D, #00
$1544          5f       MOV E,A
$1545          21 89 15 LXI H, #1589
$1548          19       DAD D
$1549          46       MOV B,M
$154a o154a:   cd 77 1d CALL co1d77
$154d          21 5a 13 LXI H, #135a
$1550 o1550:   cd e4 12 CALL c12e4
$1553          3e 0a    MVI A, #0a
$1555          32 a4 21 STA $21a4
$1558 o1558:   c3 08 06 JMP jo0608
$155b j155b:   06 11    MVI B, #11 ;o153f
$155d o155d:   cd 9d 1d CALL co1d9d
$1560 o1560:   c2 73 15 JNZ jo1573
$1563          06 38    MVI B, #38
$1565 o1565:   cd 9d 1d CALL co1d9d
$1568 o1568:   c2 7e 15 JNZ j157e
$156b          06 11    MVI B, #11
$156d o156d:   cd 77 1d CALL co1d77
$1570 o1570:   c3 7e 15 JMP j157e
$1573 jo1573:  cd 82 1d CALL co1d82 ;o1560
$1576          06 38    MVI B, #38
$1578 o1578:   cd 77 1d CALL co1d77
$157b o157b:   c3 7e 15 JMP j157e
$157e j157e:   3e ff    MVI A, #ff ;o1568,o1570,o157b
$1580          32 c6 21 STA $21c6
$1583          97       SUB A
$1584          32 05 22 STA $2205
$1587 o1587:   c3 08 06 JMP jo0608
$158a          02       STAX B
$158b          2a 10 1a LHLD $1a10
$158e          01 19 21 LXI B, #2119
$1591          0a       LDAX B
$1592          21 90 21 LXI H, #2190
$1595          3e 07    MVI A, #07
$1597 o1597:   cd e6 03 CALL c03e6
$159a o159a:   ca 7a 14 JZ jo147a
$159d o159d:   cd d9 03 CALL c03d9
$15a0          3e 02    MVI A, #02
$15a2 o15a2:   cd e6 03 CALL c03e6
$15a5 o15a5:   c2 7a 14 JNZ jo147a
$15a8          21 00 12 LXI H, #1200
$15ab o15ab:   cd ed 0e CALL c0eed
$15ae          21 90 21 LXI H, #2190
$15b1          3e 04    MVI A, #04
$15b3 o15b3:   cd e6 03 CALL c03e6
$15b6 o15b6:   ca e4 15 JZ j15e4
$15b9          21 91 21 LXI H, #2191
$15bc          3e 01    MVI A, #01
$15be o15be:   cd e6 03 CALL c03e6
$15c1 o15c1:   c2 e4 15 JNZ j15e4
$15c4 o15c4:   cd ce 03 CALL c03ce
$15c7          3a c7 21 LDA $21c7
$15ca          06 ff    MVI B, #ff
$15cc j15cc:   04       INR B ;o15ce
$15cd          1f       RAR
$15ce o15ce:   d2 cc 15 JNC j15cc
$15d1          78       MOV A,B
$15d2          3d       DCR A
$15d3 o15d3:   f2 d8 15 JP j15d8
$15d6          3e 04    MVI A, #04
$15d8 j15d8:   32 11 22 STA $2211 ;o15d3
$15db o15db:   cd fa 03 CALL c03fa
$15de          21 bb 13 LXI H, #13bb
$15e1 o15e1:   cd e4 12 CALL c12e4
$15e4 j15e4:   21 90 21 LXI H, #2190 ;o15b6,o15c1
$15e7          3e 03    MVI A, #03
$15e9 o15e9:   cd e6 03 CALL c03e6
$15ec o15ec:   c2 ff 15 JNZ j15ff
$15ef          06 09    MVI B, #09
$15f1 o15f1:   cd 9d 1d CALL co1d9d
$15f4 o15f4:   ca ff 15 JZ j15ff
$15f7 o15f7:   cd 82 1d CALL co1d82
$15fa          06 31    MVI B, #31
$15fc o15fc:   cd 92 1d CALL co1d92
$15ff j15ff:   21 70 13 LXI H, #1370 ;o15ec,o15f4
$1602 o1602:   cd e4 12 CALL c12e4
$1605 o1605:   c3 7a 14 JMP jo147a
$1608          3e ff    MVI A, #ff
$160a          32 93 21 STA $2193
$160d          3a 94 21 LDA $2194
$1610          f6 30    ORI #30
$1612          32 94 21 STA $2194
$1615          21 90 21 LXI H, #2190
$1618          3e 02    MVI A, #02
$161a o161a:   cd e6 03 CALL c03e6
$161d o161d:   c2 7a 14 JNZ jo147a
$1620 o1620:   cd ce 03 CALL c03ce
$1623          21 e8 11 LXI H, #11e8
$1626 o1626:   cd 6e 02 CALL c026e
$1629          21 ce 13 LXI H, #13ce
$162c o162c:   cd e4 12 CALL c12e4
$162f o162f:   c3 7a 14 JMP jo147a
$1632          21 90 21 LXI H, #2190
$1635          3e 02    MVI A, #02
$1637 o1637:   cd e6 03 CALL c03e6
$163a o163a:   c2 7a 14 JNZ jo147a
$163d          3e 07    MVI A, #07
$163f o163f:   cd e6 03 CALL c03e6
$1642 o1642:   ca 7a 14 JZ jo147a
$1645 o1645:   cd d9 03 CALL c03d9
$1648          21 e8 11 LXI H, #11e8
$164b o164b:   cd ed 0e CALL c0eed
$164e          21 b8 13 LXI H, #13b8
$1651 o1651:   cd e4 12 CALL c12e4
$1654 o1654:   c3 7a 14 JMP jo147a
$1657          21 92 21 LXI H, #2192
$165a          3e 00    MVI A, #00
$165c o165c:   cd e6 03 CALL c03e6
$165f o165f:   c2 03 18 JNZ j1803
$1662          3a 7a 23 LDA CREDITS_1
$1665          b7       ORA A
$1666 o1666:   c2 7c 16 JNZ j167c
$1669          3a 9e 23 LDA $239e
$166c          e6 08    ANI #08
$166e o166e:   c2 03 18 JNZ j1803
$1671          3a b6 23 LDA $23b6
$1674          f6 80    ORI #80
$1676          32 b6 23 STA $23b6
$1679 o1679:   c3 03 18 JMP j1803
$167c j167c:   3a 7b 23 LDA BALL_IN_PLAY_hrm ;o1666
$167f          e6 0f    ANI #0f
$1681          fe 01    CPI #01
$1683 o1683:   ca 49 17 JZ j1749
$1686          fe 00    CPI #00
$1688 o1688:   ca 49 17 JZ j1749
$168b          21 a3 23 LXI H, #23a3
$168e          11 20 23 LXI D, #2320
$1691          3e 2e    MVI A, #2e
$1693 o1693:   cd 60 0f CALL c0f60
$1696 o1696:   cd 22 18 CALL c1822
$1699          21 92 21 LXI H, #2192
$169c          3e 04    MVI A, #04
$169e o169e:   cd e6 03 CALL c03e6
$16a1 o16a1:   ca b1 16 JZ j16b1
$16a4          3e 07    MVI A, #07
$16a6 o16a6:   cd e6 03 CALL c03e6
$16a9 o16a9:   ca b1 16 JZ j16b1
$16ac          3e 01    MVI A, #01
$16ae o16ae:   c3 cd 16 JMP j16cd
$16b1 j16b1:   3e 06    MVI A, #06 ;o16a1,o16a9
$16b3 o16b3:   cd ce 03 CALL c03ce
$16b6          3a 90 21 LDA $2190
$16b9          f6 05    ORI #05
$16bb          32 90 21 STA $2190
$16be          3e ff    MVI A, #ff
$16c0          32 93 21 STA $2193
$16c3          3a 94 21 LDA $2194
$16c6          f6 30    ORI #30
$16c8          32 94 21 STA $2194
$16cb          3e 00    MVI A, #00
$16cd j16cd:   32 7b 23 STA BALL_IN_PLAY_hrm ;o16ae
$16d0          32 9b 23 STA BALL_IN_PLAY_1
; decrease credits
$16d3          32 bb 23 STA BALL_IN_PLAY_2
$16d6          3e 11    MVI A, #11
$16d8          32 7e 23 STA $237e
$16db          32 be 23 STA $23be
$16de          3e 01    MVI A, #01
$16e0          32 9e 23 STA $239e
$16e3          3e f0    MVI A, #f0
$16e5          32 86 23 STA $2386
$16e8          32 a6 23 STA $23a6
$16eb          32 80 23 STA $2380
$16ee          32 a0 23 STA $23a0
$16f1          3e 00    MVI A, #00
$16f3          32 14 22 STA $2214
$16f6          11 d3 21 LXI D, #21d3
$16f9          06 04    MVI B, #04
$16fb o16fb:   cd 08 18 CALL jc1808
$16fe          21 92 21 LXI H, #2192
$1701          3e 06    MVI A, #06
$1703 o1703:   cd d9 03 CALL c03d9
$1706          21 b6 23 LXI H, #23b6
$1709          3e 06    MVI A, #06
$170b o170b:   cd d9 03 CALL c03d9
$170e          21 d3 21 LXI H, #21d3
$1711          11 c6 21 LXI D, #21c6
$1714          3e 10    MVI A, #10
$1716 o1716:   cd 60 0f CALL c0f60
$1719          21 c9 21 LXI H, #21c9
$171c          11 ce 21 LXI D, #21ce
$171f          3e 0a    MVI A, #0a
$1721 o1721:   cd 60 0f CALL c0f60
$1724          21 90 21 LXI H, #2190
$1727          3e 04    MVI A, #04
$1729 o1729:   cd d9 03 CALL c03d9
$172c j172c:   3a 7a 23 LDA CREDITS_1 ;o17e4
$172f          c6 99    ADI #99
$1731          27       DAA
$1732          32 7a 23 STA CREDITS_1
$1735          32 9a 23 STA CREDITS_2
$1738          32 ba 23 STA CREDITS_3
$173b          3a 14 22 LDA $2214
$173e          47       MOV B,A
$173f          3a 13 22 LDA BALLS_PER_GAME
$1742          80       ADD B
$1743          32 14 22 STA $2214
$1746 o1746:   c3 e7 17 JMP j17e7
$1749 j1749:   3a 7e 23 LDA $237e ;o1683,o1688
$174c          e6 08    ANI #08
$174e o174e:   c2 03 18 JNZ j1803
$1751 j1751:   3e 01    MVI A, #01 ;o17fa
$1753          21 7e 23 LXI H, #237e
$1756 o1756:   cd e6 03 CALL c03e6
$1759 o1759:   ca 94 17 JZ jo1794
$175c          3e 02    MVI A, #02
$175e o175e:   cd e6 03 CALL c03e6
$1761 o1761:   ca b2 17 JZ jo17b2
$1764          3e 03    MVI A, #03
$1766 o1766:   cd ce 03 CALL c03ce
$1769          3e f0    MVI A, #f0
$176b          32 90 23 STA $2390
$176e          32 b0 23 STA $23b0
$1771          f3       DI
$1772          3a 7e 23 LDA $237e
$1775          f5       PUSH PSW
$1776          3e 1f    MVI A, #1f
$1778          32 7e 23 STA $237e
$177b          21 cc 11 LXI H, #11cc
$177e o177e:   cd cd 0f CALL c0fcd
$1781          3e 2f    MVI A, #2f
$1783          32 7e 23 STA $237e
$1786          21 cc 11 LXI H, #11cc
$1789 o1789:   cd cd 0f CALL c0fcd
$178c          f1       POP PSW
$178d          32 7e 23 STA $237e
$1790          fb       EI
$1791 o1791:   c3 d4 17 JMP j17d4
$1794 jo1794:  cd ce 03 CALL c03ce ;o1759
$1797          3e f0    MVI A, #f0
$1799          32 8d 23 STA $238d
$179c          32 ad 23 STA $23ad
$179f          3a 16 22 LDA DIP_SWITCHES
$17a2          e6 08    ANI #08
$17a4 o17a4:   c2 d4 17 JNZ j17d4
$17a7          3e f0    MVI A, #f0
$17a9          32 97 23 STA $2397
$17ac          32 b7 23 STA $23b7
$17af o17af:   c3 d4 17 JMP j17d4
$17b2 jo17b2:  cd ce 03 CALL c03ce ;o1761
$17b5          3e f0    MVI A, #f0
$17b7          32 83 23 STA $2383
$17ba          32 a3 23 STA $23a3
$17bd          3e ff    MVI A, #ff
$17bf          32 97 23 STA $2397
$17c2          32 98 23 STA $2398
$17c5          32 99 23 STA $2399
$17c8          32 b7 23 STA $23b7
$17cb          32 b8 23 STA $23b8
$17ce          32 b9 23 STA $23b9
$17d1 o17d1:   c3 d4 17 JMP j17d4
$17d4 j17d4:   3a 7e 23 LDA $237e ;o1791,o17a4,o17af,o17d1
$17d7          32 be 23 STA $23be
$17da          e6 0f    ANI #0f
$17dc          47       MOV B,A
$17dd          3a 9e 23 LDA $239e
$17e0          b0       ORA B
$17e1          32 9e 23 STA $239e
$17e4 o17e4:   c3 2c 17 JMP j172c
$17e7 j17e7:   db 05    IN DIP_SWITCH_PORT ;o1746
$17e9          e6 80    ANI #80
$17eb o17eb:   c2 fd 17 JNZ j17fd
$17ee          3a 7a 23 LDA CREDITS_1
$17f1          b7       ORA A
$17f2 o17f2:   ca fd 17 JZ j17fd
$17f5          3a 7e 23 LDA $237e
$17f8          e6 08    ANI #08
$17fa o17fa:   ca 51 17 JZ j1751
$17fd j17fd:   21 5d 13 LXI H, #135d ;o17eb,o17f2
$1800 o1800:   cd e4 12 CALL c12e4
$1803 j1803:   3e 06    MVI A, #06 ;o165f,o166e,o1679,o174e
$1805 o1805:   c3 6e 03 JMP j036e
 
$1808 jc1808:  21 1a 18 LXI H, #181a ;o0175,o16fb,o1816
$180b          0e 08    MVI C, #08
$180d j180d:   7e       MOV A,M ;o1812
$180e          12       STAX D
$180f          13       INX D
$1810          23       INX H
$1811          0d       DCR C
$1812 o1812:   c2 0d 18 JNZ j180d
$1815          05       DCR B
$1816 o1816:   c2 08 18 JNZ jc1808
$1819          c9       RET

$181a          ff       RST 7
$181b          1f       RAR
$181c          01 04 39 LXI B, #3904
$181f          2b       DCX H
$1820          37       STC
$1821          37       STC
 
$1822 c1822:   21 5b 23 LXI H, #235b ;jo0138,o1696
$1825          3e 00    MVI A, #00
$1827          16 1f    MVI D, #1f
$1829 j1829:   77       MOV M,A ;o182c
$182a          23       INX H
$182b          15       DCR D
$182c o182c:   c2 29 18 JNZ j1829
$182f          21 80 23 LXI H, #2380
$1832          3e ff    MVI A, #ff
$1834          16 1a    MVI D, #1a
$1836 j1836:   77       MOV M,A ;o1839
$1837          23       INX H
$1838          15       DCR D
$1839 o1839:   c2 36 18 JNZ j1836
$183c          21 a0 23 LXI H, #23a0
$183f          3e ff    MVI A, #ff
$1841          16 1a    MVI D, #1a
$1843 j1843:   77       MOV M,A ;o1846
$1844          23       INX H
$1845          15       DCR D
$1846 o1846:   c2 43 18 JNZ j1843
$1849          3e 0f    MVI A, #0f
$184b          32 8c 23 STA $238c
$184e          32 ac 23 STA $23ac
$1851          32 96 23 STA $2396
$1854          32 b6 23 STA $23b6
$1857          c9       RET

 
$1858 c1858:   3a 7e 23 LDA $237e ;o18ee,o196a
$185b          e6 02    ANI #02
$185d          3e 20    MVI A, #20
$185f          c8       RZ
$1860          21 90 21 LXI H, #2190
$1863          3e 03    MVI A, #03
$1865 o1865:   cd e6 03 CALL c03e6
$1868          3e 20    MVI A, #20
$186a          c0       RNZ
$186b          3a 14 22 LDA $2214
$186e          fe 01    CPI #01
$1870          3e 20    MVI A, #20
$1872          c8       RZ
$1873          3e 80    MVI A, #80
$1875          c9       RET

$1876          21 92 21 LXI H, #2192
$1879          3e 04    MVI A, #04
$187b o187b:   cd e6 03 CALL c03e6
$187e o187e:   c2 7a 14 JNZ jo147a
$1881          21 08 22 LXI H, #2208
$1884          3e ff    MVI A, #ff
$1886          86       ADD M
$1887 o1887:   d2 91 18 JNC j1891
$188a          77       MOV M,A
$188b o188b:   ca 99 18 JZ j1899
$188e o188e:   c3 7a 14 JMP jo147a
$1891 j1891:   3e 32    MVI A, #32 ;o1887
$1893          32 08 22 STA $2208
$1896 o1896:   c3 7a 14 JMP jo147a
$1899 j1899:   3e ff    MVI A, #ff ;o188b
$189b          32 93 21 STA $2193
$189e          3e 00    MVI A, #00
$18a0          32 0c 22 STA $220c
$18a3          32 c3 21 STA $21c3
$18a6          32 a8 21 STA $21a8
$18a9          32 a9 21 STA $21a9
$18ac          3a 94 21 LDA $2194
$18af          f6 30    ORI #30
$18b1          32 94 21 STA $2194
$18b4          21 90 21 LXI H, #2190
$18b7          3e 02    MVI A, #02
$18b9 o18b9:   cd ce 03 CALL c03ce
$18bc          21 92 21 LXI H, #2192
$18bf          3e 04    MVI A, #04
$18c1 o18c1:   cd ce 03 CALL c03ce
$18c4          21 6b 13 LXI H, #136b
$18c7 o18c7:   cd e4 12 CALL c12e4
$18ca o18ca:   cd a3 1b CALL c1ba3
$18cd          eb       XCHG
$18ce          21 c6 21 LXI H, #21c6
$18d1          3e 10    MVI A, #10
$18d3 o18d3:   cd 60 0f CALL c0f60
$18d6          21 90 21 LXI H, #2190
$18d9          3e 00    MVI A, #00
$18db o18db:   cd e6 03 CALL c03e6
$18de o18de:   c2 e9 18 JNZ j18e9
$18e1          06 39    MVI B, #39
$18e3 o18e3:   cd 9d 1d CALL co1d9d
$18e6 o18e6:   c2 f7 18 JNZ j18f7
$18e9 j18e9:   3e 02    MVI A, #02 ;o18de
$18eb          32 a0 21 STA $21a0
$18ee o18ee:   cd 58 18 CALL c1858
$18f1          32 1c 22 STA $221c
$18f4 o18f4:   c3 7a 14 JMP jo147a
$18f7 j18f7:   2a 5c 23 LHLD $235c ;o18e6
$18fa          29       DAD H
$18fb          29       DAD H
$18fc          29       DAD H
$18fd          29       DAD H
$18fe          22 f3 21 SHLD $21f3
$1901          2a 5d 23 LHLD $235d
$1904          29       DAD H
$1905          29       DAD H
$1906          29       DAD H
$1907          29       DAD H
$1908          7c       MOV A,H
$1909          32 f5 21 STA $21f5
$190c          21 f3 21 LXI H, #21f3
$190f          11 0d 22 LXI D, #220d
$1912          3e 06    MVI A, #06
$1914 o1914:   cd 60 0f CALL c0f60
$1917          3e 04    MVI A, #04
$1919 j1919:   f5       PUSH PSW ;o1924
$191a          21 0d 22 LXI H, #220d
$191d          3e 06    MVI A, #06
$191f o191f:   cd 7d 0e CALL c0e7d
$1922          f1       POP PSW
$1923          3d       DCR A
$1924 o1924:   c2 19 19 JNZ j1919
$1927          21 f3 21 LXI H, #21f3
$192a o192a:   cd 00 0f CALL c0f00
$192d          3e 3c    MVI A, #3c
$192f          32 ae 21 STA $21ae
$1932          21 b8 13 LXI H, #13b8
$1935 o1935:   cd e4 12 CALL c12e4
$1938 o1938:   c3 7a 14 JMP jo147a
$193b          21 e8 11 LXI H, #11e8
$193e o193e:   cd 2a 0f CALL c0f2a
$1941 o1941:   da 58 19 JC j1958
$1944          21 e8 11 LXI H, #11e8
$1947 o1947:   cd 6e 02 CALL c026e
$194a          3e 0a    MVI A, #0a
$194c          32 ae 21 STA $21ae
$194f          21 b5 13 LXI H, #13b5
$1952 o1952:   cd e4 12 CALL c12e4
$1955 o1955:   c3 08 06 JMP jo0608
$1958 j1958:   21 e8 11 LXI H, #11e8 ;o1941
$195b o195b:   cd ed 0e CALL c0eed
$195e          21 5b 23 LXI H, #235b
$1961 o1961:   cd cd 0f CALL c0fcd
$1964          21 5b 23 LXI H, #235b
$1967 o1967:   cd 2a 0f CALL c0f2a
$196a o196a:   cd 58 18 CALL c1858
$196d          32 1c 22 STA $221c
$1970          3a 1c 22 LDA $221c
$1973          3d       DCR A
$1974          32 1c 22 STA $221c
$1977 o1977:   ca 82 19 JZ j1982
$197a          3e 02    MVI A, #02
$197c          32 a0 21 STA $21a0
$197f o197f:   c3 08 06 JMP jo0608
$1982 j1982:   3e 01    MVI A, #01 ;o1977
$1984          32 12 22 STA $2212
$1987          3e 32    MVI A, #32
$1989          32 94 21 STA $2194
$198c          21 92 21 LXI H, #2192
$198f          3e 03    MVI A, #03
$1991 o1991:   cd d9 03 CALL c03d9
$1994          21 90 21 LXI H, #2190
$1997 o1997:   cd e6 03 CALL c03e6
$199a o199a:   ca b9 19 JZ j19b9
$199d o199d:   cd d9 03 CALL c03d9
$19a0          3e 02    MVI A, #02
$19a2          32 12 22 STA $2212
$19a5          06 30    MVI B, #30
$19a7 o19a7:   cd 92 1d CALL co1d92
$19aa          21 96 23 LXI H, #2396
$19ad          3e 04    MVI A, #04
$19af o19af:   cd d9 03 CALL c03d9
$19b2          21 14 22 LXI H, #2214
$19b5          34       INR M
$19b6 o19b6:   c3 8a 1a JMP j1a8a
$19b9 j19b9:   3a 7b 23 LDA BALL_IN_PLAY_hrm ;o199a
$19bc          b7       ORA A
$19bd          3e 01    MVI A, #01
$19bf          21 7e 23 LXI H, #237e
$19c2 o19c2:   ca 5b 1a JZ j1a5b
$19c5          3e 04    MVI A, #04
$19c7 jo19c7:  cd e6 03 CALL c03e6 ;o19d0
$19ca o19ca:   c2 d3 19 JNZ jo19d3
$19cd          3c       INR A
$19ce          fe 08    CPI #08
$19d0 o19d0:   c2 c7 19 JNZ jo19c7
$19d3 jo19d3:  cd d9 03 CALL c03d9 ;o19ca
$19d6          3c       INR A
$19d7          4f       MOV C,A
$19d8          d6 04    SUI #04
$19da o19da:   cd e6 03 CALL c03e6
$19dd          79       MOV A,C
$19de o19de:   c2 69 1a JNZ jo1a69
$19e1          3a 13 22 LDA BALLS_PER_GAME
$19e4          3c       INR A
$19e5          47       MOV B,A
$19e6          3a 7b 23 LDA BALL_IN_PLAY_hrm
$19e9          3c       INR A
$19ea          b8       CMP B
$19eb o19eb:   c2 5b 1a JNZ j1a5b
$19ee          21 91 21 LXI H, #2191
$19f1          3e 00    MVI A, #00
$19f3 o19f3:   cd e6 03 CALL c03e6
$19f6          3e 01    MVI A, #01
$19f8 o19f8:   c2 5b 1a JNZ j1a5b
$19fb          3a 92 21 LDA $2192
$19fe          f6 c0    ORI #c0
$1a00          32 92 21 STA $2192
$1a03          21 b6 23 LXI H, #23b6
$1a06          3e 06    MVI A, #06
$1a08 o1a08:   cd ce 03 CALL c03ce
$1a0b          3a ac 23 LDA $23ac
$1a0e          e6 30    ANI #30
$1a10 o1a10:   ca 1c 1a JZ j1a1c
$1a13          fe 10    CPI #10
$1a15          3e 05    MVI A, #05
$1a17 o1a17:   ca 1c 1a JZ j1a1c
$1a1a          3e 0a    MVI A, #0a
$1a1c j1a1c:   32 be 23 STA $23be ;o1a10,o1a17
$1a1f          97       SUB A
$1a20          32 9e 23 STA $239e
$1a23          3a 8c 23 LDA $238c
$1a26          e6 0f    ANI #0f
$1a28          32 8c 23 STA $238c
$1a2b          21 82 13 LXI H, #1382
$1a2e o1a2e:   cd e4 12 CALL c12e4
$1a31          3e 00    MVI A, #00
$1a33          32 9b 23 STA BALL_IN_PLAY_1
$1a36          32 bb 23 STA BALL_IN_PLAY_2
$1a39          3e fa    MVI A, #fa
$1a3b          32 9e 21 STA $219e
$1a3e          3a 16 22 LDA DIP_SWITCHES
$1a41          e6 04    ANI #04
$1a43 o1a43:   cc b8 1d CZ c1db8
$1a46          06 00    MVI B, #00
$1a48 o1a48:   cd 9d 1d CALL co1d9d
$1a4b o1a4b:   ca 08 06 JZ jo0608
$1a4e          3e 7d    MVI A, #7d
$1a50          32 9a 21 STA $219a
$1a53          3e 2d    MVI A, #2d
$1a55          32 17 22 STA $2217
$1a58 o1a58:   c3 08 06 JMP jo0608
$1a5b j1a5b:   32 7b 23 STA BALL_IN_PLAY_hrm ;o19c2,o19eb,o19f8
$1a5e          32 9b 23 STA BALL_IN_PLAY_1
$1a61          32 bb 23 STA BALL_IN_PLAY_2
$1a64          3e 04    MVI A, #04
$1a66          21 7e 23 LXI H, #237e
$1a69 jo1a69:  cd ce 03 CALL c03ce ;o19de
$1a6c          3a 13 22 LDA BALLS_PER_GAME
$1a6f          4f       MOV C,A
$1a70          3a 7b 23 LDA BALL_IN_PLAY_hrm
$1a73          b9       CMP C
$1a74 o1a74:   c2 8a 1a JNZ j1a8a
$1a77          21 90 21 LXI H, #2190
$1a7a          3e 04    MVI A, #04
$1a7c o1a7c:   cd ce 03 CALL c03ce
$1a7f          06 00    MVI B, #00
$1a81 o1a81:   cd 9d 1d CALL co1d9d
$1a84 o1a84:   ca 8a 1a JZ j1a8a
$1a87 o1a87:   cd 92 1d CALL co1d92
$1a8a j1a8a:   3a 7e 23 LDA $237e ;o19b6,o1a74,o1a84
$1a8d          32 be 23 STA $23be
$1a90          47       MOV B,A
$1a91          e6 0f    ANI #0f
$1a93          32 9e 23 STA $239e
$1a96          21 90 21 LXI H, #2190
$1a99          3e 00    MVI A, #00
$1a9b o1a9b:   cd d9 03 CALL c03d9
$1a9e          3e 03    MVI A, #03
$1aa0 o1aa0:   cd d9 03 CALL c03d9
$1aa3          06 09    MVI B, #09
$1aa5 o1aa5:   cd 82 1d CALL co1d82
$1aa8          21 b6 23 LXI H, #23b6
$1aab          3e 05    MVI A, #05
$1aad o1aad:   cd d9 03 CALL c03d9
$1ab0          3e 02    MVI A, #02
$1ab2          32 a1 21 STA $21a1
$1ab5 o1ab5:   c3 08 06 JMP jo0608
$1ab8          3a 17 22 LDA $2217
$1abb          3d       DCR A
$1abc          32 17 22 STA $2217
$1abf o1abf:   c2 ca 1a JNZ j1aca
$1ac2          06 00    MVI B, #00
$1ac4 o1ac4:   cd 82 1d CALL co1d82
$1ac7 o1ac7:   c3 08 06 JMP jo0608
$1aca j1aca:   3e 7d    MVI A, #7d ;o1abf
$1acc          32 9a 21 STA $219a
$1acf o1acf:   c3 08 06 JMP jo0608
$1ad2          3a 12 22 LDA $2212
$1ad5          3d       DCR A
$1ad6          32 12 22 STA $2212
$1ad9 o1ad9:   ca ea 1a JZ j1aea
$1adc          21 a4 13 LXI H, #13a4
$1adf o1adf:   cd e4 12 CALL c12e4
$1ae2          3e a0    MVI A, #a0
$1ae4          32 a1 21 STA $21a1
$1ae7 o1ae7:   c3 08 06 JMP jo0608
$1aea j1aea:   21 cc 11 LXI H, #11cc ;o1ad9
$1aed o1aed:   cd 00 0f CALL c0f00
$1af0          3a c9 21 LDA $21c9
$1af3          32 18 22 STA $2218
$1af6          3a ce 21 LDA $21ce
$1af9          32 19 22 STA $2219
$1afc o1afc:   cd a3 1b CALL c1ba3
$1aff          11 c6 21 LXI D, #21c6
$1b02          3e 10    MVI A, #10
$1b04 o1b04:   cd 60 0f CALL c0f60
$1b07          21 c9 21 LXI H, #21c9
$1b0a          11 ce 21 LXI D, #21ce
$1b0d          3e 0a    MVI A, #0a
$1b0f o1b0f:   cd 60 0f CALL c0f60
$1b12          06 2b    MVI B, #2b
$1b14 o1b14:   cd 77 1d CALL co1d77
$1b17          06 2c    MVI B, #2c
$1b19 o1b19:   cd 77 1d CALL co1d77
$1b1c          06 04    MVI B, #04
$1b1e o1b1e:   cd 77 1d CALL co1d77
$1b21          06 0c    MVI B, #0c
$1b23 o1b23:   cd 77 1d CALL co1d77
$1b26          06 14    MVI B, #14
$1b28 o1b28:   cd 77 1d CALL co1d77
$1b2b          06 11    MVI B, #11
$1b2d o1b2d:   cd 82 1d CALL co1d82
$1b30          06 38    MVI B, #38
$1b32 o1b32:   cd 82 1d CALL co1d82
$1b35          06 31    MVI B, #31
$1b37 o1b37:   cd 82 1d CALL co1d82
$1b3a          06 09    MVI B, #09
$1b3c o1b3c:   cd 82 1d CALL co1d82
$1b3f          3a 18 22 LDA $2218
$1b42          e6 41    ANI #41
$1b44          47       MOV B,A
$1b45          3a c9 21 LDA $21c9
$1b48          e6 be    ANI #be
$1b4a          b0       ORA B
$1b4b          32 c9 21 STA $21c9
$1b4e          3a 19 22 LDA $2219
$1b51          e6 41    ANI #41
$1b53          47       MOV B,A
$1b54          3a ce 21 LDA $21ce
$1b57          e6 be    ANI #be
$1b59          b0       ORA B
$1b5a          32 ce 21 STA $21ce
$1b5d          06 39    MVI B, #39
$1b5f o1b5f:   cd 82 1d CALL co1d82
$1b62          21 92 21 LXI H, #2192
$1b65          3e 07    MVI A, #07
$1b67 o1b67:   cd ce 03 CALL c03ce
$1b6a          21 c9 13 LXI H, #13c9
$1b6d o1b6d:   cd e4 12 CALL c12e4
$1b70          3a 14 22 LDA $2214
$1b73          3d       DCR A
$1b74          32 14 22 STA $2214
$1b77          d6 02    SUI #02
$1b79 o1b79:   fa a0 1b JM jo1ba0
$1b7c o1b7c:   c2 a0 1b JNZ jo1ba0
$1b7f          3a 7e 23 LDA $237e
$1b82          06 00    MVI B, #00
$1b84          e6 0f    ANI #0f
$1b86 j1b86:   1f       RAR ;o1b8b
$1b87 o1b87:   d2 8e 1b JNC j1b8e
$1b8a          04       INR B
$1b8b o1b8b:   c3 86 1b JMP j1b86
$1b8e j1b8e:   3a 7a 23 LDA CREDITS_1 ;o1b87
$1b91          90       SUB B
$1b92 o1b92:   f2 a0 1b JP jo1ba0
$1b95          06 00    MVI B, #00
$1b97 o1b97:   cd 9d 1d CALL co1d9d
$1b9a o1b9a:   c2 a0 1b JNZ jo1ba0
$1b9d o1b9d:   cd 77 1d CALL co1d77
$1ba0 jo1ba0:  c3 08 06 JMP jo0608 ;o1b79,o1b7c,o1b92,o1b9a
 
$1ba3 c1ba3:   3a 7e 23 LDA $237e ;o18ca,o1afc
$1ba6          e6 f0    ANI #f0
$1ba8          21 eb 21 LXI H, #21eb
$1bab          11 f8 ff LXI D, #fff8
$1bae j1bae:   17       RAL ;o1bb1
$1baf          d8       RC
$1bb0          19       DAD D
$1bb1 o1bb1:   c3 ae 1b JMP j1bae
$1bb4 j1bb4:   fb       EI ;o0260
$1bb5          21 15 22 LXI H, #2215
$1bb8          db 04    IN PRICE_89_CAB
$1bba          77       MOV M,A
$1bbb          3a 92 21 LDA $2192
$1bbe          e6 04    ANI #04
$1bc0 o1bc0:   c2 53 1c JNZ j1c53
$1bc3          f3       DI
$1bc4          3a 53 23 LDA $2353
$1bc7          47       MOV B,A
$1bc8          3a f8 23 LDA $23f8
$1bcb          90       SUB B
$1bcc          3a 94 21 LDA $2194
$1bcf o1bcf:   fa d7 1b JM j1bd7
$1bd2          e6 dd    ANI #dd
$1bd4 o1bd4:   c3 db 1b JMP j1bdb
$1bd7 j1bd7:   f6 02    ORI #02 ;o1bcf
$1bd9          e6 df    ANI #df
$1bdb j1bdb:   32 94 21 STA $2194 ;o1bd4
$1bde          3a 92 21 LDA $2192
$1be1          e6 01    ANI #01
$1be3          fb       EI
$1be4 o1be4:   ca 05 1c JZ j1c05
$1be7          3a 92 21 LDA $2192
$1bea          e6 fe    ANI #fe
$1bec          32 92 21 STA $2192
$1bef          21 44 22 LXI H, #2244
$1bf2          11 80 23 LXI D, #2380
$1bf5          3e 34    MVI A, #34
$1bf7 o1bf7:   cd 60 0f CALL c0f60
$1bfa          21 64 22 LXI H, #2264
$1bfd          11 a0 23 LXI D, #23a0
$1c00          3e 34    MVI A, #34
$1c02 o1c02:   cd 60 0f CALL c0f60
$1c05 j1c05:   3a 15 22 LDA $2215 ;o1be4
$1c08          e6 20    ANI #20
$1c0a o1c0a:   c2 e1 1c JNZ j1ce1
$1c0d          fb       EI
$1c0e          3a 92 21 LDA $2192
$1c11          e6 40    ANI #40
$1c13 o1c13:   ca 2e 1c JZ j1c2e
$1c16          3a 7a 23 LDA CREDITS_1
$1c19          b7       ORA A
$1c1a          21 b6 23 LXI H, #23b6
$1c1d          3e 07    MVI A, #07
$1c1f o1c1f:   c2 28 1c JNZ jo1c28
$1c22 o1c22:   cd ce 03 CALL c03ce
$1c25 o1c25:   c3 a2 01 JMP j01a2
$1c28 jo1c28:  cd d9 03 CALL c03d9 ;o1c1f
$1c2b o1c2b:   c3 a2 01 JMP j01a2
$1c2e j1c2e:   3a 91 21 LDA $2191 ;o1c13
$1c31          e6 01    ANI #01
$1c33          fb       EI
$1c34 o1c34:   ca a2 01 JZ j01a2
$1c37          db 03    IN PRICE_TENS_07_PORT
; seems pointless
$1c39          fe fe    CPI #fe
$1c3b o1c3b:   c2 45 1c JNZ j1c45
$1c3e          db 02    IN PRICE_CENTS_07_PORT
$1c40          fe fb    CPI #fb
$1c42 o1c42:   ca fa 1c JZ j1cfa
$1c45 j1c45:   21 91 21 LXI H, #2191 ;o1c3b
$1c48          3e 00    MVI A, #00
$1c4a o1c4a:   cd d9 03 CALL c03d9
$1c4d          32 9f 21 STA $219f
$1c50 o1c50:   c3 a2 01 JMP j01a2
$1c53 j1c53:   21 92 21 LXI H, #2192 ;o1bc0
$1c56          3e 00    MVI A, #00
$1c58 o1c58:   cd e6 03 CALL c03e6
$1c5b o1c5b:   c2 08 02 JNZ j0208
$1c5e o1c5e:   cd ce 03 CALL c03ce
$1c61          3a 41 22 LDA $2241
$1c64          e6 01    ANI #01
$1c66 o1c66:   c2 74 1c JNZ j1c74
$1c69          21 80 23 LXI H, #2380
$1c6c          11 44 22 LXI D, #2244
$1c6f          3e 80    MVI A, #80
$1c71 o1c71:   cd 60 0f CALL c0f60
$1c74 j1c74:   3e ff    MVI A, #ff ;o1c66
$1c76          21 83 23 LXI H, #2383
$1c79          06 17    MVI B, #17
$1c7b j1c7b:   77       MOV M,A ;o1c7e
$1c7c          23       INX H
$1c7d          05       DCR B
$1c7e o1c7e:   c2 7b 1c JNZ j1c7b
$1c81          3e 0f    MVI A, #0f
$1c83          32 8c 23 STA $238c
$1c86          3a 16 22 LDA DIP_SWITCHES
$1c89          e6 04    ANI #04
$1c8b o1c8b:   c2 96 1c JNZ j1c96
$1c8e          3a 41 22 LDA $2241
$1c91          e6 01    ANI #01
$1c93 o1c93:   c2 bb 1c JNZ j1cbb
$1c96 j1c96:   21 20 23 LXI H, #2320 ;o1c8b
$1c99          11 a3 23 LXI D, #23a3
$1c9c          3e 2e    MVI A, #2e
$1c9e o1c9e:   cd 60 0f CALL c0f60
$1ca1 j1ca1:   3a 5a 22 LDA $225a ;o1cde
$1ca4          f6 0f    ORI #0f
$1ca6          32 96 23 STA $2396
$1ca9          3a 7a 22 LDA $227a
$1cac          e6 f0    ANI #f0
$1cae          47       MOV B,A
$1caf          3a b6 23 LDA $23b6
$1cb2          e6 0f    ANI #0f
$1cb4          b0       ORA B
$1cb5          32 b6 23 STA $23b6
$1cb8 o1cb8:   c3 08 02 JMP j0208
$1cbb j1cbb:   21 a3 23 LXI H, #23a3 ;o1c93
$1cbe          0e 17    MVI C, #17
$1cc0          3e ff    MVI A, #ff
$1cc2 j1cc2:   77       MOV M,A ;o1cc5
$1cc3          23       INX H
$1cc4          0d       DCR C
$1cc5 o1cc5:   c2 c2 1c JNZ j1cc2
$1cc8          11 a9 23 LXI D, #23a9
$1ccb          21 28 22 LXI H, #2228
$1cce          3e 08    MVI A, #08
$1cd0 o1cd0:   cd 7b 0f CALL c0f7b
$1cd3          11 b3 23 LXI D, #23b3
$1cd6          21 2c 22 LXI H, #222c
$1cd9          3e 08    MVI A, #08
$1cdb o1cdb:   cd 7b 0f CALL c0f7b
$1cde o1cde:   c3 a1 1c JMP j1ca1
$1ce1 j1ce1:   3a 53 23 LDA $2353 ;o1c0a
$1ce4          47       MOV B,A
$1ce5          3a f8 23 LDA $23f8
$1ce8          90       SUB B
$1ce9 o1ce9:   f2 08 02 JP j0208
$1cec          21 92 21 LXI H, #2192
$1cef          3e 06    MVI A, #06
$1cf1 o1cf1:   cd e6 03 CALL c03e6
$1cf4 o1cf4:   ca fa 1c JZ j1cfa
$1cf7 o1cf7:   c3 08 02 JMP j0208
$1cfa j1cfa:   3a 7e 23 LDA $237e ;o1c42,o1cf4
$1cfd          32 9e 23 STA $239e
$1d00          3a ac 23 LDA $23ac
$1d03          32 8c 23 STA $238c
$1d06          06 30    MVI B, #30
$1d08 o1d08:   cd 82 1d CALL co1d82
$1d0b          3a 96 23 LDA $2396
$1d0e          e6 cf    ANI #cf
$1d10          32 96 23 STA $2396
$1d13          3a b6 23 LDA $23b6
$1d16          e6 cf    ANI #cf
$1d18          32 b6 23 STA $23b6
$1d1b          21 c2 21 LXI H, #21c2
$1d1e          3e 05    MVI A, #05
$1d20 o1d20:   cd ce 03 CALL c03ce
$1d23          3a c2 21 LDA $21c2
$1d26          2f       CMA
$1d27          d3 05    OUT #05
$1d29          3e 80    MVI A, #80
$1d2b          32 93 21 STA $2193
$1d2e          3e 06    MVI A, #06
$1d30          32 ac 21 STA $21ac
$1d33          3e 00    MVI A, #00
$1d35          32 94 21 STA $2194
$1d38          3a 90 21 LDA $2190
$1d3b          e6 30    ANI #30
$1d3d          f6 80    ORI #80
$1d3f          32 90 21 STA $2190
$1d42          3a 92 21 LDA $2192
$1d45          e6 67    ANI #67
$1d47          32 92 21 STA $2192
$1d4a          21 91 21 LXI H, #2191
$1d4d          3e 01    MVI A, #01
$1d4f o1d4f:   cd d9 03 CALL c03d9
$1d52          21 94 21 LXI H, #2194
$1d55          3e 04    MVI A, #04
$1d57 o1d57:   cd ce 03 CALL c03ce
$1d5a          3e 06    MVI A, #06
$1d5c          32 a8 21 STA $21a8
$1d5f          3e 05    MVI A, #05
$1d61          32 97 21 STA $2197
$1d64 o1d64:   c3 08 02 JMP j0208
$1d67          21 c2 21 LXI H, #21c2
$1d6a          3e 05    MVI A, #05
$1d6c o1d6c:   cd d9 03 CALL c03d9
$1d6f          f3       DI
$1d70          cd de 13 CALL $13de
$1d73          fb       EI
$1d74 o1d74:   c3 08 06 JMP jo0608
 
$1d77 co1d77:  cd a4 1d CALL c1da4 ;o0bbd,o0bfb,o0c13,o0c3b,o0d24,o0f26,o154a,o156d,o1578,o1b14,o1b19,o1b1e,o1b23,o1b28,o1b9d
$1d7a o1d7a:   cd ce 03 CALL c03ce
$1d7d          19       DAD D
$1d7e o1d7e:   cd ce 03 CALL c03ce
$1d81          c9       RET

 
$1d82 co1d82:  cd a4 1d CALL c1da4 ;o0501,o09c5,jo0ac1,o0c19,o0d14,o0d19,o0dc8,o0e4d,o1512,jo1573,o15f7,o1aa5,o1ac4,o1b2d,o1b32,o1b37,o1b3c,o1b5f,o1d08
$1d85 o1d85:   cd d9 03 CALL c03d9
$1d88          19       DAD D
$1d89 o1d89:   cd e6 03 CALL c03e6
$1d8c          f5       PUSH PSW
$1d8d o1d8d:   cd d9 03 CALL c03d9
$1d90          f1       POP PSW
$1d91          c9       RET

 
$1d92 co1d92:  cd a4 1d CALL c1da4 ;jo0afb,o15fc,o19a7,o1a87
$1d95 o1d95:   cd ce 03 CALL c03ce
$1d98          19       DAD D
$1d99 o1d99:   cd d9 03 CALL c03d9
$1d9c          c9       RET

 
$1d9d co1d9d:  cd a4 1d CALL c1da4 ;o0aea,o0bf3,o0c35,o0cb9,o0cdf,o0cec,o0cfe,o0e47,o155d,o1565,o15f1,o18e3,o1a48,o1a81,o1b97
$1da0 o1da0:   cd e6 03 CALL c03e6
$1da3          c9       RET

 
$1da4 c1da4:   21 c9 21 LXI H, #21c9 ;co1d77,co1d82,co1d92,co1d9d
$1da7          16 00    MVI D, #00
$1da9          78       MOV A,B
$1daa          e6 07    ANI #07
$1dac          5f       MOV E,A
$1dad          19       DAD D
$1dae          78       MOV A,B
$1daf          1f       RAR
$1db0          1f       RAR
$1db1          1f       RAR
$1db2          e6 07    ANI #07
$1db4          11 05 00 LXI D, #0005
$1db7          c9       RET

 
$1db8 c1db8:   21 63 23 LXI H, #2363 ;o1a43
$1dbb o1dbb:   cd e4 1f CALL c1fe4
$1dbe          21 6b 23 LXI H, #236b
$1dc1          e5       PUSH H
$1dc2 o1dc2:   cd a9 0e CALL c0ea9
$1dc5          e1       POP H
$1dc6 o1dc6:   d2 d5 1d JNC j1dd5
$1dc9          22 38 22 SHLD $2238
$1dcc          21 63 23 LXI H, #2363
$1dcf          22 3a 22 SHLD $223a
$1dd2 o1dd2:   c3 de 1d JMP j1dde
$1dd5 j1dd5:   22 3a 22 SHLD $223a ;o1dc6
$1dd8          21 63 23 LXI H, #2363
$1ddb          22 38 22 SHLD $2238
$1dde j1dde:   2a 38 22 LHLD $2238 ;o1dd2
$1de1 o1de1:   cd e4 1f CALL c1fe4
$1de4          21 5f 23 LXI H, #235f
$1de7          e5       PUSH H
$1de8 o1de8:   cd a9 0e CALL c0ea9
$1deb          e1       POP H
$1dec o1dec:   da 05 1e JC j1e05
$1def          e5       PUSH H
$1df0          2a 3a 22 LHLD $223a
$1df3 o1df3:   cd e4 1f CALL c1fe4
$1df6          e1       POP H
$1df7          e5       PUSH H
$1df8 o1df8:   cd a9 0e CALL c0ea9
$1dfb          e1       POP H
$1dfc o1dfc:   da 10 1e JC j1e10
$1dff          22 3c 22 SHLD $223c
$1e02 o1e02:   c3 18 1e JMP j1e18
$1e05 j1e05:   e5       PUSH H ;o1dec
$1e06 o1e06:   cd 6b 1e CALL c1e6b
$1e09          e1       POP H
$1e0a          22 38 22 SHLD $2238
$1e0d o1e0d:   c3 18 1e JMP j1e18
$1e10 j1e10:   e5       PUSH H ;o1dfc
$1e11 o1e11:   cd 6b 1e CALL c1e6b
$1e14          e1       POP H
$1e15          22 3a 22 SHLD $223a
$1e18 j1e18:   2a 38 22 LHLD $2238 ;o1e02,o1e0d
$1e1b o1e1b:   cd e4 1f CALL c1fe4
$1e1e          21 6f 23 LXI H, #236f
$1e21          e5       PUSH H
$1e22 o1e22:   cd a9 0e CALL c0ea9
$1e25          e1       POP H
$1e26 o1e26:   da 4f 1e JC j1e4f
$1e29          e5       PUSH H
$1e2a          2a 3a 22 LHLD $223a
$1e2d o1e2d:   cd e4 1f CALL c1fe4
$1e30          e1       POP H
$1e31          e5       PUSH H
$1e32 o1e32:   cd a9 0e CALL c0ea9
$1e35          e1       POP H
$1e36 o1e36:   da 5a 1e JC j1e5a
$1e39          e5       PUSH H
$1e3a          2a 3c 22 LHLD $223c
$1e3d o1e3d:   cd e4 1f CALL c1fe4
$1e40          e1       POP H
$1e41          e5       PUSH H
$1e42 o1e42:   cd a9 0e CALL c0ea9
$1e45          e1       POP H
$1e46 o1e46:   da 78 1e JC j1e78
$1e49          22 3e 22 SHLD $223e
$1e4c o1e4c:   c3 83 1e JMP j1e83
$1e4f j1e4f:   e5       PUSH H ;o1e26
$1e50 o1e50:   cd 65 1e CALL c1e65
$1e53          e1       POP H
$1e54          22 38 22 SHLD $2238
$1e57 o1e57:   c3 83 1e JMP j1e83
$1e5a j1e5a:   e5       PUSH H ;o1e36
$1e5b o1e5b:   cd 6b 1e CALL c1e6b
$1e5e          e1       POP H
$1e5f          22 3a 22 SHLD $223a
$1e62 o1e62:   c3 83 1e JMP j1e83
 
$1e65 c1e65:   2a 3c 22 LHLD $223c ;o1e50
$1e68          22 3e 22 SHLD $223e
 
$1e6b c1e6b:   2a 3a 22 LHLD $223a ;o1e06,o1e11,o1e5b
$1e6e          22 3c 22 SHLD $223c
$1e71          2a 38 22 LHLD $2238
$1e74          22 3a 22 SHLD $223a
$1e77          c9       RET

$1e78 j1e78:   e5       PUSH H ;o1e46
$1e79          2a 3c 22 LHLD $223c
$1e7c          22 3e 22 SHLD $223e
$1e7f          e1       POP H
$1e80          22 3c 22 SHLD $223c
$1e83 j1e83:   21 28 22 LXI H, #2228 ;o1e4c,o1e57,o1e62
$1e86 o1e86:   cd e4 1f CALL c1fe4
$1e89          2a 38 22 LHLD $2238
$1e8c          e5       PUSH H
$1e8d o1e8d:   cd a9 0e CALL c0ea9
$1e90          e1       POP H
$1e91 o1e91:   dc 5f 1f CC c1f5f
$1e94          d8       RC
$1e95          21 2c 22 LXI H, #222c
$1e98 o1e98:   cd e4 1f CALL c1fe4
$1e9b          2a 38 22 LHLD $2238
$1e9e          e5       PUSH H
$1e9f o1e9f:   cd a9 0e CALL c0ea9
$1ea2          e1       POP H
$1ea3 o1ea3:   dc 76 1f CC c1f76
$1ea6          d8       RC
$1ea7          21 30 22 LXI H, #2230
$1eaa o1eaa:   cd e4 1f CALL c1fe4
$1ead          2a 38 22 LHLD $2238
$1eb0          e5       PUSH H
$1eb1 o1eb1:   cd a9 0e CALL c0ea9
$1eb4          e1       POP H
$1eb5 o1eb5:   dc 8a 1f CC c1f8a
$1eb8          d8       RC
$1eb9          21 34 22 LXI H, #2234
$1ebc o1ebc:   cd e4 1f CALL c1fe4
$1ebf          2a 38 22 LHLD $2238
$1ec2          e5       PUSH H
$1ec3 o1ec3:   cd a9 0e CALL c0ea9
$1ec6          e1       POP H
$1ec7 o1ec7:   dc 9b 1f CC c1f9b
$1eca          c9       RET

$1ecb          21 2c 22 LXI H, #222c
$1ece o1ece:   cd e4 1f CALL c1fe4
$1ed1          2a 3a 22 LHLD $223a
$1ed4          e5       PUSH H
$1ed5 o1ed5:   cd a9 0e CALL c0ea9
$1ed8          e1       POP H
$1ed9 o1ed9:   dc 76 1f CC c1f76
$1edc          d8       RC
$1edd          21 30 22 LXI H, #2230
$1ee0 o1ee0:   cd e4 1f CALL c1fe4
$1ee3          2a 3a 22 LHLD $223a
$1ee6          e5       PUSH H
$1ee7 o1ee7:   cd a9 0e CALL c0ea9
$1eea          e1       POP H
$1eeb o1eeb:   dc 8a 1f CC c1f8a
$1eee          d8       RC
$1eef          21 34 22 LXI H, #2234
$1ef2 o1ef2:   cd e4 1f CALL c1fe4
$1ef5          2a 3a 22 LHLD $223a
$1ef8          e5       PUSH H
$1ef9 o1ef9:   cd a9 0e CALL c0ea9
$1efc          e1       POP H
$1efd o1efd:   dc 9b 1f CC c1f9b
$1f00          c9       RET

$1f01          21 30 22 LXI H, #2230
$1f04 o1f04:   cd e4 1f CALL c1fe4
$1f07          2a 3c 22 LHLD $223c
$1f0a          e5       PUSH H
$1f0b o1f0b:   cd a9 0e CALL c0ea9
$1f0e          e1       POP H
$1f0f o1f0f:   dc 8a 1f CC c1f8a
$1f12          d8       RC
$1f13          21 34 22 LXI H, #2234
$1f16 o1f16:   cd e4 1f CALL c1fe4
$1f19          2a 3c 22 LHLD $223c
$1f1c          e5       PUSH H
$1f1d o1f1d:   cd a9 0e CALL c0ea9
$1f20          e1       POP H
$1f21 o1f21:   dc 9b 1f CC c1f9b
$1f24          c9       RET

$1f25          21 34 22 LXI H, #2234
$1f28 o1f28:   cd e4 1f CALL c1fe4
$1f2b          2a 3e 22 LHLD $223e
$1f2e          e5       PUSH H
$1f2f o1f2f:   cd a9 0e CALL c0ea9
$1f32          e1       POP H
$1f33 o1f33:   dc 9b 1f CC c1f9b
$1f36          c9       RET

 
$1f37 c1f37:   f5       PUSH PSW ;o1f62,o1f79,o1f8d
$1f38          21 30 22 LXI H, #2230
$1f3b          e5       PUSH H
$1f3c          11 34 22 LXI D, #2234
$1f3f          3e 07    MVI A, #07
$1f41 o1f41:   cd 60 0f CALL c0f60
$1f44          d1       POP D
$1f45          f1       POP PSW
$1f46          3d       DCR A
$1f47          c8       RZ
$1f48          f5       PUSH PSW
$1f49          21 2c 22 LXI H, #222c
$1f4c          e5       PUSH H
$1f4d          3e 07    MVI A, #07
$1f4f o1f4f:   cd 60 0f CALL c0f60
$1f52          d1       POP D
$1f53          f1       POP PSW
$1f54          3d       DCR A
$1f55          c8       RZ
$1f56          21 28 22 LXI H, #2228
$1f59          3e 07    MVI A, #07
$1f5b o1f5b:   cd 60 0f CALL c0f60
$1f5e          c9       RET

 
$1f5f c1f5f:   e5       PUSH H ;o1e91
$1f60          3e 03    MVI A, #03
$1f62 o1f62:   cd 37 1f CALL c1f37
$1f65          e1       POP H
$1f66          11 28 22 LXI D, #2228
$1f69          3e 07    MVI A, #07
$1f6b o1f6b:   cd 60 0f CALL c0f60
$1f6e o1f6e:   cd a5 1f CALL c1fa5
$1f71 o1f71:   cd a5 1f CALL c1fa5
$1f74          3f       CMC
$1f75          c9       RET

 
$1f76 c1f76:   e5       PUSH H ;o1ea3,o1ed9
$1f77          3e 02    MVI A, #02
$1f79 o1f79:   cd 37 1f CALL c1f37
$1f7c          e1       POP H
$1f7d          11 2c 22 LXI D, #222c
$1f80          3e 07    MVI A, #07
$1f82 o1f82:   cd 60 0f CALL c0f60
$1f85 o1f85:   cd a5 1f CALL c1fa5
$1f88          3f       CMC
$1f89          c9       RET

 
$1f8a c1f8a:   e5       PUSH H ;o1eb5,o1eeb,o1f0f
$1f8b          3e 01    MVI A, #01
$1f8d o1f8d:   cd 37 1f CALL c1f37
$1f90          e1       POP H
$1f91          11 30 22 LXI D, #2230
$1f94          3e 07    MVI A, #07
$1f96 o1f96:   cd 60 0f CALL c0f60
$1f99          3f       CMC
$1f9a          c9       RET

 
$1f9b c1f9b:   11 34 22 LXI D, #2234 ;o1ec7,o1efd,o1f21,o1f33
$1f9e          3e 07    MVI A, #07
$1fa0 o1fa0:   cd 60 0f CALL c0f60
$1fa3          3f       CMC
$1fa4          c9       RET

 
$1fa5 c1fa5:   3a 7a 23 LDA CREDITS_1 ;o1f6e,o1f71,o1f85
$1fa8          fe 99    CPI #99
$1faa          c8       RZ
$1fab          b7       ORA A
$1fac          3c       INR A
$1fad          27       DAA
$1fae          32 7a 23 STA CREDITS_1
$1fb1          32 9a 23 STA CREDITS_2
$1fb4          32 ba 23 STA CREDITS_3
$1fb7          21 d4 13 LXI H, #13d4
$1fba o1fba:   cd e4 12 CALL c12e4
$1fbd          21 c4 13 LXI H, #13c4
$1fc0 o1fc0:   cd e4 12 CALL c12e4
$1fc3          c9       RET

 
$1fc4 c1fc4:   21 2c 22 LXI H, #222c ;o09eb
$1fc7          e5       PUSH H
$1fc8          11 28 22 LXI D, #2228
$1fcb          3e 07    MVI A, #07
$1fcd o1fcd:   cd 60 0f CALL c0f60
$1fd0          d1       POP D
$1fd1          21 30 22 LXI H, #2230
$1fd4          e5       PUSH H
$1fd5          3e 07    MVI A, #07
$1fd7 o1fd7:   cd 60 0f CALL c0f60
$1fda          d1       POP D
$1fdb          21 34 22 LXI H, #2234
$1fde          3e 07    MVI A, #07
$1fe0 o1fe0:   cd 60 0f CALL c0f60
$1fe3          c9       RET

 
$1fe4 c1fe4:   11 f3 21 LXI D, #21f3 ;o1dbb,o1de1,o1df3,o1e1b,o1e2d,o1e3d,o1e86,o1e98,o1eaa,o1ebc,o1ece,o1ee0,o1ef2,o1f04,o1f16,o1f28
$1fe7          3e 00    MVI A, #00
$1fe9          06 04    MVI B, #04
$1feb j1feb:   12       STAX D ;o1fee
$1fec          13       INX D
$1fed          05       DCR B
$1fee o1fee:   c2 eb 1f JNZ j1feb
$1ff1          11 f3 21 LXI D, #21f3
$1ff4          3e 07    MVI A, #07
$1ff6 o1ff6:   cd 60 0f CALL c0f60
$1ff9          3e 07    MVI A, #07
$1ffb          c9       RET

$1ffc          00       NOP
$1ffd          81       ADD C
$1ffe          e9       PCHL
$1fff          01 00 00 LXI B, #0000
