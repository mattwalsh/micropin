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
LEFT_SLING_TONE EQU 0x12b9
RIGHT_SLING_TONE EQU 0x12bc
SILENCE_END_LOOP_MUSIC EQU 0x12bf
TILT_MUSIC EQU 0x12c2
BONUS_MUSIC EQU 0x12c2
START_PLAYER_MUSIC EQU 0x12da
UNKNOWN_MUSIC EQU 0x12dd
LOW_MUSIC EQU 0x12e0
OOPS_MUSIC EQU 0x12e3
OOPS2_MUSIC EQU 0x12e8
LIL_VICTORY_MUSIC EQU 0x12ed
LIT_STANDUP_MUSIC EQU 0x12f2
GAME_OVER_MUSIC EQU 0x12ff
SPREAD_TAKEOVER_MUSIC EQU 0x1316
MORSE_CODE_MUSIC EQU 0x1321
BUMPER_25_MUSIC_2 EQU 0x12ad
BUMPER_25_MUSIC EQU 0x1332
SPREAD_HRM_MUSIC EQU 0x1335
LONGER_BUMPER_25_MUSIC EQU 0x1338
CREDIT_MUSIC EQU 0x1341
NEXT_PLAYER_MUSIC EQU 0x1346
OUTLANE_MUSIC EQU 0x134b
SILENCE_MUSIC EQU 0x134e
POPCORN_MUSIC EQU 0x136a
HIGH_SCORE_MUSIC EQU 0x1351

; INPUT PORTS
MYSTERY_PORT_1 EQU 0x1
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
LAMP_D EQU 0xd
LAMP_E EQU 0xe
LAMP_F EQU 0xf
$0000 o0000:   c3 40 00 JMP j0040
$0003 o0003:   cd b4 06 CALL jcCREDIT_HANDLER
$0006 o0006:   c3 82 03 JMP jo0382
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
$0024 o0024:   c3 69 00 JMP j0069
$0027          76       HLT
$0028          76       HLT
$0029          76       HLT
$002a          76       HLT
$002b          46       MOV B,M
; RST5.5
$002c o002c:   c3 30 03 JMP jo0330
; TRAP
$002f          76       HLT
$0030          76       HLT
$0031          76       HLT
$0032          76       HLT
$0033          00       NOP
; RST6.5
$0034 o0034:   c3 86 03 JMP joSWITCH_HANDLER
$0037          76       HLT
$0038          76       HLT
$0039          76       HLT
$003a          76       HLT
$003b o003b:   c2 c3 00 JNZ j00c3
$003e          28 76    (LDHI) #76
$0040 j0040:   3e 21    MVI A, #21 ;o0000
$0042          32 da 23 STA CREDITS_4
$0045          16 05    MVI D, #05
$0047 j0047:   21 10 27 LXI H, #2710 ;o0053
$004a j004a:   2b       DCX H ;o004f
$004b          d3 0f    OUT LAMP_F
$004d          7c       MOV A,H
$004e          b7       ORA A
$004f o004f:   c2 4a 00 JNZ j004a
$0052          15       DCR D
$0053 o0053:   c2 47 00 JNZ j0047
$0056          db 04    IN PRICE_89_CAB
$0058          e6 20    ANI #20
$005a o005a:   ca 69 00 JZ j0069
; hard reset routine
HARD_RESET          21 00 20 LXI H, #2000
$0060 j0060:   97       SUB A ;o0066
$0061          77       MOV M,A
$0062          23       INX H
$0063          3e 24    MVI A, #24
$0065          bc       CMP H
$0066 o0066:   c2 60 00 JNZ j0060
$0069 j0069:   31 90 21 LXI SP, GAME_STATE ;o0024,o005a
$006c          3e 07    MVI A, #07
$006e j006e:   d3 0e    OUT LAMP_E ;o0073
$0070          d3 0d    OUT LAMP_D
$0072          3d       DCR A
$0073 o0073:   f2 6e 00 JP j006e
$0076          21 97 21 LXI H, #2197
$0079          0e 2d    MVI C, #2d
$007b j007b:   97       SUB A ;o007f
$007c          77       MOV M,A
$007d          23       INX H
$007e          0d       DCR C
$007f o007f:   c2 7b 00 JNZ j007b
$0082          3e 05    MVI A, #05
$0084          32 00 00 STA $0000
$0087          3e fe    MVI A, #fe
$0089          d3 09    OUT TONE_ENABLE_DUR
$008b          3e 02    MVI A, #02
$008d          32 98 21 STA $2198
$0090          3e ff    MVI A, #ff
$0092          32 93 21 STA $2193
$0095          3e fc    MVI A, #fc
$0097          32 94 21 STA STATE_OUTLANE_1
$009a          21 fb 21 LXI H, #21fb
$009d          22 f9 21 SHLD $21f9
$00a0          21 b4 21 LXI H, #21b4
$00a3          22 be 21 SHLD $21be
$00a6          22 c0 21 SHLD $21c0
$00a9          3e 0f    MVI A, #0f
$00ab          32 f8 21 STA $21f8
$00ae          3a 90 21 LDA GAME_STATE
$00b1          f6 05    ORI #05
$00b3          32 90 21 STA GAME_STATE
$00b6          3e 0c    MVI A, #0c
$00b8          30       SIM
$00b9          db 04    IN PRICE_89_CAB
$00bb          e6 20    ANI #20
$00bd o00bd:   ca f5 00 JZ jo00f5
$00c0          21 81 11 LXI H, #1181
$00c3 j00c3:   11 2d 22 LXI D, HIGH_SCORE_START ;o003b
$00c6          3e 08    MVI A, #08
$00c8 o00c8:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$00cb          21 7d 11 LXI H, #117d
$00ce          11 31 22 LXI D, #2231
$00d1          3e 08    MVI A, #08
$00d3 o00d3:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$00d6          3e 71    MVI A, #71
$00d8          32 9f 21 STA $219f
$00db          3e 3c    MVI A, #3c
$00dd          32 1f 22 STA $221f
$00e0          3e 00    MVI A, #00
$00e2          32 20 22 STA $2220
$00e5          32 21 22 STA $2221
$00e8          3e 04    MVI A, #04
$00ea          32 22 22 STA $2222
$00ed          3e 64    MVI A, #64
$00ef          32 4a 22 STA $224a
$00f2 o00f2:   c3 fb 00 JMP j00fb
$00f5 jo00f5:  cd 17 03 CALL co0317 ;o00bd
$00f8 o00f8:   ca 43 01 JZ j0143
$00fb j00fb:   3e 07    MVI A, #07 ;o00f2
$00fd          32 c2 21 STA $21c2
$0100          2f       CMA
$0101          d3 05    OUT COIL_5
$0103          3e 06    MVI A, #06
$0105          32 a6 21 STA $21a6
$0108 j0108:   fb       EI ;o010d
$0109          3a a6 21 LDA $21a6
$010c          b7       ORA A
$010d o010d:   c2 08 01 JNZ j0108
$0110          3e 28    MVI A, #28
$0112          32 c2 21 STA $21c2
$0115          2f       CMA
$0116          d3 05    OUT COIL_5
$0118          3e 20    MVI A, #20
$011a          32 c4 21 STA $21c4
$011d          2f       CMA
$011e          d3 07    OUT COIL_7
$0120          3e 02    MVI A, #02
$0122          32 c5 21 STA $21c5
$0125          2f       CMA
$0126          d3 08    OUT COIL_8
$0128          3e 06    MVI A, #06
$012a          32 a6 21 STA $21a6
$012d j012d:   fb       EI ;o0132
$012e          3a a6 21 LDA $21a6
$0131          b7       ORA A
$0132 o0132:   c2 2d 01 JNZ j012d
$0135          3e ff    MVI A, #ff
$0137          d3 05    OUT COIL_5
$0139          d3 06    OUT COIL_6
$013b          d3 07    OUT COIL_7
$013d          d3 08    OUT COIL_8
$013f          f3       DI
$0140 o0140:   cd 7d 13 CALL jc137d
$0143 j0143:   db 04    IN PRICE_89_CAB ;o00f8,o0300
$0145          e6 20    ANI #20
$0147 o0147:   c2 68 01 JNZ jo0168
$014a          3a 92 21 LDA GAME_STATE2
$014d          3e d0    MVI A, #d0
$014f          32 92 21 STA GAME_STATE2
$0152          db 03    IN PRICE_TENS_07_PORT
$0154          fe fe    CPI #fe
$0156 o0156:   c2 bf 01 JNZ j01bf
$0159          db 02    IN PRICE_CENTS_07_PORT
$015b          fe fb    CPI #fb
$015d o015d:   ca 9e 02 JZ j029e
$0160          fe f7    CPI #f7
$0162 o0162:   ca c8 02 JZ j02c8
$0165 o0165:   c3 bf 01 JMP j01bf
$0168 jo0168:  cd a8 17 CALL c17a8 ;o0147,o02c5
$016b          3e d0    MVI A, #d0
$016d          32 92 21 STA GAME_STATE2
$0170          3e 00    MVI A, #00
$0172          32 7e 23 STA $237e
$0175          32 9e 23 STA $239e
$0178          32 be 23 STA $23be
$017b          32 7a 23 STA CREDITS_1
$017e          32 9a 23 STA CREDITS_2
$0181          32 ba 23 STA CREDITS_3
$0184          3e 0f    MVI A, #0f
$0186          32 7b 23 STA BALL_IN_PLAY_hrm
$0189          32 9b 23 STA BALL_IN_PLAY_1
$018c          32 bb 23 STA BALL_IN_PLAY_2
$018f          32 96 23 STA $2396
$0192          32 b6 23 STA $23b6
$0195          21 a3 23 LXI H, #23a3
$0198          11 20 23 LXI D, #2320
$019b          3e 2e    MVI A, #2e
$019d o019d:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$01a0          06 01    MVI B, #01
$01a2          11 c6 21 LXI D, #21c6
$01a5 o01a5:   cd 8e 17 CALL jc178e
$01a8          21 c9 21 LXI H, #21c9
$01ab          11 ce 21 LXI D, #21ce
$01ae          3e 0a    MVI A, #0a
$01b0 o01b0:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$01b3          21 05 22 LXI H, #2205
$01b6          06 13    MVI B, #13
$01b8          97       SUB A
$01b9 j01b9:   77       MOV M,A ;o01bc
$01ba          23       INX H
$01bb          05       DCR B
$01bc o01bc:   c2 b9 01 JNZ j01b9
$01bf j01bf:   f3       DI ;o0156,o0165,o02a4
$01c0          3e 30    MVI A, #30
$01c2          32 94 21 STA STATE_OUTLANE_1
$01c5          3a 92 21 LDA GAME_STATE2
$01c8          e6 80    ANI #80
$01ca o01ca:   c2 d2 01 JNZ j01d2
$01cd          3e 00    MVI A, #00
$01cf          32 92 21 STA GAME_STATE2
$01d2 j01d2:   db 02    IN PRICE_CENTS_07_PORT ;o01ca,o1c45,o1c4b,o1c54,o1c70
$01d4          2f       CMA
$01d5          6f       MOV L,A
; read in the ones place
$01d6          db 04    IN PRICE_89_CAB
$01d8          2f       CMA
$01d9          e6 03    ANI #03
$01db          67       MOV H,A
$01dc          06 0f    MVI B, #0f
$01de j01de:   29       DAD H ;o01e3
$01df o01df:   da e6 01 JC j01e6
$01e2          05       DCR B
$01e3 o01e3:   c2 de 01 JNZ j01de
$01e6 j01e6:   db 03    IN PRICE_TENS_07_PORT ;o01df
$01e8          2f       CMA
$01e9          6f       MOV L,A
; read in the dimes place
$01ea          db 04    IN PRICE_89_CAB
$01ec          2f       CMA
$01ed          e6 0c    ANI #0c
$01ef          1f       RAR
$01f0          1f       RAR
$01f1          67       MOV H,A
$01f2          0e 0f    MVI C, #0f
$01f4 j01f4:   29       DAD H ;o01f9
$01f5 o01f5:   da fc 01 JC j01fc
$01f8          0d       DCR C
$01f9 o01f9:   c2 f4 01 JNZ j01f4
$01fc j01fc:   79       MOV A,C ;o01f5
$01fd          17       RAL
$01fe          17       RAL
$01ff          17       RAL
$0200          17       RAL
$0201          e6 f0    ANI #f0
$0203          80       ADD B
$0204          32 7f 23 STA PRICE_1
$0207          32 9f 23 STA PRICE_2
$020a          32 bf 23 STA PRICE_3
$020d          fb       EI
; load dip switches, set # balls per game
$020e          db 05    IN DIP_SWITCH_PORT
$0210          21 16 22 LXI H, DIP_SWITCHES
$0213          77       MOV M,A
$0214          06 03    MVI B, #03
$0216          3e 00    MVI A, #00
$0218 o0218:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$021b o021b:   c2 28 02 JNZ j0228
$021e          04       INR B
$021f          3e 01    MVI A, #01
$0221 o0221:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0224 o0224:   c2 28 02 JNZ j0228
$0227          04       INR B
$0228 j0228:   78       MOV A,B ;o021b,o0224
$0229          32 13 22 STA BALLS_PER_GAME
$022c j022c:   d3 0f    OUT LAMP_F ;o028f,o1c7b,o1cc0,o1ccb,o1cd9,o1d63
$022e          fb       EI
$022f          00       NOP
$0230          fb       EI
$0231          00       NOP
$0232          fb       EI
$0233          00       NOP
$0234          f3       DI
$0235          3a c2 21 LDA $21c2
$0238          2f       CMA
$0239          d3 05    OUT COIL_5
$023b          3a c3 21 LDA $21c3
$023e          2f       CMA
$023f          d3 06    OUT COIL_6
$0241          3a c4 21 LDA $21c4
$0244          2f       CMA
$0245          d3 07    OUT COIL_7
$0247          3a c5 21 LDA $21c5
$024a          2f       CMA
$024b          d3 08    OUT COIL_8
$024d          fb       EI
$024e          00       NOP
$024f          fb       EI
$0250          00       NOP
$0251          fb       EI
$0252          00       NOP
$0253          f3       DI
$0254          2a f9 21 LHLD $21f9
$0257          11 fb 21 LXI D, #21fb
$025a          7d       MOV A,L
$025b          93       SUB E
$025c o025c:   ca 7b 02 JZ j027b
$025f o025f:   fa 67 02 JM j0267
$0262          fe 08    CPI #08
$0264 o0264:   da 70 02 JC j0270
$0267 j0267:   21 fb 21 LXI H, #21fb ;o025f
$026a          22 f9 21 SHLD $21f9
$026d o026d:   c3 7b 02 JMP j027b
$0270 j0270:   2b       DCX H ;o0264
$0271          7e       MOV A,M
$0272          2b       DCX H
$0273          22 f9 21 SHLD $21f9
$0276          6e       MOV L,M
$0277          67       MOV H,A
$0278 o0278:   cd 3c 0f CALL c0f3c
$027b j027b:   fb       EI ;o025c,o026d
$027c          21 92 21 LXI H, GAME_STATE2
$027f          3e 07    MVI A, #07
$0281 o0281:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0284 o0284:   c2 b9 1b JNZ j1bb9
$0287          3a b6 23 LDA $23b6
$028a          e6 bf    ANI #bf
$028c          32 b6 23 STA $23b6
$028f o028f:   c3 2c 02 JMP j022c
 
$0292 cADD_BONUS_HL:
               eb       XCHG ;o07c8,o0ce8,o0dc5,o0dd4,o14b7,o15ca,o18d9
$0293          2a f9 21 LHLD $21f9
$0296          73       MOV M,E
$0297          23       INX H
$0298          72       MOV M,D
$0299          23       INX H
$029a          22 f9 21 SHLD $21f9
$029d          c9       RET

$029e j029e:   3a 91 21 LDA $2191 ;o015d
$02a1          47       MOV B,A
$02a2          e6 01    ANI #01
$02a4 o02a4:   c2 bf 01 JNZ j01bf
$02a7          78       MOV A,B
$02a8          f6 01    ORI #01
$02aa          32 91 21 STA $2191
$02ad          f3       DI
$02ae          3e 30    MVI A, #30
$02b0          32 94 21 STA STATE_OUTLANE_1
$02b3          3e 7d    MVI A, #7d
$02b5          32 9f 21 STA $219f
$02b8          3e 3c    MVI A, #3c
$02ba          32 1f 22 STA $221f
$02bd          3e 00    MVI A, #00
$02bf          32 20 22 STA $2220
$02c2          32 21 22 STA $2221
$02c5 o02c5:   c3 68 01 JMP jo0168
$02c8 j02c8:   f3       DI ;o0162
$02c9          21 c0 23 LXI H, #23c0
$02cc          06 0c    MVI B, #0c
$02ce j02ce:   36 88    MVI M, #88 ;o02d2
$02d0          23       INX H
$02d1          05       DCR B
$02d2 o02d2:   c2 ce 02 JNZ j02ce
$02d5          36 f8    MVI M, #f8
$02d7          23       INX H
$02d8          06 09    MVI B, #09
$02da j02da:   36 88    MVI M, #88 ;o02de
$02dc          23       INX H
$02dd          05       DCR B
$02de o02de:   c2 da 02 JNZ j02da
$02e1          36 f8    MVI M, #f8
$02e3          23       INX H
$02e4          06 07    MVI B, #07
$02e6 j02e6:   36 88    MVI M, #88 ;o02ea
$02e8          23       INX H
$02e9          05       DCR B
$02ea o02ea:   c2 e6 02 JNZ j02e6
$02ed          36 ff    MVI M, #ff
$02ef          23       INX H
$02f0          36 88    MVI M, #88
$02f2          3e 00    MVI A, #00
$02f4          d3 00    OUT LAMP_0
$02f6          d3 01    OUT LAMP_1
$02f8          d3 02    OUT LAMP_2
$02fa          d3 03    OUT LAMP_3
$02fc          d3 04    OUT LAMP_4
$02fe          d3 0f    OUT LAMP_F
$0300 o0300:   c3 43 01 JMP j0143
 
$0303 c0303:   11 3b 23 LXI D, #233b ;co0317,o13b5
$0306          01 00 00 LXI B, #0000
$0309          21 00 00 LXI H, #0000
$030c j030c:   1a       LDAX D ;o0313
$030d          4f       MOV C,A
$030e          09       DAD B
$030f          13       INX D
$0310          7b       MOV A,E
$0311          fe 5d    CPI #5d
$0313 o0313:   c2 0c 03 JNZ j030c
$0316          c9       RET

 
$0317 co0317:  cd 03 03 CALL c0303 ;jo00f5
$031a          eb       XCHG
$031b          2a 24 22 LHLD $2224
$031e          7b       MOV A,E
$031f          bd       CMP L
$0320          c0       RNZ
$0321          b7       ORA A
$0322 o0322:   ca 28 03 JZ j0328
$0325 j0325:   7a       MOV A,D ;o032a
$0326          bc       CMP H
$0327          c9       RET

$0328 j0328:   7a       MOV A,D ;o0322
$0329          b7       ORA A
$032a o032a:   c2 25 03 JNZ j0325
$032d          3c       INR A
$032e          c9       RET

$032f          2d       DCR L
$0330 jo0330:  cd 24 06 CALL cSAVE_BDPSW ;o002c
$0333          3a 90 21 LDA GAME_STATE
$0336          f6 80    ORI #80
$0338          32 90 21 STA GAME_STATE
$033b          db 01    IN MYSTERY_PORT_1
$033d          11 00 00 LXI D, #0000
$0340 j0340:   b7       ORA A ;o0349
$0341 o0341:   ca 82 03 JZ jo0382
$0344          1f       RAR
$0345 o0345:   da 4c 03 JC j034c
$0348          1c       INR E
$0349 o0349:   c3 40 03 JMP j0340
$034c j034c:   7b       MOV A,E ;o0345
$034d          2f       CMA
$034e          d3 0e    OUT LAMP_E
$0350          2f       CMA
$0351          21 93 21 LXI H, #2193
$0354 o0354:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0357 o0357:   c2 82 03 JNZ jo0382
$035a o035a:   cd 24 06 CALL cSAVE_BDPSW
$035d          3a 91 21 LDA $2191
$0360          e6 02    ANI #02
$0362 o0362:   c4 02 04 CNZ c0402
$0365 o0365:   cd 30 06 CALL cRESTORE_BDPSW
$0368 o0368:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$036b          eb       XCHG
$036c          29       DAD H
$036d          11 b6 03 LXI D, #03b6
$0370          19       DAD D
$0371          7e       MOV A,M
$0372          23       INX H
$0373          66       MOV H,M
$0374          6f       MOV L,A
$0375          e9       PCHL
$0376 j0376:   21 94 21 LXI H, STATE_OUTLANE_1 ;o0606,o13e7,o178b
$0379 o0379:   c3 7f 03 JMP jo037f
$037c          21 93 21 LXI H, #2193
$037f jo037f:  cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL ;o0379
; vector to 0630 stack restore
$0382 jo0382:  cd 30 06 CALL cRESTORE_BDPSW ;o0006,o0341,o0357,o038f,o03a5,o0486,o0540,o0549,o078c,o07cb,o084f,o0865,o086d,o0921,o092a
$0385          c9       RET

$0386 joSWITCH_HANDLER:
               cd 24 06 CALL cSAVE_BDPSW ;o0034
$0389          11 00 00 LXI D, #0000
$038c          db 00    IN #00
$038e j038e:   b7       ORA A ;o0397
$038f o038f:   ca 82 03 JZ jo0382
$0392          1f       RAR
$0393 o0393:   da 9a 03 JC j039a
$0396          1c       INR E
$0397 o0397:   c3 8e 03 JMP j038e
$039a j039a:   7b       MOV A,E ;o0393
$039b          2f       CMA
$039c          d3 0d    OUT LAMP_D
$039e          2f       CMA
$039f          21 94 21 LXI H, STATE_OUTLANE_1
$03a2 o03a2:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$03a5 o03a5:   c2 82 03 JNZ jo0382
$03a8 o03a8:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$03ab          eb       DB #eb
$03ac          29       DB #29
$03ad          11       DB #11
$03ae          c6       DB #c6
$03af          03       DB #03
$03b0          19       DB #19
$03b1          7e       DB #7e
$03b2          23       DB #23
$03b3          66       DB #66
$03b4          6f       DB #6f
$03b5          e9       DB #e9
$03b6          60       DB #60
$03b7          07       DB #07
$03b8          66       DB #66
$03b9          07       DB #07
$03ba          6c       DB #6c
$03bb          07       DB #07
$03bc          72       DB #72
$03bd          07       DB #07
$03be          78       DB #78
$03bf          07       DB #07
$03c0          7e       DB #7e
$03c1          07       DB #07
$03c2          84       DB #84
$03c3          07       DB #07
$03c4          82       DB #82
$03c5          03       DB #03
$03c6          d9       DB #d9
$03c7          05       DB #05
$03c8          bc       DB #bc
$03c9          13       DB #13
$03ca          03       DB #03
$03cb          00       DB #00
$03cc          7b       DB #7b
$03cd          04       DB #04
; left flipper vector
$03ce          37       DB #37
$03cf          08       DB #08
$03d0          09       DB #09
$03d1          09       DB #09
$03d2          fb       DB #fb
$03d3          15       DB #15
$03d4          7b       DB #7b
$03d5          04       DB #04
 
$03d6 cSET_ATH_BIT_OF_HL:
               c5       PUSH B ;o0368,o03a8,o0410,o052e,o06cb,o079f,o09c0,o09cf,o09f6,o0aa1,o0af2,o0b55,o0c98,o0c9e,o0d52,jo1078,jo10ad,o11f8,o1213,o1283,o13c1,o13fb,o1499,o1568,o15c4,o1657,o170a,jo1738,jo174e,o184b,o1853,o19a3,o19dc,jo1a98,o1aab,o1b6c,o1c42,o1c7e,o1d1f,o1d56,o1d79,o1d7d,o1d94
$03d7          47       MOV B,A
$03d8 o03d8:   cd f9 03 CALL c2_LSHIFT_A
$03db          4e       MOV C,M
$03dc          b1       ORA C
$03dd          77       MOV M,A
$03de o03de:   c3 f6 03 JMP j03f6
 
$03e1 cCLEAR_ATH_BIT_OF_HL:
               c5       PUSH B ;jo037f,o0423,o06bd,o06d8,o06de,o06e4,o0716,o088b,o0948,o09e7,jo09fc,o0a4d,o0a5b,o0ba4,o0bb4,jo107d,o10ba,o10bf,jo1222,jo1255,o1382,o13e1,o13f1,jo1402,o14ae,o1541,o15e9,o16a7,o1923,jo1955,o199d,o1abf,o1acc,jo1c48,o1c6a,o1d4e,o1d6b,o1d84,o1d8c,o1d98
$03e2          47       MOV B,A
$03e3 o03e3:   cd f9 03 CALL c2_LSHIFT_A
$03e6          2f       CMA
$03e7          4f       MOV C,A
$03e8          7e       MOV A,M
$03e9          a1       ANA C
$03ea          77       MOV M,A
$03eb o03eb:   c3 f6 03 JMP j03f6
 
$03ee cCHECK_ATH_BIT_OF_HL:
               c5       PUSH B ;o0218,o0221,o0281,o0354,o03a2,o0409,o05b2,o06b9,o0710,o07f8,o084c,o0862,o0875,o0880,o091e,o0932,o093d,o09c5,o09e1,o0a0b,o0a47,o0a55,o0b13,o0b49,o0bec,o0cd6,o0f49,o0f50,o0f57,o0faa,o1071,o10a6,o120b,o1227,o127f,o13d9,o13f5,o149e,o14a8,o153b,o1546,o1557,o1562,o158d,o15be,o15db,o15e3,o1600,o1642,o164a,o16fa,o1702,o17f7,o180d,o186d,jo1949,o195c,o19c4,o1c78,o1cd3,o1d88,o1d9f
$03ef          47       MOV B,A
$03f0 o03f0:   cd f9 03 CALL c2_LSHIFT_A
$03f3          4f       MOV C,A
$03f4          7e       MOV A,M
$03f5          a1       ANA C
$03f6 j03f6:   78       MOV A,B ;o03de,o03eb
$03f7          c1       POP B
$03f8          c9       RET

 
$03f9 c2_LSHIFT_A:
               4f       MOV C,A ;o03d8,o03e3,o03f0
$03fa          3e 01    MVI A, #01
$03fc j03fc:   0d       DCR C ;o03ff
$03fd          f8       RM
$03fe          87       ADD A
$03ff o03ff:   c3 fc 03 JMP j03fc
 
$0402 c0402:   3a 11 22 LDA $2211 ;o0362,o0b4c,o157f
$0405          47       MOV B,A
$0406 o0406:   cd 27 04 CALL c0427
$0409 o0409:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$040c o040c:   ca 13 04 JZ j0413
$040f          eb       XCHG
$0410 o0410:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$0413 j0413:   78       MOV A,B ;o040c
$0414          3c       INR A
$0415          fe 05    CPI #05
$0417 o0417:   c2 1c 04 JNZ j041c
$041a          3e 00    MVI A, #00
$041c j041c:   32 11 22 STA $2211 ;o0417
$041f o041f:   cd 27 04 CALL c0427
$0422          eb       XCHG
$0423 o0423:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$0426          c9       RET

 
$0427 c0427:   16 00    MVI D, #00 ;o0406,o041f
$0429          5f       MOV E,A
$042a          21 40 04 LXI H, #0440
$042d          19       DAD D
$042e          7e       MOV A,M
$042f          21 45 04 LXI H, #0445
$0432          eb       XCHG
$0433          29       DAD H
$0434          19       DAD D
$0435          4e       MOV C,M
$0436          23       INX H
$0437          66       MOV H,M
$0438          69       MOV L,C
$0439          11 05 00 LXI D, #0005
$043c          eb       XCHG
$043d          19       DAD D
$043e          eb       XCHG
$043f          c9       RET

; unreachable or data or computed call?
$0440          04       DB #04
$0441          00       DB #00
$0442          01       DB #01
$0443          02       DB #02
$0444          05       DB #05
$0445          cd       DB #cd
$0446          21       DB #21
$0447          cc       DB #cc
$0448          21       DB #21
$0449          cc       DB #cc
$044a          21       DB #21
$044b          cc       DB #cc
$044c          21       DB #21
$044d          ca       DB #ca
$044e          21       DB #21
 
$044f cTILT_HELPER:
               3a 90 21 LDA GAME_STATE ;oTILT_HANDLER,o0591
$0452          f6 05    ORI #05
$0454          32 90 21 STA GAME_STATE
$0457          3e 00    MVI A, #00
$0459          32 0c 22 STA $220c
$045c          3e ff    MVI A, #ff
$045e          32 93 21 STA $2193
$0461          3a 94 21 LDA STATE_OUTLANE_1
$0464          f6 30    ORI #30
$0466          32 94 21 STA STATE_OUTLANE_1
$0469          c9       RET

 
$046a c046a:   3a 92 21 LDA GAME_STATE2 ;o0483,o058b
$046d          e6 40    ANI #40
$046f          c8       RZ
$0470          3a 7a 23 LDA CREDITS_1
$0473          b7       ORA A
$0474 o0474:   ca 79 04 JZ j0479
$0477          bf       CMP A
$0478          c9       RET

$0479 j0479:   3d       DCR A ;o0474
$047a          c9       RET

$047b oTILT_HANDLER:
               cd 4f 04 CALL cTILT_HELPER
$047e          3e 7d    MVI A, #7d
$0480          32 a2 21 STA $21a2
$0483 o0483:   cd 6a 04 CALL c046a
$0486 o0486:   c2 82 03 JNZ jo0382
$0489          3e fa    MVI A, #fa
$048b          32 9e 21 STA $219e
$048e          3a b6 23 LDA $23b6
$0491          f6 10    ORI #10
$0493          32 b6 23 STA $23b6
$0496          3e ff    MVI A, #ff
$0498          32 80 23 STA $2380
$049b          32 81 23 STA $2381
$049e          32 82 23 STA $2382
$04a1          3a 3f 23 LDA $233f
$04a4          c6 08    ADI #08
$04a6          47       MOV B,A
$04a7          3a e4 23 LDA $23e4
$04aa          90       SUB B
$04ab o04ab:   fa 43 05 JM jTILT2
$04ae          3a 92 21 LDA GAME_STATE2
$04b1          e6 40    ANI #40
$04b3 o04b3:   c2 43 05 JNZ jTILT2
$04b6          3a 94 21 LDA STATE_OUTLANE_1
$04b9          f6 fc    ORI #fc
$04bb          32 94 21 STA STATE_OUTLANE_1
$04be          3a 47 22 LDA $2247
$04c1          f6 40    ORI #40
$04c3          32 47 22 STA $2247
$04c6          3e ff    MVI A, #ff
$04c8          21 c0 23 LXI H, #23c0
$04cb          06 20    MVI B, #20
$04cd j04cd:   77       MOV M,A ;o04d0
$04ce          23       INX H
$04cf          05       DCR B
$04d0 o04d0:   c2 cd 04 JNZ j04cd
$04d3          d3 00    OUT LAMP_0
$04d5          d3 01    OUT LAMP_1
$04d7          d3 02    OUT LAMP_2
$04d9          d3 03    OUT LAMP_3
$04db          d3 04    OUT LAMP_4
$04dd          d3 05    OUT COIL_5
$04df          d3 06    OUT COIL_6
$04e1          d3 07    OUT COIL_7
$04e3          d3 08    OUT COIL_8
$04e5          3e 00    MVI A, #00
$04e7          3e 0f    MVI A, #0f
$04e9          32 cc 23 STA $23cc
$04ec          32 d6 23 STA $23d6
$04ef          32 de 23 STA $23de
$04f2          3a 90 21 LDA GAME_STATE
$04f5          e6 f7    ANI #f7
$04f7          32 90 21 STA GAME_STATE
$04fa          3a 96 23 LDA $2396
$04fd          e6 df    ANI #df
$04ff          32 96 23 STA $2396
$0502          3a b6 23 LDA $23b6
$0505          e6 df    ANI #df
$0507          32 b6 23 STA $23b6
$050a          06 30    MVI B, #30
$050c o050c:   cd 81 1d CALL co1d81
$050f          3e d0    MVI A, #d0
$0511          32 92 21 STA GAME_STATE2
$0514          3a 13 22 LDA BALLS_PER_GAME
$0517          32 7b 23 STA BALL_IN_PLAY_hrm
$051a          21 7e 23 LXI H, #237e
$051d          7e       MOV A,M
$051e          e6 0f    ANI #0f
$0520          77       MOV M,A
$0521          06 ff    MVI B, #ff
$0523 j0523:   1f       RAR ;o0528
$0524 o0524:   d2 2b 05 JNC j052b
$0527          04       INR B
$0528 o0528:   c3 23 05 JMP j0523
$052b j052b:   78       MOV A,B ;o0524
$052c          c6 04    ADI #04
$052e o052e:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$0531          3e 01    MVI A, #01
$0533          32 14 22 STA $2214
$0536          3e 28    MVI A, #28
$0538          32 1b 22 STA $221b
$053b          3e 02    MVI A, #02
$053d          32 9d 21 STA $219d
$0540 o0540:   c3 82 03 JMP jo0382
$0543 jTILT2:  21 c2 12 LXI H, BONUS_MUSIC ;o04ab,o04b3
$0546 o0546:   cd 61 12 CALL cPLAY_SOUND
$0549 o0549:   c3 82 03 JMP jo0382
$054c          3a 1b 22 LDA $221b
$054f          3d       DCR A
$0550          32 1b 22 STA $221b
$0553 o0553:   ca 69 05 JZ j0569
$0556          3e 14    MVI A, #14
$0558          32 9d 21 STA $219d
$055b          3e fa    MVI A, #fa
$055d          32 9e 21 STA $219e
$0560          21 bf 12 LXI H, SILENCE_END_LOOP_MUSIC
$0563 o0563:   cd 61 12 CALL cPLAY_SOUND
$0566 o0566:   c3 1e 06 JMP joEND_MAIN_LOOP
$0569 j0569:   3a 47 22 LDA $2247 ;o0553
$056c          e6 bf    ANI #bf
$056e          32 47 22 STA $2247
$0571          3e 01    MVI A, #01
$0573          32 a0 21 STA $21a0
$0576          32 1c 22 STA $221c
$0579          3a 94 21 LDA STATE_OUTLANE_1
$057c          e6 33    ANI #33
$057e          32 94 21 STA STATE_OUTLANE_1
$0581 o0581:   c3 1e 06 JMP joEND_MAIN_LOOP
; tilt handler 2
$0584          db 04    IN PRICE_89_CAB
$0586          e6 80    ANI #80
$0588 o0588:   ca a2 05 JZ j05a2
$058b o058b:   cd 6a 04 CALL c046a
$058e o058e:   c2 a2 05 JNZ j05a2
$0591 o0591:   cd 4f 04 CALL cTILT_HELPER
$0594          3e 7d    MVI A, #7d
$0596          32 a2 21 STA $21a2
$0599          21 c2 12 LXI H, BONUS_MUSIC
$059c o059c:   cd 61 12 CALL cPLAY_SOUND
$059f o059f:   c3 1e 06 JMP joEND_MAIN_LOOP
$05a2 j05a2:   3a 94 21 LDA STATE_OUTLANE_1 ;o0588,o058e
$05a5          e6 77    ANI #77
$05a7          32 94 21 STA STATE_OUTLANE_1
$05aa o05aa:   c3 1e 06 JMP joEND_MAIN_LOOP
$05ad          21 92 21 LXI H, GAME_STATE2
$05b0          3e 07    MVI A, #07
$05b2 o05b2:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$05b5 o05b5:   ca 1e 06 JZ joEND_MAIN_LOOP
$05b8          3a b6 23 LDA $23b6
$05bb          e6 ef    ANI #ef
$05bd          32 b6 23 STA $23b6
$05c0          3e f0    MVI A, #f0
$05c2          32 a0 23 STA $23a0
$05c5          32 80 23 STA $2380
$05c8          3e ff    MVI A, #ff
$05ca          32 a1 23 STA $23a1
$05cd          32 81 23 STA $2381
$05d0          32 a2 23 STA $23a2
$05d3          32 82 23 STA $2382
$05d6 o05d6:   c3 1e 06 JMP joEND_MAIN_LOOP
; when no switches activated?
$05d9          21 97 21 LXI H, #2197
$05dc          0e 1a    MVI C, #1a
$05de j05de:   3e ff    MVI A, #ff ;o05ea
$05e0          86       ADD M
$05e1 o05e1:   d2 e8 05 JNC j05e8
$05e4          77       MOV M,A
$05e5 o05e5:   ca 09 06 JZ j0609
$05e8 j05e8:   23       INX H ;o05e1,o0621
$05e9          0d       DCR C
$05ea o05ea:   c2 de 05 JNZ j05de
$05ed          3a 98 21 LDA $2198
$05f0          b7       ORA A
$05f1 o05f1:   c2 f6 05 JNZ j05f6
$05f4          3e 01    MVI A, #01
$05f6 j05f6:   e6 3f    ANI #3f ;o05f1
$05f8          32 98 21 STA $2198
$05fb          3a 47 22 LDA $2247
$05fe          e6 40    ANI #40
$0600 o0600:   cc 36 06 CZ c0636
$0603          3e 00    MVI A, #00
$0605          f3       DI
$0606 o0606:   c3 76 03 JMP j0376
$0609 j0609:   f3       DI ;o05e5
$060a o060a:   cd 24 06 CALL cSAVE_BDPSW
$060d          3e 1a    MVI A, #1a
$060f          91       SUB C
$0610          87       ADD A
$0611          11 00 00 LXI D, #0000
$0614          5f       MOV E,A
$0615          21 2c 07 LXI H, #072c
$0618          19       DAD D
$0619          7e       MOV A,M
$061a          23       INX H
$061b          66       MOV H,M
$061c          6f       MOV L,A
$061d          e9       PCHL
$061e joEND_MAIN_LOOP:
               cd 30 06 CALL cRESTORE_BDPSW ;o0566,o0581,o059f,o05aa,o05b5,o05d6,o071e,o0729,o07e8,o07f0,o07fb,o0803,o0883,o088e,o08a1,o08c8,o08da,o08f1,o0906,o0940,o094b,o095e,o0a6d,o0a90,o0aa9,o0abb,o0ae9,o0b4f,o0ba7,o0bb7,o0cc1,o0cf6,o0d26,o0de9,o121f,o123e,o1252,o125e,o14f7,o152b,o18e7,o1911,o1a37,o1a6e,o1a87,o1ad4,o1aec,jo1ba5,o1d73
$0621 o0621:   c3 e8 05 JMP j05e8
; push A, SP, B, D, H
 
$0624 cSAVE_BDPSW:
               22 95 21 SHLD STACK_SCRATCH ;jo0330,o035a,joSWITCH_HANDLER,o060a,o1406
$0627          e3       XTHL
$0628          c5       PUSH B
$0629          d5       PUSH D
$062a          f5       PUSH PSW
$062b          e5       PUSH H
$062c          2a 95 21 LHLD STACK_SCRATCH
$062f          c9       RET

; restore A, SP, B, D, H
 
$0630 cRESTORE_BDPSW:
               e1       POP H ;o0365,jo0382,joEND_MAIN_LOOP,jo1419
$0631          f1       POP PSW
$0632          d1       POP D
$0633          c1       POP B
$0634          e3       XTHL
$0635          c9       RET

 
$0636 c0636:   21 f8 21 LXI H, #21f8 ;o0600
$0639          35       DCR M
$063a o063a:   c2 47 06 JNZ j0647
$063d          36 14    MVI M, #14
$063f          3a 47 22 LDA $2247
$0642          c6 80    ADI #80
$0644          32 47 22 STA $2247
$0647 j0647:   3a 47 22 LDA $2247 ;o063a
$064a          e6 80    ANI #80
$064c o064c:   ca 7b 06 JZ j067b
$064f          21 a0 23 LXI H, #23a0
$0652          11 c0 23 LXI D, #23c0
$0655          3e 40    MVI A, #40
$0657 oLAMP_COPY:
               cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$065a          3a c9 21 LDA $21c9
$065d          2f       CMA
$065e          d3 00    OUT LAMP_0
$0660          3a ca 21 LDA $21ca
$0663          2f       CMA
$0664          d3 01    OUT LAMP_1
$0666          3a cb 21 LDA $21cb
$0669          2f       CMA
$066a          d3 02    OUT LAMP_2
$066c          3a cc 21 LDA $21cc
$066f          2f       CMA
$0670          d3 03    OUT LAMP_3
$0672          3a cd 21 LDA $21cd
$0675          2f       CMA
$0676          d3 04    OUT LAMP_4
$0678 o0678:   c3 a4 06 JMP j06a4
$067b j067b:   21 80 23 LXI H, #2380 ;o064c
$067e          11 c0 23 LXI D, #23c0
$0681          3e 40    MVI A, #40
$0683 o0683:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$0686          3a ce 21 LDA $21ce
$0689          2f       CMA
$068a          d3 00    OUT LAMP_0
$068c          3a cf 21 LDA $21cf
$068f          2f       CMA
$0690          d3 01    OUT LAMP_1
$0692          3a d0 21 LDA $21d0
$0695          2f       CMA
$0696          d3 02    OUT LAMP_2
$0698          3a d1 21 LDA $21d1
$069b          2f       CMA
$069c          d3 03    OUT LAMP_3
$069e          3a d2 21 LDA $21d2
$06a1          2f       CMA
$06a2          d3 04    OUT LAMP_4
; check credit button
$06a4 j06a4:   db 04    IN PRICE_89_CAB ;o0678
$06a6          e6 10    ANI #10
$06a8 o06a8:   c2 b4 06 JNZ jcCREDIT_HANDLER
$06ab          3a 92 21 LDA GAME_STATE2
$06ae          f6 20    ORI #20
$06b0          32 92 21 STA GAME_STATE2
$06b3          c9       RET

 
$06b4 jcCREDIT_HANDLER:
               21 92 21 LXI H, GAME_STATE2 ;o0003,o06a8
$06b7          3e 05    MVI A, #05
$06b9 o06b9:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$06bc          c8       RZ
$06bd o06bd:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$06c0          3a 7a 23 LDA CREDITS_1
$06c3          fe 99    CPI #99
$06c5          c8       RZ
$06c6          21 c5 21 LXI H, #21c5
$06c9          3e 03    MVI A, #03
$06cb o06cb:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$06ce          3e 09    MVI A, #09
$06d0          32 ab 21 STA $21ab
 
$06d3 c06d3:   3e 06    MVI A, #06 ;jo1a71
$06d5          21 76 23 LXI H, #2376
$06d8 o06d8:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$06db          21 96 23 LXI H, #2396
$06de o06de:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$06e1          21 b6 23 LXI H, #23b6
$06e4 o06e4:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$06e7          06 00    MVI B, #00
$06e9 o06e9:   cd 81 1d CALL co1d81
$06ec          3a 7a 23 LDA CREDITS_1
$06ef          3c       INR A
$06f0          27       DAA
$06f1          32 7a 23 STA CREDITS_1
$06f4          32 9a 23 STA CREDITS_2
$06f7          32 ba 23 STA CREDITS_3
$06fa          21 41 13 LXI H, CREDIT_MUSIC
$06fd o06fd:   cd 61 12 CALL cPLAY_SOUND
$0700          21 4a 22 LXI H, #224a
$0703          35       DCR M
$0704          c0       RNZ
$0705          36 64    MVI M, #64
$0707 o0707:   cd aa 1f CALL c1faa
$070a          c9       RET

$070b          21 c5 21 LXI H, #21c5
$070e          3e 03    MVI A, #03
$0710 o0710:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0713 o0713:   ca 21 07 JZ j0721
$0716 o0716:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$0719          3e 09    MVI A, #09
$071b          32 ab 21 STA $21ab
$071e o071e:   c3 1e 06 JMP joEND_MAIN_LOOP
$0721 j0721:   3a 94 21 LDA STATE_OUTLANE_1 ;o0713
$0724          e6 bb    ANI #bb
$0726          32 94 21 STA STATE_OUTLANE_1
$0729 o0729:   c3 1e 06 JMP joEND_MAIN_LOOP
$072c          aa       XRA D
$072d          0b       DCX B
$072e          06 12    MVI B, #12
$0730          ce 07    ACI #07
$0732          1e 06    MVI E, #06
$0734          2a 0a 70 LHLD $700a
$0737          0a       LDAX B
$0738          4c       MOV C,H
$0739          05       DCR B
$073a          ad       XRA L
$073b          05       DCR B
$073c          a4       ANA H
$073d          08       (DSUB)
$073e          02       STAX B
$073f          19       DAD D
$0740          d7       RST 2
$0741          1a       LDAX D
$0742          84       DB #84
$0743          05       DB #05
$0744          62       MOV H,D
$0745          1a       LDAX D
$0746          d5       PUSH D
$0747          14       INR D
$0748          be       CMP M
$0749          0a       LDAX B
$074a          8f       ADC A
$074b          0b       DCX B
$074c          ae       XRA M
$074d          0c       INR C
$074e          70       MOV M,B
$074f          08       (DSUB)
$0750          2d       DCR L
$0751          09       DAD B
$0752          1e 06    MVI E, #06
$0754          0b       DCX B
$0755          07       RLC
$0756          66       MOV H,M
$0757          1d       DCR E
$0758          f3       DI
$0759          07       RLC
$075a          cd 18 9d CALL $9d18
$075d          0d       DCR C
$075e          1e 06    MVI E, #06
$0760          11 00 00 LXI D, #0000
$0763 o0763:   c3 8f 07 JMP j078f
$0766          11 01 00 LXI D, #0001
$0769 o0769:   c3 8f 07 JMP j078f
$076c          11 02 00 LXI D, #0002
$076f o076f:   c3 8f 07 JMP j078f
$0772          11 03 00 LXI D, #0003
$0775 o0775:   c3 8f 07 JMP j078f
$0778          11 04 00 LXI D, #0004
$077b o077b:   c3 8f 07 JMP j078f
$077e          11 05 00 LXI D, #0005
$0781 o0781:   c3 8f 07 JMP j078f
$0784          3a 91 21 LDA $2191
$0787          f6 20    ORI #20
$0789          32 91 21 STA $2191
$078c o078c:   c3 82 03 JMP jo0382
$078f j078f:   21 06 08 LXI H, #0806 ;o0763,o0769,o076f,o0775,o077b,o0781
$0792          19       DAD D
$0793          7e       MOV A,M
$0794          eb       XCHG
$0795          29       DAD H
$0796          eb       XCHG
$0797          21 0d 08 LXI H, #080d
$079a          19       DAD D
$079b          46       MOV B,M
$079c          23       INX H
$079d          66       MOV H,M
$079e          68       MOV L,B
$079f o079f:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$07a2          3e 09    MVI A, #09
$07a4          32 99 21 STA $2199
$07a7          3a c3 21 LDA $21c3
$07aa          2f       CMA
$07ab          d3 06    OUT COIL_6
$07ad          3a c4 21 LDA $21c4
$07b0          2f       CMA
$07b1          d3 07    OUT COIL_7
$07b3          21 1b 08 LXI H, #081b
$07b6          19       DAD D
$07b7          46       MOV B,M
$07b8          23       INX H
$07b9          66       MOV H,M
$07ba          68       MOV L,B
$07bb          d5       PUSH D
; computed sound?
$07bc o07bc:   cd 61 12 CALL cPLAY_SOUND
$07bf          d1       POP D
$07c0          21 29 08 LXI H, #0829
$07c3          19       DAD D
$07c4          46       MOV B,M
$07c5          23       INX H
$07c6          66       MOV H,M
$07c7          68       MOV L,B
$07c8 o07c8:   cd 92 02 CALL cADD_BONUS_HL
$07cb o07cb:   c3 82 03 JMP jo0382
$07ce          3a c3 21 LDA $21c3
$07d1          e6 30    ANI #30
$07d3          32 c3 21 STA $21c3
$07d6          2f       CMA
$07d7          d3 06    OUT COIL_6
$07d9          3a c4 21 LDA $21c4
$07dc          e6 20    ANI #20
$07de          32 c4 21 STA $21c4
$07e1          2f       CMA
$07e2          d3 07    OUT COIL_7
$07e4          3a ad 21 LDA $21ad
$07e7          b7       ORA A
$07e8 o07e8:   c2 1e 06 JNZ joEND_MAIN_LOOP
$07eb          3e 06    MVI A, #06
$07ed          32 ad 21 STA $21ad
$07f0 o07f0:   c3 1e 06 JMP joEND_MAIN_LOOP
$07f3          21 90 21 LXI H, GAME_STATE
$07f6          3e 02    MVI A, #02
$07f8 o07f8:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$07fb o07fb:   c2 1e 06 JNZ joEND_MAIN_LOOP
$07fe          3e 80    MVI A, #80
$0800          32 93 21 STA $2193
$0803 o0803:   c3 1e 06 JMP joEND_MAIN_LOOP
$0806          03       INX B
$0807          00       NOP
$0808          01 02 03 LXI B, #0302
$080b          04       INR B
$080c          02       STAX B
$080d          c3 21 c4 JMP $c421
$0810          21 c4 21 LXI H, #21c4
$0813          c3 21 c4 JMP $c421
$0816          21 c4 21 LXI H, #21c4
$0819          c4       DB #c4
$081a          21       DB #21
$081b          ad       DB #ad
$081c          12       DB #12
$081d          b0       DB #b0
$081e          12       DB #12
$081f          b3       DB #b3
$0820          12       DB #12
$0821          b6       DB #b6
$0822          12       DB #12
$0823          b9       DB #b9
$0824          12       DB #12
$0825          bc       DB #bc
$0826          12       DB #12
$0827          bf       DB #bf
$0828          12       DB #12
$0829          55       DB #55
$082a          11       DB #11
$082b          59       DB #59
$082c          11       DB #11
$082d          5d       DB #5d
$082e          11       DB #11
$082f          51       DB #51
$0830          11       DB #11
$0831          4d       DB #4d
$0832          11       DB #11
$0833          4d       DB #4d
$0834          11       DB #11
$0835          49       DB #49
$0836          11       DB #11
; left flipper
$0837          3a c3 21 LDA $21c3
$083a          f6 10    ORI #10
$083c          32 c3 21 STA $21c3
$083f          2f       CMA
$0840          d3 06    OUT COIL_6
$0842          3e 09    MVI A, #09
$0844          32 a8 21 STA $21a8
$0847          21 90 21 LXI H, GAME_STATE
$084a          3e 05    MVI A, #05
$084c o084c:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$084f o084f:   c2 82 03 JNZ jo0382
$0852          21 4e 13 LXI H, SILENCE_MUSIC
$0855 o0855:   cd 61 12 CALL cPLAY_SOUND
$0858          3e 04    MVI A, #04
$085a          32 22 22 STA $2222
$085d          21 91 21 LXI H, #2191
$0860          3e 00    MVI A, #00
$0862 o0862:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0865 o0865:   ca 82 03 JZ jo0382
$0868          3e 7d    MVI A, #7d
$086a          32 9f 21 STA $219f
$086d o086d:   c3 82 03 JMP jo0382
$0870          21 c3 21 LXI H, #21c3
$0873          3e 04    MVI A, #04
$0875 o0875:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0878 o0878:   c2 91 08 JNZ j0891
$087b          21 90 21 LXI H, GAME_STATE
$087e          3e 02    MVI A, #02
$0880 o0880:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0883 o0883:   c2 1e 06 JNZ joEND_MAIN_LOOP
$0886          3e 04    MVI A, #04
$0888          21 94 21 LXI H, STATE_OUTLANE_1
$088b o088b:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$088e o088e:   c3 1e 06 JMP joEND_MAIN_LOOP
; right flipper
$0891 j0891:   3a c3 21 LDA $21c3 ;o0878
$0894          e6 2f    ANI #2f
$0896          32 c3 21 STA $21c3
$0899          2f       CMA
$089a          d3 06    OUT COIL_6
$089c          3e 06    MVI A, #06
$089e          32 a8 21 STA $21a8
$08a1 o08a1:   c3 1e 06 JMP joEND_MAIN_LOOP
$08a4          3a 91 21 LDA $2191
$08a7          e6 01    ANI #01
$08a9 o08a9:   ca bc 08 JZ j08bc
$08ac          3a c3 21 LDA $21c3
$08af          f6 30    ORI #30
$08b1          32 c3 21 STA $21c3
$08b4          3e 09    MVI A, #09
$08b6          32 a8 21 STA $21a8
$08b9          32 a9 21 STA $21a9
$08bc j08bc:   3e 71    MVI A, #71 ;o08a9
$08be          32 9f 21 STA $219f
$08c1          3a 1f 22 LDA $221f
$08c4          3d       DCR A
$08c5          32 1f 22 STA $221f
$08c8 o08c8:   c2 1e 06 JNZ joEND_MAIN_LOOP
$08cb          3e 3c    MVI A, #3c
$08cd          32 1f 22 STA $221f
$08d0          3a 20 22 LDA $2220
$08d3          3c       INR A
$08d4          27       DAA
$08d5          32 20 22 STA $2220
$08d8          fe 60    CPI #60
$08da o08da:   c2 1e 06 JNZ joEND_MAIN_LOOP
$08dd          3e 00    MVI A, #00
$08df          32 20 22 STA $2220
$08e2          3a 21 22 LDA $2221
$08e5          3c       INR A
$08e6          27       DAA
$08e7          32 21 22 STA $2221
$08ea          3a 22 22 LDA $2222
$08ed          3d       DCR A
$08ee          32 22 22 STA $2222
$08f1 o08f1:   c2 1e 06 JNZ joEND_MAIN_LOOP
$08f4 o08f4:   cd aa 1f CALL c1faa
$08f7          3e 64    MVI A, #64
$08f9          32 4a 22 STA $224a
$08fc          3e 04    MVI A, #04
$08fe          32 22 22 STA $2222
$0901          3e 00    MVI A, #00
$0903          32 9f 21 STA $219f
$0906 o0906:   c3 1e 06 JMP joEND_MAIN_LOOP
$0909          3a c3 21 LDA $21c3
$090c          f6 20    ORI #20
$090e          32 c3 21 STA $21c3
$0911          2f       CMA
$0912          d3 06    OUT COIL_6
$0914          3e 09    MVI A, #09
$0916          32 a9 21 STA $21a9
$0919          21 90 21 LXI H, GAME_STATE
$091c          3e 05    MVI A, #05
$091e o091e:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0921 o0921:   c2 82 03 JNZ jo0382
$0924          21 4e 13 LXI H, SILENCE_MUSIC
$0927 o0927:   cd 61 12 CALL cPLAY_SOUND
$092a o092a:   c3 82 03 JMP jo0382
$092d          21 c3 21 LXI H, #21c3
$0930          3e 05    MVI A, #05
$0932 o0932:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0935 o0935:   c2 4e 09 JNZ j094e
$0938          21 90 21 LXI H, GAME_STATE
$093b          3e 02    MVI A, #02
$093d o093d:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0940 o0940:   c2 1e 06 JNZ joEND_MAIN_LOOP
$0943          21 94 21 LXI H, STATE_OUTLANE_1
$0946          3e 05    MVI A, #05
$0948 o0948:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$094b o094b:   c3 1e 06 JMP joEND_MAIN_LOOP
$094e j094e:   3a c3 21 LDA $21c3 ;o0935
$0951          e6 1f    ANI #1f
$0953          32 c3 21 STA $21c3
$0956          2f       CMA
$0957          d3 06    OUT COIL_6
$0959          3e 06    MVI A, #06
$095b          32 a9 21 STA $21a9
$095e o095e:   c3 1e 06 JMP joEND_MAIN_LOOP
$0961          06 24    MVI B, #24
$0963          0e 00    MVI C, #00
$0965 o0965:   c3 99 09 JMP j0999
$0968          06 03    MVI B, #03
$096a          0e 01    MVI C, #01
$096c o096c:   c3 99 09 JMP j0999
$096f          06 0b    MVI B, #0b
$0971          0e 02    MVI C, #02
$0973 o0973:   c3 99 09 JMP j0999
$0976          06 13    MVI B, #13
$0978          0e 03    MVI C, #03
$097a o097a:   c3 99 09 JMP j0999
$097d          06 29    MVI B, #29
$097f          0e 04    MVI C, #04
$0981 o0981:   c3 99 09 JMP j0999
$0984          3e 04    MVI A, #04
$0986          32 97 21 STA $2197
$0989          21 08 22 LXI H, #2208
$098c          3e ff    MVI A, #ff
$098e          86       ADD M
$098f o098f:   d2 ae 09 JNC j09ae
$0992          77       MOV M,A
$0993 o0993:   ca df 0b JZ j0bdf
$0996 o0996:   c3 19 14 JMP jo1419
$0999 j0999:   21 08 22 LXI H, #2208 ;o0965,o096c,o0973,o097a,o0981
$099c          3e ff    MVI A, #ff
$099e          86       ADD M
$099f o099f:   d2 ae 09 JNC j09ae
$09a2          77       MOV M,A
$09a3 o09a3:   ca bb 09 JZ j09bb
$09a6          3e 04    MVI A, #04
$09a8          32 97 21 STA $2197
$09ab o09ab:   c3 19 14 JMP jo1419
$09ae j09ae:   3e 64    MVI A, #64 ;o098f,o099f
$09b0          32 08 22 STA $2208
$09b3          3e 04    MVI A, #04
$09b5          32 97 21 STA $2197
$09b8 o09b8:   c3 19 14 JMP jo1419
$09bb j09bb:   21 90 21 LXI H, GAME_STATE ;o09a3
$09be          3e 07    MVI A, #07
$09c0 o09c0:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$09c3          3e 02    MVI A, #02
$09c5 o09c5:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$09c8 o09c8:   ca da 09 JZ jo09da
$09cb          79       MOV A,C
$09cc o09cc:   cd 6f 0b CALL c0b6f
$09cf o09cf:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$09d2          3e 06    MVI A, #06
$09d4          32 a6 21 STA $21a6
$09d7 o09d7:   c3 19 14 JMP jo1419
$09da jo09da:  cd 81 1d CALL co1d81 ;o09c8
$09dd          79       MOV A,C
$09de          21 c7 21 LXI H, #21c7
$09e1 o09e1:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$09e4 o09e4:   ca 52 0b JZ jo0b52
$09e7 o09e7:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$09ea          21 11 22 LXI H, #2211
$09ed          be       CMP M
$09ee          21 92 21 LXI H, GAME_STATE2
$09f1          3e 01    MVI A, #01
$09f3 o09f3:   c2 fc 09 JNZ jo09fc
$09f6 o09f6:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$09f9 o09f9:   c3 ff 09 JMP j09ff
$09fc jo09fc:  cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL ;o09f3
$09ff j09ff:   79       MOV A,C ;o09f9
$0a00 o0a00:   cd 6f 0b CALL c0b6f
$0a03 o0a03:   cd 9c 1d CALL co1d9c
$0a06 o0a06:   ca 14 0a JZ jo0a14
$0a09          eb       XCHG
$0a0a          19       DAD D
$0a0b o0a0b:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0a0e          eb       XCHG
$0a0f          3e 01    MVI A, #01
$0a11 o0a11:   ca 24 0a JZ j0a24
$0a14 jo0a14:  cd 91 1d CALL co1d91 ;o0a06
$0a17          21 e3 12 LXI H, OOPS_MUSIC
$0a1a o0a1a:   cd 61 12 CALL cPLAY_SOUND
$0a1d          3e c8    MVI A, #c8
$0a1f          32 08 22 STA $2208
$0a22          3e 5a    MVI A, #5a
$0a24 j0a24:   32 9b 21 STA $219b ;o0a11
$0a27 o0a27:   c3 19 14 JMP jo1419
$0a2a          21 d5 0b LXI H, #0bd5
$0a2d          3a c8 21 LDA $21c8
$0a30          87       ADD A
$0a31          16 00    MVI D, #00
$0a33          5f       MOV E,A
$0a34          19       DAD D
$0a35          7e       MOV A,M
$0a36          23       INX H
$0a37          66       MOV H,M
$0a38          6f       MOV L,A
$0a39 o0a39:   cd 5c 0e CALL c0e5c
$0a3c          21 dd 12 LXI H, UNKNOWN_MUSIC
$0a3f o0a3f:   cd 61 12 CALL cPLAY_SOUND
$0a42          21 92 21 LXI H, GAME_STATE2
$0a45          3e 01    MVI A, #01
$0a47 o0a47:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0a4a o0a4a:   ca 93 0a JZ j0a93
$0a4d o0a4d:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$0a50          21 91 21 LXI H, #2191
$0a53          3e 01    MVI A, #01
$0a55 o0a55:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0a58 o0a58:   ca 93 0a JZ j0a93
$0a5b o0a5b:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$0a5e          3e fa    MVI A, #fa
$0a60          32 08 22 STA $2208
$0a63          3e 05    MVI A, #05
$0a65          32 1a 22 STA $221a
$0a68          3e 28    MVI A, #28
$0a6a          32 9c 21 STA $219c
$0a6d o0a6d:   c3 1e 06 JMP joEND_MAIN_LOOP
$0a70          21 71 11 LXI H, #1171
$0a73 o0a73:   cd 5c 0e CALL c0e5c
$0a76          21 35 13 LXI H, SPREAD_HRM_MUSIC
$0a79 o0a79:   cd 61 12 CALL cPLAY_SOUND
$0a7c          3a 1a 22 LDA $221a
$0a7f          3d       DCR A
$0a80          32 1a 22 STA $221a
$0a83 o0a83:   ca 93 0a JZ j0a93
$0a86          3e 28    MVI A, #28
$0a88          32 9c 21 STA $219c
$0a8b          3e fa    MVI A, #fa
$0a8d          32 08 22 STA $2208
$0a90 o0a90:   c3 1e 06 JMP joEND_MAIN_LOOP
$0a93 j0a93:   3a c7 21 LDA $21c7 ;o0a4a,o0a58,o0a83
$0a96          fe 00    CPI #00
$0a98 o0a98:   ca ac 0a JZ j0aac
$0a9b          2a 09 22 LHLD $2209
$0a9e          3a 0b 22 LDA $220b
$0aa1 o0aa1:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$0aa4          3e 06    MVI A, #06
$0aa6          32 a6 21 STA $21a6
$0aa9 o0aa9:   c3 1e 06 JMP joEND_MAIN_LOOP
$0aac j0aac:   3e 3c    MVI A, #3c ;o0a98
$0aae          32 a5 21 STA $21a5
$0ab1          3e 64    MVI A, #64
$0ab3          32 08 22 STA $2208
$0ab6          3e 00    MVI A, #00
$0ab8          32 07 22 STA $2207
$0abb o0abb:   c3 1e 06 JMP joEND_MAIN_LOOP
$0abe          97       SUB A
$0abf          32 08 22 STA $2208
$0ac2          3a 07 22 LDA $2207
$0ac5          3c       INR A
$0ac6          32 07 22 STA $2207
$0ac9          fe 06    CPI #06
$0acb o0acb:   ca ec 0a JZ j0aec
$0ace          16 00    MVI D, #00
$0ad0          5f       MOV E,A
$0ad1          21 b9 0b LXI H, #0bb9
$0ad4          19       DAD D
$0ad5          46       MOV B,M
$0ad6 o0ad6:   cd 76 1d CALL co1d76
$0ad9          21 dd 12 LXI H, UNKNOWN_MUSIC
$0adc o0adc:   cd 61 12 CALL cPLAY_SOUND
$0adf          3e 0f    MVI A, #0f
$0ae1          32 a5 21 STA $21a5
$0ae4          3e 64    MVI A, #64
$0ae6          32 08 22 STA $2208
$0ae9 o0ae9:   c3 1e 06 JMP joEND_MAIN_LOOP
$0aec j0aec:   2a 09 22 LHLD $2209 ;o0acb
$0aef          3a 0b 22 LDA $220b
$0af2 o0af2:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$0af5          3e 06    MVI A, #06
$0af7          32 a6 21 STA $21a6
$0afa          3e 1f    MVI A, #1f
$0afc          32 c7 21 STA $21c7
$0aff          3a 46 22 LDA $2246
$0b02          87       ADD A
$0b03          87       ADD A
$0b04          87       ADD A
$0b05          87       ADD A
$0b06          47       MOV B,A
$0b07          3a be 23 LDA $23be
$0b0a          a0       ANA B
$0b0b o0b0b:   c2 26 0b JNZ j0b26
$0b0e          21 90 21 LXI H, GAME_STATE
$0b11          3e 03    MVI A, #03
$0b13 o0b13:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0b16 o0b16:   c2 26 0b JNZ j0b26
$0b19          06 31    MVI B, #31
$0b1b o0b1b:   cd 9c 1d CALL co1d9c
$0b1e o0b1e:   c2 26 0b JNZ j0b26
$0b21          06 09    MVI B, #09
$0b23 o0b23:   cd 76 1d CALL co1d76
$0b26 j0b26:   3a c8 21 LDA $21c8 ;o0b0b,o0b16,o0b1e
$0b29          3c       INR A
$0b2a          fe 05    CPI #05
$0b2c o0b2c:   ca 44 0b JZ j0b44
$0b2f          32 c8 21 STA $21c8
$0b32          16 00    MVI D, #00
$0b34          5f       MOV E,A
$0b35          21 be 0b LXI H, #0bbe
$0b38          19       DAD D
$0b39          46       MOV B,M
$0b3a          e5       PUSH H
$0b3b o0b3b:   cd 76 1d CALL co1d76
$0b3e          e1       POP H
$0b3f          2b       DCX H
$0b40          46       MOV B,M
$0b41 o0b41:   cd 81 1d CALL co1d81
$0b44 j0b44:   21 91 21 LXI H, #2191 ;o0b2c
$0b47          3e 01    MVI A, #01
$0b49 o0b49:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0b4c o0b4c:   c4 02 04 CNZ c0402
$0b4f o0b4f:   c3 1e 06 JMP joEND_MAIN_LOOP
$0b52 jo0b52:  cd 6f 0b CALL c0b6f ;o09e4
$0b55 o0b55:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$0b58          3e 06    MVI A, #06
$0b5a          32 a6 21 STA $21a6
$0b5d o0b5d:   cd 9c 1d CALL co1d9c
$0b60 o0b60:   c2 19 14 JNZ jo1419
$0b63 o0b63:   cd 76 1d CALL co1d76
$0b66          21 e0 12 LXI H, LOW_MUSIC
$0b69 o0b69:   cd 61 12 CALL cPLAY_SOUND
$0b6c o0b6c:   c3 19 14 JMP jo1419
 
$0b6f c0b6f:   16 00    MVI D, #00 ;o09cc,o0a00,jo0b52
$0b71          5f       MOV E,A
$0b72          21 c3 0b LXI H, #0bc3
$0b75          19       DAD D
$0b76          46       MOV B,M
$0b77          21 c8 0b LXI H, #0bc8
$0b7a          19       DAD D
$0b7b          87       ADD A
$0b7c          5f       MOV E,A
$0b7d          7e       MOV A,M
$0b7e          32 0b 22 STA $220b
$0b81          4f       MOV C,A
$0b82          21 cd 0b LXI H, #0bcd
$0b85          19       DAD D
$0b86          7e       MOV A,M
$0b87          23       INX H
$0b88          66       MOV H,M
$0b89          6f       MOV L,A
$0b8a          22 09 22 SHLD $2209
$0b8d          79       MOV A,C
$0b8e          c9       RET

$0b8f          3e 00    MVI A, #00
$0b91          32 c2 21 STA $21c2
$0b94          3a c4 21 LDA $21c4
$0b97          e6 1f    ANI #1f
$0b99          32 c4 21 STA $21c4
$0b9c          2f       CMA
$0b9d          d3 07    OUT COIL_7
$0b9f          21 c5 21 LXI H, #21c5
$0ba2          3e 01    MVI A, #01
$0ba4 o0ba4:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$0ba7 o0ba7:   c3 1e 06 JMP joEND_MAIN_LOOP
$0baa          3e 00    MVI A, #00
$0bac          32 08 22 STA $2208
$0baf          21 92 21 LXI H, GAME_STATE2
$0bb2          3e 03    MVI A, #03
$0bb4 o0bb4:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$0bb7 o0bb7:   c3 1e 06 JMP joEND_MAIN_LOOP
$0bba          24       INR H
$0bbb          03       INX B
$0bbc          0b       DCX B
$0bbd          13       INX D
$0bbe          29       DAD H
$0bbf          23       INX H
$0bc0          1c       INR E
$0bc1          1b       DCX D
$0bc2          12       STAX D
$0bc3          2b       DCX H
$0bc4          2c       INR L
$0bc5          04       INR B
$0bc6          0c       INR C
$0bc7          14       INR D
$0bc8          03       INX B
$0bc9          05       DCR B
$0bca          02       STAX B
$0bcb          00       NOP
$0bcc          01 c2 21 LXI B, #21c2
$0bcf          c4 21 c2 CNZ $c221
$0bd2          21 c2 21 LXI H, #21c2
$0bd5          c2 21 69 JNZ $6921
$0bd8          11 6d 11 LXI D, #116d
$0bdb          75       MOV M,L
$0bdc          11 79 11 LXI D, #1179
$0bdf j0bdf:   06 39    MVI B, #39 ;o0993
$0be1 o0be1:   cd 9c 1d CALL co1d9c
$0be4 o0be4:   ca 4d 0d JZ j0d4d
$0be7          21 90 21 LXI H, GAME_STATE
$0bea          3e 02    MVI A, #02
$0bec o0bec:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0bef o0bef:   c2 4d 0d JNZ j0d4d
$0bf2          3a 0c 22 LDA $220c
$0bf5          e6 03    ANI #03
$0bf7 o0bf7:   c2 a6 0c JNZ j0ca6
$0bfa          21 5b 23 LXI H, #235b
$0bfd          11 0d 22 LXI D, #220d
$0c00          3e 06    MVI A, #06
$0c02 o0c02:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$0c05          06 38    MVI B, #38
$0c07 o0c07:   cd 9c 1d CALL co1d9c
$0c0a o0c0a:   ca 12 0c JZ j0c12
$0c0d          3e 03    MVI A, #03
$0c0f o0c0f:   c3 21 0c JMP j0c21
$0c12 j0c12:   06 11    MVI B, #11 ;o0c0a
$0c14 o0c14:   cd 9c 1d CALL co1d9c
$0c17 o0c17:   ca 1f 0c JZ j0c1f
$0c1a          3e 02    MVI A, #02
$0c1c o0c1c:   c3 21 0c JMP j0c21
$0c1f j0c1f:   3e 01    MVI A, #01 ;o0c17
$0c21 j0c21:   32 0c 22 STA $220c ;o0c0f,o0c1c
$0c24          06 31    MVI B, #31
$0c26 o0c26:   cd 9c 1d CALL co1d9c
$0c29 o0c29:   ca a6 0c JZ j0ca6
$0c2c          06 31    MVI B, #31
$0c2e o0c2e:   cd 81 1d CALL co1d81
$0c31          06 09    MVI B, #09
$0c33 o0c33:   cd 81 1d CALL co1d81
$0c36          21 21 13 LXI H, MORSE_CODE_MUSIC
$0c39 o0c39:   cd 61 12 CALL cPLAY_SOUND
$0c3c          21 8a 23 LXI H, #238a
$0c3f          3a be 23 LDA $23be
$0c42          e6 f0    ANI #f0
$0c44          4f       MOV C,A
$0c45          1e 04    MVI E, #04
$0c47          06 4f    MVI B, #4f
$0c49          fe 80    CPI #80
$0c4b o0c4b:   ca 77 0c JZ j0c77
$0c4e          23       INX H
$0c4f          1e 03    MVI E, #03
$0c51          06 03    MVI B, #03
$0c53          7e       MOV A,M
$0c54          e6 f0    ANI #f0
$0c56          b0       ORA B
$0c57          47       MOV B,A
$0c58          79       MOV A,C
$0c59          fe 40    CPI #40
$0c5b o0c5b:   ca 77 0c JZ j0c77
$0c5e          1e 02    MVI E, #02
$0c60          06 20    MVI B, #20
$0c62          7e       MOV A,M
$0c63          e6 0f    ANI #0f
$0c65          b0       ORA B
$0c66          47       MOV B,A
$0c67          79       MOV A,C
$0c68          fe 20    CPI #20
$0c6a o0c6a:   ca 77 0c JZ j0c77
$0c6d          23       INX H
$0c6e          1e 01    MVI E, #01
$0c70          06 01    MVI B, #01
$0c72          7e       MOV A,M
$0c73          e6 f0    ANI #f0
$0c75          b0       ORA B
$0c76          47       MOV B,A
$0c77 j0c77:   70       MOV M,B ;o0c4b,o0c5b,o0c6a
$0c78          16 00    MVI D, #00
$0c7a          d5       PUSH D
$0c7b          11 20 00 LXI D, #0020
$0c7e          19       DAD D
$0c7f          70       MOV M,B
$0c80          79       MOV A,C
$0c81          07       RLC
$0c82          07       RLC
$0c83          07       RLC
$0c84          07       RLC
$0c85          4f       MOV C,A
$0c86          3a 46 22 LDA $2246
$0c89          b1       ORA C
$0c8a          32 46 22 STA $2246
$0c8d          21 28 22 LXI H, #2228
$0c90          d1       POP D
$0c91          19       DAD D
$0c92          73       MOV M,E
$0c93          21 96 23 LXI H, #2396
$0c96          3e 05    MVI A, #05
$0c98 o0c98:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$0c9b          21 b6 23 LXI H, #23b6
$0c9e o0c9e:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$0ca1          3e fa    MVI A, #fa
$0ca3 o0ca3:   c3 a8 0c JMP j0ca8
$0ca6 j0ca6:   3e 3c    MVI A, #3c ;o0bf7,o0c29
$0ca8 j0ca8:   32 a7 21 STA $21a7 ;o0ca3
$0cab o0cab:   c3 19 14 JMP jo1419
$0cae          3a 49 23 LDA $2349
$0cb1          47       MOV B,A
$0cb2          3a ee 23 LDA $23ee
$0cb5          90       SUB B
$0cb6 o0cb6:   fa c4 0c JM j0cc4
$0cb9          3a 94 21 LDA STATE_OUTLANE_1
$0cbc          e6 fd    ANI #fd
$0cbe          32 94 21 STA STATE_OUTLANE_1
$0cc1 o0cc1:   c3 1e 06 JMP joEND_MAIN_LOOP
$0cc4 j0cc4:   3e 00    MVI A, #00 ;o0cb6
$0cc6          32 97 21 STA $2197
$0cc9          3a 94 21 LDA STATE_OUTLANE_1
$0ccc          f6 02    ORI #02
$0cce          32 94 21 STA STATE_OUTLANE_1
$0cd1          21 90 21 LXI H, GAME_STATE
$0cd4          3e 00    MVI A, #00
$0cd6 o0cd6:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0cd9 o0cd9:   c2 29 0d JNZ j0d29
$0cdc          21 65 11 LXI H, #1165
$0cdf o0cdf:   cd 99 0e CALL c0e99
$0ce2 o0ce2:   da f9 0c JC j0cf9
$0ce5          21 65 11 LXI H, #1165
$0ce8 o0ce8:   cd 92 02 CALL cADD_BONUS_HL
$0ceb          3e 0a    MVI A, #0a
$0ced          32 a7 21 STA $21a7
$0cf0          21 32 13 LXI H, BUMPER_25_MUSIC
$0cf3 o0cf3:   cd 61 12 CALL cPLAY_SOUND
$0cf6 o0cf6:   c3 1e 06 JMP joEND_MAIN_LOOP
$0cf9 j0cf9:   21 65 11 LXI H, #1165 ;o0ce2
$0cfc o0cfc:   cd 5c 0e CALL c0e5c
$0cff          21 5b 23 LXI H, #235b
$0d02 o0d02:   cd 3c 0f CALL c0f3c
$0d05          21 5b 23 LXI H, #235b
$0d08 o0d08:   cd 99 0e CALL c0e99
$0d0b          21 0c 22 LXI H, #220c
$0d0e          35       DCR M
$0d0f o0d0f:   ca 29 0d JZ j0d29
$0d12 o0d12:   fa 29 0d JM j0d29
$0d15          21 0d 22 LXI H, #220d
$0d18 o0d18:   cd 6f 0e CALL c0e6f
$0d1b          3e 3c    MVI A, #3c
$0d1d          32 a7 21 STA $21a7
$0d20          21 35 13 LXI H, SPREAD_HRM_MUSIC
$0d23 jo0d23:  cd 61 12 CALL cPLAY_SOUND ;o0d4a
$0d26 o0d26:   c3 1e 06 JMP joEND_MAIN_LOOP
$0d29 j0d29:   21 c5 21 LXI H, #21c5 ;o0cd9,o0d0f,o0d12
$0d2c          7e       MOV A,M
$0d2d          f6 02    ORI #02
$0d2f          77       MOV M,A
$0d30          3e 09    MVI A, #09
$0d32          32 a6 21 STA $21a6
$0d35          06 39    MVI B, #39
$0d37 o0d37:   cd 81 1d CALL co1d81
$0d3a          3a 94 21 LDA STATE_OUTLANE_1
$0d3d          e6 fd    ANI #fd
$0d3f          32 94 21 STA STATE_OUTLANE_1
$0d42          3e 00    MVI A, #00
$0d44          32 0c 22 STA $220c
$0d47          21 35 13 LXI H, SPREAD_HRM_MUSIC
$0d4a o0d4a:   c3 23 0d JMP jo0d23
$0d4d j0d4d:   21 c5 21 LXI H, #21c5 ;o0be4,o0bef
$0d50          3e 01    MVI A, #01
$0d52 o0d52:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$0d55          3e 06    MVI A, #06
$0d57          32 a6 21 STA $21a6
$0d5a o0d5a:   c3 19 14 JMP jo1419
$0d5d          3e 2b    MVI A, #2b
$0d5f o0d5f:   c3 76 0d JMP j0d76
$0d62          3e 2c    MVI A, #2c
$0d64 o0d64:   c3 76 0d JMP j0d76
$0d67          3e 04    MVI A, #04
$0d69 o0d69:   c3 76 0d JMP j0d76
$0d6c          3e 0c    MVI A, #0c
$0d6e o0d6e:   c3 76 0d JMP j0d76
$0d71          3e 14    MVI A, #14
$0d73 o0d73:   c3 76 0d JMP j0d76
$0d76 j0d76:   32 26 22 STA $2226 ;o0d5f,o0d64,o0d69,o0d6e,o0d73
$0d79          3a 90 21 LDA GAME_STATE
$0d7c          e6 04    ANI #04
$0d7e o0d7e:   c2 19 14 JNZ jo1419
$0d81          3a af 21 LDA $21af
$0d84          b7       ORA A
$0d85 o0d85:   c2 95 0d JNZ j0d95
$0d88          3a 91 21 LDA $2191
$0d8b          e6 df    ANI #df
$0d8d          32 91 21 STA $2191
$0d90          3e 80    MVI A, #80
$0d92          32 93 21 STA $2193
$0d95 j0d95:   3e 03    MVI A, #03 ;o0d85
$0d97          32 af 21 STA $21af
$0d9a o0d9a:   c3 19 14 JMP jo1419
$0d9d          3a 91 21 LDA $2191
$0da0          e6 20    ANI #20
$0da2 o0da2:   ca e1 0d JZ j0de1
$0da5          3a c4 21 LDA $21c4
$0da8          f6 04    ORI #04
$0daa          32 c4 21 STA $21c4
$0dad          3e 09    MVI A, #09
$0daf          32 99 21 STA $2199
$0db2          3a 26 22 LDA $2226
$0db5          47       MOV B,A
$0db6 o0db6:   cd 9c 1d CALL co1d9c
$0db9 o0db9:   ca e1 0d JZ j0de1
$0dbc o0dbc:   cd 81 1d CALL co1d81
$0dbf o0dbf:   ca d1 0d JZ j0dd1
$0dc2          21 65 11 LXI H, #1165
$0dc5 o0dc5:   cd 92 02 CALL cADD_BONUS_HL
$0dc8          21 e0 12 LXI H, LOW_MUSIC
$0dcb o0dcb:   cd 61 12 CALL cPLAY_SOUND
$0dce o0dce:   c3 e1 0d JMP j0de1
$0dd1 j0dd1:   21 71 11 LXI H, #1171 ;o0dbf
$0dd4 o0dd4:   cd 92 02 CALL cADD_BONUS_HL
$0dd7          eb       XCHG
$0dd8 o0dd8:   cd 5c 0e CALL c0e5c
$0ddb          21 f2 12 LXI H, LIT_STANDUP_MUSIC
$0dde o0dde:   cd 61 12 CALL cPLAY_SOUND
$0de1 j0de1:   3a 91 21 LDA $2191 ;o0da2,o0db9,o0dce
$0de4          e6 df    ANI #df
$0de6          32 91 21 STA $2191
$0de9 o0de9:   c3 1e 06 JMP joEND_MAIN_LOOP
 
$0dec c0dec:   11 f3 21 LXI D, SPREAD_1 ;o0e69,o0f73,o100b,o18b1
$0def          b7       ORA A
$0df0          f5       PUSH PSW
$0df1 j0df1:   de 02    SBI #02 ;o0e0b
$0df3 o0df3:   fa 0e 0e JM j0e0e
$0df6          47       MOV B,A
$0df7          f1       POP PSW
$0df8          1a       LDAX D
$0df9          8e       ADC M
$0dfa          27       DAA
$0dfb          12       STAX D
$0dfc          f5       PUSH PSW
$0dfd          78       MOV A,B
$0dfe          b7       ORA A
$0dff o0dff:   c2 09 0e JNZ j0e09
$0e02          f1       POP PSW
$0e03          3e 00    MVI A, #00
$0e05          8f       ADC A
$0e06          13       INX D
$0e07          12       STAX D
$0e08          c9       RET

$0e09 j0e09:   23       INX H ;o0dff
$0e0a          13       INX D
$0e0b o0e0b:   c3 f1 0d JMP j0df1
$0e0e j0e0e:   7e       MOV A,M ;o0df3
$0e0f          e6 0f    ANI #0f
$0e11          47       MOV B,A
$0e12          f1       POP PSW
$0e13          1a       LDAX D
$0e14          88       ADC B
$0e15          27       DAA
$0e16          12       STAX D
$0e17          c9       RET

 
$0e18 c0e18:   0e 00    MVI C, #00 ;o0ea8,o0fcb,o1004,o102a,o1132,o1dc1,o1de7,o1df7,o1e21,o1e31,o1e41,o1e8c,o1e9e,o1eb0,o1ec2,o1ed4,o1ee6,o1ef8,o1f0a,o1f1c,o1f2e
$0e1a          b7       ORA A
$0e1b          11 f3 21 LXI D, SPREAD_1
$0e1e          f5       PUSH PSW
$0e1f j0e1f:   de 02    SBI #02 ;o0e3a
$0e21 o0e21:   fa 3d 0e JM j0e3d
$0e24          47       MOV B,A
$0e25          f1       POP PSW
$0e26          3e 9a    MVI A, #9a
$0e28          9e       SBB M
$0e29 j0e29:   eb       XCHG ;o0e47
$0e2a          86       ADD M
$0e2b          27       DAA
$0e2c          3f       CMC
$0e2d          77       MOV M,A
$0e2e          f5       PUSH PSW
$0e2f o0e2f:   c2 4a 0e JNZ j0e4a
$0e32 j0e32:   78       MOV A,B ;o0e4c
$0e33          b7       ORA A
$0e34 o0e34:   ca 4f 0e JZ j0e4f
$0e37          eb       XCHG
$0e38          13       INX D
$0e39          23       INX H
$0e3a o0e3a:   c3 1f 0e JMP j0e1f
$0e3d j0e3d:   7e       MOV A,M ;o0e21
$0e3e          e6 0f    ANI #0f
$0e40          47       MOV B,A
$0e41          f1       POP PSW
$0e42          3e 9a    MVI A, #9a
$0e44          98       SBB B
$0e45          06 00    MVI B, #00
$0e47 o0e47:   c3 29 0e JMP j0e29
$0e4a j0e4a:   0e ff    MVI C, #ff ;o0e2f
$0e4c o0e4c:   c3 32 0e JMP j0e32
$0e4f j0e4f:   79       MOV A,C ;o0e34
$0e50          b7       ORA A
$0e51 o0e51:   ca 58 0e JZ j0e58
$0e54          f1       POP PSW
$0e55          d8       RC
$0e56          b1       ORA C
$0e57          c9       RET

$0e58 j0e58:   f1       POP PSW ;o0e51
$0e59          e6 00    ANI #00
$0e5b          c9       RET

 
$0e5c c0e5c:   11 f3 21 LXI D, SPREAD_1 ;o0a39,o0a73,o0cfc,o0dd8,o154f,o15ef,o18ed
$0e5f          3e 08    MVI A, #08
$0e61 o0e61:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$0e64          21 5b 23 LXI H, #235b
$0e67          3e 08    MVI A, #08
$0e69 o0e69:   cd ec 0d CALL c0dec
$0e6c          21 f3 21 LXI H, SPREAD_1
 
$0e6f c0e6f:   11 5b 23 LXI D, #235b ;o0d18,o18bc,o1af2
$0e72          3e 08    MVI A, #08
$0e74 o0e74:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$0e77          21 5b 23 LXI H, #235b
$0e7a          11 a0 23 LXI D, #23a0
$0e7d          3e 06    MVI A, #06
$0e7f o0e7f:   cd ea 0e CALL cWRITE_TO_RAM
$0e82          3a 90 21 LDA GAME_STATE
$0e85          e6 01    ANI #01
$0e87          c0       RNZ
$0e88          21 a0 23 LXI H, #23a0
$0e8b          11 80 23 LXI D, #2380
$0e8e          3e 06    MVI A, #06
$0e90 o0e90:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$0e93          06 39    MVI B, #39
$0e95 o0e95:   cd 76 1d CALL co1d76
$0e98          c9       RET

 
$0e99 c0e99:   e5       PUSH H ;o0cdf,o0d08,o18d0,o18f9
$0e9a          21 5b 23 LXI H, #235b
$0e9d          11 f3 21 LXI D, SPREAD_1
$0ea0          3e 08    MVI A, #08
$0ea2 o0ea2:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$0ea5          e1       POP H
$0ea6          3e 08    MVI A, #08
$0ea8 o0ea8:   cd 18 0e CALL c0e18
$0eab          f5       PUSH PSW
$0eac          21 f3 21 LXI H, SPREAD_1
$0eaf          11 5b 23 LXI D, #235b
$0eb2          3e 08    MVI A, #08
$0eb4 o0eb4:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$0eb7          21 5b 23 LXI H, #235b
$0eba          11 80 23 LXI D, #2380
$0ebd          3e 06    MVI A, #06
$0ebf o0ebf:   cd ea 0e CALL cWRITE_TO_RAM
$0ec2          21 80 23 LXI H, #2380
$0ec5          11 a0 23 LXI D, #23a0
$0ec8          3e 06    MVI A, #06
$0eca o0eca:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$0ecd          f1       POP PSW
$0ece          c9       RET

 
$0ecf cCOPY_FROM_HL_TO_DE:
               b7       ORA A ;o00c8,o00d3,o019d,o01b0,oLAMP_COPY,o0683,o0c02,o0e61,o0e74,o0e90,o0ea2,o0eb4,o0eca,o0f41,o0f7d,o0f91,o0fa2,o0fc3,o0fdb,o0ffc,o1015,o1022,o1039,o104f,o1062,o10cb,o10d6,o112a,o1637,o16ba,o16c5,o1865,o18a6,o1a84,o1b09,o1b14,o1bf6,o1c01,o1c2b,o1c89,o1ca6,o1f40,o1f4e,o1f5a,o1f6a,o1f8a,o1f9b,o1fa5,o1fb3,o1fbd,o1fc7,o1fd0,o1fe6
$0ed0 j0ed0:   de 02    SBI #02 ;o0edc
$0ed2 o0ed2:   fa e0 0e JM j0ee0
$0ed5          47       MOV B,A
$0ed6          7e       MOV A,M
$0ed7          12       STAX D
$0ed8          23       INX H
$0ed9          13       INX D
$0eda          78       MOV A,B
$0edb          b7       ORA A
$0edc o0edc:   c2 d0 0e JNZ j0ed0
$0edf          c9       RET

$0ee0 j0ee0:   7e       MOV A,M ;o0ed2
$0ee1          e6 0f    ANI #0f
$0ee3          47       MOV B,A
$0ee4          1a       LDAX D
$0ee5          e6 f0    ANI #f0
$0ee7          b0       ORA B
$0ee8          12       STAX D
$0ee9          c9       RET

 
$0eea cWRITE_TO_RAM:
               0f       RRC ;o0e7f,o0ebf,o0f85,o0fe5,o0fee,o1044,o1c15
$0eeb          f5       PUSH PSW
$0eec o0eec:   d2 f2 0e JNC j0ef2
$0eef          3c       INR A
$0ef0          e6 7f    ANI #7f
$0ef2 j0ef2:   4f       MOV C,A ;o0eec
$0ef3          0d       DCR C
$0ef4          06 00    MVI B, #00
$0ef6          09       DAD B
$0ef7          eb       XCHG
$0ef8          09       DAD B
$0ef9          eb       XCHG
$0efa          f1       POP PSW
$0efb o0efb:   da 14 0f JC j0f14
$0efe          7e       MOV A,M
$0eff j0eff:   b7       ORA A ;o0f26
$0f00 o0f00:   ca 2a 0f JZ j0f2a
$0f03          e6 f0    ANI #f0
$0f05          7e       MOV A,M
$0f06 o0f06:   c2 0b 0f JNZ j0f0b
$0f09          f6 f0    ORI #f0
$0f0b j0f0b:   12       STAX D ;o0f06,o0f10,o0f35
$0f0c          2b       DCX H
$0f0d          1b       DCX D
$0f0e          7e       MOV A,M
$0f0f          0d       DCR C
$0f10 o0f10:   f2 0b 0f JP j0f0b
$0f13          c9       RET

$0f14 j0f14:   1a       LDAX D ;o0efb
$0f15          e6 f0    ANI #f0
$0f17          47       MOV B,A
$0f18          7e       MOV A,M
$0f19          e6 0f    ANI #0f
$0f1b o0f1b:   c2 34 0f JNZ j0f34
$0f1e          f6 0f    ORI #0f
$0f20          b0       ORA B
$0f21 j0f21:   12       STAX D ;o0f31
$0f22          2b       DCX H
$0f23          1b       DCX D
$0f24          0d       DCR C
$0f25          7e       MOV A,M
$0f26 o0f26:   f2 ff 0e JP j0eff
$0f29          c9       RET

$0f2a j0f2a:   79       MOV A,C ;o0f00
$0f2b          3d       DCR A
$0f2c o0f2c:   fa 38 0f JM j0f38
$0f2f          3e ff    MVI A, #ff
$0f31 o0f31:   c3 21 0f JMP j0f21
$0f34 j0f34:   b0       ORA B ;o0f1b
$0f35 o0f35:   c3 0b 0f JMP j0f0b
$0f38 j0f38:   3e f0    MVI A, #f0 ;o0f2c
$0f3a          12       STAX D
$0f3b          c9       RET

 
$0f3c c0f3c:   11 f3 21 LXI D, SPREAD_1 ;o0278,o0d02,o1722,o172d,o18f3
$0f3f          3e 08    MVI A, #08
$0f41 o0f41:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$0f44          21 7e 23 LXI H, #237e
$0f47          3e 04    MVI A, #04
$0f49 o0f49:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0f4c o0f4c:   c2 dd 10 JNZ j10dd
$0f4f          3c       INR A
$0f50 o0f50:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0f53 o0f53:   c2 f4 10 JNZ j10f4
$0f56          3c       INR A
$0f57 o0f57:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0f5a o0f5a:   c2 0b 11 JNZ j110b
$0f5d          21 93 23 LXI H, HIGH_SCORE_NOW
$0f60          e5       PUSH H
$0f61          21 73 23 LXI H, PL24_SCORE_1
$0f64          e5       PUSH H
$0f65          21 6b 23 LXI H, PL2_SCORE_1
$0f68          e5       PUSH H
$0f69          21 90 23 LXI H, PL4_SCORE_2
$0f6c          e5       PUSH H
$0f6d          21 6f 23 LXI H, PL4_SCORE_1
$0f70          e5       PUSH H
$0f71 j0f71:   3e 08    MVI A, #08 ;o10f1,o1108,o111f
$0f73 o0f73:   cd ec 0d CALL c0dec
$0f76          d1       POP D
$0f77          d5       PUSH D
$0f78          21 f3 21 LXI H, SPREAD_1
$0f7b          3e 08    MVI A, #08
$0f7d o0f7d:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$0f80          e1       POP H
$0f81          d1       POP D
$0f82          d5       PUSH D
$0f83          3e 06    MVI A, #06
$0f85 o0f85:   cd ea 0e CALL cWRITE_TO_RAM
$0f88          d1       POP D
$0f89          d5       PUSH D
$0f8a          21 20 00 LXI H, #0020
$0f8d          19       DAD D
$0f8e          eb       XCHG
$0f8f          3e 06    MVI A, #06
$0f91 o0f91:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$0f94          d1       POP D
$0f95          3a f6 21 LDA $21f6
$0f98          e6 0f    ANI #0f
$0f9a o0f9a:   ca a5 0f JZ j0fa5
$0f9d          21 89 11 LXI H, #1189
$0fa0          3e 06    MVI A, #06
$0fa2 o0fa2:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$0fa5 j0fa5:   21 7e 23 LXI H, #237e ;o0f9a
$0fa8          3e 03    MVI A, #03
$0faa o0faa:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$0fad o0fad:   c2 08 10 JNZ j1008
$0fb0          e1       POP H
$0fb1          e1       POP H
$0fb2          e1       POP H
$0fb3          3a 7e 23 LDA $237e
$0fb6          e6 0f    ANI #0f
$0fb8          fe 03    CPI #03
$0fba          c0       RNZ
$0fbb          21 63 23 LXI H, PL1_SCORE_1
$0fbe          11 f3 21 LXI D, SPREAD_1
$0fc1          3e 07    MVI A, #07
$0fc3 o0fc3:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$0fc6          21 6b 23 LXI H, PL2_SCORE_1
$0fc9          3e 07    MVI A, #07
$0fcb o0fcb:   cd 18 0e CALL c0e18
$0fce          f5       PUSH PSW
$0fcf o0fcf:   dc f4 0f CC c0ff4
$0fd2          21 f3 21 LXI H, SPREAD_1
$0fd5          11 77 23 LXI D, PL1_SCORE_hrm
$0fd8          d5       PUSH D
$0fd9          3e 06    MVI A, #06
$0fdb o0fdb:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$0fde          e1       POP H
$0fdf          e5       PUSH H
$0fe0          11 97 23 LXI D, SPREAD_4
$0fe3          3e 06    MVI A, #06
$0fe5 o0fe5:   cd ea 0e CALL cWRITE_TO_RAM
$0fe8          e1       POP H
$0fe9          11 b7 23 LXI D, SPREAD_3
$0fec          3e 06    MVI A, #06
$0fee o0fee:   cd ea 0e CALL cWRITE_TO_RAM
$0ff1 o0ff1:   c3 52 10 JMP j1052
 
$0ff4 c0ff4:   21 6b 23 LXI H, PL2_SCORE_1 ;o0fcf
$0ff7          11 f3 21 LXI D, SPREAD_1
$0ffa          3e 07    MVI A, #07
$0ffc o0ffc:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$0fff          21 63 23 LXI H, PL1_SCORE_1
$1002          3e 07    MVI A, #07
$1004 o1004:   cd 18 0e CALL c0e18
$1007          c9       RET

$1008 j1008:   e1       POP H ;o0fad
$1009          3e 08    MVI A, #08
$100b o100b:   cd ec 0d CALL c0dec
$100e          21 f3 21 LXI H, SPREAD_1
$1011          d1       POP D
$1012          d5       PUSH D
$1013          3e 07    MVI A, #07
$1015 o1015:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1018          e1       POP H
$1019          d1       POP D
$101a          21 67 23 LXI H, PL13_SCORE_1
$101d          11 f3 21 LXI D, SPREAD_1
$1020          3e 07    MVI A, #07
$1022 o1022:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1025          21 73 23 LXI H, PL24_SCORE_1
$1028          3e 07    MVI A, #07
$102a o102a:   cd 18 0e CALL c0e18
$102d          f5       PUSH PSW
$102e o102e:   da 22 11 JC j1122
$1031 j1031:   21 f3 21 LXI H, SPREAD_1 ;o1135
$1034          11 77 23 LXI D, PL1_SCORE_hrm
$1037          3e 06    MVI A, #06
$1039 o1039:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$103c          21 77 23 LXI H, PL1_SCORE_hrm
$103f          11 97 23 LXI D, SPREAD_4
$1042          3e 06    MVI A, #06
$1044 o1044:   cd ea 0e CALL cWRITE_TO_RAM
$1047          21 97 23 LXI H, SPREAD_4
$104a          11 b7 23 LXI D, SPREAD_3
$104d          3e 06    MVI A, #06
$104f o104f:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1052 j1052:   3a f6 21 LDA $21f6 ;o0ff1
$1055          e6 0f    ANI #0f
$1057 o1057:   ca 65 10 JZ j1065
$105a          21 89 11 LXI H, #1189
$105d          11 97 23 LXI D, SPREAD_4
$1060          3e 06    MVI A, #06
$1062 o1062:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1065 j1065:   f1       POP PSW ;o1057
$1066 o1066:   ca b5 10 JZ j10b5
$1069 o1069:   da a1 10 JC j10a1
$106c          21 6a 23 LXI H, #236a
$106f          3e 04    MVI A, #04
$1071 o1071:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$1074 o1074:   ca 78 10 JZ jo1078
$1077          c9       RET

$1078 jo1078:  cd d6 03 CALL cSET_ATH_BIT_OF_HL ;o1074
$107b          3e 05    MVI A, #05
$107d jo107d:  cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL ;o10b2
$1080          e5       PUSH H
$1081          c5       PUSH B
$1082          21 16 13 LXI H, SPREAD_TAKEOVER_MUSIC
$1085 o1085:   cd 61 12 CALL cPLAY_SOUND
$1088          21 a7 21 LXI H, #21a7
$108b          7e       MOV A,M
$108c          b7       ORA A
$108d o108d:   ca 92 10 JZ j1092
$1090          36 7d    MVI M, #7d
$1092 j1092:   21 ae 21 LXI H, #21ae ;o108d
$1095          7e       MOV A,M
$1096          b7       ORA A
$1097 o1097:   ca 9c 10 JZ j109c
$109a          36 7d    MVI M, #7d
$109c j109c:   c1       POP B ;o1097
$109d          e1       POP H
$109e o109e:   c3 38 11 JMP j1138
$10a1 j10a1:   21 6a 23 LXI H, #236a ;o1069
$10a4          3e 05    MVI A, #05
$10a6 o10a6:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$10a9 o10a9:   ca ad 10 JZ jo10ad
$10ac          c9       RET

$10ad jo10ad:  cd d6 03 CALL cSET_ATH_BIT_OF_HL ;o10a9
$10b0          3e 04    MVI A, #04
$10b2 o10b2:   c3 7d 10 JMP jo107d
$10b5 j10b5:   21 6a 23 LXI H, #236a ;o1066
$10b8          3e 04    MVI A, #04
$10ba o10ba:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$10bd          3e 05    MVI A, #05
$10bf o10bf:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$10c2          e5       PUSH H
$10c3          21 85 11 LXI H, #1185
$10c6          11 97 23 LXI D, SPREAD_4
$10c9          3e 06    MVI A, #06
$10cb o10cb:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$10ce          21 85 11 LXI H, #1185
$10d1          11 b7 23 LXI D, SPREAD_3
$10d4          3e 06    MVI A, #06
$10d6 o10d6:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$10d9          e1       POP H
$10da o10da:   c3 38 11 JMP j1138
$10dd j10dd:   21 89 23 LXI H, PL1_AND_3 ;o0f4c
$10e0          e5       PUSH H
$10e1          21 67 23 LXI H, PL13_SCORE_1
$10e4          e5       PUSH H
$10e5          21 5f 23 LXI H, PL3_SCORE_1
$10e8          e5       PUSH H
$10e9          21 86 23 LXI H, PL1_SCORE_DISPLAY2
$10ec          e5       PUSH H
$10ed          21 63 23 LXI H, PL1_SCORE_1
$10f0          e5       PUSH H
$10f1 o10f1:   c3 71 0f JMP j0f71
$10f4 j10f4:   21 93 23 LXI H, HIGH_SCORE_NOW ;o0f53
$10f7          e5       PUSH H
$10f8          21 73 23 LXI H, PL24_SCORE_1
$10fb          e5       PUSH H
$10fc          21 6f 23 LXI H, PL4_SCORE_1
$10ff          e5       PUSH H
$1100          21 8d 23 LXI H, PL2_SCORE_2
$1103          e5       PUSH H
$1104          21 6b 23 LXI H, PL2_SCORE_1
$1107          e5       PUSH H
$1108 o1108:   c3 71 0f JMP j0f71
$110b j110b:   21 89 23 LXI H, PL1_AND_3 ;o0f5a
$110e          e5       PUSH H
$110f          21 67 23 LXI H, PL13_SCORE_1
$1112          e5       PUSH H
$1113          21 63 23 LXI H, PL1_SCORE_1
$1116          e5       PUSH H
$1117          21 83 23 LXI H, PL3_SCORE_DISPLAY_2
$111a          e5       PUSH H
$111b          21 5f 23 LXI H, PL3_SCORE_1
$111e          e5       PUSH H
$111f o111f:   c3 71 0f JMP j0f71
$1122 j1122:   21 73 23 LXI H, PL24_SCORE_1 ;o102e
$1125          11 f3 21 LXI D, SPREAD_1
$1128          3e 07    MVI A, #07
$112a o112a:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$112d          21 67 23 LXI H, PL13_SCORE_1
$1130          3e 07    MVI A, #07
$1132 o1132:   cd 18 0e CALL c0e18
$1135 o1135:   c3 31 10 JMP j1031
$1138 j1138:   7e       MOV A,M ;o109e,o10da
$1139          e6 30    ANI #30
$113b          47       MOV B,A
$113c          3a 8c 23 LDA $238c
$113f          e6 0f    ANI #0f
$1141          b0       ORA B
$1142          32 8c 23 STA $238c
$1145          32 ac 23 STA $23ac
$1148          c9       RET

$1149          00       DB #00
$114a          00       DB #00
$114b          00       DB #00
$114c          00       DB #00
$114d          01       DB #01
$114e          00       DB #00
$114f          00       DB #00
$1150          00       DB #00
$1151          10       DB #10
$1152          00       DB #00
$1153          00       DB #00
$1154          00       DB #00
$1155          25       DB #25
$1156          00       DB #00
$1157          00       DB #00
$1158          00       DB #00
$1159          50       DB #50
$115a          00       DB #00
$115b          00       DB #00
$115c          00       DB #00
$115d          00       DB #00
$115e          01       DB #01
$115f          00       DB #00
$1160          00       DB #00
$1161          00       DB #00
$1162          05       DB #05
$1163          00       DB #00
$1164          00       DB #00
$1165          00       DB #00
$1166          10       DB #10
$1167          00       DB #00
$1168          00       DB #00
$1169          00       DB #00
$116a          20       DB #20
$116b          00       DB #00
$116c          00       DB #00
$116d          00       DB #00
$116e          40       DB #40
$116f          00       DB #00
$1170          00       DB #00
$1171          00       DB #00
$1172          50       DB #50
$1173          00       DB #00
$1174          00       DB #00
$1175          00       DB #00
$1176          60       DB #60
$1177          00       DB #00
$1178          00       DB #00
$1179          00       DB #00
$117a          80       DB #80
$117b          00       DB #00
$117c          00       DB #00
$117d          00       DB #00
$117e          00       DB #00
$117f          01       DB #01
$1180          00       DB #00
; default high score
$1181          00       DB #00
$1182          50       DB #50
$1183          02       DB #02
$1184          00       DB #00
$1185          f0       DB #f0
$1186          ff       DB #ff
$1187          ff       DB #ff
$1188          ff       DB #ff
$1189          ff       DB #ff
$118a          ff       DB #ff
$118b          ff       DB #ff
$118c          ff       DB #ff
 
$118d cTONE_PLAY:
               3e ff    MVI A, #ff ;o123b,o125b
$118f          d3 09    OUT TONE_ENABLE_DUR
$1191          11 ac 12 LXI D, #12ac
$1194          7d       MOV A,L
$1195          93       SUB E
$1196          7c       MOV A,H
$1197          9a       SBB D
$1198          f8       RM
$1199          11 7c 13 LXI D, #137c
$119c          7b       MOV A,E
$119d          95       SUB L
$119e          7a       MOV A,D
$119f          9c       SBB H
$11a0          f8       RM
$11a1          7e       MOV A,M
$11a2          2f       CMA
$11a3          d3 0a    OUT TONE_PITCH
$11a5          23       INX H
$11a6          7e       MOV A,M
$11a7          2f       CMA
$11a8          d3 09    OUT TONE_ENABLE_DUR
$11aa          2f       CMA
$11ab          22 b1 21 SHLD NEXT_TONE
$11ae          11 fc 11 LXI D, #11fc
$11b1          fe 00    CPI #00
$11b3 o11b3:   ca ef 11 JZ j11ef
$11b6          fe 02    CPI #02
$11b8 o11b8:   ca ee 11 JZ j11ee
$11bb          fe 04    CPI #04
$11bd o11bd:   ca ed 11 JZ j11ed
$11c0          fe 08    CPI #08
$11c2 o11c2:   ca ec 11 JZ j11ec
$11c5          fe 0c    CPI #0c
$11c7 o11c7:   ca eb 11 JZ j11eb
$11ca          fe 10    CPI #10
$11cc o11cc:   ca ea 11 JZ j11ea
$11cf          fe 2c    CPI #2c
$11d1 o11d1:   ca e9 11 JZ j11e9
$11d4          fe 28    CPI #28
$11d6 o11d6:   ca e8 11 JZ j11e8
$11d9          fe 24    CPI #24
$11db o11db:   ca e7 11 JZ j11e7
$11de          fe 20    CPI #20
$11e0 o11e0:   ca e6 11 JZ j11e6
$11e3 o11e3:   c3 ef 11 JMP j11ef
$11e6 j11e6:   13       INX D ;o11e0
$11e7 j11e7:   13       INX D ;o11db
$11e8 j11e8:   13       INX D ;o11d6
$11e9 j11e9:   13       INX D ;o11d1
$11ea j11ea:   13       INX D ;o11cc
$11eb j11eb:   13       INX D ;o11c7
$11ec j11ec:   13       INX D ;o11c2
$11ed j11ed:   13       INX D ;o11bd
$11ee j11ee:   13       INX D ;o11b8
$11ef j11ef:   1a       LDAX D ;o11b3,o11e3
$11f0          32 98 21 STA $2198
$11f3          21 90 21 LXI H, GAME_STATE
$11f6          3e 05    MVI A, #05
$11f8 o11f8:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$11fb          c9       RET

$11fc          0d       DCR C
$11fd          0a       LDAX B
$11fe          0e 0a    MVI C, #0a
$1200          18       (RLDE)
$1201          20       RIM
$1202          0a       LDAX B
$1203          05       DCR B
$1204          02       STAX B
$1205          32 21 90 STA $9021
$1208          21 3e 05 LXI H, #053e
$120b o120b:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$120e o120e:   c2 22 12 JNZ jo1222
$1211          3e 06    MVI A, #06
$1213 o1213:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$1216          3e fe    MVI A, #fe
$1218          d3 09    OUT TONE_ENABLE_DUR
$121a          3e 02    MVI A, #02
$121c          32 98 21 STA $2198
$121f o121f:   c3 1e 06 JMP joEND_MAIN_LOOP
$1222 jo1222:  cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL ;o120e
$1225          3e 06    MVI A, #06
$1227 o1227:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$122a o122a:   c2 55 12 JNZ jo1255
$122d          3e ff    MVI A, #ff
$122f          d3 09    OUT TONE_ENABLE_DUR
$1231          2a b1 21 LHLD NEXT_TONE
$1234          23       INX H
$1235          7e       MOV A,M
$1236          fe ff    CPI #ff
$1238 o1238:   ca 41 12 JZ j1241
$123b o123b:   cd 8d 11 CALL cTONE_PLAY
$123e o123e:   c3 1e 06 JMP joEND_MAIN_LOOP
$1241 j1241:   3a b3 21 LDA $21b3 ;o1238
$1244          fe 00    CPI #00
$1246 o1246:   c2 58 12 JNZ jo1258
$1249          3e ff    MVI A, #ff
$124b          d3 09    OUT TONE_ENABLE_DUR
$124d          3e 0c    MVI A, #0c
$124f          32 98 21 STA $2198
$1252 o1252:   c3 1e 06 JMP joEND_MAIN_LOOP
$1255 jo1255:  cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL ;o122a
$1258 jo1258:  cd 8c 12 CALL c128c ;o1246
$125b o125b:   cd 8d 11 CALL cTONE_PLAY
$125e o125e:   c3 1e 06 JMP joEND_MAIN_LOOP
 
$1261 cPLAY_SOUND:
               eb       XCHG ;o0546,o0563,o059c,o06fd,o07bc,o0855,o0927,o0a1a,o0a3f,o0a79,o0adc,o0b69,o0c39,o0cf3,jo0d23,o0dcb,o0dde,o1085,o14bd,o14ef,o1585,o15a6,o15d0,o15f5,o1786,o1859,o18c7,o18e4,o1a27,o1ae4,o1b72,o1f70
$1262          2a be 21 LHLD $21be
$1265          01 be 21 LXI B, #21be
$1268          79       MOV A,C
$1269          32 b3 21 STA $21b3
$126c          95       SUB L
$126d o126d:   c2 73 12 JNZ j1273
$1270          21 b4 21 LXI H, #21b4
$1273 j1273:   73       MOV M,E ;o126d
$1274          23       INX H
$1275          72       MOV M,D
$1276          23       INX H
$1277          22 be 21 SHLD $21be
$127a          21 90 21 LXI H, GAME_STATE
$127d          3e 05    MVI A, #05
$127f o127f:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$1282          c0       RNZ
$1283 o1283:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$1286          3e 01    MVI A, #01
$1288          32 98 21 STA $2198
$128b          c9       RET

 
$128c c128c:   2a c0 21 LHLD $21c0 ;jo1258
$128f          01 be 21 LXI B, #21be
$1292          79       MOV A,C
$1293          95       SUB L
$1294 o1294:   c2 9a 12 JNZ j129a
$1297          21 b4 21 LXI H, #21b4
$129a j129a:   5e       MOV E,M ;o1294
$129b          23       INX H
$129c          56       MOV D,M
$129d          23       INX H
$129e          22 c0 21 SHLD $21c0
$12a1          d5       PUSH D
$12a2          7d       MOV A,L
$12a3          2a be 21 LHLD $21be
$12a6          95       SUB L
$12a7          32 b3 21 STA $21b3
$12aa          e1       POP H
$12ab          c9       RET

$12ac          ff       DB #ff
BUMPER_25_MUSIC_2          ca       DB #ca
$12ae          08       DB #08
$12af          ff       DB #ff
$12b0          aa       DB #aa
$12b1          08       DB #08
$12b2          ff       DB #ff
$12b3          87       DB #87
$12b4          08       DB #08
$12b5          ff       DB #ff
$12b6          65       DB #65
$12b7          08       DB #08
$12b8          ff       DB #ff
LEFT_SLING_TONE          1c       DB #1c
$12ba          0c       DB #0c
$12bb          ff       DB #ff
RIGHT_SLING_TONE          1c       DB #1c
$12bd          0c       DB #0c
$12be          ff       DB #ff
SILENCE_END_LOOP_MUSIC          1c       DB #1c
$12c0          00       DB #00
$12c1          ff       DB #ff
BONUS_MUSIC          43       DB #43
$12c3          08       DB #08
$12c4          87       DB #87
$12c5          08       DB #08
$12c6          43       DB #43
$12c7          08       DB #08
$12c8          87       DB #87
$12c9          08       DB #08
$12ca          43       DB #43
$12cb          08       DB #08
$12cc          87       DB #87
$12cd          08       DB #08
$12ce          43       DB #43
$12cf          08       DB #08
$12d0          87       DB #87
$12d1          08       DB #08
$12d2          43       DB #43
$12d3          08       DB #08
$12d4          87       DB #87
$12d5          08       DB #08
$12d6          ff       DB #ff
$12d7          55       DB #55
$12d8          08       DB #08
$12d9          ff       DB #ff
START_PLAYER_MUSIC          3c       DB #3c
$12db          08       DB #08
$12dc          ff       DB #ff
UNKNOWN_MUSIC          2b       DB #2b
$12de          08       DB #08
$12df          ff       DB #ff
LOW_MUSIC          22       DB #22
$12e1          08       DB #08
$12e2          ff       DB #ff
OOPS_MUSIC          22       DB #22
$12e4          28       DB #28
$12e5          1e       DB #1e
$12e6          0c       DB #0c
$12e7          ff       DB #ff
OOPS2_MUSIC          15       DB #15
$12e9          02       DB #02
$12ea          15       DB #15
$12eb          0c       DB #0c
$12ec          ff       DB #ff
LIL_VICTORY_MUSIC          4c       DB #4c
$12ee          08       DB #08
$12ef          65       DB #65
$12f0          0c       DB #0c
$12f1          ff       DB #ff
LIT_STANDUP_MUSIC          78       DB #78
$12f3          28       DB #28
$12f4          50       DB #50
$12f5          28       DB #28
$12f6          78       DB #78
$12f7          28       DB #28
$12f8          50       DB #50
$12f9          28       DB #28
$12fa          78       DB #78
$12fb          28       DB #28
$12fc          50       DB #50
$12fd          28       DB #28
$12fe          ff       DB #ff
GAME_OVER_MUSIC          55       DB #55
$1300          08       DB #08
$1301          65       DB #65
$1302          08       DB #08
$1303          78       DB #78
$1304          08       DB #08
$1305          78       DB #78
$1306          00       DB #00
$1307          55       DB #55
$1308          08       DB #08
$1309          65       DB #65
$130a          08       DB #08
$130b          78       DB #78
$130c          08       DB #08
$130d          78       DB #78
$130e          00       DB #00
$130f          55       DB #55
$1310          08       DB #08
$1311          65       DB #65
$1312          08       DB #08
$1313          78       DB #78
$1314          08       DB #08
$1315          ff       DB #ff
SPREAD_TAKEOVER_MUSIC          43       DB #43
$1317          20       DB #20
$1318          43       DB #43
$1319          08       DB #08
$131a          55       DB #55
$131b          08       DB #08
$131c          65       DB #65
$131d          08       DB #08
$131e          72       DB #72
$131f          0c       DB #0c
$1320          ff       DB #ff
MORSE_CODE_MUSIC          43       DB #43
$1322          04       DB #04
$1323          43       DB #43
$1324          04       DB #04
$1325          43       DB #43
$1326          00       DB #00
$1327          43       DB #43
$1328          04       DB #04
$1329          43       DB #43
$132a          04       DB #04
$132b          43       DB #43
$132c          00       DB #00
$132d          43       DB #43
$132e          04       DB #04
$132f          43       DB #43
$1330          04       DB #04
$1331          ff       DB #ff
BUMPER_25_MUSIC          c6       DB #c6
$1333          08       DB #08
$1334          ff       DB #ff
SPREAD_HRM_MUSIC          4c       DB #4c
$1336          0c       DB #0c
$1337          ff       DB #ff
LONGER_BUMPER_25_MUSIC          ca       DB #ca
$1339          08       DB #08
$133a          ca       DB #ca
$133b          08       DB #08
$133c          ca       DB #ca
$133d          08       DB #08
$133e          ca       DB #ca
$133f          0c       DB #0c
$1340          ff       DB #ff
CREDIT_MUSIC          78       DB #78
$1342          28       DB #28
$1343          65       DB #65
$1344          04       DB #04
$1345          ff       DB #ff
NEXT_PLAYER_MUSIC          a0       DB #a0
$1347          2c       DB #2c
$1348          a0       DB #a0
$1349          0c       DB #0c
$134a          ff       DB #ff
OUTLANE_MUSIC          15       DB #15
$134c          0c       DB #0c
$134d          ff       DB #ff
SILENCE_MUSIC          ca       DB #ca
$134f          00       DB #00
$1350          ff       DB #ff
; godfather
HIGH_SCORE_MUSIC          65       DB #65
$1352          0c       DB #0c
$1353          87       DB #87
$1354          0c       DB #0c
$1355          aa       DB #aa
$1356          0c       DB #0c
$1357          ca       DB #ca
$1358          0c       DB #0c
$1359          ca       DB #ca
$135a          00       DB #00
$135b          ca       DB #ca
$135c          08       DB #08
$135d          ca       DB #ca
$135e          08       DB #08
$135f          ca       DB #ca
$1360          08       DB #08
$1361          aa       DB #aa
$1362          00       DB #00
$1363          aa       DB #aa
$1364          0c       DB #0c
$1365          aa       DB #aa
$1366          00       DB #00
$1367          aa       DB #aa
$1368          08       DB #08
$1369          aa       DB #aa
; popcorn
POPCORN_MUSIC          08       DB #08
$136b          aa       DB #aa
$136c          08       DB #08
$136d          87       DB #87
$136e          00       DB #00
$136f          87       DB #87
$1370          0c       DB #0c
$1371          aa       DB #aa
$1372          0c       DB #0c
$1373          87       DB #87
$1374          0c       DB #0c
$1375          65       DB #65
$1376          0c       DB #0c
$1377          65       DB #65
$1378          20       DB #20
$1379          65       DB #65
$137a          20       DB #20
$137b          ff       DB #ff
$137c          fe       DB #fe
 
$137d jc137d:  21 91 21 LXI H, #2191 ;o0140,o13b2,o1d6f
$1380          3e 03    MVI A, #03
$1382 o1382:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$1385          d3 0f    OUT LAMP_F
$1387          21 e0 23 LXI H, #23e0
$138a          11 3b 23 LXI D, #233b
$138d j138d:   46       MOV B,M ;o13aa
$138e          1a       LDAX D
$138f          c6 04    ADI #04
$1391          90       SUB B
$1392 o1392:   f2 97 13 JP j1397
$1395          2f       CMA
$1396          3c       INR A
$1397 j1397:   fe 03    CPI #03 ;o1392
$1399 o1399:   da a4 13 JC j13a4
$139c          3a 91 21 LDA $2191
$139f          f6 08    ORI #08
$13a1          32 91 21 STA $2191
$13a4 j13a4:   78       MOV A,B ;o1399
$13a5          d6 04    SUI #04
$13a7          12       STAX D
$13a8          13       INX D
$13a9          2c       INR L
$13aa o13aa:   c2 8d 13 JNZ j138d
$13ad          3a 91 21 LDA $2191
$13b0          e6 08    ANI #08
$13b2 o13b2:   c2 7d 13 JNZ jc137d
$13b5 o13b5:   cd 03 03 CALL c0303
$13b8          22 24 22 SHLD $2224
$13bb          c9       RET

$13bc          21 91 21 LXI H, #2191
$13bf          3e 06    MVI A, #06
$13c1 o13c1:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$13c4          21 e0 23 LXI H, #23e0
$13c7          11 3b 23 LXI D, #233b
$13ca j13ca:   1a       LDAX D ;o13d1
$13cb          96       SUB M
$13cc o13cc:   f2 ea 13 JP j13ea
$13cf j13cf:   13       INX D ;jo141c
$13d0          2c       INR L
$13d1 o13d1:   c2 ca 13 JNZ j13ca
$13d4          21 91 21 LXI H, #2191
$13d7          3e 06    MVI A, #06
$13d9 o13d9:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$13dc o13dc:   ca e4 13 JZ j13e4
$13df          3e 07    MVI A, #07
$13e1 o13e1:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$13e4 j13e4:   3e 01    MVI A, #01 ;o13dc
$13e6          f3       DI
$13e7 o13e7:   c3 76 03 JMP j0376
$13ea j13ea:   f3       DI ;o13cc
$13eb          e5       PUSH H
$13ec          21 91 21 LXI H, #2191
$13ef          3e 06    MVI A, #06
$13f1 o13f1:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$13f4          3c       INR A
$13f5 o13f5:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$13f8 o13f8:   c2 02 14 JNZ jo1402
$13fb o13fb:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$13fe          e1       POP H
$13ff o13ff:   c3 1c 14 JMP jo141c
$1402 jo1402:  cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL ;o13f8
$1405          e1       POP H
$1406 o1406:   cd 24 06 CALL cSAVE_BDPSW
$1409          7d       MOV A,L
$140a          d6 e0    SUI #e0
$140c          6f       MOV L,A
$140d          26 00    MVI H, #00
$140f          29       DAD H
$1410          11 1f 14 LXI D, #141f
$1413          19       DAD D
$1414          7e       MOV A,M
$1415          23       INX H
$1416          66       MOV H,M
$1417          6f       MOV L,A
$1418          e9       PCHL
$1419 jo1419:  cd 30 06 CALL cRESTORE_BDPSW ;o0996,o09ab,o09b8,o09d7,o0a27,o0b60,o0b6c,o0cab,o0d5a,o0d7e,o0d9a,o14a1,o14ab,o14c5,o14d2,o153e,o1549,o15a9,o15c1,o15d3,o15de,o15e6,o15f8,o1810,o1820,o1828,o1886,o18ca
$141c jo141c:  c3 cf 13 JMP j13cf ;o13ff
$141f          d6 15    SUI #15
$1421          19       DAD D
$1422          14       INR D
$1423          19       DAD D
$1424          14       INR D
$1425          19       DAD D
$1426          14       INR D
$1427          19       DAD D
$1428          14       INR D
$1429          19       DAD D
$142a          14       INR D
$142b          19       DAD D
$142c          14       INR D
$142d          19       DAD D
$142e          14       INR D
$142f          ac       XRA H
$1430          15       DCR D
$1431          66       MOV H,M
$1432          14       INR D
$1433          6d       MOV L,L
$1434          14       INR D
$1435          82       ADD D
$1436          14       INR D
$1437          74       MOV M,H
$1438          14       INR D
$1439          7b       MOV A,E
$143a          14       INR D
$143b          84       ADD H
$143c          09       DAD B
$143d          36 15    MVI M, #15
$143f          89       ADC C
$1440          14       INR D
$1441          90       SUB B
$1442          14       INR D
$1443          7d       MOV A,L
$1444          09       DAD B
$1445          5f       MOV E,A
$1446          14       INR D
$1447          76       HLT
$1448          09       DAD B
$1449          67       MOV H,A
$144a          0d       DCR C
$144b          6c       MOV L,H
$144c          0d       DCR C
$144d          71       MOV M,C
$144e          0d       DCR C
$144f          08       (DSUB)
$1450          18       (RLDE)
$1451          6f       MOV L,A
$1452          09       DAD B
$1453          62       MOV H,D
$1454          0d       DCR C
$1455          68       MOV L,B
$1456          09       DAD B
$1457          5d       MOV E,L
$1458          0d       DCR C
$1459          61       MOV H,C
$145a          09       DAD B
$145b          ac       DB #ac
$145c          15       DB #15
$145d          d6       DB #d6
$145e          15       DB #15
$145f          0e 00    MVI C, #00
$1461          06 02    MVI B, #02
$1463 o1463:   c3 94 14 JMP j1494
$1466          0e 01    MVI C, #01
$1468          06 2a    MVI B, #2a
$146a o146a:   c3 94 14 JMP j1494
$146d          0e 02    MVI C, #02
$146f          06 10    MVI B, #10
$1471 o1471:   c3 94 14 JMP j1494
$1474          0e 03    MVI C, #03
$1476          06 1a    MVI B, #1a
$1478 o1478:   c3 94 14 JMP j1494
$147b          0e 04    MVI C, #04
$147d          06 01    MVI B, #01
$147f o147f:   c3 94 14 JMP j1494
$1482          0e 05    MVI C, #05
$1484          06 19    MVI B, #19
$1486 o1486:   c3 94 14 JMP j1494
$1489          0e 06    MVI C, #06
$148b          06 21    MVI B, #21
$148d o148d:   c3 94 14 JMP j1494
$1490          0e 07    MVI C, #07
$1492          06 0a    MVI B, #0a
$1494 j1494:   21 90 21 LXI H, GAME_STATE ;o1463,o146a,o1471,o1478,o147f,o1486,o148d
$1497          3e 07    MVI A, #07
$1499 o1499:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$149c          3e 02    MVI A, #02
$149e o149e:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$14a1 o14a1:   c2 19 14 JNZ jo1419
$14a4          79       MOV A,C
$14a5          21 c6 21 LXI H, #21c6
$14a8 o14a8:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$14ab o14ab:   ca 19 14 JZ jo1419
$14ae o14ae:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$14b1 o14b1:   cd 81 1d CALL co1d81
$14b4          21 61 11 LXI H, #1161
$14b7 o14b7:   cd 92 02 CALL cADD_BONUS_HL
$14ba          21 d7 12 LXI H, #12d7
$14bd o14bd:   cd 61 12 CALL cPLAY_SOUND
$14c0          3a c6 21 LDA $21c6
$14c3          fe 00    CPI #00
$14c5 o14c5:   c2 19 14 JNZ jo1419
$14c8          3e 3d    MVI A, #3d
$14ca          32 a4 21 STA $21a4
$14cd          3e 00    MVI A, #00
$14cf          32 05 22 STA $2205
$14d2 o14d2:   c3 19 14 JMP jo1419
$14d5          3a 05 22 LDA $2205
$14d8          3c       INR A
$14d9          32 05 22 STA $2205
$14dc          fe 09    CPI #09
$14de o14de:   ca fa 14 JZ j14fa
$14e1          16 00    MVI D, #00
$14e3          5f       MOV E,A
$14e4          21 2d 15 LXI H, #152d
$14e7          19       DAD D
$14e8          46       MOV B,M
$14e9 o14e9:   cd 76 1d CALL co1d76
$14ec          21 d7 12 LXI H, #12d7
$14ef o14ef:   cd 61 12 CALL cPLAY_SOUND
$14f2          3e 0a    MVI A, #0a
$14f4          32 a4 21 STA $21a4
$14f7 o14f7:   c3 1e 06 JMP joEND_MAIN_LOOP
$14fa j14fa:   3e 00    MVI A, #00 ;o14de
$14fc          32 0c 22 STA $220c
$14ff          06 11    MVI B, #11
$1501 o1501:   cd 9c 1d CALL co1d9c
$1504 o1504:   c2 17 15 JNZ jo1517
$1507          06 38    MVI B, #38
$1509 o1509:   cd 9c 1d CALL co1d9c
$150c o150c:   c2 22 15 JNZ j1522
$150f          06 11    MVI B, #11
$1511 o1511:   cd 76 1d CALL co1d76
$1514 o1514:   c3 22 15 JMP j1522
$1517 jo1517:  cd 81 1d CALL co1d81 ;o1504
$151a          06 38    MVI B, #38
$151c o151c:   cd 76 1d CALL co1d76
$151f o151f:   c3 22 15 JMP j1522
$1522 j1522:   3e ff    MVI A, #ff ;o150c,o1514,o151f
$1524          32 c6 21 STA $21c6
$1527          97       SUB A
$1528          32 05 22 STA $2205
$152b o152b:   c3 1e 06 JMP joEND_MAIN_LOOP
$152e          02       STAX B
$152f          2a 10 1a LHLD $1a10
$1532          01 19 21 LXI B, #2119
$1535          0a       LDAX B
; 10,000 / EB lane
$1536          21 90 21 LXI H, GAME_STATE
$1539          3e 07    MVI A, #07
$153b o153b:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$153e o153e:   ca 19 14 JZ jo1419
$1541 o1541:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$1544          3e 02    MVI A, #02
$1546 o1546:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$1549 o1549:   c2 19 14 JNZ jo1419
$154c          21 7d 11 LXI H, #117d
$154f o154f:   cd 5c 0e CALL c0e5c
$1552          21 90 21 LXI H, GAME_STATE
$1555          3e 04    MVI A, #04
$1557 o1557:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$155a o155a:   ca 88 15 JZ j1588
$155d          21 91 21 LXI H, #2191
$1560          3e 01    MVI A, #01
$1562 o1562:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$1565 o1565:   c2 88 15 JNZ j1588
$1568 o1568:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$156b          3a c7 21 LDA $21c7
$156e          06 ff    MVI B, #ff
$1570 j1570:   04       INR B ;o1572
$1571          1f       RAR
$1572 o1572:   d2 70 15 JNC j1570
$1575          78       MOV A,B
$1576          3d       DCR A
$1577 o1577:   f2 7c 15 JP j157c
$157a          3e 04    MVI A, #04
$157c j157c:   32 11 22 STA $2211 ;o1577
$157f o157f:   cd 02 04 CALL c0402
$1582          21 38 13 LXI H, LONGER_BUMPER_25_MUSIC
$1585 o1585:   cd 61 12 CALL cPLAY_SOUND
$1588 j1588:   21 90 21 LXI H, GAME_STATE ;o155a,o1565
$158b          3e 03    MVI A, #03
$158d o158d:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$1590 o1590:   c2 a3 15 JNZ j15a3
$1593          06 09    MVI B, #09
$1595 o1595:   cd 9c 1d CALL co1d9c
$1598 o1598:   ca a3 15 JZ j15a3
$159b o159b:   cd 81 1d CALL co1d81
$159e          06 31    MVI B, #31
$15a0 o15a0:   cd 91 1d CALL co1d91
$15a3 j15a3:   21 ed 12 LXI H, LIL_VICTORY_MUSIC ;o1590,o1598
$15a6 o15a6:   cd 61 12 CALL cPLAY_SOUND
$15a9 o15a9:   c3 19 14 JMP jo1419
; outlane handler
$15ac          3e ff    MVI A, #ff
$15ae          32 93 21 STA $2193
$15b1          3a 94 21 LDA STATE_OUTLANE_1
$15b4          f6 30    ORI #30
$15b6          32 94 21 STA STATE_OUTLANE_1
; don't let outlane scrore > 1x
$15b9          21 90 21 LXI H, GAME_STATE
$15bc          3e 02    MVI A, #02
$15be o15be:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$15c1 o15c1:   c2 19 14 JNZ jo1419
$15c4 o15c4:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$15c7          21 65 11 LXI H, #1165
$15ca o15ca:   cd 92 02 CALL cADD_BONUS_HL
$15cd          21 4b 13 LXI H, OUTLANE_MUSIC
$15d0 o15d0:   cd 61 12 CALL cPLAY_SOUND
$15d3 o15d3:   c3 19 14 JMP jo1419
; inlane routine
$15d6          21 90 21 LXI H, GAME_STATE
$15d9          3e 02    MVI A, #02
$15db o15db:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$15de o15de:   c2 19 14 JNZ jo1419
$15e1          3e 07    MVI A, #07
$15e3 o15e3:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$15e6 o15e6:   ca 19 14 JZ jo1419
$15e9 o15e9:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$15ec          21 65 11 LXI H, #1165
$15ef o15ef:   cd 5c 0e CALL c0e5c
$15f2          21 35 13 LXI H, SPREAD_HRM_MUSIC
$15f5 o15f5:   cd 61 12 CALL cPLAY_SOUND
$15f8 o15f8:   c3 19 14 JMP jo1419
$15fb          21 92 21 LXI H, GAME_STATE2
$15fe          3e 00    MVI A, #00
$1600 o1600:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$1603 o1603:   c2 89 17 JNZ j1789
$1606          3a 7a 23 LDA CREDITS_1
; check if credits
$1609          b7       ORA A
$160a o160a:   c2 20 16 JNZ j1620
$160d          3a 9e 23 LDA $239e
$1610          e6 08    ANI #08
$1612 o1612:   c2 89 17 JNZ j1789
$1615          3a b6 23 LDA $23b6
$1618          f6 40    ORI #40
$161a          32 b6 23 STA $23b6
$161d o161d:   c3 89 17 JMP j1789
$1620 j1620:   3a 7b 23 LDA BALL_IN_PLAY_hrm ;o160a
$1623          e6 0f    ANI #0f
$1625          fe 01    CPI #01
$1627 o1627:   ca ed 16 JZ j16ed
$162a          fe 00    CPI #00
$162c o162c:   ca ed 16 JZ j16ed
$162f          21 a3 23 LXI H, #23a3
$1632          11 20 23 LXI D, #2320
$1635          3e 2e    MVI A, #2e
$1637 o1637:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$163a o163a:   cd a8 17 CALL c17a8
$163d          21 92 21 LXI H, GAME_STATE2
$1640          3e 04    MVI A, #04
$1642 o1642:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$1645 o1645:   ca 55 16 JZ j1655
$1648          3e 07    MVI A, #07
$164a o164a:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$164d o164d:   ca 55 16 JZ j1655
$1650          3e 01    MVI A, #01
$1652 o1652:   c3 71 16 JMP j1671
$1655 j1655:   3e 06    MVI A, #06 ;o1645,o164d
$1657 o1657:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$165a          3a 90 21 LDA GAME_STATE
$165d          f6 05    ORI #05
$165f          32 90 21 STA GAME_STATE
$1662          3e ff    MVI A, #ff
$1664          32 93 21 STA $2193
$1667          3a 94 21 LDA STATE_OUTLANE_1
$166a          f6 30    ORI #30
$166c          32 94 21 STA STATE_OUTLANE_1
$166f          3e 00    MVI A, #00
$1671 j1671:   32 7b 23 STA BALL_IN_PLAY_hrm ;o1652
$1674          32 9b 23 STA BALL_IN_PLAY_1
$1677          32 bb 23 STA BALL_IN_PLAY_2
$167a          3e 11    MVI A, #11
$167c          32 7e 23 STA $237e
$167f          32 be 23 STA $23be
$1682          3e 01    MVI A, #01
$1684          32 9e 23 STA $239e
$1687          3e f0    MVI A, #f0
$1689          32 86 23 STA PL1_SCORE_DISPLAY2
$168c          32 a6 23 STA PL1_SCORE_DISPLAY
$168f          32 80 23 STA $2380
$1692          32 a0 23 STA $23a0
$1695          3e 00    MVI A, #00
$1697          32 14 22 STA $2214
$169a          11 d3 21 LXI D, #21d3
$169d          06 04    MVI B, #04
$169f o169f:   cd 8e 17 CALL jc178e
$16a2          21 92 21 LXI H, GAME_STATE2
$16a5          3e 06    MVI A, #06
$16a7 o16a7:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$16aa          3a b6 23 LDA $23b6
$16ad          e6 7f    ANI #7f
$16af          32 b6 23 STA $23b6
$16b2          21 d3 21 LXI H, #21d3
$16b5          11 c6 21 LXI D, #21c6
$16b8          3e 10    MVI A, #10
$16ba o16ba:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$16bd          21 c9 21 LXI H, #21c9
$16c0          11 ce 21 LXI D, #21ce
$16c3          3e 0a    MVI A, #0a
$16c5 o16c5:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$16c8          3a 90 21 LDA GAME_STATE
$16cb          e6 e7    ANI #e7
$16cd          32 90 21 STA GAME_STATE
$16d0 jDECREASE_CREDIT:
               3a 7a 23 LDA CREDITS_1 ;o1735,o174b,o176d,o1780
$16d3          c6 99    ADI #99
$16d5          27       DAA
$16d6          32 7a 23 STA CREDITS_1
$16d9          32 9a 23 STA CREDITS_2
$16dc          32 ba 23 STA CREDITS_3
$16df          3a 14 22 LDA $2214
$16e2          47       MOV B,A
$16e3          3a 13 22 LDA BALLS_PER_GAME
$16e6          80       ADD B
$16e7          32 14 22 STA $2214
$16ea o16ea:   c3 83 17 JMP j1783
$16ed j16ed:   3a 7e 23 LDA $237e ;o1627,o162c
$16f0          e6 08    ANI #08
$16f2 o16f2:   c2 89 17 JNZ j1789
$16f5          3e 01    MVI A, #01
$16f7          21 7e 23 LXI H, #237e
$16fa o16fa:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$16fd o16fd:   ca 38 17 JZ jo1738
$1700          3e 02    MVI A, #02
$1702 o1702:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$1705 o1705:   ca 4e 17 JZ jo174e
$1708          3e 03    MVI A, #03
$170a o170a:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$170d          3e f0    MVI A, #f0
$170f          32 90 23 STA PL4_SCORE_2
$1712          32 b0 23 STA PL4_SCORE_3
$1715          f3       DI
$1716          3a 7e 23 LDA $237e
$1719          f5       PUSH PSW
$171a          3e 1f    MVI A, #1f
$171c          32 7e 23 STA $237e
$171f          21 49 11 LXI H, #1149
$1722 o1722:   cd 3c 0f CALL c0f3c
$1725          3e 2f    MVI A, #2f
$1727          32 7e 23 STA $237e
$172a          21 49 11 LXI H, #1149
$172d o172d:   cd 3c 0f CALL c0f3c
$1730          f1       POP PSW
$1731          32 7e 23 STA $237e
$1734          fb       EI
$1735 o1735:   c3 d0 16 JMP jDECREASE_CREDIT
$1738 jo1738:  cd d6 03 CALL cSET_ATH_BIT_OF_HL ;o16fd
$173b          3e f0    MVI A, #f0
$173d          32 8d 23 STA PL2_SCORE_2
$1740          32 ad 23 STA PL2_SCORE_3
$1743          3e f0    MVI A, #f0
$1745          32 97 23 STA SPREAD_4
$1748          32 b7 23 STA SPREAD_3
$174b o174b:   c3 d0 16 JMP jDECREASE_CREDIT
$174e jo174e:  cd d6 03 CALL cSET_ATH_BIT_OF_HL ;o1705
$1751          3e f0    MVI A, #f0
$1753          32 83 23 STA PL3_SCORE_DISPLAY_2
$1756          32 a3 23 STA $23a3
$1759          3e ff    MVI A, #ff
$175b          32 97 23 STA SPREAD_4
$175e          32 98 23 STA $2398
$1761          32 99 23 STA $2399
$1764          32 b7 23 STA SPREAD_3
$1767          32 b8 23 STA $23b8
$176a          32 b9 23 STA $23b9
$176d o176d:   c3 d0 16 JMP jDECREASE_CREDIT
$1770          3a 7e 23 LDA $237e
$1773          32 be 23 STA $23be
$1776          e6 0f    ANI #0f
$1778          47       MOV B,A
$1779          3a 9e 23 LDA $239e
$177c          b0       ORA B
$177d          32 9e 23 STA $239e
$1780 o1780:   c3 d0 16 JMP jDECREASE_CREDIT
$1783 j1783:   21 da 12 LXI H, START_PLAYER_MUSIC ;o16ea
$1786 o1786:   cd 61 12 CALL cPLAY_SOUND
$1789 j1789:   3e 06    MVI A, #06 ;o1603,o1612,o161d,o16f2
$178b o178b:   c3 76 03 JMP j0376
 
$178e jc178e:  21 a0 17 LXI H, #17a0 ;o01a5,o169f,o179c
$1791          0e 08    MVI C, #08
$1793 j1793:   7e       MOV A,M ;o1798
$1794          12       STAX D
$1795          13       INX D
$1796          23       INX H
$1797          0d       DCR C
$1798 o1798:   c2 93 17 JNZ j1793
$179b          05       DCR B
$179c o179c:   c2 8e 17 JNZ jc178e
$179f          c9       RET

$17a0          ff       DB #ff
$17a1          1f       DB #1f
$17a2          01       DB #01
$17a3          04       DB #04
$17a4          39       DB #39
$17a5          2b       DB #2b
$17a6          37       DB #37
$17a7          37       DB #37
 
$17a8 c17a8:   21 5b 23 LXI H, #235b ;jo0168,o163a
$17ab          3e 00    MVI A, #00
$17ad          16 1f    MVI D, #1f
$17af j17af:   77       MOV M,A ;o17b2
$17b0          23       INX H
$17b1          15       DCR D
$17b2 o17b2:   c2 af 17 JNZ j17af
$17b5          32 46 22 STA $2246
$17b8          21 80 23 LXI H, #2380
$17bb          3e ff    MVI A, #ff
$17bd          16 1a    MVI D, #1a
$17bf j17bf:   77       MOV M,A ;o17c2
$17c0          23       INX H
$17c1          15       DCR D
$17c2 o17c2:   c2 bf 17 JNZ j17bf
$17c5          21 a0 23 LXI H, #23a0
$17c8          3e ff    MVI A, #ff
$17ca          16 1a    MVI D, #1a
$17cc j17cc:   77       MOV M,A ;o17cf
$17cd          23       INX H
$17ce          15       DCR D
$17cf o17cf:   c2 cc 17 JNZ j17cc
$17d2          3e 0f    MVI A, #0f
$17d4          32 8c 23 STA $238c
$17d7          32 ac 23 STA $23ac
$17da          32 96 23 STA $2396
$17dd          32 b6 23 STA $23b6
$17e0          21 ff ff LXI H, #ffff
$17e3          22 9c 23 SHLD $239c
$17e6          22 bc 23 SHLD $23bc
$17e9          c9       RET

 
$17ea c17ea:   3a 7e 23 LDA $237e ;o1880,o18fc
$17ed          e6 02    ANI #02
$17ef          3e 20    MVI A, #20
$17f1          c8       RZ
$17f2          21 90 21 LXI H, GAME_STATE
$17f5          3e 03    MVI A, #03
$17f7 o17f7:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$17fa          3e 20    MVI A, #20
$17fc          c0       RNZ
$17fd          3a 14 22 LDA $2214
$1800          fe 01    CPI #01
$1802          3e 20    MVI A, #20
$1804          c8       RZ
$1805          3e 80    MVI A, #80
$1807          c9       RET

$1808          21 92 21 LXI H, GAME_STATE2
$180b          3e 04    MVI A, #04
$180d o180d:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$1810 o1810:   c2 19 14 JNZ jo1419
$1813          21 08 22 LXI H, #2208
$1816          3e ff    MVI A, #ff
$1818          86       ADD M
$1819 o1819:   d2 23 18 JNC j1823
$181c          77       MOV M,A
$181d o181d:   ca 2b 18 JZ j182b
$1820 o1820:   c3 19 14 JMP jo1419
$1823 j1823:   3e 32    MVI A, #32 ;o1819
$1825          32 08 22 STA $2208
$1828 o1828:   c3 19 14 JMP jo1419
$182b j182b:   3e ff    MVI A, #ff ;o181d
$182d          32 93 21 STA $2193
$1830          3e 00    MVI A, #00
$1832          32 0c 22 STA $220c
$1835          32 c3 21 STA $21c3
$1838          32 a8 21 STA $21a8
$183b          32 a9 21 STA $21a9
$183e          3a 94 21 LDA STATE_OUTLANE_1
$1841          f6 30    ORI #30
$1843          32 94 21 STA STATE_OUTLANE_1
$1846          21 90 21 LXI H, GAME_STATE
$1849          3e 02    MVI A, #02
$184b o184b:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$184e          21 92 21 LXI H, GAME_STATE2
$1851          3e 04    MVI A, #04
$1853 o1853:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$1856          21 e8 12 LXI H, OOPS2_MUSIC
$1859 o1859:   cd 61 12 CALL cPLAY_SOUND
$185c o185c:   cd a8 1b CALL c1ba8
$185f          eb       XCHG
$1860          21 c6 21 LXI H, #21c6
$1863          3e 10    MVI A, #10
$1865 o1865:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1868          21 90 21 LXI H, GAME_STATE
$186b          3e 00    MVI A, #00
$186d o186d:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$1870 o1870:   c2 7b 18 JNZ j187b
$1873          06 39    MVI B, #39
$1875 o1875:   cd 9c 1d CALL co1d9c
$1878 o1878:   c2 89 18 JNZ j1889
$187b j187b:   3e 02    MVI A, #02 ;o1870
$187d          32 a0 21 STA $21a0
$1880 o1880:   cd ea 17 CALL c17ea
$1883          32 1c 22 STA $221c
$1886 o1886:   c3 19 14 JMP jo1419
$1889 j1889:   2a 5c 23 LHLD $235c ;o1878
$188c          29       DAD H
$188d          29       DAD H
$188e          29       DAD H
$188f          29       DAD H
$1890          22 f3 21 SHLD SPREAD_1
$1893          2a 5d 23 LHLD $235d
$1896          29       DAD H
$1897          29       DAD H
$1898          29       DAD H
$1899          29       DAD H
$189a          7c       MOV A,H
$189b          32 f5 21 STA $21f5
$189e          21 f3 21 LXI H, SPREAD_1
$18a1          11 0d 22 LXI D, #220d
$18a4          3e 06    MVI A, #06
$18a6 o18a6:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$18a9          3e 04    MVI A, #04
$18ab j18ab:   f5       PUSH PSW ;o18b6
$18ac          21 0d 22 LXI H, #220d
$18af          3e 06    MVI A, #06
$18b1 o18b1:   cd ec 0d CALL c0dec
$18b4          f1       POP PSW
$18b5          3d       DCR A
$18b6 o18b6:   c2 ab 18 JNZ j18ab
$18b9          21 f3 21 LXI H, SPREAD_1
$18bc o18bc:   cd 6f 0e CALL c0e6f
$18bf          3e 3c    MVI A, #3c
$18c1          32 ae 21 STA $21ae
$18c4          21 35 13 LXI H, SPREAD_HRM_MUSIC
$18c7 o18c7:   cd 61 12 CALL cPLAY_SOUND
$18ca o18ca:   c3 19 14 JMP jo1419
$18cd          21 65 11 LXI H, #1165
$18d0 o18d0:   cd 99 0e CALL c0e99
$18d3 o18d3:   da ea 18 JC j18ea
$18d6          21 65 11 LXI H, #1165
$18d9 o18d9:   cd 92 02 CALL cADD_BONUS_HL
$18dc          3e 0a    MVI A, #0a
$18de          32 ae 21 STA $21ae
$18e1          21 32 13 LXI H, BUMPER_25_MUSIC
$18e4 o18e4:   cd 61 12 CALL cPLAY_SOUND
$18e7 o18e7:   c3 1e 06 JMP joEND_MAIN_LOOP
$18ea j18ea:   21 65 11 LXI H, #1165 ;o18d3
$18ed o18ed:   cd 5c 0e CALL c0e5c
$18f0          21 5b 23 LXI H, #235b
$18f3 o18f3:   cd 3c 0f CALL c0f3c
$18f6          21 5b 23 LXI H, #235b
$18f9 o18f9:   cd 99 0e CALL c0e99
$18fc o18fc:   cd ea 17 CALL c17ea
$18ff          32 1c 22 STA $221c
$1902          3a 1c 22 LDA $221c
$1905          3d       DCR A
$1906          32 1c 22 STA $221c
$1909 o1909:   ca 14 19 JZ j1914
$190c          3e 02    MVI A, #02
$190e          32 a0 21 STA $21a0
$1911 o1911:   c3 1e 06 JMP joEND_MAIN_LOOP
$1914 j1914:   3e 01    MVI A, #01 ;o1909
$1916          32 12 22 STA $2212
$1919          3e 32    MVI A, #32
$191b          32 94 21 STA STATE_OUTLANE_1
$191e          21 92 21 LXI H, GAME_STATE2
$1921          3e 03    MVI A, #03
$1923 o1923:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$1926          21 7b 23 LXI H, BALL_IN_PLAY_hrm
$1929          3a 13 22 LDA BALLS_PER_GAME
$192c          96       SUB M
$192d o192d:   f2 3b 19 JP j193b
$1930 o1930:   cd 3a 1a CALL c1a3a
$1933          7e       MOV A,M
$1934          b0       ORA B
$1935          77       MOV M,A
$1936          19       DAD D
$1937          77       MOV M,A
$1938 o1938:   c3 76 19 JMP j1976
$193b j193b:   3a 7b 23 LDA BALL_IN_PLAY_hrm ;o192d
$193e          b7       ORA A
$193f          3e 01    MVI A, #01
$1941          21 7e 23 LXI H, #237e
$1944 o1944:   ca 8a 1a JZ j1a8a
$1947          3e 04    MVI A, #04
$1949 jo1949:  cd ee 03 CALL cCHECK_ATH_BIT_OF_HL ;o1952
$194c o194c:   c2 55 19 JNZ jo1955
$194f          3c       INR A
$1950          fe 08    CPI #08
$1952 o1952:   c2 49 19 JNZ jo1949
$1955 jo1955:  cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL ;o194c
$1958          3c       INR A
$1959          4f       MOV C,A
$195a          d6 04    SUI #04
$195c o195c:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$195f          79       MOV A,C
$1960 o1960:   c2 98 1a JNZ jo1a98
$1963          3a 13 22 LDA BALLS_PER_GAME
$1966          3c       INR A
$1967          47       MOV B,A
$1968          3a 7b 23 LDA BALL_IN_PLAY_hrm
$196b          3c       INR A
$196c          b8       CMP B
$196d o196d:   c2 8a 1a JNZ j1a8a
$1970          32 7b 23 STA BALL_IN_PLAY_hrm
$1973          32 bb 23 STA BALL_IN_PLAY_2
$1976 j1976:   3e ff    MVI A, #ff ;o1938
$1978          32 9b 23 STA BALL_IN_PLAY_1
$197b          3a 46 22 LDA $2246
$197e          b7       ORA A
$197f o197f:   ca bf 19 JZ j19bf
$1982          21 7e 23 LXI H, #237e
$1985          47       MOV B,A
$1986          7e       MOV A,M
$1987          e6 0f    ANI #0f
$1989          77       MOV M,A
$198a          78       MOV A,B
$198b          06 00    MVI B, #00
$198d j198d:   1f       RAR ;o1992
$198e o198e:   da 95 19 JC j1995
$1991          04       INR B
$1992 o1992:   c3 8d 19 JMP j198d
$1995 j1995:   eb       XCHG ;o198e
$1996          21 46 22 LXI H, #2246
$1999          78       MOV A,B
$199a          32 45 22 STA $2245
$199d o199d:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$19a0          c6 04    ADI #04
$19a2          eb       XCHG
$19a3 o19a3:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$19a6 o19a6:   cd 3a 1a CALL c1a3a
$19a9          7e       MOV A,M
$19aa          b0       ORA B
$19ab          77       MOV M,A
$19ac          3a 96 23 LDA $2396
$19af          e6 df    ANI #df
$19b1          32 96 23 STA $2396
$19b4          3a 90 21 LDA GAME_STATE
$19b7          f6 08    ORI #08
$19b9          32 90 21 STA GAME_STATE
$19bc o19bc:   c3 ae 1a JMP j1aae
$19bf j19bf:   21 91 21 LXI H, #2191 ;o197f
$19c2          3e 00    MVI A, #00
$19c4 o19c4:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$19c7          3e 01    MVI A, #01
$19c9 o19c9:   c2 8a 1a JNZ j1a8a
$19cc          3a 92 21 LDA GAME_STATE2
$19cf          f6 c0    ORI #c0
$19d1          32 92 21 STA GAME_STATE2
$19d4 o19d4:   cd b7 1d CALL c1db7
$19d7          21 b6 23 LXI H, #23b6
$19da          3e 07    MVI A, #07
$19dc o19dc:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$19df          3a 96 23 LDA $2396
$19e2          e6 cf    ANI #cf
$19e4          32 96 23 STA $2396
$19e7          3a b6 23 LDA $23b6
$19ea          e6 cf    ANI #cf
$19ec          32 b6 23 STA $23b6
$19ef          3a ac 23 LDA $23ac
$19f2          e6 30    ANI #30
$19f4 o19f4:   ca 00 1a JZ j1a00
$19f7          fe 10    CPI #10
$19f9          3e 05    MVI A, #05
$19fb o19fb:   ca 00 1a JZ j1a00
$19fe          3e 0a    MVI A, #0a
$1a00 j1a00:   32 be 23 STA $23be ;o19f4,o19fb
$1a03          97       SUB A
$1a04          32 9e 23 STA $239e
$1a07          3a 8c 23 LDA $238c
$1a0a          e6 0f    ANI #0f
$1a0c          32 8c 23 STA $238c
$1a0f          3a 47 22 LDA $2247
$1a12          e6 08    ANI #08
$1a14 o1a14:   ca 24 1a JZ j1a24
$1a17          3e 04    MVI A, #04
$1a19          32 17 22 STA $2217
$1a1c          3e 7a    MVI A, #7a
$1a1e          32 a3 21 STA $21a3
$1a21 o1a21:   c3 2a 1a JMP j1a2a
$1a24 j1a24:   21 ff 12 LXI H, GAME_OVER_MUSIC ;o1a14
$1a27 o1a27:   cd 61 12 CALL cPLAY_SOUND
$1a2a j1a2a:   3e 00    MVI A, #00 ;o1a21
$1a2c          32 9b 23 STA BALL_IN_PLAY_1
$1a2f          32 bb 23 STA BALL_IN_PLAY_2
$1a32          3e fa    MVI A, #fa
$1a34          32 9e 21 STA $219e
$1a37 o1a37:   c3 1e 06 JMP joEND_MAIN_LOOP
 
$1a3a c1a3a:   21 56 1a LXI H, #1a56 ;o1930,o19a6
$1a3d          3a 45 22 LDA $2245
$1a40          87       ADD A
$1a41          01 00 00 LXI B, #0000
$1a44          4f       MOV C,A
$1a45          09       DAD B
$1a46          5e       MOV E,M
$1a47          23       INX H
$1a48          56       MOV D,M
$1a49          21 5e 1a LXI H, #1a5e
$1a4c          79       MOV A,C
$1a4d          1f       RAR
$1a4e          4f       MOV C,A
$1a4f          09       DAD B
$1a50          46       MOV B,M
$1a51          eb       XCHG
$1a52          11 20 00 LXI D, #0020
$1a55          c9       RET

$1a56          8c       DB #8c
$1a57          23       DB #23
$1a58          8b       DB #8b
$1a59          23       DB #23
$1a5a          8b       DB #8b
$1a5b          23       DB #23
$1a5c          8a       DB #8a
$1a5d          23       DB #23
$1a5e          0f       DB #0f
$1a5f          f0       DB #f0
$1a60          0f       DB #0f
$1a61          f0       DB #f0
$1a62          21 17 22 LXI H, #2217
$1a65          35       DCR M
$1a66 o1a66:   ca 71 1a JZ jo1a71
$1a69          3e 72    MVI A, #72
$1a6b          32 a3 21 STA $21a3
$1a6e o1a6e:   c3 1e 06 JMP joEND_MAIN_LOOP
$1a71 jo1a71:  cd d3 06 CALL c06d3 ;o1a66
$1a74          3a 47 22 LDA $2247
$1a77          e6 f7    ANI #f7
$1a79          32 47 22 STA $2247
$1a7c          3e 07    MVI A, #07
$1a7e          21 b3 23 LXI H, HIGH_SCORE_DISP3
$1a81          11 93 23 LXI D, HIGH_SCORE_NOW
$1a84 o1a84:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1a87 o1a87:   c3 1e 06 JMP joEND_MAIN_LOOP
$1a8a j1a8a:   32 7b 23 STA BALL_IN_PLAY_hrm ;o1944,o196d,o19c9
$1a8d          32 9b 23 STA BALL_IN_PLAY_1
$1a90          32 bb 23 STA BALL_IN_PLAY_2
$1a93          3e 04    MVI A, #04
$1a95          21 7e 23 LXI H, #237e
$1a98 jo1a98:  cd d6 03 CALL cSET_ATH_BIT_OF_HL ;o1960
$1a9b          3a 13 22 LDA BALLS_PER_GAME
$1a9e          4f       MOV C,A
$1a9f          3a 7b 23 LDA BALL_IN_PLAY_hrm
$1aa2          b9       CMP C
$1aa3 o1aa3:   c2 ae 1a JNZ j1aae
$1aa6          21 90 21 LXI H, GAME_STATE
$1aa9          3e 04    MVI A, #04
$1aab o1aab:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$1aae j1aae:   3a 7e 23 LDA $237e ;o19bc,o1aa3
$1ab1          32 be 23 STA $23be
$1ab4          47       MOV B,A
$1ab5          e6 0f    ANI #0f
$1ab7          32 9e 23 STA $239e
$1aba          21 90 21 LXI H, GAME_STATE
$1abd          3e 00    MVI A, #00
$1abf o1abf:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$1ac2          06 09    MVI B, #09
$1ac4 o1ac4:   cd 81 1d CALL co1d81
$1ac7          21 b6 23 LXI H, #23b6
$1aca          3e 04    MVI A, #04
$1acc o1acc:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$1acf          3e 02    MVI A, #02
$1ad1          32 a1 21 STA $21a1
$1ad4 o1ad4:   c3 1e 06 JMP joEND_MAIN_LOOP
$1ad7          3a 12 22 LDA $2212
$1ada          3d       DCR A
$1adb          32 12 22 STA $2212
$1ade o1ade:   ca ef 1a JZ j1aef
$1ae1          21 21 13 LXI H, MORSE_CODE_MUSIC
$1ae4 o1ae4:   cd 61 12 CALL cPLAY_SOUND
$1ae7          3e a0    MVI A, #a0
$1ae9          32 a1 21 STA $21a1
$1aec o1aec:   c3 1e 06 JMP joEND_MAIN_LOOP
$1aef j1aef:   21 49 11 LXI H, #1149 ;o1ade
$1af2 o1af2:   cd 6f 0e CALL c0e6f
$1af5          3a c9 21 LDA $21c9
$1af8          32 18 22 STA $2218
$1afb          3a ce 21 LDA $21ce
$1afe          32 19 22 STA $2219
$1b01 o1b01:   cd a8 1b CALL c1ba8
$1b04          11 c6 21 LXI D, #21c6
$1b07          3e 10    MVI A, #10
$1b09 o1b09:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1b0c          21 c9 21 LXI H, #21c9
$1b0f          11 ce 21 LXI D, #21ce
$1b12          3e 0a    MVI A, #0a
$1b14 o1b14:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1b17          06 2b    MVI B, #2b
$1b19 o1b19:   cd 76 1d CALL co1d76
$1b1c          06 2c    MVI B, #2c
$1b1e o1b1e:   cd 76 1d CALL co1d76
$1b21          06 04    MVI B, #04
$1b23 o1b23:   cd 76 1d CALL co1d76
$1b26          06 0c    MVI B, #0c
$1b28 o1b28:   cd 76 1d CALL co1d76
$1b2b          06 14    MVI B, #14
$1b2d o1b2d:   cd 76 1d CALL co1d76
$1b30          06 11    MVI B, #11
$1b32 o1b32:   cd 81 1d CALL co1d81
$1b35          06 38    MVI B, #38
$1b37 o1b37:   cd 81 1d CALL co1d81
$1b3a          06 31    MVI B, #31
$1b3c o1b3c:   cd 81 1d CALL co1d81
$1b3f          06 09    MVI B, #09
$1b41 o1b41:   cd 81 1d CALL co1d81
$1b44          3a 18 22 LDA $2218
$1b47          e6 41    ANI #41
$1b49          47       MOV B,A
$1b4a          3a c9 21 LDA $21c9
$1b4d          e6 be    ANI #be
$1b4f          b0       ORA B
$1b50          32 c9 21 STA $21c9
$1b53          3a 19 22 LDA $2219
$1b56          e6 41    ANI #41
$1b58          47       MOV B,A
$1b59          3a ce 21 LDA $21ce
$1b5c          e6 be    ANI #be
$1b5e          b0       ORA B
$1b5f          32 ce 21 STA $21ce
$1b62          06 39    MVI B, #39
$1b64 o1b64:   cd 81 1d CALL co1d81
$1b67          21 92 21 LXI H, GAME_STATE2
$1b6a          3e 07    MVI A, #07
$1b6c o1b6c:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$1b6f          21 46 13 LXI H, NEXT_PLAYER_MUSIC
$1b72 o1b72:   cd 61 12 CALL cPLAY_SOUND
$1b75          3a 14 22 LDA $2214
$1b78          3d       DCR A
$1b79          32 14 22 STA $2214
$1b7c          d6 02    SUI #02
$1b7e o1b7e:   fa a5 1b JM jo1ba5
$1b81 o1b81:   c2 a5 1b JNZ jo1ba5
$1b84          3a 7e 23 LDA $237e
$1b87          06 00    MVI B, #00
$1b89          e6 0f    ANI #0f
$1b8b j1b8b:   1f       RAR ;o1b90
$1b8c o1b8c:   d2 93 1b JNC j1b93
$1b8f          04       INR B
$1b90 o1b90:   c3 8b 1b JMP j1b8b
$1b93 j1b93:   3a 7a 23 LDA CREDITS_1 ;o1b8c
$1b96          90       SUB B
$1b97 o1b97:   f2 a5 1b JP jo1ba5
$1b9a          06 00    MVI B, #00
$1b9c o1b9c:   cd 9c 1d CALL co1d9c
$1b9f o1b9f:   c2 a5 1b JNZ jo1ba5
$1ba2 o1ba2:   cd 76 1d CALL co1d76
$1ba5 jo1ba5:  c3 1e 06 JMP joEND_MAIN_LOOP ;o1b7e,o1b81,o1b97,o1b9f
 
$1ba8 c1ba8:   3a 7e 23 LDA $237e ;o185c,o1b01
$1bab          e6 f0    ANI #f0
$1bad          21 eb 21 LXI H, #21eb
$1bb0          11 f8 ff LXI D, #fff8
$1bb3 j1bb3:   17       RAL ;o1bb6
$1bb4          d8       RC
$1bb5          19       DAD D
$1bb6 o1bb6:   c3 b3 1b JMP j1bb3
$1bb9 j1bb9:   fb       EI ;o0284
$1bba          21 15 22 LXI H, #2215
$1bbd          db 04    IN PRICE_89_CAB
$1bbf          77       MOV M,A
$1bc0          e6 40    ANI #40
$1bc2 o1bc2:   c2 73 1c JNZ j1c73
$1bc5          f3       DI
$1bc6          3a 53 23 LDA $2353
$1bc9          47       MOV B,A
$1bca          3a f8 23 LDA $23f8
$1bcd          90       SUB B
$1bce          3a 94 21 LDA STATE_OUTLANE_1
$1bd1 o1bd1:   fa d9 1b JM j1bd9
$1bd4          e6 fd    ANI #fd
$1bd6 o1bd6:   c3 db 1b JMP j1bdb
$1bd9 j1bd9:   f6 02    ORI #02 ;o1bd1
$1bdb j1bdb:   32 94 21 STA STATE_OUTLANE_1 ;o1bd6
$1bde          3a 92 21 LDA GAME_STATE2
$1be1          47       MOV B,A
$1be2          e6 01    ANI #01
$1be4 o1be4:   ca 04 1c JZ j1c04
$1be7          78       MOV A,B
$1be8          e6 fe    ANI #fe
$1bea          32 92 21 STA GAME_STATE2
$1bed          fb       EI
$1bee          21 4b 22 LXI H, #224b
$1bf1          11 80 23 LXI D, #2380
$1bf4          3e 34    MVI A, #34
$1bf6 o1bf6:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1bf9          21 6b 22 LXI H, #226b
$1bfc          11 a0 23 LXI D, #23a0
$1bff          3e 34    MVI A, #34
$1c01 o1c01:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1c04 j1c04:   3a 15 22 LDA $2215 ;o1be4
$1c07          e6 20    ANI #20
$1c09 o1c09:   c2 c3 1c JNZ j1cc3
$1c0c          fb       EI
$1c0d          21 2d 22 LXI H, HIGH_SCORE_START
$1c10          11 b3 23 LXI D, HIGH_SCORE_DISP3
$1c13          3e 07    MVI A, #07
$1c15 o1c15:   cd ea 0e CALL cWRITE_TO_RAM
$1c18          21 89 11 LXI H, #1189
$1c1b          3a 47 22 LDA $2247
$1c1e          e6 08    ANI #08
$1c20 o1c20:   c2 26 1c JNZ j1c26
$1c23          21 b3 23 LXI H, HIGH_SCORE_DISP3
$1c26 j1c26:   11 93 23 LXI D, HIGH_SCORE_NOW ;o1c20
$1c29          3e 07    MVI A, #07
$1c2b o1c2b:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1c2e          3a 92 21 LDA GAME_STATE2
$1c31          e6 40    ANI #40
$1c33 o1c33:   ca 4e 1c JZ j1c4e
$1c36          3a 7a 23 LDA CREDITS_1
; seems pointless
$1c39          b7       ORA A
$1c3a          21 b6 23 LXI H, #23b6
$1c3d          3e 06    MVI A, #06
$1c3f o1c3f:   c2 48 1c JNZ jo1c48
$1c42 o1c42:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$1c45 o1c45:   c3 d2 01 JMP j01d2
$1c48 jo1c48:  cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL ;o1c3f
$1c4b o1c4b:   c3 d2 01 JMP j01d2
$1c4e j1c4e:   3a 91 21 LDA $2191 ;o1c33
$1c51          e6 01    ANI #01
$1c53          fb       EI
$1c54 o1c54:   ca d2 01 JZ j01d2
$1c57          db 03    IN PRICE_TENS_07_PORT
$1c59          fe fe    CPI #fe
$1c5b o1c5b:   c2 65 1c JNZ j1c65
$1c5e          db 02    IN PRICE_CENTS_07_PORT
$1c60          fe fb    CPI #fb
$1c62 o1c62:   ca dc 1c JZ j1cdc
$1c65 j1c65:   21 91 21 LXI H, #2191 ;o1c5b
$1c68          3e 00    MVI A, #00
$1c6a o1c6a:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$1c6d          32 9f 21 STA $219f
$1c70 o1c70:   c3 d2 01 JMP j01d2
$1c73 j1c73:   21 92 21 LXI H, GAME_STATE2 ;o1bc2
$1c76          3e 00    MVI A, #00
$1c78 o1c78:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$1c7b o1c7b:   c2 2c 02 JNZ j022c
$1c7e o1c7e:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$1c81          21 80 23 LXI H, #2380
$1c84          11 4b 22 LXI D, #224b
$1c87          3e 80    MVI A, #80
$1c89 o1c89:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1c8c          3e ff    MVI A, #ff
$1c8e          21 83 23 LXI H, PL3_SCORE_DISPLAY_2
$1c91          06 17    MVI B, #17
$1c93 j1c93:   77       MOV M,A ;o1c96
$1c94          23       INX H
$1c95          05       DCR B
$1c96 o1c96:   c2 93 1c JNZ j1c93
$1c99          3e 0f    MVI A, #0f
$1c9b          32 8c 23 STA $238c
$1c9e          21 20 23 LXI H, #2320
$1ca1          11 a3 23 LXI D, #23a3
$1ca4          3e 2e    MVI A, #2e
$1ca6 o1ca6:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1ca9          3a 61 22 LDA $2261
$1cac          f6 0f    ORI #0f
$1cae          32 96 23 STA $2396
$1cb1          3a 81 22 LDA $2281
$1cb4          e6 f0    ANI #f0
$1cb6          47       MOV B,A
$1cb7          3a b6 23 LDA $23b6
$1cba          e6 0f    ANI #0f
$1cbc          b0       ORA B
$1cbd          32 b6 23 STA $23b6
$1cc0 o1cc0:   c3 2c 02 JMP j022c
$1cc3 j1cc3:   3a 53 23 LDA $2353 ;o1c09
$1cc6          47       MOV B,A
$1cc7          3a f8 23 LDA $23f8
$1cca          90       SUB B
$1ccb o1ccb:   f2 2c 02 JP j022c
$1cce          21 92 21 LXI H, GAME_STATE2
$1cd1          3e 06    MVI A, #06
$1cd3 o1cd3:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$1cd6 o1cd6:   ca dc 1c JZ j1cdc
$1cd9 o1cd9:   c3 2c 02 JMP j022c
$1cdc j1cdc:   3a 7e 23 LDA $237e ;o1c62,o1cd6
$1cdf          32 9e 23 STA $239e
$1ce2          3a ac 23 LDA $23ac
$1ce5          32 8c 23 STA $238c
$1ce8          3a bb 23 LDA BALL_IN_PLAY_2
$1ceb          32 9b 23 STA BALL_IN_PLAY_1
$1cee          3a aa 23 LDA $23aa
$1cf1          32 8a 23 STA $238a
$1cf4          3a ab 23 LDA $23ab
$1cf7          32 8b 23 STA $238b
$1cfa          3a ac 23 LDA $23ac
$1cfd          32 8c 23 STA $238c
$1d00          3a 96 23 LDA $2396
$1d03          e6 ef    ANI #ef
$1d05          32 96 23 STA $2396
$1d08          3a b6 23 LDA $23b6
$1d0b          e6 ef    ANI #ef
$1d0d          32 b6 23 STA $23b6
$1d10          e6 20    ANI #20
$1d12          47       MOV B,A
$1d13          3a 96 23 LDA $2396
$1d16          b0       ORA B
$1d17          32 96 23 STA $2396
$1d1a          21 c2 21 LXI H, #21c2
$1d1d          3e 05    MVI A, #05
$1d1f o1d1f:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$1d22          3a c2 21 LDA $21c2
$1d25          2f       CMA
$1d26          d3 05    OUT COIL_5
$1d28          3e 80    MVI A, #80
$1d2a          32 93 21 STA $2193
$1d2d          3e 06    MVI A, #06
$1d2f          32 ac 21 STA $21ac
$1d32          3e 00    MVI A, #00
$1d34          32 94 21 STA STATE_OUTLANE_1
$1d37          3a 90 21 LDA GAME_STATE
$1d3a          e6 38    ANI #38
$1d3c          f6 80    ORI #80
$1d3e          32 90 21 STA GAME_STATE
$1d41          3a 92 21 LDA GAME_STATE2
$1d44          e6 67    ANI #67
$1d46          32 92 21 STA GAME_STATE2
$1d49          21 91 21 LXI H, #2191
$1d4c          3e 01    MVI A, #01
$1d4e o1d4e:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$1d51          21 94 21 LXI H, STATE_OUTLANE_1
$1d54          3e 04    MVI A, #04
$1d56 o1d56:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$1d59          3e 06    MVI A, #06
$1d5b          32 a8 21 STA $21a8
$1d5e          3e 05    MVI A, #05
$1d60          32 97 21 STA $2197
$1d63 o1d63:   c3 2c 02 JMP j022c
$1d66          21 c2 21 LXI H, #21c2
$1d69          3e 05    MVI A, #05
$1d6b o1d6b:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$1d6e          f3       DI
$1d6f o1d6f:   cd 7d 13 CALL jc137d
$1d72          fb       EI
$1d73 o1d73:   c3 1e 06 JMP joEND_MAIN_LOOP
 
$1d76 co1d76:  cd a3 1d CALL c1da3 ;o0ad6,o0b23,o0b3b,o0b63,o0e95,o14e9,o1511,o151c,o1b19,o1b1e,o1b23,o1b28,o1b2d,o1ba2
$1d79 o1d79:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$1d7c          19       DAD D
$1d7d o1d7d:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$1d80          c9       RET

 
$1d81 co1d81:  cd a3 1d CALL c1da3 ;o050c,o06e9,jo09da,o0b41,o0c2e,o0c33,o0d37,o0dbc,o14b1,jo1517,o159b,o1ac4,o1b32,o1b37,o1b3c,o1b41,o1b64
$1d84 o1d84:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$1d87          19       DAD D
$1d88 o1d88:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$1d8b          f5       PUSH PSW
$1d8c o1d8c:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$1d8f          f1       POP PSW
$1d90          c9       RET

 
$1d91 co1d91:  cd a3 1d CALL c1da3 ;jo0a14,o15a0
$1d94 o1d94:   cd d6 03 CALL cSET_ATH_BIT_OF_HL
$1d97          19       DAD D
$1d98 o1d98:   cd e1 03 CALL cCLEAR_ATH_BIT_OF_HL
$1d9b          c9       RET

 
$1d9c co1d9c:  cd a3 1d CALL c1da3 ;o0a03,o0b1b,o0b5d,o0be1,o0c07,o0c14,o0c26,o0db6,o1501,o1509,o1595,o1875,o1b9c
$1d9f o1d9f:   cd ee 03 CALL cCHECK_ATH_BIT_OF_HL
$1da2          c9       RET

 
$1da3 c1da3:   21 c9 21 LXI H, #21c9 ;co1d76,co1d81,co1d91,co1d9c
$1da6          16 00    MVI D, #00
$1da8          78       MOV A,B
$1da9          e6 07    ANI #07
$1dab          5f       MOV E,A
$1dac          19       DAD D
$1dad          78       MOV A,B
$1dae          1f       RAR
$1daf          1f       RAR
$1db0          1f       RAR
$1db1          e6 07    ANI #07
$1db3          11 05 00 LXI D, #0005
$1db6          c9       RET

 
$1db7 c1db7:   21 63 23 LXI H, PL1_SCORE_1 ;o19d4
$1dba o1dba:   cd d4 1f CALL c1fd4
$1dbd          21 6b 23 LXI H, PL2_SCORE_1
$1dc0          e5       PUSH H
$1dc1 o1dc1:   cd 18 0e CALL c0e18
$1dc4          e1       POP H
$1dc5 o1dc5:   d2 d4 1d JNC j1dd4
$1dc8          22 3d 22 SHLD $223d
$1dcb          21 63 23 LXI H, PL1_SCORE_1
$1dce          22 3f 22 SHLD $223f
$1dd1 o1dd1:   c3 dd 1d JMP j1ddd
$1dd4 j1dd4:   22 3f 22 SHLD $223f ;o1dc5
$1dd7          21 63 23 LXI H, PL1_SCORE_1
$1dda          22 3d 22 SHLD $223d
$1ddd j1ddd:   2a 3d 22 LHLD $223d ;o1dd1
$1de0 o1de0:   cd d4 1f CALL c1fd4
$1de3          21 5f 23 LXI H, PL3_SCORE_1
$1de6          e5       PUSH H
$1de7 o1de7:   cd 18 0e CALL c0e18
$1dea          e1       POP H
$1deb o1deb:   da 04 1e JC j1e04
$1dee          e5       PUSH H
$1def          2a 3f 22 LHLD $223f
$1df2 o1df2:   cd d4 1f CALL c1fd4
$1df5          e1       POP H
$1df6          e5       PUSH H
$1df7 o1df7:   cd 18 0e CALL c0e18
$1dfa          e1       POP H
$1dfb o1dfb:   da 0f 1e JC j1e0f
$1dfe          22 41 22 SHLD $2241
$1e01 o1e01:   c3 17 1e JMP j1e17
$1e04 j1e04:   e5       PUSH H ;o1deb
$1e05 o1e05:   cd 6a 1e CALL c1e6a
$1e08          e1       POP H
$1e09          22 3d 22 SHLD $223d
$1e0c o1e0c:   c3 17 1e JMP j1e17
$1e0f j1e0f:   e5       PUSH H ;o1dfb
$1e10 o1e10:   cd 6a 1e CALL c1e6a
$1e13          e1       POP H
$1e14          22 3f 22 SHLD $223f
$1e17 j1e17:   2a 3d 22 LHLD $223d ;o1e01,o1e0c
$1e1a o1e1a:   cd d4 1f CALL c1fd4
$1e1d          21 6f 23 LXI H, PL4_SCORE_1
$1e20          e5       PUSH H
$1e21 o1e21:   cd 18 0e CALL c0e18
$1e24          e1       POP H
$1e25 o1e25:   da 4e 1e JC j1e4e
$1e28          e5       PUSH H
$1e29          2a 3f 22 LHLD $223f
$1e2c o1e2c:   cd d4 1f CALL c1fd4
$1e2f          e1       POP H
$1e30          e5       PUSH H
$1e31 o1e31:   cd 18 0e CALL c0e18
$1e34          e1       POP H
$1e35 o1e35:   da 59 1e JC j1e59
$1e38          e5       PUSH H
$1e39          2a 41 22 LHLD $2241
$1e3c o1e3c:   cd d4 1f CALL c1fd4
$1e3f          e1       POP H
$1e40          e5       PUSH H
$1e41 o1e41:   cd 18 0e CALL c0e18
$1e44          e1       POP H
$1e45 o1e45:   da 77 1e JC j1e77
$1e48          22 43 22 SHLD $2243
$1e4b o1e4b:   c3 82 1e JMP j1e82
$1e4e j1e4e:   e5       PUSH H ;o1e25
$1e4f o1e4f:   cd 64 1e CALL c1e64
$1e52          e1       POP H
$1e53          22 3d 22 SHLD $223d
$1e56 o1e56:   c3 82 1e JMP j1e82
$1e59 j1e59:   e5       PUSH H ;o1e35
$1e5a o1e5a:   cd 6a 1e CALL c1e6a
$1e5d          e1       POP H
$1e5e          22 3f 22 SHLD $223f
$1e61 o1e61:   c3 82 1e JMP j1e82
 
$1e64 c1e64:   2a 41 22 LHLD $2241 ;o1e4f
$1e67          22 43 22 SHLD $2243
 
$1e6a c1e6a:   2a 3f 22 LHLD $223f ;o1e05,o1e10,o1e5a
$1e6d          22 41 22 SHLD $2241
$1e70          2a 3d 22 LHLD $223d
$1e73          22 3f 22 SHLD $223f
$1e76          c9       RET

$1e77 j1e77:   e5       PUSH H ;o1e45
$1e78          2a 41 22 LHLD $2241
$1e7b          22 43 22 SHLD $2243
$1e7e          e1       POP H
$1e7f          22 41 22 SHLD $2241
$1e82 j1e82:   21 2d 22 LXI H, HIGH_SCORE_START ;o1e4b,o1e56,o1e61
$1e85 o1e85:   cd d4 1f CALL c1fd4
$1e88          2a 3d 22 LHLD $223d
$1e8b          e5       PUSH H
$1e8c o1e8c:   cd 18 0e CALL c0e18
$1e8f          e1       POP H
$1e90 o1e90:   dc 5e 1f CC c1f5e
$1e93          d8       RC
$1e94          21 31 22 LXI H, #2231
$1e97 o1e97:   cd d4 1f CALL c1fd4
$1e9a          2a 3d 22 LHLD $223d
$1e9d          e5       PUSH H
$1e9e o1e9e:   cd 18 0e CALL c0e18
$1ea1          e1       POP H
$1ea2 o1ea2:   dc 7e 1f CC c1f7e
$1ea5          d8       RC
$1ea6          21 35 22 LXI H, #2235
$1ea9 o1ea9:   cd d4 1f CALL c1fd4
$1eac          2a 3d 22 LHLD $223d
$1eaf          e5       PUSH H
$1eb0 o1eb0:   cd 18 0e CALL c0e18
$1eb3          e1       POP H
$1eb4 o1eb4:   dc 8f 1f CC c1f8f
$1eb7          d8       RC
$1eb8          21 39 22 LXI H, #2239
$1ebb o1ebb:   cd d4 1f CALL c1fd4
$1ebe          2a 3d 22 LHLD $223d
$1ec1          e5       PUSH H
$1ec2 o1ec2:   cd 18 0e CALL c0e18
$1ec5          e1       POP H
$1ec6 o1ec6:   dc a0 1f CC c1fa0
$1ec9          c9       RET

$1eca          21 31 22 LXI H, #2231
$1ecd o1ecd:   cd d4 1f CALL c1fd4
$1ed0          2a 3f 22 LHLD $223f
$1ed3          e5       PUSH H
$1ed4 o1ed4:   cd 18 0e CALL c0e18
$1ed7          e1       POP H
$1ed8 o1ed8:   dc 7e 1f CC c1f7e
$1edb          d8       RC
$1edc          21 35 22 LXI H, #2235
$1edf o1edf:   cd d4 1f CALL c1fd4
$1ee2          2a 3f 22 LHLD $223f
$1ee5          e5       PUSH H
$1ee6 o1ee6:   cd 18 0e CALL c0e18
$1ee9          e1       POP H
$1eea o1eea:   dc 8f 1f CC c1f8f
$1eed          d8       RC
$1eee          21 39 22 LXI H, #2239
$1ef1 o1ef1:   cd d4 1f CALL c1fd4
$1ef4          2a 3f 22 LHLD $223f
$1ef7          e5       PUSH H
$1ef8 o1ef8:   cd 18 0e CALL c0e18
$1efb          e1       POP H
$1efc o1efc:   dc a0 1f CC c1fa0
$1eff          c9       RET

$1f00          21 35 22 LXI H, #2235
$1f03 o1f03:   cd d4 1f CALL c1fd4
$1f06          2a 41 22 LHLD $2241
$1f09          e5       PUSH H
$1f0a o1f0a:   cd 18 0e CALL c0e18
$1f0d          e1       POP H
$1f0e o1f0e:   dc 8f 1f CC c1f8f
$1f11          d8       RC
$1f12          21 39 22 LXI H, #2239
$1f15 o1f15:   cd d4 1f CALL c1fd4
$1f18          2a 41 22 LHLD $2241
$1f1b          e5       PUSH H
$1f1c o1f1c:   cd 18 0e CALL c0e18
$1f1f          e1       POP H
$1f20 o1f20:   dc a0 1f CC c1fa0
$1f23          c9       RET

$1f24          21 39 22 LXI H, #2239
$1f27 o1f27:   cd d4 1f CALL c1fd4
$1f2a          2a 43 22 LHLD $2243
$1f2d          e5       PUSH H
$1f2e o1f2e:   cd 18 0e CALL c0e18
$1f31          e1       POP H
$1f32 o1f32:   dc a0 1f CC c1fa0
$1f35          c9       RET

 
$1f36 c1f36:   f5       PUSH PSW ;o1f61,o1f81,o1f92
$1f37          21 35 22 LXI H, #2235
$1f3a          e5       PUSH H
$1f3b          11 39 22 LXI D, #2239
$1f3e          3e 07    MVI A, #07
$1f40 o1f40:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1f43          d1       POP D
$1f44          f1       POP PSW
$1f45          3d       DCR A
$1f46          c8       RZ
$1f47          f5       PUSH PSW
$1f48          21 31 22 LXI H, #2231
$1f4b          e5       PUSH H
$1f4c          3e 07    MVI A, #07
$1f4e o1f4e:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1f51          d1       POP D
$1f52          f1       POP PSW
$1f53          3d       DCR A
$1f54          c8       RZ
$1f55          21 2d 22 LXI H, HIGH_SCORE_START
$1f58          3e 07    MVI A, #07
$1f5a o1f5a:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1f5d          c9       RET

 
$1f5e c1f5e:   e5       PUSH H ;o1e90
$1f5f          3e 03    MVI A, #03
$1f61 o1f61:   cd 36 1f CALL c1f36
$1f64          e1       POP H
$1f65          11 2d 22 LXI D, HIGH_SCORE_START
$1f68          3e 07    MVI A, #07
$1f6a o1f6a:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1f6d          21 51 13 LXI H, HIGH_SCORE_MUSIC
$1f70 o1f70:   cd 61 12 CALL cPLAY_SOUND
$1f73          3a 47 22 LDA $2247
$1f76          f6 08    ORI #08
$1f78          32 47 22 STA $2247
$1f7b          b7       ORA A
$1f7c          3f       CMC
$1f7d          c9       RET

 
$1f7e c1f7e:   e5       PUSH H ;o1ea2,o1ed8
$1f7f          3e 02    MVI A, #02
$1f81 o1f81:   cd 36 1f CALL c1f36
$1f84          e1       POP H
$1f85          11 31 22 LXI D, #2231
$1f88          3e 07    MVI A, #07
$1f8a o1f8a:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1f8d          3f       CMC
$1f8e          c9       RET

 
$1f8f c1f8f:   e5       PUSH H ;o1eb4,o1eea,o1f0e
$1f90          3e 01    MVI A, #01
$1f92 o1f92:   cd 36 1f CALL c1f36
$1f95          e1       POP H
$1f96          11 35 22 LXI D, #2235
$1f99          3e 07    MVI A, #07
$1f9b o1f9b:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1f9e          3f       CMC
$1f9f          c9       RET

 
$1fa0 c1fa0:   11 39 22 LXI D, #2239 ;o1ec6,o1efc,o1f20,o1f32
$1fa3          3e 07    MVI A, #07
$1fa5 o1fa5:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1fa8          3f       CMC
$1fa9          c9       RET

 
$1faa c1faa:   21 31 22 LXI H, #2231 ;o0707,o08f4
$1fad          e5       PUSH H
$1fae          11 2d 22 LXI D, HIGH_SCORE_START
$1fb1          3e 07    MVI A, #07
$1fb3 o1fb3:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1fb6          d1       POP D
$1fb7          21 35 22 LXI H, #2235
$1fba          e5       PUSH H
$1fbb          3e 07    MVI A, #07
$1fbd o1fbd:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1fc0          d1       POP D
$1fc1          21 39 22 LXI H, #2239
$1fc4          e5       PUSH H
$1fc5          3e 07    MVI A, #07
$1fc7 o1fc7:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1fca          21 81 11 LXI H, #1181
$1fcd          d1       POP D
$1fce          3e 07    MVI A, #07
$1fd0 o1fd0:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1fd3          c9       RET

 
$1fd4 c1fd4:   11 f3 21 LXI D, SPREAD_1 ;o1dba,o1de0,o1df2,o1e1a,o1e2c,o1e3c,o1e85,o1e97,o1ea9,o1ebb,o1ecd,o1edf,o1ef1,o1f03,o1f15,o1f27
$1fd7          3e 00    MVI A, #00
$1fd9          06 04    MVI B, #04
$1fdb j1fdb:   12       STAX D ;o1fde
$1fdc          13       INX D
$1fdd          05       DCR B
$1fde o1fde:   c2 db 1f JNZ j1fdb
$1fe1          11 f3 21 LXI D, SPREAD_1
$1fe4          3e 07    MVI A, #07
$1fe6 o1fe6:   cd cf 0e CALL cCOPY_FROM_HL_TO_DE
$1fe9          3e 07    MVI A, #07
$1feb          c9       RET

$1fec          00       NOP
$1fed          00       NOP
$1fee          00       NOP
$1fef          60       MOV H,B
$1ff0          2c       INR L
$1ff1          02       STAX B
$1ff2          00       NOP
$1ff3          00       NOP
$1ff4          4c       MOV C,H
$1ff5          4f       MOV C,A
$1ff6          4f       MOV C,A
$1ff7          50       MOV D,B
$1ff8          32 3e b1 STA $b13e
$1ffb          00       NOP
$1ffc          00       NOP
$1ffd          00       NOP
$1ffe          60       MOV H,B
$1fff          92       SUB D
