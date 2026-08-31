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
HARD_RESET EQU 0x5d
CUPS_LEFT EQU 0x21c7
GAME_STATE EQU 0x2190
GAME_STATE2 EQU 0x2192
STACK_SCRATCH EQU 0x2195
LEFT_SLING_TONE EQU 0x12b9
RIGHT_SLING_TONE EQU 0x12bc
SILENCE_END_LOOP_MUSIC EQU 0x12bf
TILT_MUSIC EQU 0x12c2
BONUS_MUSIC EQU 0x12d7
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
SWITCH_PORT EQU 0x0
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
$0003 o0003:   cd b4 06 CALL CREDIT_HANDLER
$0006 o0006:   c3 82 03 JMP jo0382
 
$0009 c0009:   3e 01    MVI A, #01 ;o1606
$000b          32 7a 23 STA CREDITS_1
$000e          c9       RET

$000f          00       NOP
$0010          00       NOP
$0011          00       NOP
$0012          00       NOP
$0013          00       NOP
$0014          00       NOP
$0015          00       NOP
$0016          00       NOP
$0017          00       NOP
 
$0018 c0018:   3e 3c    MVI A, #3c ;jo0aac
$001a          32 a5 21 STA $21a5
 
$001d c001d:   21 7d 11 LXI H, #117d ;jo151f
$0020 o0020:   cd 5c 0e CALL ADD_BONUS
$0023          c9       RET

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
$0034 o0034:   c3 86 03 JMP SWITCH_HANDLER
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
$0092          32 93 21 STA STATE_OUTLANE_1
$0095          3e fc    MVI A, #fc
$0097          32 94 21 STA SWITCH_LATCHED
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
$00c8 o00c8:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$00cb          21 7d 11 LXI H, #117d
$00ce          11 31 22 LXI D, #2231
$00d1          3e 08    MVI A, #08
$00d3 o00d3:   cd cf 0e CALL COPY_FROM_HL_TO_DE
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
$0145          47       MOV B,A
$0146          e6 20    ANI #20
$0148 o0148:   c2 68 01 JNZ jo0168
$014b          3a 92 21 LDA GAME_STATE2
$014e          e6 df    ANI #df
$0150          32 92 21 STA GAME_STATE2
$0153          78       MOV A,B
$0154          e6 10    ANI #10
$0156 o0156:   c2 9e 02 JNZ TEST_ROUTINE_1
$0159          78       MOV A,B
$015a          e6 40    ANI #40
$015c o015c:   c2 c8 02 JNZ TEST_ROUTINE_2
$015f          21 ff 12 LXI H, GAME_OVER_MUSIC
$0162 o0162:   cd 61 12 CALL PLAY_SOUND
$0165 o0165:   c3 bf 01 JMP j01bf
$0168 jo0168:  cd a8 17 CALL c17a8 ;o0148,o02c5
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
$019d o019d:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$01a0          06 01    MVI B, #01
$01a2          11 c6 21 LXI D, ROLLOVERS
$01a5 o01a5:   cd 8e 17 CALL jc178e
$01a8          21 c9 21 LXI H, #21c9
$01ab          11 ce 21 LXI D, #21ce
$01ae          3e 0a    MVI A, #0a
$01b0 o01b0:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$01b3          21 05 22 LXI H, #2205
$01b6          06 13    MVI B, #13
$01b8          97       SUB A
$01b9 j01b9:   77       MOV M,A ;o01bc
$01ba          23       INX H
$01bb          05       DCR B
$01bc o01bc:   c2 b9 01 JNZ j01b9
$01bf j01bf:   f3       DI ;o0165,o02a4
$01c0          3e 30    MVI A, #30
$01c2          32 94 21 STA SWITCH_LATCHED
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
$0218 o0218:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$021b o021b:   c2 28 02 JNZ j0228
$021e          04       INR B
$021f          3e 01    MVI A, #01
$0221 o0221:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
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
$0278 o0278:   cd 3c 0f CALL ADD_PTS
$027b j027b:   fb       EI ;o025c,o026d
$027c          21 92 21 LXI H, GAME_STATE2
$027f          3e 07    MVI A, #07
$0281 o0281:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$0284 o0284:   c2 b9 1b JNZ j1bb9
$0287          3a b6 23 LDA $23b6
$028a          e6 bf    ANI #bf
$028c          32 b6 23 STA $23b6
$028f o028f:   c3 2c 02 JMP j022c
 
$0292 ADD_BONUS_HL:
         eb       XCHG ;o07c8,o0ce8,o0dc5,o0dd4,o14b7,o15ca,o18d9
$0293          2a f9 21 LHLD $21f9
$0296          73       MOV M,E
$0297          23       INX H
$0298          72       MOV M,D
$0299          23       INX H
$029a          22 f9 21 SHLD $21f9
$029d          c9       RET

$029e TEST_ROUTINE_1:
         3a 91 21 LDA CONTROL_FLAGS ;o0156
$02a1          47       MOV B,A
$02a2          e6 01    ANI #01
$02a4 o02a4:   c2 bf 01 JNZ j01bf
$02a7          78       MOV A,B
$02a8          f6 01    ORI #01
$02aa          32 91 21 STA CONTROL_FLAGS
$02ad          f3       DI
$02ae          3e 30    MVI A, #30
$02b0          32 94 21 STA SWITCH_LATCHED
$02b3          3e 7d    MVI A, #7d
$02b5          32 9f 21 STA $219f
$02b8          3e 3c    MVI A, #3c
$02ba          32 1f 22 STA $221f
$02bd          3e 00    MVI A, #00
$02bf          32 20 22 STA $2220
$02c2          32 21 22 STA $2221
$02c5 o02c5:   c3 68 01 JMP jo0168
$02c8 TEST_ROUTINE_2:
         f3       DI ;o015c
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
$0330 jo0330:  cd 24 06 CALL SAVE_BDPSW ;o002c
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
$0351          21 93 21 LXI H, STATE_OUTLANE_1
$0354 o0354:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$0357 o0357:   c2 82 03 JNZ jo0382
$035a o035a:   cd 24 06 CALL SAVE_BDPSW
$035d          3a 91 21 LDA CONTROL_FLAGS
$0360          e6 02    ANI #02
$0362 o0362:   c4 02 04 CNZ c0402
$0365 o0365:   cd 30 06 CALL RESTORE_BDPSW
$0368 o0368:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$036b          eb       XCHG
$036c          29       DAD H
$036d          11 b6 03 LXI D, #03b6
$0370          19       DAD D
$0371          7e       MOV A,M
$0372          23       INX H
$0373          66       MOV H,M
$0374          6f       MOV L,A
$0375          e9       PCHL
$0376 j0376:   21 94 21 LXI H, SWITCH_LATCHED ;o0606,o13e7,o178b
$0379 o0379:   c3 7f 03 JMP jo037f
$037c          21 93 21 LXI H, STATE_OUTLANE_1
$037f jo037f:  cd e1 03 CALL CLEAR_ATH_BIT_OF_HL ;o0379
; vector to 0630 stack restore
$0382 jo0382:  cd 30 06 CALL RESTORE_BDPSW ;o0006,o0341,o0357,o038f,o03a5,o0486,o0540,o0549,o078c,o07cb,o084f,o0865,o086d,o0921,o092a
$0385          c9       RET

$0386 SWITCH_HANDLER:
         cd 24 06 CALL SAVE_BDPSW ;o0034
$0389          11 00 00 LXI D, #0000
$038c          db 00    IN SWITCH_PORT
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
$039f          21 94 21 LXI H, SWITCH_LATCHED
$03a2 o03a2:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$03a5 o03a5:   c2 82 03 JNZ jo0382
$03a8 o03a8:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$03ab          eb       XCHG
$03ac          29       DAD H
$03ad          11 c6 03 LXI D, #03c6
$03b0          19       DAD D
$03b1          7e       MOV A,M
$03b2          23       INX H
$03b3          66       MOV H,M
$03b4          6f       MOV L,A
$03b5          e9       PCHL
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
; port 1 bit 6 vector -> $0784
$03c2          84       DB #84
$03c3          07       DB #07
$03c4          82       DB #82
$03c5          03       DB #03
; switch 0 vector -> $05d9
$03c6          d9       DB #d9
$03c7          05       DB #05
; switch 1 vector -> $13bc
$03c8          bc       DB #bc
$03c9          13       DB #13
; switch 2 vector -> $0003
$03ca          03       DB #03
$03cb          00       DB #00
; switch 3 tilt vector -> $047b
$03cc          7b       DB #7b
$03cd          04       DB #04
; switch 4 left flipper vector -> $0837
$03ce          37       DB #37
$03cf          08       DB #08
; switch 5 vector -> $0909
$03d0          09       DB #09
$03d1          09       DB #09
; switch 6 vector -> $15fb
$03d2          fb       DB #fb
$03d3          15       DB #15
; switch 7 tilt vector -> $047b
$03d4          7b       DB #7b
$03d5          04       DB #04
 
$03d6 SET_ATH_BIT_OF_HL:
         c5       PUSH B ;o0368,o03a8,o0410,o052e,o06cb,o079f,o09c0,o09cf,o09f6,o0aa1,o0af2,o0b55,o0c98,o0c9e,o0d52,jo1078,jo10ad,o11f8,o1213,o1283,o13c1,o13fb,o1499,o1568,o15c4,o1657,o170a,jo1738,jo174e,o184b,o1853,o19a3,o19dc,jo1a98,o1aab,o1b6c,o1c42,o1c7e,o1d1f,o1d56,o1d79,o1d7d,o1d94
$03d7          47       MOV B,A
$03d8 o03d8:   cd f9 03 CALL LSHIFT_A
$03db          4e       MOV C,M
$03dc          b1       ORA C
$03dd          77       MOV M,A
$03de o03de:   c3 f6 03 JMP j03f6
 
$03e1 CLEAR_ATH_BIT_OF_HL:
         c5       PUSH B ;jo037f,o0423,o06bd,o06d8,o06de,o06e4,o0716,o088b,o0948,o09e7,jo09fc,o0a4d,o0a5b,o0ba4,o0bb4,jo107d,o10ba,o10bf,jo1222,jo1255,o1382,o13e1,o13f1,jo1402,o14ae,o1541,o15e9,o16a7,o1923,jo1955,o199d,o1abf,o1acc,jo1c48,o1c6a,o1d4e,o1d6b,o1d84,o1d8c,o1d98
$03e2          47       MOV B,A
$03e3 o03e3:   cd f9 03 CALL LSHIFT_A
$03e6          2f       CMA
$03e7          4f       MOV C,A
$03e8          7e       MOV A,M
$03e9          a1       ANA C
$03ea          77       MOV M,A
$03eb o03eb:   c3 f6 03 JMP j03f6
 
$03ee CHECK_ATH_BIT_OF_HL:
         c5       PUSH B ;o0218,o0221,o0281,o0354,o03a2,o0409,o05b2,o06b9,o0710,o07f8,o084c,o0862,o0875,o0880,o091e,o0932,o093d,o09c5,o09e1,o0a0b,o0a47,o0a55,o0b13,o0b49,o0bec,o0cd6,o0f49,o0f50,o0f57,o0faa,o1071,o10a6,o120b,o1227,o127f,o13d9,o13f5,o149e,o14a8,o153b,o1546,o1557,o1562,o158d,o15be,o15db,o15e3,o1600,o1642,o164a,o16fa,o1702,o17f7,o180d,o186d,jo1949,o195c,o19c4,o1c78,o1cd3,o1d88,o1d9f
$03ef          47       MOV B,A
$03f0 o03f0:   cd f9 03 CALL LSHIFT_A
$03f3          4f       MOV C,A
$03f4          7e       MOV A,M
$03f5          a1       ANA C
$03f6 j03f6:   78       MOV A,B ;o03de,o03eb
$03f7          c1       POP B
$03f8          c9       RET

 
$03f9 LSHIFT_A:
         4f       MOV C,A ;o03d8,o03e3,o03f0
$03fa          3e 01    MVI A, #01
$03fc j03fc:   0d       DCR C ;o03ff
$03fd          f8       RM
$03fe          87       ADD A
$03ff o03ff:   c3 fc 03 JMP j03fc
 
$0402 c0402:   3a 11 22 LDA $2211 ;o0362,o0b4c,o157f
$0405          47       MOV B,A
$0406 o0406:   cd 27 04 CALL c0427
$0409 o0409:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$040c o040c:   ca 13 04 JZ j0413
$040f          eb       XCHG
$0410 o0410:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$0413 j0413:   78       MOV A,B ;o040c
$0414          3c       INR A
$0415          fe 05    CPI #05
$0417 o0417:   c2 1c 04 JNZ j041c
$041a          3e 00    MVI A, #00
$041c j041c:   32 11 22 STA $2211 ;o0417
$041f o041f:   cd 27 04 CALL c0427
$0422          eb       XCHG
$0423 o0423:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
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
 
$044f TILT_HELPER:
         3a 90 21 LDA GAME_STATE ;TILT_HANDLER,o0591
$0452          f6 05    ORI #05
$0454          32 90 21 STA GAME_STATE
$0457          3e 00    MVI A, #00
$0459          32 0c 22 STA $220c
$045c          3e ff    MVI A, #ff
$045e          32 93 21 STA STATE_OUTLANE_1
$0461          3a 94 21 LDA SWITCH_LATCHED
$0464          f6 30    ORI #30
$0466          32 94 21 STA SWITCH_LATCHED
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

$047b TILT_HANDLER:
         cd 4f 04 CALL TILT_HELPER
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
$0498          32 80 23 STA LAMPS_PAGE_1
$049b          32 81 23 STA $2381
$049e          32 82 23 STA $2382
$04a1          3a 3f 23 LDA $233f
$04a4          c6 08    ADI #08
$04a6          47       MOV B,A
$04a7          3a e4 23 LDA $23e4
$04aa          90       SUB B
$04ab o04ab:   fa 43 05 JM TILT2
$04ae          3a 92 21 LDA GAME_STATE2
$04b1          e6 40    ANI #40
$04b3 o04b3:   c2 43 05 JNZ TILT2
$04b6          3a 94 21 LDA SWITCH_LATCHED
$04b9          f6 fc    ORI #fc
$04bb          32 94 21 STA SWITCH_LATCHED
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
$052e o052e:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$0531          3e 01    MVI A, #01
$0533          32 14 22 STA $2214
$0536          3e 28    MVI A, #28
$0538          32 1b 22 STA $221b
$053b          3e 02    MVI A, #02
$053d          32 9d 21 STA $219d
$0540 o0540:   c3 82 03 JMP jo0382
$0543 TILT2:   21 c2 12 LXI H, TILT_MUSIC ;o04ab,o04b3
$0546 o0546:   cd 61 12 CALL PLAY_SOUND
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
$0563 o0563:   cd 61 12 CALL PLAY_SOUND
$0566 o0566:   c3 1e 06 JMP END_MAIN_LOOP
$0569 j0569:   3a 47 22 LDA $2247 ;o0553
$056c          e6 bf    ANI #bf
$056e          32 47 22 STA $2247
$0571          3e 01    MVI A, #01
$0573          32 a0 21 STA $21a0
$0576          32 1c 22 STA $221c
$0579          3a 94 21 LDA SWITCH_LATCHED
$057c          e6 33    ANI #33
$057e          32 94 21 STA SWITCH_LATCHED
$0581 o0581:   c3 1e 06 JMP END_MAIN_LOOP
; tilt handler 2
$0584          db 04    IN PRICE_89_CAB
$0586          e6 80    ANI #80
$0588 o0588:   c3 a2 05 JMP j05a2
$058b o058b:   cd 6a 04 CALL c046a
$058e o058e:   c2 a2 05 JNZ j05a2
$0591 o0591:   cd 4f 04 CALL TILT_HELPER
$0594          3e 7d    MVI A, #7d
$0596          32 a2 21 STA $21a2
$0599          21 c2 12 LXI H, TILT_MUSIC
$059c o059c:   cd 61 12 CALL PLAY_SOUND
$059f o059f:   c3 1e 06 JMP END_MAIN_LOOP
$05a2 j05a2:   3a 94 21 LDA SWITCH_LATCHED ;o0588,o058e
$05a5          e6 77    ANI #77
$05a7          32 94 21 STA SWITCH_LATCHED
$05aa o05aa:   c3 1e 06 JMP END_MAIN_LOOP
$05ad          21 92 21 LXI H, GAME_STATE2
$05b0          3e 07    MVI A, #07
$05b2 o05b2:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$05b5 o05b5:   ca 1e 06 JZ END_MAIN_LOOP
$05b8          3a b6 23 LDA $23b6
$05bb          e6 ef    ANI #ef
$05bd          32 b6 23 STA $23b6
$05c0          3e f0    MVI A, #f0
$05c2          32 a0 23 STA LAMPS_PAGE_2
$05c5          32 80 23 STA LAMPS_PAGE_1
$05c8          3e ff    MVI A, #ff
$05ca          32 a1 23 STA $23a1
$05cd          32 81 23 STA $2381
$05d0          32 a2 23 STA $23a2
$05d3          32 82 23 STA $2382
$05d6 o05d6:   c3 1e 06 JMP END_MAIN_LOOP
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
$0600 o0600:   cc 36 06 CZ FLASH_ROUTINE
$0603          3e 00    MVI A, #00
$0605          f3       DI
$0606 o0606:   c3 76 03 JMP j0376
$0609 j0609:   f3       DI ;o05e5
$060a o060a:   cd 24 06 CALL SAVE_BDPSW
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
$061e END_MAIN_LOOP:
         cd 30 06 CALL RESTORE_BDPSW ;o0566,o0581,o059f,o05aa,o05b5,o05d6,o071e,o0729,o07e8,o07f0,o07fb,o0803,o0883,o088e,o08a1,o08c8,o08da,o08f1,o0906,o0940,o094b,o095e,o0a6d,o0a90,o0aa9,o0abb,o0ae9,o0b4f,o0ba7,o0bb7,o0cc1,o0cf6,o0d26,o0de9,o121f,o123e,o1252,o125e,o14f7,o152b,o18e7,o1911,o1a37,o1a6e,o1a87,o1ad4,o1aec,jo1ba5,o1d73
$0621 o0621:   c3 e8 05 JMP j05e8
; push A, SP, B, D, H
 
$0624 SAVE_BDPSW:
         22 95 21 SHLD STACK_SCRATCH ;jo0330,o035a,SWITCH_HANDLER,o060a,o1406
$0627          e3       XTHL
$0628          c5       PUSH B
$0629          d5       PUSH D
$062a          f5       PUSH PSW
$062b          e5       PUSH H
$062c          2a 95 21 LHLD STACK_SCRATCH
$062f          c9       RET

; restore A, SP, B, D, H
 
$0630 RESTORE_BDPSW:
         e1       POP H ;o0365,jo0382,END_MAIN_LOOP,jo1419
$0631          f1       POP PSW
$0632          d1       POP D
$0633          c1       POP B
$0634          e3       XTHL
$0635          c9       RET

 
$0636 FLASH_ROUTINE:
         21 f8 21 LXI H, #21f8 ;o0600
$0639          35       DCR M
$063a o063a:   c2 47 06 JNZ j0647
$063d          36 14    MVI M, #14
$063f          3a 47 22 LDA $2247
$0642          c6 80    ADI #80
$0644          32 47 22 STA $2247
$0647 j0647:   3a 47 22 LDA $2247 ;o063a
$064a          e6 80    ANI #80
$064c o064c:   ca 7b 06 JZ LAMP_PAGE_2_COPY
$064f          21 a0 23 LXI H, LAMPS_PAGE_2
$0652          11 c0 23 LXI D, #23c0
$0655          3e 40    MVI A, #40
$0657 LAMP_PAGE_1_COPY:
         cd cf 0e CALL COPY_FROM_HL_TO_DE
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
$067b LAMP_PAGE_2_COPY:
         21 80 23 LXI H, LAMPS_PAGE_1 ;o064c
$067e          11 c0 23 LXI D, #23c0
$0681          3e 40    MVI A, #40
$0683 o0683:   cd cf 0e CALL COPY_FROM_HL_TO_DE
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
$06a8 o06a8:   c2 b4 06 JNZ CREDIT_HANDLER
$06ab          3a 92 21 LDA GAME_STATE2
$06ae          f6 20    ORI #20
$06b0          32 92 21 STA GAME_STATE2
$06b3          c9       RET

 
$06b4 CREDIT_HANDLER:
         21 92 21 LXI H, GAME_STATE2 ;o0003,o06a8
$06b7          3e 05    MVI A, #05
$06b9 o06b9:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$06bc          c8       RZ
$06bd o06bd:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$06c0          3a 7a 23 LDA CREDITS_1
$06c3          fe 99    CPI #99
$06c5          c8       RZ
$06c6          21 c5 21 LXI H, #21c5
$06c9          3e 03    MVI A, #03
$06cb o06cb:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$06ce          3e 09    MVI A, #09
$06d0          32 ab 21 STA $21ab
 
$06d3 c06d3:   3e 06    MVI A, #06 ;jo1a71
$06d5          21 76 23 LXI H, #2376
$06d8 o06d8:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$06db          21 96 23 LXI H, #2396
$06de o06de:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$06e1          21 b6 23 LXI H, #23b6
$06e4 o06e4:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$06e7          06 00    MVI B, #00
$06e9 o06e9:   cd 81 1d CALL co1d81
$06ec          3a 7a 23 LDA CREDITS_1
$06ef          3c       INR A
$06f0          27       DAA
$06f1          32 7a 23 STA CREDITS_1
$06f4          32 9a 23 STA CREDITS_2
$06f7          32 ba 23 STA CREDITS_3
$06fa          21 41 13 LXI H, CREDIT_MUSIC
$06fd o06fd:   cd 61 12 CALL PLAY_SOUND
$0700          21 4a 22 LXI H, #224a
$0703          35       DCR M
$0704          c0       RNZ
$0705          36 64    MVI M, #64
$0707 o0707:   cd aa 1f CALL c1faa
$070a          c9       RET

$070b          21 c5 21 LXI H, #21c5
$070e          3e 03    MVI A, #03
$0710 o0710:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$0713 o0713:   ca 21 07 JZ j0721
$0716 o0716:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$0719          3e 09    MVI A, #09
$071b          32 ab 21 STA $21ab
$071e o071e:   c3 1e 06 JMP END_MAIN_LOOP
$0721 j0721:   3a 94 21 LDA SWITCH_LATCHED ;o0713
$0724          e6 bb    ANI #bb
$0726          32 94 21 STA SWITCH_LATCHED
$0729 o0729:   c3 1e 06 JMP END_MAIN_LOOP
$072c          aa       DB #aa
$072d          0b       DB #0b
$072e          06       DB #06
$072f          12       DB #12
$0730          ce       DB #ce
$0731          07       DB #07
$0732          1e       DB #1e
$0733          06       DB #06
$0734          2a       DB #2a
$0735          0a       DB #0a
$0736          70       DB #70
$0737          0a       DB #0a
$0738          4c       DB #4c
$0739          05       DB #05
$073a          ad       DB #ad
$073b          05       DB #05
$073c          a4       DB #a4
$073d          08       DB #08
$073e          02       DB #02
$073f          19       DB #19
$0740          d7       DB #d7
$0741          1a       DB #1a
$0742          84       DB #84
$0743          05       DB #05
$0744          62       DB #62
$0745          1a       DB #1a
$0746          d5       DB #d5
$0747          14       DB #14
$0748          be       DB #be
$0749          0a       DB #0a
$074a          8f       DB #8f
$074b          0b       DB #0b
$074c          ae       DB #ae
$074d          0c       DB #0c
$074e          70       DB #70
$074f          08       DB #08
$0750          2d       DB #2d
$0751          09       DB #09
$0752          1e       DB #1e
$0753          06       DB #06
$0754          0b       DB #0b
$0755          07       DB #07
$0756          66       DB #66
$0757          1d       DB #1d
$0758          f3       DB #f3
$0759          07       DB #07
$075a          cd       DB #cd
$075b          18       DB #18
$075c          9d       DB #9d
$075d          0d       DB #0d
$075e          1e       DB #1e
$075f          06       DB #06
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
; port 1 bit 6 handler: set $2191 bit 5
$0784          3a 91 21 LDA CONTROL_FLAGS
$0787          f6 20    ORI #20
$0789          32 91 21 STA CONTROL_FLAGS
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
$079f o079f:   cd d6 03 CALL SET_ATH_BIT_OF_HL
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
$07bc o07bc:   cd 61 12 CALL PLAY_SOUND
$07bf          d1       POP D
$07c0          21 29 08 LXI H, #0829
$07c3          19       DAD D
$07c4          46       MOV B,M
$07c5          23       INX H
$07c6          66       MOV H,M
$07c7          68       MOV L,B
$07c8 o07c8:   cd 92 02 CALL ADD_BONUS_HL
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
$07e8 o07e8:   c2 1e 06 JNZ END_MAIN_LOOP
$07eb          3e 06    MVI A, #06
$07ed          32 ad 21 STA $21ad
$07f0 o07f0:   c3 1e 06 JMP END_MAIN_LOOP
$07f3          21 90 21 LXI H, GAME_STATE
$07f6          3e 02    MVI A, #02
$07f8 o07f8:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$07fb o07fb:   c2 1e 06 JNZ END_MAIN_LOOP
$07fe          3e 80    MVI A, #80
$0800          32 93 21 STA STATE_OUTLANE_1
$0803 o0803:   c3 1e 06 JMP END_MAIN_LOOP
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
; left flipper fire
$0837          3a c3 21 LDA $21c3
$083a          f6 10    ORI #10
$083c          32 c3 21 STA $21c3
$083f          2f       CMA
$0840          d3 06    OUT COIL_6
$0842          3e 09    MVI A, #09
$0844          32 a8 21 STA $21a8
$0847          21 90 21 LXI H, GAME_STATE
$084a          3e 05    MVI A, #05
$084c o084c:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$084f o084f:   c2 82 03 JNZ jo0382
$0852          21 4e 13 LXI H, SILENCE_MUSIC
$0855 o0855:   cd 61 12 CALL PLAY_SOUND
$0858          3e 04    MVI A, #04
$085a          32 22 22 STA $2222
$085d          21 91 21 LXI H, CONTROL_FLAGS
$0860          3e 00    MVI A, #00
$0862 o0862:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$0865 o0865:   ca 82 03 JZ jo0382
$0868          3e 7d    MVI A, #7d
$086a          32 9f 21 STA $219f
$086d o086d:   c3 82 03 JMP jo0382
$0870          21 c3 21 LXI H, #21c3
$0873          3e 04    MVI A, #04
$0875 o0875:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$0878 o0878:   c2 91 08 JNZ j0891
$087b          21 90 21 LXI H, GAME_STATE
$087e          3e 02    MVI A, #02
$0880 o0880:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$0883 o0883:   c2 1e 06 JNZ END_MAIN_LOOP
$0886          3e 04    MVI A, #04
$0888          21 94 21 LXI H, SWITCH_LATCHED
$088b o088b:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$088e o088e:   c3 1e 06 JMP END_MAIN_LOOP
; right flipper
$0891 j0891:   3a c3 21 LDA $21c3 ;o0878
$0894          e6 2f    ANI #2f
$0896          32 c3 21 STA $21c3
$0899          2f       CMA
$089a          d3 06    OUT COIL_6
$089c          3e 06    MVI A, #06
$089e          32 a8 21 STA $21a8
$08a1 o08a1:   c3 1e 06 JMP END_MAIN_LOOP
$08a4          3a 91 21 LDA CONTROL_FLAGS
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
$08c8 o08c8:   c2 1e 06 JNZ END_MAIN_LOOP
$08cb          3e 3c    MVI A, #3c
$08cd          32 1f 22 STA $221f
$08d0          3a 20 22 LDA $2220
$08d3          3c       INR A
$08d4          27       DAA
$08d5          32 20 22 STA $2220
$08d8          fe 60    CPI #60
$08da o08da:   c2 1e 06 JNZ END_MAIN_LOOP
$08dd          3e 00    MVI A, #00
$08df          32 20 22 STA $2220
$08e2          3a 21 22 LDA $2221
$08e5          3c       INR A
$08e6          27       DAA
$08e7          32 21 22 STA $2221
$08ea          3a 22 22 LDA $2222
$08ed          3d       DCR A
$08ee          32 22 22 STA $2222
$08f1 o08f1:   c2 1e 06 JNZ END_MAIN_LOOP
$08f4 o08f4:   cd aa 1f CALL c1faa
$08f7          3e 64    MVI A, #64
$08f9          32 4a 22 STA $224a
$08fc          3e 04    MVI A, #04
$08fe          32 22 22 STA $2222
$0901          3e 00    MVI A, #00
$0903          32 9f 21 STA $219f
$0906 o0906:   c3 1e 06 JMP END_MAIN_LOOP
$0909          3a c3 21 LDA $21c3
$090c          f6 20    ORI #20
$090e          32 c3 21 STA $21c3
$0911          2f       CMA
$0912          d3 06    OUT COIL_6
$0914          3e 09    MVI A, #09
$0916          32 a9 21 STA $21a9
$0919          21 90 21 LXI H, GAME_STATE
$091c          3e 05    MVI A, #05
$091e o091e:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$0921 o0921:   c2 82 03 JNZ jo0382
$0924          21 4e 13 LXI H, SILENCE_MUSIC
$0927 o0927:   cd 61 12 CALL PLAY_SOUND
$092a o092a:   c3 82 03 JMP jo0382
$092d          21 c3 21 LXI H, #21c3
$0930          3e 05    MVI A, #05
$0932 o0932:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$0935 o0935:   c2 4e 09 JNZ j094e
$0938          21 90 21 LXI H, GAME_STATE
$093b          3e 02    MVI A, #02
$093d o093d:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$0940 o0940:   c2 1e 06 JNZ END_MAIN_LOOP
$0943          21 94 21 LXI H, SWITCH_LATCHED
$0946          3e 05    MVI A, #05
$0948 o0948:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$094b o094b:   c3 1e 06 JMP END_MAIN_LOOP
$094e j094e:   3a c3 21 LDA $21c3 ;o0935
$0951          e6 1f    ANI #1f
$0953          32 c3 21 STA $21c3
$0956          2f       CMA
$0957          d3 06    OUT COIL_6
$0959          3e 06    MVI A, #06
$095b          32 a9 21 STA $21a9
$095e o095e:   c3 1e 06 JMP END_MAIN_LOOP
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
$09c0 o09c0:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$09c3          3e 02    MVI A, #02
$09c5 o09c5:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$09c8 o09c8:   ca da 09 JZ jo09da
$09cb          79       MOV A,C
$09cc o09cc:   cd 6f 0b CALL c0b6f
$09cf o09cf:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$09d2          3e 06    MVI A, #06
$09d4          32 a6 21 STA $21a6
$09d7 o09d7:   c3 19 14 JMP jo1419
$09da jo09da:  cd 81 1d CALL co1d81 ;o09c8
$09dd          79       MOV A,C
$09de          21 c7 21 LXI H, CUPS_LEFT
$09e1 o09e1:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$09e4 o09e4:   ca 52 0b JZ jo0b52
$09e7 o09e7:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$09ea          21 11 22 LXI H, #2211
$09ed          be       CMP M
$09ee          21 92 21 LXI H, GAME_STATE2
$09f1          3e 01    MVI A, #01
$09f3 o09f3:   c2 fc 09 JNZ jo09fc
$09f6 o09f6:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$09f9 o09f9:   c3 ff 09 JMP j09ff
$09fc jo09fc:  cd e1 03 CALL CLEAR_ATH_BIT_OF_HL ;o09f3
$09ff j09ff:   79       MOV A,C ;o09f9
$0a00 o0a00:   cd 6f 0b CALL c0b6f
$0a03 o0a03:   cd 9c 1d CALL co1d9c
$0a06 o0a06:   ca 14 0a JZ jo0a14
$0a09          eb       XCHG
$0a0a          19       DAD D
$0a0b o0a0b:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$0a0e          eb       XCHG
$0a0f          3e 01    MVI A, #01
$0a11 o0a11:   ca 24 0a JZ j0a24
$0a14 jo0a14:  cd 91 1d CALL co1d91 ;o0a06
$0a17          21 e3 12 LXI H, OOPS_MUSIC
$0a1a o0a1a:   cd 61 12 CALL PLAY_SOUND
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
$0a39 o0a39:   cd 5c 0e CALL ADD_BONUS
$0a3c          21 dd 12 LXI H, UNKNOWN_MUSIC
$0a3f o0a3f:   cd 61 12 CALL PLAY_SOUND
$0a42          21 92 21 LXI H, GAME_STATE2
$0a45          3e 01    MVI A, #01
$0a47 o0a47:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$0a4a o0a4a:   ca 93 0a JZ j0a93
$0a4d o0a4d:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$0a50          21 91 21 LXI H, CONTROL_FLAGS
$0a53          3e 01    MVI A, #01
$0a55 o0a55:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$0a58 o0a58:   ca 93 0a JZ j0a93
$0a5b o0a5b:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$0a5e          3e fa    MVI A, #fa
$0a60          32 08 22 STA $2208
$0a63          3e 05    MVI A, #05
$0a65          32 1a 22 STA $221a
$0a68          3e 28    MVI A, #28
$0a6a          32 9c 21 STA $219c
$0a6d o0a6d:   c3 1e 06 JMP END_MAIN_LOOP
$0a70          21 71 11 LXI H, #1171
$0a73 o0a73:   cd 5c 0e CALL ADD_BONUS
$0a76          21 35 13 LXI H, SPREAD_HRM_MUSIC
$0a79 o0a79:   cd 61 12 CALL PLAY_SOUND
$0a7c          3a 1a 22 LDA $221a
$0a7f          3d       DCR A
$0a80          32 1a 22 STA $221a
$0a83 o0a83:   ca 93 0a JZ j0a93
$0a86          3e 28    MVI A, #28
$0a88          32 9c 21 STA $219c
$0a8b          3e fa    MVI A, #fa
$0a8d          32 08 22 STA $2208
$0a90 o0a90:   c3 1e 06 JMP END_MAIN_LOOP
$0a93 j0a93:   3a c7 21 LDA CUPS_LEFT ;o0a4a,o0a58,o0a83
$0a96          fe 00    CPI #00
$0a98 o0a98:   ca ac 0a JZ jo0aac
$0a9b          2a 09 22 LHLD $2209
$0a9e          3a 0b 22 LDA $220b
$0aa1 o0aa1:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$0aa4          3e 06    MVI A, #06
$0aa6          32 a6 21 STA $21a6
$0aa9 o0aa9:   c3 1e 06 JMP END_MAIN_LOOP
; all cups complete
$0aac jo0aac:  cd 18 00 CALL c0018 ;o0a98
$0aaf          00       NOP
$0ab0          00       NOP
$0ab1          3e 64    MVI A, #64
$0ab3          32 08 22 STA $2208
$0ab6          3e 00    MVI A, #00
$0ab8          32 07 22 STA $2207
$0abb o0abb:   c3 1e 06 JMP END_MAIN_LOOP
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
$0adc o0adc:   cd 61 12 CALL PLAY_SOUND
$0adf          3e 0f    MVI A, #0f
$0ae1          32 a5 21 STA $21a5
$0ae4          3e 64    MVI A, #64
$0ae6          32 08 22 STA $2208
$0ae9 o0ae9:   c3 1e 06 JMP END_MAIN_LOOP
$0aec j0aec:   2a 09 22 LHLD $2209 ;o0acb
$0aef          3a 0b 22 LDA $220b
$0af2 o0af2:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$0af5          3e 06    MVI A, #06
$0af7          32 a6 21 STA $21a6
$0afa          3e 1f    MVI A, #1f
$0afc          32 c7 21 STA CUPS_LEFT
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
$0b13 o0b13:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
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
$0b44 j0b44:   21 91 21 LXI H, CONTROL_FLAGS ;o0b2c
$0b47          3e 01    MVI A, #01
$0b49 o0b49:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$0b4c o0b4c:   c4 02 04 CNZ c0402
$0b4f o0b4f:   c3 1e 06 JMP END_MAIN_LOOP
$0b52 jo0b52:  cd 6f 0b CALL c0b6f ;o09e4
$0b55 o0b55:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$0b58          3e 06    MVI A, #06
$0b5a          32 a6 21 STA $21a6
$0b5d o0b5d:   cd 9c 1d CALL co1d9c
$0b60 o0b60:   c2 19 14 JNZ jo1419
$0b63 o0b63:   cd 76 1d CALL co1d76
$0b66          21 e0 12 LXI H, LOW_MUSIC
$0b69 o0b69:   cd 61 12 CALL PLAY_SOUND
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
$0ba4 o0ba4:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$0ba7 o0ba7:   c3 1e 06 JMP END_MAIN_LOOP
$0baa          3e 00    MVI A, #00
$0bac          32 08 22 STA $2208
$0baf          21 92 21 LXI H, GAME_STATE2
$0bb2          3e 03    MVI A, #03
$0bb4 o0bb4:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$0bb7 o0bb7:   c3 1e 06 JMP END_MAIN_LOOP
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
$0bec o0bec:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$0bef o0bef:   c2 4d 0d JNZ j0d4d
$0bf2          3a 0c 22 LDA $220c
$0bf5          e6 03    ANI #03
$0bf7 o0bf7:   c2 a6 0c JNZ j0ca6
$0bfa          21 5b 23 LXI H, #235b
$0bfd          11 0d 22 LXI D, #220d
$0c00          3e 06    MVI A, #06
$0c02 o0c02:   cd cf 0e CALL COPY_FROM_HL_TO_DE
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
$0c39 o0c39:   cd 61 12 CALL PLAY_SOUND
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
$0c98 o0c98:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$0c9b          21 b6 23 LXI H, #23b6
$0c9e o0c9e:   cd d6 03 CALL SET_ATH_BIT_OF_HL
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
$0cb9          3a 94 21 LDA SWITCH_LATCHED
$0cbc          e6 fd    ANI #fd
$0cbe          32 94 21 STA SWITCH_LATCHED
$0cc1 o0cc1:   c3 1e 06 JMP END_MAIN_LOOP
$0cc4 j0cc4:   3e 00    MVI A, #00 ;o0cb6
$0cc6          32 97 21 STA $2197
$0cc9          3a 94 21 LDA SWITCH_LATCHED
$0ccc          f6 02    ORI #02
$0cce          32 94 21 STA SWITCH_LATCHED
$0cd1          21 90 21 LXI H, GAME_STATE
$0cd4          3e 00    MVI A, #00
$0cd6 o0cd6:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$0cd9 o0cd9:   c2 29 0d JNZ j0d29
$0cdc          21 65 11 LXI H, #1165
$0cdf o0cdf:   cd 99 0e CALL c0e99
$0ce2 o0ce2:   da f9 0c JC j0cf9
$0ce5          21 65 11 LXI H, #1165
$0ce8 o0ce8:   cd 92 02 CALL ADD_BONUS_HL
$0ceb          3e 0a    MVI A, #0a
$0ced          32 a7 21 STA $21a7
$0cf0          21 32 13 LXI H, BUMPER_25_MUSIC
$0cf3 o0cf3:   cd 61 12 CALL PLAY_SOUND
$0cf6 o0cf6:   c3 1e 06 JMP END_MAIN_LOOP
$0cf9 j0cf9:   21 65 11 LXI H, #1165 ;o0ce2
$0cfc o0cfc:   cd 5c 0e CALL ADD_BONUS
$0cff          21 5b 23 LXI H, #235b
$0d02 o0d02:   cd 3c 0f CALL ADD_PTS
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
$0d23 jo0d23:  cd 61 12 CALL PLAY_SOUND ;o0d4a
$0d26 o0d26:   c3 1e 06 JMP END_MAIN_LOOP
$0d29 j0d29:   21 c5 21 LXI H, #21c5 ;o0cd9,o0d0f,o0d12
$0d2c          7e       MOV A,M
$0d2d          f6 02    ORI #02
$0d2f          77       MOV M,A
$0d30          3e 09    MVI A, #09
$0d32          32 a6 21 STA $21a6
$0d35          06 39    MVI B, #39
$0d37 o0d37:   cd 81 1d CALL co1d81
$0d3a          3a 94 21 LDA SWITCH_LATCHED
$0d3d          e6 fd    ANI #fd
$0d3f          32 94 21 STA SWITCH_LATCHED
$0d42          3e 00    MVI A, #00
$0d44          32 0c 22 STA $220c
$0d47          21 35 13 LXI H, SPREAD_HRM_MUSIC
$0d4a o0d4a:   c3 23 0d JMP jo0d23
$0d4d j0d4d:   21 c5 21 LXI H, #21c5 ;o0be4,o0bef
$0d50          3e 01    MVI A, #01
$0d52 o0d52:   cd d6 03 CALL SET_ATH_BIT_OF_HL
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
$0d88          3a 91 21 LDA CONTROL_FLAGS
$0d8b          e6 df    ANI #df
$0d8d          32 91 21 STA CONTROL_FLAGS
$0d90          3e 80    MVI A, #80
$0d92          32 93 21 STA STATE_OUTLANE_1
$0d95 j0d95:   3e 03    MVI A, #03 ;o0d85
$0d97          32 af 21 STA $21af
$0d9a o0d9a:   c3 19 14 JMP jo1419
$0d9d          3a 91 21 LDA CONTROL_FLAGS
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
$0dc5 o0dc5:   cd 92 02 CALL ADD_BONUS_HL
$0dc8          21 e0 12 LXI H, LOW_MUSIC
$0dcb o0dcb:   cd 61 12 CALL PLAY_SOUND
$0dce o0dce:   c3 e1 0d JMP j0de1
$0dd1 j0dd1:   21 71 11 LXI H, #1171 ;o0dbf
$0dd4 o0dd4:   cd 92 02 CALL ADD_BONUS_HL
$0dd7          eb       XCHG
$0dd8 o0dd8:   cd 5c 0e CALL ADD_BONUS
$0ddb          21 f2 12 LXI H, LIT_STANDUP_MUSIC
$0dde o0dde:   cd 61 12 CALL PLAY_SOUND
$0de1 j0de1:   3a 91 21 LDA CONTROL_FLAGS ;o0da2,o0db9,o0dce
$0de4          e6 df    ANI #df
$0de6          32 91 21 STA CONTROL_FLAGS
$0de9 o0de9:   c3 1e 06 JMP END_MAIN_LOOP
 
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

 
$0e5c ADD_BONUS:
         11 f3 21 LXI D, SPREAD_1 ;o0020,o0a39,o0a73,o0cfc,o0dd8,o154f,o15ef,o18ed
$0e5f          3e 08    MVI A, #08
$0e61 o0e61:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$0e64          21 5b 23 LXI H, #235b
$0e67          3e 08    MVI A, #08
$0e69 o0e69:   cd ec 0d CALL c0dec
$0e6c          21 f3 21 LXI H, SPREAD_1
 
$0e6f c0e6f:   11 5b 23 LXI D, #235b ;o0d18,o18bc,o1af2
$0e72          3e 08    MVI A, #08
$0e74 o0e74:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$0e77          21 5b 23 LXI H, #235b
$0e7a          11 a0 23 LXI D, LAMPS_PAGE_2
$0e7d          3e 06    MVI A, #06
$0e7f o0e7f:   cd ea 0e CALL WRITE_TO_RAM
$0e82          3a 90 21 LDA GAME_STATE
$0e85          e6 01    ANI #01
$0e87          c0       RNZ
$0e88          21 a0 23 LXI H, LAMPS_PAGE_2
$0e8b          11 80 23 LXI D, LAMPS_PAGE_1
$0e8e          3e 06    MVI A, #06
$0e90 o0e90:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$0e93          06 39    MVI B, #39
$0e95 o0e95:   cd 76 1d CALL co1d76
$0e98          c9       RET

 
$0e99 c0e99:   e5       PUSH H ;o0cdf,o0d08,o18d0,o18f9
$0e9a          21 5b 23 LXI H, #235b
$0e9d          11 f3 21 LXI D, SPREAD_1
$0ea0          3e 08    MVI A, #08
$0ea2 o0ea2:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$0ea5          e1       POP H
$0ea6          3e 08    MVI A, #08
$0ea8 o0ea8:   cd 18 0e CALL c0e18
$0eab          f5       PUSH PSW
$0eac          21 f3 21 LXI H, SPREAD_1
$0eaf          11 5b 23 LXI D, #235b
$0eb2          3e 08    MVI A, #08
$0eb4 o0eb4:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$0eb7          21 5b 23 LXI H, #235b
$0eba          11 80 23 LXI D, LAMPS_PAGE_1
$0ebd          3e 06    MVI A, #06
$0ebf o0ebf:   cd ea 0e CALL WRITE_TO_RAM
$0ec2          21 80 23 LXI H, LAMPS_PAGE_1
$0ec5          11 a0 23 LXI D, LAMPS_PAGE_2
$0ec8          3e 06    MVI A, #06
$0eca o0eca:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$0ecd          f1       POP PSW
$0ece          c9       RET

 
$0ecf COPY_FROM_HL_TO_DE:
         b7       ORA A ;o00c8,o00d3,o019d,o01b0,LAMP_PAGE_1_COPY,o0683,o0c02,o0e61,o0e74,o0e90,o0ea2,o0eb4,o0eca,o0f41,o0f7d,o0f91,o0fa2,o0fc3,o0fdb,o0ffc,o1015,o1022,o1039,o104f,o1062,o10cb,o10d6,o112a,o1637,o16ba,o16c5,o1865,o18a6,o1a84,o1b09,o1b14,o1bf6,o1c01,o1c2b,o1c89,o1ca6,o1f40,o1f4e,o1f5a,o1f6a,o1f8a,o1f9b,o1fa5,o1fb3,o1fbd,o1fc7,o1fd0,o1fe6
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

 
$0eea WRITE_TO_RAM:
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

 
$0f3c ADD_PTS:  11 f3 21 LXI D, SPREAD_1 ;o0278,o0d02,o1722,o172d,o18f3
$0f3f          3e 08    MVI A, #08
$0f41 o0f41:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$0f44          21 7e 23 LXI H, #237e
$0f47          3e 04    MVI A, #04
$0f49 o0f49:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$0f4c o0f4c:   c2 dd 10 JNZ j10dd
$0f4f          3c       INR A
$0f50 o0f50:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$0f53 o0f53:   c2 f4 10 JNZ j10f4
$0f56          3c       INR A
$0f57 o0f57:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
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
$0f7d o0f7d:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$0f80          e1       POP H
$0f81          d1       POP D
$0f82          d5       PUSH D
$0f83          3e 06    MVI A, #06
$0f85 o0f85:   cd ea 0e CALL WRITE_TO_RAM
$0f88          d1       POP D
$0f89          d5       PUSH D
$0f8a          21 20 00 LXI H, #0020
$0f8d          19       DAD D
$0f8e          eb       XCHG
$0f8f          3e 06    MVI A, #06
$0f91 o0f91:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$0f94          d1       POP D
$0f95          3a f6 21 LDA $21f6
$0f98          e6 0f    ANI #0f
$0f9a o0f9a:   ca a5 0f JZ j0fa5
$0f9d          21 89 11 LXI H, #1189
$0fa0          3e 06    MVI A, #06
$0fa2 o0fa2:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$0fa5 j0fa5:   21 7e 23 LXI H, #237e ;o0f9a
$0fa8          3e 03    MVI A, #03
$0faa o0faa:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
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
$0fc3 o0fc3:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$0fc6          21 6b 23 LXI H, PL2_SCORE_1
$0fc9          3e 07    MVI A, #07
$0fcb o0fcb:   cd 18 0e CALL c0e18
$0fce          f5       PUSH PSW
$0fcf o0fcf:   dc f4 0f CC c0ff4
$0fd2          21 f3 21 LXI H, SPREAD_1
$0fd5          11 77 23 LXI D, PL1_SCORE_hrm
$0fd8          d5       PUSH D
$0fd9          3e 06    MVI A, #06
$0fdb o0fdb:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$0fde          e1       POP H
$0fdf          e5       PUSH H
$0fe0          11 97 23 LXI D, SPREAD_4
$0fe3          3e 06    MVI A, #06
$0fe5 o0fe5:   cd ea 0e CALL WRITE_TO_RAM
$0fe8          e1       POP H
$0fe9          11 b7 23 LXI D, SPREAD_3
$0fec          3e 06    MVI A, #06
$0fee o0fee:   cd ea 0e CALL WRITE_TO_RAM
$0ff1 o0ff1:   c3 52 10 JMP j1052
 
$0ff4 c0ff4:   21 6b 23 LXI H, PL2_SCORE_1 ;o0fcf
$0ff7          11 f3 21 LXI D, SPREAD_1
$0ffa          3e 07    MVI A, #07
$0ffc o0ffc:   cd cf 0e CALL COPY_FROM_HL_TO_DE
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
$1015 o1015:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$1018          e1       POP H
$1019          d1       POP D
$101a          21 67 23 LXI H, PL13_SCORE_1
$101d          11 f3 21 LXI D, SPREAD_1
$1020          3e 07    MVI A, #07
$1022 o1022:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$1025          21 73 23 LXI H, PL24_SCORE_1
$1028          3e 07    MVI A, #07
$102a o102a:   cd 18 0e CALL c0e18
$102d          f5       PUSH PSW
$102e o102e:   da 22 11 JC j1122
$1031 j1031:   21 f3 21 LXI H, SPREAD_1 ;o1135
$1034          11 77 23 LXI D, PL1_SCORE_hrm
$1037          3e 06    MVI A, #06
$1039 o1039:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$103c          21 77 23 LXI H, PL1_SCORE_hrm
$103f          11 97 23 LXI D, SPREAD_4
$1042          3e 06    MVI A, #06
$1044 o1044:   cd ea 0e CALL WRITE_TO_RAM
$1047          21 97 23 LXI H, SPREAD_4
$104a          11 b7 23 LXI D, SPREAD_3
$104d          3e 06    MVI A, #06
$104f o104f:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$1052 j1052:   3a f6 21 LDA $21f6 ;o0ff1
$1055          e6 0f    ANI #0f
$1057 o1057:   ca 65 10 JZ j1065
$105a          21 89 11 LXI H, #1189
$105d          11 97 23 LXI D, SPREAD_4
$1060          3e 06    MVI A, #06
$1062 o1062:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$1065 j1065:   f1       POP PSW ;o1057
$1066 o1066:   ca b5 10 JZ j10b5
$1069 o1069:   da a1 10 JC j10a1
$106c          21 6a 23 LXI H, #236a
$106f          3e 04    MVI A, #04
$1071 o1071:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$1074 o1074:   ca 78 10 JZ jo1078
$1077          c9       RET

$1078 jo1078:  cd d6 03 CALL SET_ATH_BIT_OF_HL ;o1074
$107b          3e 05    MVI A, #05
$107d jo107d:  cd e1 03 CALL CLEAR_ATH_BIT_OF_HL ;o10b2
$1080          e5       PUSH H
$1081          c5       PUSH B
$1082          21 16 13 LXI H, SPREAD_TAKEOVER_MUSIC
$1085 o1085:   cd 61 12 CALL PLAY_SOUND
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
$10a6 o10a6:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$10a9 o10a9:   ca ad 10 JZ jo10ad
$10ac          c9       RET

$10ad jo10ad:  cd d6 03 CALL SET_ATH_BIT_OF_HL ;o10a9
$10b0          3e 04    MVI A, #04
$10b2 o10b2:   c3 7d 10 JMP jo107d
$10b5 j10b5:   21 6a 23 LXI H, #236a ;o1066
$10b8          3e 04    MVI A, #04
$10ba o10ba:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$10bd          3e 05    MVI A, #05
$10bf o10bf:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$10c2          e5       PUSH H
$10c3          21 85 11 LXI H, #1185
$10c6          11 97 23 LXI D, SPREAD_4
$10c9          3e 06    MVI A, #06
$10cb o10cb:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$10ce          21 85 11 LXI H, #1185
$10d1          11 b7 23 LXI D, SPREAD_3
$10d4          3e 06    MVI A, #06
$10d6 o10d6:   cd cf 0e CALL COPY_FROM_HL_TO_DE
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
$112a o112a:   cd cf 0e CALL COPY_FROM_HL_TO_DE
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

; scores
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
$1181          79       DB #79
$1182          19       DB #19
$1183          00       DB #00
$1184          00       DB #00
$1185          f0       DB #f0
$1186          ff       DB #ff
$1187          ff       DB #ff
$1188          ff       DB #ff
$1189          ff       DB #ff
$118a          ff       DB #ff
$118b          ff       DB #ff
$118c          ff       DB #ff
 
$118d TONE_PLAY:
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
$11f8 o11f8:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$11fb          c9       RET

$11fc          0d       DB #0d
$11fd          0a       DB #0a
$11fe          0e       DB #0e
$11ff          0a       DB #0a
$1200          18       DB #18
$1201          20       DB #20
$1202          0a       DB #0a
$1203          05       DB #05
$1204          02       DB #02
$1205          32       DB #32
$1206          21 90 21 LXI H, GAME_STATE
$1209          3e 05    MVI A, #05
$120b o120b:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$120e o120e:   c2 22 12 JNZ jo1222
$1211          3e 06    MVI A, #06
$1213 o1213:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$1216          3e fe    MVI A, #fe
$1218          d3 09    OUT TONE_ENABLE_DUR
$121a          3e 02    MVI A, #02
$121c          32 98 21 STA $2198
$121f o121f:   c3 1e 06 JMP END_MAIN_LOOP
$1222 jo1222:  cd e1 03 CALL CLEAR_ATH_BIT_OF_HL ;o120e
$1225          3e 06    MVI A, #06
$1227 o1227:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$122a o122a:   c2 55 12 JNZ jo1255
$122d          3e ff    MVI A, #ff
$122f          d3 09    OUT TONE_ENABLE_DUR
$1231          2a b1 21 LHLD NEXT_TONE
$1234          23       INX H
$1235          7e       MOV A,M
$1236          fe ff    CPI #ff
$1238 o1238:   ca 41 12 JZ j1241
$123b o123b:   cd 8d 11 CALL TONE_PLAY
$123e o123e:   c3 1e 06 JMP END_MAIN_LOOP
$1241 j1241:   3a b3 21 LDA $21b3 ;o1238
$1244          fe 00    CPI #00
$1246 o1246:   c2 58 12 JNZ jo1258
$1249          3e ff    MVI A, #ff
$124b          d3 09    OUT TONE_ENABLE_DUR
$124d          3e 0c    MVI A, #0c
$124f          32 98 21 STA $2198
$1252 o1252:   c3 1e 06 JMP END_MAIN_LOOP
$1255 jo1255:  cd e1 03 CALL CLEAR_ATH_BIT_OF_HL ;o122a
$1258 jo1258:  cd 8c 12 CALL c128c ;o1246
$125b o125b:   cd 8d 11 CALL TONE_PLAY
$125e o125e:   c3 1e 06 JMP END_MAIN_LOOP
 
$1261 PLAY_SOUND:
         eb       XCHG ;o0162,o0546,o0563,o059c,o06fd,o07bc,o0855,o0927,o0a1a,o0a3f,o0a79,o0adc,o0b69,o0c39,o0cf3,jo0d23,o0dcb,o0dde,o1085,o14bd,o14ef,o1585,o15a6,o15d0,o15f5,o1786,o1859,o18c7,o18e4,o1a27,o1ae4,o1b72,o1f70
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
$127f o127f:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$1282          c0       RNZ
$1283 o1283:   cd d6 03 CALL SET_ATH_BIT_OF_HL
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
LEFT_SLING_TONE          33       DB #33
$12ba          08       DB #08
$12bb          ff       DB #ff
RIGHT_SLING_TONE          3c       DB #3c
$12bd          08       DB #08
$12be          ff       DB #ff
SILENCE_END_LOOP_MUSIC          1c       DB #1c
$12c0          00       DB #00
$12c1          ff       DB #ff
TILT_MUSIC          43       DB #43
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
BONUS_MUSIC          55       DB #55
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
LIL_VICTORY_MUSIC          33       DB #33
$12ee          08       DB #08
$12ef          43       DB #43
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
; game over music
GAME_OVER_MUSIC          98       DB #98
$1300          08       DB #08
$1301          ca       DB #ca
$1302          08       DB #08
$1303          00       DB #00
$1304          00       DB #00
$1305          ca       DB #ca
$1306          08       DB #08
$1307          98       DB #98
$1308          08       DB #08
$1309          00       DB #00
$130a          00       DB #00
$130b          98       DB #98
$130c          08       DB #08
$130d          7f       DB #7f
$130e          08       DB #08
$130f          00       DB #00
$1310          00       DB #00
$1311          7f       DB #7f
$1312          08       DB #08
$1313          65       DB #65
$1314          08       DB #08
$1315          ff       DB #ff
; spread takeover music
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
; morse code music
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
; bumper 25 music
BUMPER_25_MUSIC          c6       DB #c6
$1333          08       DB #08
$1334          ff       DB #ff
; spread music
SPREAD_HRM_MUSIC          4c       DB #4c
$1336          0c       DB #0c
$1337          ff       DB #ff
; longer bumper 25 music
LONGER_BUMPER_25_MUSIC          ca       DB #ca
$1339          08       DB #08
$133a          ca       DB #ca
$133b          08       DB #08
$133c          ca       DB #ca
$133d          08       DB #08
$133e          ca       DB #ca
$133f          0c       DB #0c
$1340          ff       DB #ff
; credit music
CREDIT_MUSIC          78       DB #78
$1342          28       DB #28
$1343          65       DB #65
$1344          04       DB #04
$1345          ff       DB #ff
; next player music
NEXT_PLAYER_MUSIC          a0       DB #a0
$1347          2c       DB #2c
$1348          a0       DB #a0
$1349          0c       DB #0c
$134a          ff       DB #ff
; outlane music
OUTLANE_MUSIC          15       DB #15
$134c          0c       DB #0c
$134d          ff       DB #ff
; silence music
SILENCE_MUSIC          ca       DB #ca
$134f          00       DB #00
$1350          ff       DB #ff
; funkytown
HIGH_SCORE_MUSIC          87       DB #87
$1352          0c       DB #0c
$1353          87       DB #87
$1354          0c       DB #0c
$1355          78       DB #78
$1356          0c       DB #0c
$1357          87       DB #87
$1358          0c       DB #0c
$1359          00       DB #00
$135a          00       DB #00
$135b          65       DB #65
$135c          0c       DB #0c
$135d          00       DB #00
$135e          00       DB #00
$135f          65       DB #65
$1360          0c       DB #0c
$1361          87       DB #87
$1362          0c       DB #0c
$1363          bf       DB #bf
$1364          0c       DB #0c
$1365          aa       DB #aa
$1366          0c       DB #0c
$1367          87       DB #87
$1368          0c       DB #0c
$1369          ff       DB #ff
; popcorn
POPCORN_MUSIC          f1       DB #f1
$136b          04       DB #04
$136c          d6       DB #d6
$136d          04       DB #04
$136e          f1       DB #f1
$136f          04       DB #04
$1370          b4       DB #b4
$1371          04       DB #04
$1372          8f       DB #8f
$1373          04       DB #04
$1374          b4       DB #b4
$1375          04       DB #04
$1376          78       DB #78
$1377          04       DB #04
$1378          ff       DB #ff
$1379          ff       DB #ff
$137a          ff       DB #ff
$137b          ff       DB #ff
$137c          fe       DB #fe
 
$137d jc137d:  21 91 21 LXI H, CONTROL_FLAGS ;o0140,o13b2,o1d6f
$1380          3e 03    MVI A, #03
$1382 o1382:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
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
$139c          3a 91 21 LDA CONTROL_FLAGS
$139f          f6 08    ORI #08
$13a1          32 91 21 STA CONTROL_FLAGS
$13a4 j13a4:   78       MOV A,B ;o1399
$13a5          d6 04    SUI #04
$13a7          12       STAX D
$13a8          13       INX D
$13a9          2c       INR L
$13aa o13aa:   c2 8d 13 JNZ j138d
$13ad          3a 91 21 LDA CONTROL_FLAGS
$13b0          e6 08    ANI #08
$13b2 o13b2:   c2 7d 13 JNZ jc137d
$13b5 o13b5:   cd 03 03 CALL c0303
$13b8          22 24 22 SHLD $2224
$13bb          c9       RET

$13bc          21 91 21 LXI H, CONTROL_FLAGS
$13bf          3e 06    MVI A, #06
$13c1 o13c1:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$13c4          21 e0 23 LXI H, #23e0
$13c7          11 3b 23 LXI D, #233b
$13ca j13ca:   1a       LDAX D ;o13d1
$13cb          96       SUB M
$13cc o13cc:   f2 ea 13 JP j13ea
$13cf j13cf:   13       INX D ;jo141c
$13d0          2c       INR L
$13d1 o13d1:   c2 ca 13 JNZ j13ca
$13d4          21 91 21 LXI H, CONTROL_FLAGS
$13d7          3e 06    MVI A, #06
$13d9 o13d9:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$13dc o13dc:   ca e4 13 JZ j13e4
$13df          3e 07    MVI A, #07
$13e1 o13e1:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$13e4 j13e4:   3e 01    MVI A, #01 ;o13dc
$13e6          f3       DI
$13e7 o13e7:   c3 76 03 JMP j0376
$13ea j13ea:   f3       DI ;o13cc
$13eb          e5       PUSH H
$13ec          21 91 21 LXI H, CONTROL_FLAGS
$13ef          3e 06    MVI A, #06
$13f1 o13f1:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$13f4          3c       INR A
$13f5 o13f5:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$13f8 o13f8:   c2 02 14 JNZ jo1402
$13fb o13fb:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$13fe          e1       POP H
$13ff o13ff:   c3 1c 14 JMP jo141c
$1402 jo1402:  cd e1 03 CALL CLEAR_ATH_BIT_OF_HL ;o13f8
$1405          e1       POP H
$1406 o1406:   cd 24 06 CALL SAVE_BDPSW
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
$1419 jo1419:  cd 30 06 CALL RESTORE_BDPSW ;o0996,o09ab,o09b8,o09d7,o0a27,o0b60,o0b6c,o0cab,o0d5a,o0d7e,o0d9a,o14a1,o14ab,o14c5,o14d2,o153e,o1549,o15a9,o15c1,o15d3,o15de,o15e6,o15f8,o1810,o1820,o1828,o1886,o18ca
$141c jo141c:  c3 cf 13 JMP j13cf ;o13ff
$141f          d6       DB #d6
$1420          15       DB #15
$1421          19       DB #19
$1422          14       DB #14
$1423          19       DB #19
$1424          14       DB #14
$1425          19       DB #19
$1426          14       DB #14
$1427          19       DB #19
$1428          14       DB #14
$1429          19       DB #19
$142a          14       DB #14
$142b          19       DB #19
$142c          14       DB #14
$142d          19       DB #19
$142e          14       DB #14
$142f          ac       DB #ac
$1430          15       DB #15
$1431          66       DB #66
$1432          14       DB #14
$1433          6d       DB #6d
$1434          14       DB #14
$1435          82       DB #82
$1436          14       DB #14
$1437          74       DB #74
$1438          14       DB #14
$1439          7b       DB #7b
$143a          14       DB #14
$143b          84       DB #84
$143c          09       DB #09
$143d          36       DB #36
$143e          15       DB #15
$143f          89       DB #89
$1440          14       DB #14
$1441          90       DB #90
$1442          14       DB #14
$1443          7d       DB #7d
$1444          09       DB #09
$1445          5f       DB #5f
$1446          14       DB #14
$1447          76       DB #76
$1448          09       DB #09
$1449          67       DB #67
$144a          0d       DB #0d
$144b          6c       DB #6c
$144c          0d       DB #0d
$144d          71       DB #71
$144e          0d       DB #0d
$144f          08       DB #08
$1450          18       DB #18
$1451          6f       DB #6f
$1452          09       DB #09
$1453          62       DB #62
$1454          0d       DB #0d
$1455          68       DB #68
$1456          09       DB #09
$1457          5d       DB #5d
$1458          0d       DB #0d
$1459          61       DB #61
$145a          09       DB #09
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
$1499 o1499:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$149c          3e 02    MVI A, #02
$149e o149e:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$14a1 o14a1:   c2 19 14 JNZ jo1419
$14a4          79       MOV A,C
$14a5          21 c6 21 LXI H, ROLLOVERS
$14a8 o14a8:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$14ab o14ab:   ca 19 14 JZ jo1419
$14ae o14ae:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$14b1 o14b1:   cd 81 1d CALL co1d81
$14b4          21 61 11 LXI H, #1161
$14b7 o14b7:   cd 92 02 CALL ADD_BONUS_HL
$14ba          21 d7 12 LXI H, BONUS_MUSIC
$14bd o14bd:   cd 61 12 CALL PLAY_SOUND
$14c0          3a c6 21 LDA ROLLOVERS
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
$14ec          21 d7 12 LXI H, BONUS_MUSIC
$14ef o14ef:   cd 61 12 CALL PLAY_SOUND
$14f2          3e 0a    MVI A, #0a
$14f4          32 a4 21 STA $21a4
$14f7 o14f7:   c3 1e 06 JMP END_MAIN_LOOP
$14fa j14fa:   3e 00    MVI A, #00 ;o14de
$14fc          32 0c 22 STA $220c
$14ff          06 11    MVI B, #11
$1501 o1501:   cd 9c 1d CALL co1d9c
$1504 o1504:   c2 17 15 JNZ jo1517
$1507          06 38    MVI B, #38
$1509 o1509:   cd 9c 1d CALL co1d9c
$150c o150c:   c2 1f 15 JNZ jo151f
$150f          06 11    MVI B, #11
$1511 o1511:   cd 76 1d CALL co1d76
$1514 o1514:   c3 1f 15 JMP jo151f
$1517 jo1517:  cd 81 1d CALL co1d81 ;o1504
$151a          06 38    MVI B, #38
$151c o151c:   cd 76 1d CALL co1d76
$151f jo151f:  cd 1d 00 CALL c001d ;o150c,o1514
; reset rollovers
$1522          3e ff    MVI A, #ff
$1524          32 c6 21 STA ROLLOVERS
$1527          97       SUB A
$1528          32 05 22 STA $2205
$152b o152b:   c3 1e 06 JMP END_MAIN_LOOP
$152e          02       STAX B
$152f          2a 10 1a LHLD $1a10
$1532          01 19 21 LXI B, #2119
$1535          0a       LDAX B
; 10,000 / EB lane
$1536          21 90 21 LXI H, GAME_STATE
$1539          3e 07    MVI A, #07
$153b o153b:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$153e o153e:   ca 19 14 JZ jo1419
$1541 o1541:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$1544          3e 02    MVI A, #02
$1546 o1546:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$1549 o1549:   c2 19 14 JNZ jo1419
$154c          21 7d 11 LXI H, #117d
$154f o154f:   cd 5c 0e CALL ADD_BONUS
$1552          21 90 21 LXI H, GAME_STATE
$1555          3e 04    MVI A, #04
$1557 o1557:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$155a o155a:   ca 88 15 JZ j1588
$155d          21 91 21 LXI H, CONTROL_FLAGS
$1560          3e 01    MVI A, #01
$1562 o1562:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$1565 o1565:   c2 88 15 JNZ j1588
$1568 o1568:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$156b          3a c7 21 LDA CUPS_LEFT
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
$1585 o1585:   cd 61 12 CALL PLAY_SOUND
$1588 j1588:   21 90 21 LXI H, GAME_STATE ;o155a,o1565
$158b          3e 03    MVI A, #03
$158d o158d:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$1590 o1590:   c2 a3 15 JNZ j15a3
$1593          06 09    MVI B, #09
$1595 o1595:   cd 9c 1d CALL co1d9c
$1598 o1598:   ca a3 15 JZ j15a3
$159b o159b:   cd 81 1d CALL co1d81
$159e          06 31    MVI B, #31
$15a0 o15a0:   cd 91 1d CALL co1d91
$15a3 j15a3:   21 ed 12 LXI H, LIL_VICTORY_MUSIC ;o1590,o1598
$15a6 o15a6:   cd 61 12 CALL PLAY_SOUND
$15a9 o15a9:   c3 19 14 JMP jo1419
; outlane handler
$15ac          3e ff    MVI A, #ff
$15ae          32 93 21 STA STATE_OUTLANE_1
$15b1          3a 94 21 LDA SWITCH_LATCHED
$15b4          f6 30    ORI #30
$15b6          32 94 21 STA SWITCH_LATCHED
; don't let outlane scrore > 1x
$15b9          21 90 21 LXI H, GAME_STATE
$15bc          3e 02    MVI A, #02
$15be o15be:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$15c1 o15c1:   c2 19 14 JNZ jo1419
$15c4 o15c4:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$15c7          21 65 11 LXI H, #1165
$15ca o15ca:   cd 92 02 CALL ADD_BONUS_HL
$15cd          21 4b 13 LXI H, OUTLANE_MUSIC
$15d0 o15d0:   cd 61 12 CALL PLAY_SOUND
$15d3 o15d3:   c3 19 14 JMP jo1419
; inlane routine
$15d6          21 90 21 LXI H, GAME_STATE
$15d9          3e 02    MVI A, #02
$15db o15db:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$15de o15de:   c2 19 14 JNZ jo1419
$15e1          3e 07    MVI A, #07
$15e3 o15e3:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$15e6 o15e6:   ca 19 14 JZ jo1419
$15e9 o15e9:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$15ec          21 65 11 LXI H, #1165
$15ef o15ef:   cd 5c 0e CALL ADD_BONUS
$15f2          21 35 13 LXI H, SPREAD_HRM_MUSIC
$15f5 o15f5:   cd 61 12 CALL PLAY_SOUND
$15f8 o15f8:   c3 19 14 JMP jo1419
$15fb          21 92 21 LXI H, GAME_STATE2
$15fe          3e 00    MVI A, #00
$1600 o1600:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$1603 o1603:   c2 89 17 JNZ j1789
$1606 o1606:   cd 09 00 CALL c0009
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
$1637 o1637:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$163a o163a:   cd a8 17 CALL c17a8
$163d          21 92 21 LXI H, GAME_STATE2
$1640          3e 04    MVI A, #04
$1642 o1642:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$1645 o1645:   ca 55 16 JZ j1655
$1648          3e 07    MVI A, #07
$164a o164a:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$164d o164d:   ca 55 16 JZ j1655
$1650          3e 01    MVI A, #01
$1652 o1652:   c3 71 16 JMP j1671
$1655 j1655:   3e 06    MVI A, #06 ;o1645,o164d
$1657 o1657:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$165a          3a 90 21 LDA GAME_STATE
$165d          f6 05    ORI #05
$165f          32 90 21 STA GAME_STATE
$1662          3e ff    MVI A, #ff
$1664          32 93 21 STA STATE_OUTLANE_1
$1667          3a 94 21 LDA SWITCH_LATCHED
$166a          f6 30    ORI #30
$166c          32 94 21 STA SWITCH_LATCHED
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
$168f          32 80 23 STA LAMPS_PAGE_1
$1692          32 a0 23 STA LAMPS_PAGE_2
$1695          3e 00    MVI A, #00
$1697          32 14 22 STA $2214
$169a          11 d3 21 LXI D, #21d3
$169d          06 04    MVI B, #04
$169f o169f:   cd 8e 17 CALL jc178e
$16a2          21 92 21 LXI H, GAME_STATE2
$16a5          3e 06    MVI A, #06
$16a7 o16a7:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$16aa          3a b6 23 LDA $23b6
$16ad          e6 7f    ANI #7f
$16af          32 b6 23 STA $23b6
$16b2          21 d3 21 LXI H, #21d3
$16b5          11 c6 21 LXI D, ROLLOVERS
$16b8          3e 10    MVI A, #10
$16ba o16ba:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$16bd          21 c9 21 LXI H, #21c9
$16c0          11 ce 21 LXI D, #21ce
$16c3          3e 0a    MVI A, #0a
$16c5 o16c5:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$16c8          3a 90 21 LDA GAME_STATE
$16cb          e6 e7    ANI #e7
$16cd          32 90 21 STA GAME_STATE
$16d0 DECREASE_CREDIT:
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
$16fa o16fa:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$16fd o16fd:   ca 38 17 JZ jo1738
$1700          3e 02    MVI A, #02
$1702 o1702:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$1705 o1705:   ca 4e 17 JZ jo174e
$1708          3e 03    MVI A, #03
$170a o170a:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$170d          3e f0    MVI A, #f0
$170f          32 90 23 STA PL4_SCORE_2
$1712          32 b0 23 STA PL4_SCORE_3
$1715          f3       DI
$1716          3a 7e 23 LDA $237e
$1719          f5       PUSH PSW
$171a          3e 1f    MVI A, #1f
$171c          32 7e 23 STA $237e
$171f          21 49 11 LXI H, #1149
$1722 o1722:   cd 3c 0f CALL ADD_PTS
$1725          3e 2f    MVI A, #2f
$1727          32 7e 23 STA $237e
$172a          21 49 11 LXI H, #1149
$172d o172d:   cd 3c 0f CALL ADD_PTS
$1730          f1       POP PSW
$1731          32 7e 23 STA $237e
$1734          fb       EI
$1735 o1735:   c3 d0 16 JMP DECREASE_CREDIT
$1738 jo1738:  cd d6 03 CALL SET_ATH_BIT_OF_HL ;o16fd
$173b          3e f0    MVI A, #f0
$173d          32 8d 23 STA PL2_SCORE_2
$1740          32 ad 23 STA PL2_SCORE_3
$1743          3e f0    MVI A, #f0
$1745          32 97 23 STA SPREAD_4
$1748          32 b7 23 STA SPREAD_3
$174b o174b:   c3 d0 16 JMP DECREASE_CREDIT
$174e jo174e:  cd d6 03 CALL SET_ATH_BIT_OF_HL ;o1705
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
$176d o176d:   c3 d0 16 JMP DECREASE_CREDIT
$1770          3a 7e 23 LDA $237e
$1773          32 be 23 STA $23be
$1776          e6 0f    ANI #0f
$1778          47       MOV B,A
$1779          3a 9e 23 LDA $239e
$177c          b0       ORA B
$177d          32 9e 23 STA $239e
$1780 o1780:   c3 d0 16 JMP DECREASE_CREDIT
$1783 j1783:   21 6a 13 LXI H, POPCORN_MUSIC ;o16ea
$1786 o1786:   cd 61 12 CALL PLAY_SOUND
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
$17b8          21 80 23 LXI H, LAMPS_PAGE_1
$17bb          3e ff    MVI A, #ff
$17bd          16 1a    MVI D, #1a
$17bf j17bf:   77       MOV M,A ;o17c2
$17c0          23       INX H
$17c1          15       DCR D
$17c2 o17c2:   c2 bf 17 JNZ j17bf
$17c5          21 a0 23 LXI H, LAMPS_PAGE_2
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
$17f7 o17f7:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
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
$180d o180d:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
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
$182d          32 93 21 STA STATE_OUTLANE_1
$1830          3e 00    MVI A, #00
$1832          32 0c 22 STA $220c
$1835          32 c3 21 STA $21c3
$1838          32 a8 21 STA $21a8
$183b          32 a9 21 STA $21a9
$183e          3a 94 21 LDA SWITCH_LATCHED
$1841          f6 30    ORI #30
$1843          32 94 21 STA SWITCH_LATCHED
$1846          21 90 21 LXI H, GAME_STATE
$1849          3e 02    MVI A, #02
$184b o184b:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$184e          21 92 21 LXI H, GAME_STATE2
$1851          3e 04    MVI A, #04
$1853 o1853:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$1856          21 e8 12 LXI H, OOPS2_MUSIC
$1859 o1859:   cd 61 12 CALL PLAY_SOUND
$185c o185c:   cd a8 1b CALL c1ba8
$185f          eb       XCHG
$1860          21 c6 21 LXI H, ROLLOVERS
$1863          3e 10    MVI A, #10
$1865 o1865:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$1868          21 90 21 LXI H, GAME_STATE
$186b          3e 00    MVI A, #00
$186d o186d:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
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
$18a6 o18a6:   cd cf 0e CALL COPY_FROM_HL_TO_DE
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
$18c7 o18c7:   cd 61 12 CALL PLAY_SOUND
$18ca o18ca:   c3 19 14 JMP jo1419
$18cd          21 65 11 LXI H, #1165
$18d0 o18d0:   cd 99 0e CALL c0e99
$18d3 o18d3:   da ea 18 JC j18ea
$18d6          21 65 11 LXI H, #1165
$18d9 o18d9:   cd 92 02 CALL ADD_BONUS_HL
$18dc          3e 0a    MVI A, #0a
$18de          32 ae 21 STA $21ae
$18e1          21 32 13 LXI H, BUMPER_25_MUSIC
$18e4 o18e4:   cd 61 12 CALL PLAY_SOUND
$18e7 o18e7:   c3 1e 06 JMP END_MAIN_LOOP
$18ea j18ea:   21 65 11 LXI H, #1165 ;o18d3
$18ed o18ed:   cd 5c 0e CALL ADD_BONUS
$18f0          21 5b 23 LXI H, #235b
$18f3 o18f3:   cd 3c 0f CALL ADD_PTS
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
$1911 o1911:   c3 1e 06 JMP END_MAIN_LOOP
$1914 j1914:   3e 01    MVI A, #01 ;o1909
$1916          32 12 22 STA $2212
$1919          3e 32    MVI A, #32
$191b          32 94 21 STA SWITCH_LATCHED
$191e          21 92 21 LXI H, GAME_STATE2
$1921          3e 03    MVI A, #03
$1923 o1923:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
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
$1949 jo1949:  cd ee 03 CALL CHECK_ATH_BIT_OF_HL ;o1952
$194c o194c:   c2 55 19 JNZ jo1955
$194f          3c       INR A
$1950          fe 08    CPI #08
$1952 o1952:   c2 49 19 JNZ jo1949
$1955 jo1955:  cd e1 03 CALL CLEAR_ATH_BIT_OF_HL ;o194c
$1958          3c       INR A
$1959          4f       MOV C,A
$195a          d6 04    SUI #04
$195c o195c:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
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
$199d o199d:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$19a0          c6 04    ADI #04
$19a2          eb       XCHG
$19a3 o19a3:   cd d6 03 CALL SET_ATH_BIT_OF_HL
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
$19bf j19bf:   21 91 21 LXI H, CONTROL_FLAGS ;o197f
$19c2          3e 00    MVI A, #00
$19c4 o19c4:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$19c7          3e 01    MVI A, #01
$19c9 o19c9:   c2 8a 1a JNZ j1a8a
$19cc          3a 92 21 LDA GAME_STATE2
$19cf          f6 c0    ORI #c0
$19d1          32 92 21 STA GAME_STATE2
$19d4 o19d4:   cd b7 1d CALL c1db7
$19d7          21 b6 23 LXI H, #23b6
$19da          3e 07    MVI A, #07
$19dc o19dc:   cd d6 03 CALL SET_ATH_BIT_OF_HL
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
$1a27 o1a27:   cd 61 12 CALL PLAY_SOUND
$1a2a j1a2a:   3e 00    MVI A, #00 ;o1a21
$1a2c          32 9b 23 STA BALL_IN_PLAY_1
$1a2f          32 bb 23 STA BALL_IN_PLAY_2
$1a32          3e fa    MVI A, #fa
$1a34          32 9e 21 STA $219e
$1a37 o1a37:   c3 1e 06 JMP END_MAIN_LOOP
 
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
$1a6e o1a6e:   c3 1e 06 JMP END_MAIN_LOOP
$1a71 jo1a71:  cd d3 06 CALL c06d3 ;o1a66
$1a74          3a 47 22 LDA $2247
$1a77          e6 f7    ANI #f7
$1a79          32 47 22 STA $2247
$1a7c          3e 07    MVI A, #07
$1a7e          21 b3 23 LXI H, HIGH_SCORE_DISP3
$1a81          11 93 23 LXI D, HIGH_SCORE_NOW
$1a84 o1a84:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$1a87 o1a87:   c3 1e 06 JMP END_MAIN_LOOP
$1a8a j1a8a:   32 7b 23 STA BALL_IN_PLAY_hrm ;o1944,o196d,o19c9
$1a8d          32 9b 23 STA BALL_IN_PLAY_1
$1a90          32 bb 23 STA BALL_IN_PLAY_2
$1a93          3e 04    MVI A, #04
$1a95          21 7e 23 LXI H, #237e
$1a98 jo1a98:  cd d6 03 CALL SET_ATH_BIT_OF_HL ;o1960
$1a9b          3a 13 22 LDA BALLS_PER_GAME
$1a9e          4f       MOV C,A
$1a9f          3a 7b 23 LDA BALL_IN_PLAY_hrm
$1aa2          b9       CMP C
$1aa3 o1aa3:   c2 ae 1a JNZ j1aae
$1aa6          21 90 21 LXI H, GAME_STATE
$1aa9          3e 04    MVI A, #04
$1aab o1aab:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$1aae j1aae:   3a 7e 23 LDA $237e ;o19bc,o1aa3
$1ab1          32 be 23 STA $23be
$1ab4          47       MOV B,A
$1ab5          e6 0f    ANI #0f
$1ab7          32 9e 23 STA $239e
$1aba          21 90 21 LXI H, GAME_STATE
$1abd          3e 00    MVI A, #00
$1abf o1abf:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$1ac2          06 09    MVI B, #09
$1ac4 o1ac4:   cd 81 1d CALL co1d81
$1ac7          21 b6 23 LXI H, #23b6
$1aca          3e 04    MVI A, #04
$1acc o1acc:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$1acf          3e 02    MVI A, #02
$1ad1          32 a1 21 STA $21a1
$1ad4 o1ad4:   c3 1e 06 JMP END_MAIN_LOOP
$1ad7          3a 12 22 LDA $2212
$1ada          3d       DCR A
$1adb          32 12 22 STA $2212
$1ade o1ade:   ca ef 1a JZ j1aef
$1ae1          21 21 13 LXI H, MORSE_CODE_MUSIC
$1ae4 o1ae4:   cd 61 12 CALL PLAY_SOUND
$1ae7          3e a0    MVI A, #a0
$1ae9          32 a1 21 STA $21a1
$1aec o1aec:   c3 1e 06 JMP END_MAIN_LOOP
$1aef j1aef:   21 49 11 LXI H, #1149 ;o1ade
$1af2 o1af2:   cd 6f 0e CALL c0e6f
$1af5          3a c9 21 LDA $21c9
$1af8          32 18 22 STA $2218
$1afb          3a ce 21 LDA $21ce
$1afe          32 19 22 STA $2219
$1b01 o1b01:   cd a8 1b CALL c1ba8
$1b04          11 c6 21 LXI D, ROLLOVERS
$1b07          3e 10    MVI A, #10
$1b09 o1b09:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$1b0c          21 c9 21 LXI H, #21c9
$1b0f          11 ce 21 LXI D, #21ce
$1b12          3e 0a    MVI A, #0a
$1b14 o1b14:   cd cf 0e CALL COPY_FROM_HL_TO_DE
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
$1b6c o1b6c:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$1b6f          21 46 13 LXI H, NEXT_PLAYER_MUSIC
$1b72 o1b72:   cd 61 12 CALL PLAY_SOUND
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
$1ba5 jo1ba5:  c3 1e 06 JMP END_MAIN_LOOP ;o1b7e,o1b81,o1b97,o1b9f
 
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
$1bce          3a 94 21 LDA SWITCH_LATCHED
$1bd1 o1bd1:   fa d9 1b JM j1bd9
$1bd4          e6 fd    ANI #fd
$1bd6 o1bd6:   c3 db 1b JMP j1bdb
$1bd9 j1bd9:   f6 02    ORI #02 ;o1bd1
$1bdb j1bdb:   32 94 21 STA SWITCH_LATCHED ;o1bd6
$1bde          3a 92 21 LDA GAME_STATE2
$1be1          47       MOV B,A
$1be2          e6 01    ANI #01
$1be4 o1be4:   ca 04 1c JZ j1c04
$1be7          78       MOV A,B
$1be8          e6 fe    ANI #fe
$1bea          32 92 21 STA GAME_STATE2
$1bed          fb       EI
$1bee          21 4b 22 LXI H, #224b
$1bf1          11 80 23 LXI D, LAMPS_PAGE_1
$1bf4          3e 34    MVI A, #34
$1bf6 o1bf6:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$1bf9          21 6b 22 LXI H, #226b
$1bfc          11 a0 23 LXI D, LAMPS_PAGE_2
$1bff          3e 34    MVI A, #34
$1c01 o1c01:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$1c04 j1c04:   3a 15 22 LDA $2215 ;o1be4
$1c07          e6 20    ANI #20
$1c09 o1c09:   c2 c3 1c JNZ j1cc3
$1c0c          fb       EI
$1c0d          21 2d 22 LXI H, HIGH_SCORE_START
$1c10          11 b3 23 LXI D, HIGH_SCORE_DISP3
$1c13          3e 07    MVI A, #07
$1c15 o1c15:   cd ea 0e CALL WRITE_TO_RAM
$1c18          21 89 11 LXI H, #1189
$1c1b          3a 47 22 LDA $2247
$1c1e          e6 08    ANI #08
$1c20 o1c20:   c2 26 1c JNZ j1c26
$1c23          21 b3 23 LXI H, HIGH_SCORE_DISP3
$1c26 j1c26:   11 93 23 LXI D, HIGH_SCORE_NOW ;o1c20
$1c29          3e 07    MVI A, #07
$1c2b o1c2b:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$1c2e          3a 92 21 LDA GAME_STATE2
$1c31          e6 40    ANI #40
$1c33 o1c33:   ca 4e 1c JZ j1c4e
$1c36          3a 7a 23 LDA CREDITS_1
; seems pointless
$1c39          b7       ORA A
$1c3a          21 b6 23 LXI H, #23b6
$1c3d          3e 06    MVI A, #06
$1c3f o1c3f:   c2 48 1c JNZ jo1c48
$1c42 o1c42:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$1c45 o1c45:   c3 d2 01 JMP j01d2
$1c48 jo1c48:  cd e1 03 CALL CLEAR_ATH_BIT_OF_HL ;o1c3f
$1c4b o1c4b:   c3 d2 01 JMP j01d2
$1c4e j1c4e:   3a 91 21 LDA CONTROL_FLAGS ;o1c33
$1c51          e6 01    ANI #01
$1c53          fb       EI
$1c54 o1c54:   ca d2 01 JZ j01d2
$1c57          db 03    IN PRICE_TENS_07_PORT
$1c59          fe fe    CPI #fe
$1c5b o1c5b:   c2 65 1c JNZ j1c65
$1c5e          db 02    IN PRICE_CENTS_07_PORT
$1c60          fe fb    CPI #fb
$1c62 o1c62:   ca dc 1c JZ j1cdc
$1c65 j1c65:   21 91 21 LXI H, CONTROL_FLAGS ;o1c5b
$1c68          3e 00    MVI A, #00
$1c6a o1c6a:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$1c6d          32 9f 21 STA $219f
$1c70 o1c70:   c3 d2 01 JMP j01d2
$1c73 j1c73:   21 92 21 LXI H, GAME_STATE2 ;o1bc2
$1c76          3e 00    MVI A, #00
$1c78 o1c78:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$1c7b o1c7b:   c2 2c 02 JNZ j022c
$1c7e o1c7e:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$1c81          21 80 23 LXI H, LAMPS_PAGE_1
$1c84          11 4b 22 LXI D, #224b
$1c87          3e 80    MVI A, #80
$1c89 o1c89:   cd cf 0e CALL COPY_FROM_HL_TO_DE
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
$1ca6 o1ca6:   cd cf 0e CALL COPY_FROM_HL_TO_DE
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
$1cd3 o1cd3:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
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
$1d1f o1d1f:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$1d22          3a c2 21 LDA $21c2
$1d25          2f       CMA
$1d26          d3 05    OUT COIL_5
$1d28          3e 80    MVI A, #80
$1d2a          32 93 21 STA STATE_OUTLANE_1
$1d2d          3e 06    MVI A, #06
$1d2f          32 ac 21 STA $21ac
$1d32          3e 00    MVI A, #00
$1d34          32 94 21 STA SWITCH_LATCHED
$1d37          3a 90 21 LDA GAME_STATE
$1d3a          e6 38    ANI #38
$1d3c          f6 80    ORI #80
$1d3e          32 90 21 STA GAME_STATE
$1d41          3a 92 21 LDA GAME_STATE2
$1d44          e6 67    ANI #67
$1d46          32 92 21 STA GAME_STATE2
$1d49          21 91 21 LXI H, CONTROL_FLAGS
$1d4c          3e 01    MVI A, #01
$1d4e o1d4e:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$1d51          21 94 21 LXI H, SWITCH_LATCHED
$1d54          3e 04    MVI A, #04
$1d56 o1d56:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$1d59          3e 06    MVI A, #06
$1d5b          32 a8 21 STA $21a8
$1d5e          3e 05    MVI A, #05
$1d60          32 97 21 STA $2197
$1d63 o1d63:   c3 2c 02 JMP j022c
$1d66          21 c2 21 LXI H, #21c2
$1d69          3e 05    MVI A, #05
$1d6b o1d6b:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$1d6e          f3       DI
$1d6f o1d6f:   cd 7d 13 CALL jc137d
$1d72          fb       EI
$1d73 o1d73:   c3 1e 06 JMP END_MAIN_LOOP
 
$1d76 co1d76:  cd a3 1d CALL c1da3 ;o0ad6,o0b23,o0b3b,o0b63,o0e95,o14e9,o1511,o151c,o1b19,o1b1e,o1b23,o1b28,o1b2d,o1ba2
$1d79 o1d79:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$1d7c          19       DAD D
$1d7d o1d7d:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$1d80          c9       RET

 
$1d81 co1d81:  cd a3 1d CALL c1da3 ;o050c,o06e9,jo09da,o0b41,o0c2e,o0c33,o0d37,o0dbc,o14b1,jo1517,o159b,o1ac4,o1b32,o1b37,o1b3c,o1b41,o1b64
$1d84 o1d84:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$1d87          19       DAD D
$1d88 o1d88:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
$1d8b          f5       PUSH PSW
$1d8c o1d8c:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$1d8f          f1       POP PSW
$1d90          c9       RET

 
$1d91 co1d91:  cd a3 1d CALL c1da3 ;jo0a14,o15a0
$1d94 o1d94:   cd d6 03 CALL SET_ATH_BIT_OF_HL
$1d97          19       DAD D
$1d98 o1d98:   cd e1 03 CALL CLEAR_ATH_BIT_OF_HL
$1d9b          c9       RET

 
$1d9c co1d9c:  cd a3 1d CALL c1da3 ;o0a03,o0b1b,o0b5d,o0be1,o0c07,o0c14,o0c26,o0db6,o1501,o1509,o1595,o1875,o1b9c
$1d9f o1d9f:   cd ee 03 CALL CHECK_ATH_BIT_OF_HL
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
$1f40 o1f40:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$1f43          d1       POP D
$1f44          f1       POP PSW
$1f45          3d       DCR A
$1f46          c8       RZ
$1f47          f5       PUSH PSW
$1f48          21 31 22 LXI H, #2231
$1f4b          e5       PUSH H
$1f4c          3e 07    MVI A, #07
$1f4e o1f4e:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$1f51          d1       POP D
$1f52          f1       POP PSW
$1f53          3d       DCR A
$1f54          c8       RZ
$1f55          21 2d 22 LXI H, HIGH_SCORE_START
$1f58          3e 07    MVI A, #07
$1f5a o1f5a:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$1f5d          c9       RET

 
$1f5e c1f5e:   e5       PUSH H ;o1e90
$1f5f          3e 03    MVI A, #03
$1f61 o1f61:   cd 36 1f CALL c1f36
$1f64          e1       POP H
$1f65          11 2d 22 LXI D, HIGH_SCORE_START
$1f68          3e 07    MVI A, #07
$1f6a o1f6a:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$1f6d          21 51 13 LXI H, HIGH_SCORE_MUSIC
$1f70 o1f70:   cd 61 12 CALL PLAY_SOUND
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
$1f8a o1f8a:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$1f8d          3f       CMC
$1f8e          c9       RET

 
$1f8f c1f8f:   e5       PUSH H ;o1eb4,o1eea,o1f0e
$1f90          3e 01    MVI A, #01
$1f92 o1f92:   cd 36 1f CALL c1f36
$1f95          e1       POP H
$1f96          11 35 22 LXI D, #2235
$1f99          3e 07    MVI A, #07
$1f9b o1f9b:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$1f9e          3f       CMC
$1f9f          c9       RET

 
$1fa0 c1fa0:   11 39 22 LXI D, #2239 ;o1ec6,o1efc,o1f20,o1f32
$1fa3          3e 07    MVI A, #07
$1fa5 o1fa5:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$1fa8          3f       CMC
$1fa9          c9       RET

 
$1faa c1faa:   21 31 22 LXI H, #2231 ;o0707,o08f4
$1fad          e5       PUSH H
$1fae          11 2d 22 LXI D, HIGH_SCORE_START
$1fb1          3e 07    MVI A, #07
$1fb3 o1fb3:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$1fb6          d1       POP D
$1fb7          21 35 22 LXI H, #2235
$1fba          e5       PUSH H
$1fbb          3e 07    MVI A, #07
$1fbd o1fbd:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$1fc0          d1       POP D
$1fc1          21 39 22 LXI H, #2239
$1fc4          e5       PUSH H
$1fc5          3e 07    MVI A, #07
$1fc7 o1fc7:   cd cf 0e CALL COPY_FROM_HL_TO_DE
$1fca          21 81 11 LXI H, #1181
$1fcd          d1       POP D
$1fce          3e 07    MVI A, #07
$1fd0 o1fd0:   cd cf 0e CALL COPY_FROM_HL_TO_DE
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
$1fe6 o1fe6:   cd cf 0e CALL COPY_FROM_HL_TO_DE
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
$2000          00       NOP
$2001          00       NOP
$2002          00       NOP
$2003          00       NOP
$2004          00       NOP
$2005          00       NOP
$2006          00       NOP
$2007          00       NOP
$2008          00       NOP
$2009          00       NOP
$200a          00       NOP
$200b          00       NOP
$200c          00       NOP
$200d          00       NOP
$200e          00       NOP
$200f          00       NOP
$2010          00       NOP
$2011          00       NOP
$2012          00       NOP
$2013          00       NOP
$2014          00       NOP
$2015          00       NOP
$2016          00       NOP
$2017          00       NOP
$2018          00       NOP
$2019          00       NOP
$201a          00       NOP
$201b          00       NOP
$201c          00       NOP
$201d          00       NOP
$201e          00       NOP
$201f          00       NOP
$2020          00       NOP
$2021          00       NOP
$2022          00       NOP
$2023          00       NOP
$2024          00       NOP
$2025          00       NOP
$2026          00       NOP
$2027          00       NOP
$2028          00       NOP
$2029          00       NOP
$202a          00       NOP
$202b          00       NOP
$202c          00       NOP
$202d          00       NOP
$202e          00       NOP
$202f          00       NOP
$2030          00       NOP
$2031          00       NOP
$2032          00       NOP
$2033          00       NOP
$2034          00       NOP
$2035          00       NOP
$2036          00       NOP
$2037          00       NOP
$2038          00       NOP
$2039          00       NOP
$203a          00       NOP
$203b          00       NOP
$203c          00       NOP
$203d          00       NOP
$203e          00       NOP
$203f          00       NOP
$2040          00       NOP
$2041          00       NOP
$2042          00       NOP
$2043          00       NOP
$2044          00       NOP
$2045          00       NOP
$2046          00       NOP
$2047          00       NOP
$2048          00       NOP
$2049          00       NOP
$204a          00       NOP
$204b          00       NOP
$204c          00       NOP
$204d          00       NOP
$204e          00       NOP
$204f          00       NOP
$2050          00       NOP
$2051          00       NOP
$2052          00       NOP
$2053          00       NOP
$2054          00       NOP
$2055          00       NOP
$2056          00       NOP
$2057          00       NOP
$2058          00       NOP
$2059          00       NOP
$205a          00       NOP
$205b          00       NOP
$205c          00       NOP
$205d          00       NOP
$205e          00       NOP
$205f          00       NOP
$2060          00       NOP
$2061          00       NOP
$2062          00       NOP
$2063          00       NOP
$2064          00       NOP
$2065          00       NOP
$2066          00       NOP
$2067          00       NOP
$2068          00       NOP
$2069          00       NOP
$206a          00       NOP
$206b          00       NOP
$206c          00       NOP
$206d          00       NOP
$206e          00       NOP
$206f          00       NOP
$2070          00       NOP
$2071          00       NOP
$2072          00       NOP
$2073          00       NOP
$2074          00       NOP
$2075          00       NOP
$2076          00       NOP
$2077          00       NOP
$2078          00       NOP
$2079          00       NOP
$207a          00       NOP
$207b          00       NOP
$207c          00       NOP
$207d          00       NOP
$207e          00       NOP
$207f          00       NOP
$2080          00       NOP
$2081          00       NOP
$2082          00       NOP
$2083          00       NOP
$2084          00       NOP
$2085          00       NOP
$2086          00       NOP
$2087          00       NOP
$2088          00       NOP
$2089          00       NOP
$208a          00       NOP
$208b          00       NOP
$208c          00       NOP
$208d          00       NOP
$208e          00       NOP
$208f          00       NOP
$2090          00       NOP
$2091          00       NOP
$2092          00       NOP
$2093          00       NOP
$2094          00       NOP
$2095          00       NOP
$2096          00       NOP
$2097          00       NOP
$2098          00       NOP
$2099          00       NOP
$209a          00       NOP
$209b          00       NOP
$209c          00       NOP
$209d          00       NOP
$209e          00       NOP
$209f          00       NOP
$20a0          00       NOP
$20a1          00       NOP
$20a2          00       NOP
$20a3          00       NOP
$20a4          00       NOP
$20a5          00       NOP
$20a6          00       NOP
$20a7          00       NOP
$20a8          00       NOP
$20a9          00       NOP
$20aa          00       NOP
$20ab          00       NOP
$20ac          00       NOP
$20ad          00       NOP
$20ae          00       NOP
$20af          00       NOP
$20b0          00       NOP
$20b1          00       NOP
$20b2          00       NOP
$20b3          00       NOP
$20b4          00       NOP
$20b5          00       NOP
$20b6          00       NOP
$20b7          00       NOP
$20b8          00       NOP
$20b9          00       NOP
$20ba          00       NOP
$20bb          00       NOP
$20bc          00       NOP
$20bd          00       NOP
$20be          00       NOP
$20bf          00       NOP
$20c0          00       NOP
$20c1          00       NOP
$20c2          00       NOP
$20c3          00       NOP
$20c4          00       NOP
$20c5          00       NOP
$20c6          00       NOP
$20c7          00       NOP
$20c8          00       NOP
$20c9          00       NOP
$20ca          00       NOP
$20cb          00       NOP
$20cc          00       NOP
$20cd          00       NOP
$20ce          00       NOP
$20cf          00       NOP
$20d0          00       NOP
$20d1          00       NOP
$20d2          00       NOP
$20d3          00       NOP
$20d4          00       NOP
$20d5          00       NOP
$20d6          00       NOP
$20d7          00       NOP
$20d8          00       NOP
$20d9          00       NOP
$20da          00       NOP
$20db          00       NOP
$20dc          00       NOP
$20dd          00       NOP
$20de          00       NOP
$20df          00       NOP
$20e0          00       NOP
$20e1          00       NOP
$20e2          00       NOP
$20e3          00       NOP
$20e4          00       NOP
$20e5          00       NOP
$20e6          00       NOP
$20e7          00       NOP
$20e8          00       NOP
$20e9          00       NOP
$20ea          00       NOP
$20eb          00       NOP
$20ec          00       NOP
$20ed          00       NOP
$20ee          00       NOP
$20ef          00       NOP
$20f0          00       NOP
$20f1          00       NOP
$20f2          00       NOP
$20f3          00       NOP
$20f4          00       NOP
$20f5          00       NOP
$20f6          00       NOP
$20f7          00       NOP
$20f8          00       NOP
$20f9          00       NOP
$20fa          00       NOP
$20fb          00       NOP
$20fc          00       NOP
$20fd          00       NOP
$20fe          00       NOP
$20ff          00       NOP
$2100          00       NOP
$2101          00       NOP
$2102          00       NOP
$2103          00       NOP
$2104          00       NOP
$2105          00       NOP
$2106          00       NOP
$2107          00       NOP
$2108          00       NOP
$2109          00       NOP
$210a          00       NOP
$210b          00       NOP
$210c          00       NOP
$210d          00       NOP
$210e          00       NOP
$210f          00       NOP
$2110          00       NOP
$2111          00       NOP
$2112          00       NOP
$2113          00       NOP
$2114          00       NOP
$2115          00       NOP
$2116          00       NOP
$2117          00       NOP
$2118          00       NOP
$2119          00       NOP
$211a          00       NOP
$211b          00       NOP
$211c          00       NOP
$211d          00       NOP
$211e          00       NOP
$211f          00       NOP
$2120          00       NOP
$2121          00       NOP
$2122          00       NOP
$2123          00       NOP
$2124          00       NOP
$2125          00       NOP
$2126          00       NOP
$2127          00       NOP
$2128          00       NOP
$2129          00       NOP
$212a          00       NOP
$212b          00       NOP
$212c          00       NOP
$212d          00       NOP
$212e          00       NOP
$212f          00       NOP
$2130          00       NOP
$2131          00       NOP
$2132          00       NOP
$2133          00       NOP
$2134          00       NOP
$2135          00       NOP
$2136          00       NOP
$2137          00       NOP
$2138          00       NOP
$2139          00       NOP
$213a          00       NOP
$213b          00       NOP
$213c          00       NOP
$213d          00       NOP
$213e          00       NOP
$213f          00       NOP
$2140          00       NOP
$2141          00       NOP
$2142          00       NOP
$2143          00       NOP
$2144          00       NOP
$2145          00       NOP
$2146          00       NOP
$2147          00       NOP
$2148          00       NOP
$2149          00       NOP
$214a          00       NOP
$214b          00       NOP
$214c          00       NOP
$214d          00       NOP
$214e          00       NOP
$214f          00       NOP
$2150          00       NOP
$2151          00       NOP
$2152          00       NOP
$2153          00       NOP
$2154          00       NOP
$2155          00       NOP
$2156          00       NOP
$2157          00       NOP
$2158          00       NOP
$2159          00       NOP
$215a          00       NOP
$215b          00       NOP
$215c          00       NOP
$215d          00       NOP
$215e          00       NOP
$215f          00       NOP
$2160          00       NOP
$2161          00       NOP
$2162          00       NOP
$2163          00       NOP
$2164          00       NOP
$2165          00       NOP
$2166          00       NOP
$2167          00       NOP
$2168          00       NOP
$2169          00       NOP
$216a          00       NOP
$216b          00       NOP
$216c          00       NOP
$216d          00       NOP
$216e          00       NOP
$216f          00       NOP
$2170          00       NOP
$2171          00       NOP
$2172          00       NOP
$2173          00       NOP
$2174          00       NOP
$2175          00       NOP
$2176          00       NOP
$2177          00       NOP
$2178          00       NOP
$2179          00       NOP
$217a          00       NOP
$217b          00       NOP
$217c          00       NOP
$217d          00       NOP
$217e          00       NOP
$217f          00       NOP
$2180          00       NOP
$2181          00       NOP
$2182          00       NOP
$2183          00       NOP
$2184          00       NOP
$2185          00       NOP
$2186          00       NOP
$2187          00       NOP
$2188          00       NOP
$2189          00       NOP
$218a          00       NOP
$218b          00       NOP
$218c          00       NOP
$218d          00       NOP
$218e          00       NOP
$218f          00       NOP
GAME_STATE          00       NOP
CONTROL_FLAGS          00       NOP
GAME_STATE2          00       NOP
STATE_OUTLANE_1          00       NOP
SWITCH_LATCHED          00       NOP
STACK_SCRATCH          00       NOP
$2196          00       NOP
$2197          00       NOP
$2198          00       NOP
$2199          00       NOP
$219a          00       NOP
$219b          00       NOP
$219c          00       NOP
$219d          00       NOP
$219e          00       NOP
$219f          00       NOP
$21a0          00       NOP
$21a1          00       NOP
$21a2          00       NOP
$21a3          00       NOP
$21a4          00       NOP
$21a5          00       NOP
$21a6          00       NOP
$21a7          00       NOP
$21a8          00       NOP
$21a9          00       NOP
$21aa          00       NOP
$21ab          00       NOP
$21ac          00       NOP
$21ad          00       NOP
$21ae          00       NOP
$21af          00       NOP
$21b0          00       NOP
NEXT_TONE          00       NOP
$21b2          00       NOP
$21b3          00       NOP
$21b4          00       NOP
$21b5          00       NOP
$21b6          00       NOP
$21b7          00       NOP
$21b8          00       NOP
$21b9          00       NOP
$21ba          00       NOP
$21bb          00       NOP
$21bc          00       NOP
$21bd          00       NOP
$21be          00       NOP
$21bf          00       NOP
$21c0          00       NOP
$21c1          00       NOP
$21c2          00       NOP
$21c3          00       NOP
$21c4          00       NOP
$21c5          00       NOP
ROLLOVERS          00       NOP
CUPS_LEFT          00       NOP
$21c8          00       NOP
$21c9          00       NOP
$21ca          00       NOP
$21cb          00       NOP
$21cc          00       NOP
$21cd          00       NOP
$21ce          00       NOP
$21cf          00       NOP
$21d0          00       NOP
$21d1          00       NOP
$21d2          00       NOP
$21d3          00       NOP
$21d4          00       NOP
$21d5          00       NOP
$21d6          00       NOP
$21d7          00       NOP
$21d8          00       NOP
$21d9          00       NOP
$21da          00       NOP
$21db          00       NOP
$21dc          00       NOP
$21dd          00       NOP
$21de          00       NOP
$21df          00       NOP
$21e0          00       NOP
$21e1          00       NOP
$21e2          00       NOP
$21e3          00       NOP
$21e4          00       NOP
$21e5          00       NOP
$21e6          00       NOP
$21e7          00       NOP
$21e8          00       NOP
$21e9          00       NOP
$21ea          00       NOP
$21eb          00       NOP
$21ec          00       NOP
$21ed          00       NOP
$21ee          00       NOP
$21ef          00       NOP
$21f0          00       NOP
$21f1          00       NOP
$21f2          00       NOP
SPREAD_1          00       NOP
$21f4          00       NOP
$21f5          00       NOP
$21f6          00       NOP
$21f7          00       NOP
$21f8          00       NOP
$21f9          00       NOP
$21fa          00       NOP
$21fb          00       NOP
$21fc          00       NOP
$21fd          00       NOP
$21fe          00       NOP
$21ff          00       NOP
$2200          00       NOP
$2201          00       NOP
$2202          00       NOP
$2203          00       NOP
$2204          00       NOP
$2205          00       NOP
$2206          00       NOP
$2207          00       NOP
$2208          00       NOP
$2209          00       NOP
$220a          00       NOP
$220b          00       NOP
$220c          00       NOP
$220d          00       NOP
$220e          00       NOP
$220f          00       NOP
$2210          00       NOP
$2211          00       NOP
$2212          00       NOP
BALLS_PER_GAME          00       NOP
$2214          00       NOP
$2215          00       NOP
DIP_SWITCHES          00       NOP
$2217          00       NOP
$2218          00       NOP
$2219          00       NOP
$221a          00       NOP
$221b          00       NOP
$221c          00       NOP
$221d          00       NOP
$221e          00       NOP
$221f          00       NOP
$2220          00       NOP
$2221          00       NOP
$2222          00       NOP
$2223          00       NOP
$2224          00       NOP
$2225          00       NOP
$2226          00       NOP
$2227          00       NOP
$2228          00       NOP
$2229          00       NOP
$222a          00       NOP
$222b          00       NOP
$222c          00       NOP
HIGH_SCORE_START          00       NOP
$222e          00       NOP
$222f          00       NOP
$2230          00       NOP
$2231          00       NOP
$2232          00       NOP
$2233          00       NOP
$2234          00       NOP
$2235          00       NOP
$2236          00       NOP
$2237          00       NOP
$2238          00       NOP
$2239          00       NOP
$223a          00       NOP
$223b          00       NOP
$223c          00       NOP
$223d          00       NOP
$223e          00       NOP
$223f          00       NOP
$2240          00       NOP
$2241          00       NOP
$2242          00       NOP
$2243          00       NOP
$2244          00       NOP
$2245          00       NOP
$2246          00       NOP
$2247          00       NOP
$2248          00       NOP
$2249          00       NOP
$224a          00       NOP
$224b          00       NOP
$224c          00       NOP
$224d          00       NOP
$224e          00       NOP
$224f          00       NOP
$2250          00       NOP
$2251          00       NOP
$2252          00       NOP
$2253          00       NOP
$2254          00       NOP
$2255          00       NOP
$2256          00       NOP
$2257          00       NOP
$2258          00       NOP
$2259          00       NOP
$225a          00       NOP
$225b          00       NOP
$225c          00       NOP
$225d          00       NOP
$225e          00       NOP
$225f          00       NOP
$2260          00       NOP
$2261          00       NOP
$2262          00       NOP
$2263          00       NOP
$2264          00       NOP
$2265          00       NOP
$2266          00       NOP
$2267          00       NOP
$2268          00       NOP
$2269          00       NOP
$226a          00       NOP
$226b          00       NOP
$226c          00       NOP
$226d          00       NOP
$226e          00       NOP
$226f          00       NOP
$2270          00       NOP
$2271          00       NOP
$2272          00       NOP
$2273          00       NOP
$2274          00       NOP
$2275          00       NOP
$2276          00       NOP
$2277          00       NOP
$2278          00       NOP
$2279          00       NOP
$227a          00       NOP
$227b          00       NOP
$227c          00       NOP
$227d          00       NOP
$227e          00       NOP
$227f          00       NOP
$2280          00       NOP
$2281          00       NOP
$2282          00       NOP
$2283          00       NOP
$2284          00       NOP
$2285          00       NOP
$2286          00       NOP
$2287          00       NOP
$2288          00       NOP
$2289          00       NOP
$228a          00       NOP
$228b          00       NOP
$228c          00       NOP
$228d          00       NOP
$228e          00       NOP
$228f          00       NOP
$2290          00       NOP
$2291          00       NOP
$2292          00       NOP
$2293          00       NOP
$2294          00       NOP
$2295          00       NOP
$2296          00       NOP
$2297          00       NOP
$2298          00       NOP
$2299          00       NOP
$229a          00       NOP
$229b          00       NOP
$229c          00       NOP
$229d          00       NOP
$229e          00       NOP
$229f          00       NOP
$22a0          00       NOP
$22a1          00       NOP
$22a2          00       NOP
$22a3          00       NOP
$22a4          00       NOP
$22a5          00       NOP
$22a6          00       NOP
$22a7          00       NOP
$22a8          00       NOP
$22a9          00       NOP
$22aa          00       NOP
$22ab          00       NOP
$22ac          00       NOP
$22ad          00       NOP
$22ae          00       NOP
$22af          00       NOP
$22b0          00       NOP
$22b1          00       NOP
$22b2          00       NOP
$22b3          00       NOP
$22b4          00       NOP
$22b5          00       NOP
$22b6          00       NOP
$22b7          00       NOP
$22b8          00       NOP
$22b9          00       NOP
$22ba          00       NOP
$22bb          00       NOP
$22bc          00       NOP
$22bd          00       NOP
$22be          00       NOP
$22bf          00       NOP
$22c0          00       NOP
$22c1          00       NOP
$22c2          00       NOP
$22c3          00       NOP
$22c4          00       NOP
$22c5          00       NOP
$22c6          00       NOP
$22c7          00       NOP
$22c8          00       NOP
$22c9          00       NOP
$22ca          00       NOP
$22cb          00       NOP
$22cc          00       NOP
$22cd          00       NOP
$22ce          00       NOP
$22cf          00       NOP
$22d0          00       NOP
$22d1          00       NOP
$22d2          00       NOP
$22d3          00       NOP
$22d4          00       NOP
$22d5          00       NOP
$22d6          00       NOP
$22d7          00       NOP
$22d8          00       NOP
$22d9          00       NOP
$22da          00       NOP
$22db          00       NOP
$22dc          00       NOP
$22dd          00       NOP
$22de          00       NOP
$22df          00       NOP
$22e0          00       NOP
$22e1          00       NOP
$22e2          00       NOP
$22e3          00       NOP
$22e4          00       NOP
$22e5          00       NOP
$22e6          00       NOP
$22e7          00       NOP
$22e8          00       NOP
$22e9          00       NOP
$22ea          00       NOP
$22eb          00       NOP
$22ec          00       NOP
$22ed          00       NOP
$22ee          00       NOP
$22ef          00       NOP
$22f0          00       NOP
$22f1          00       NOP
$22f2          00       NOP
$22f3          00       NOP
$22f4          00       NOP
$22f5          00       NOP
$22f6          00       NOP
$22f7          00       NOP
$22f8          00       NOP
$22f9          00       NOP
$22fa          00       NOP
$22fb          00       NOP
$22fc          00       NOP
$22fd          00       NOP
$22fe          00       NOP
$22ff          00       NOP
$2300          00       NOP
$2301          00       NOP
$2302          00       NOP
$2303          00       NOP
$2304          00       NOP
$2305          00       NOP
$2306          00       NOP
$2307          00       NOP
$2308          00       NOP
$2309          00       NOP
$230a          00       NOP
$230b          00       NOP
$230c          00       NOP
$230d          00       NOP
$230e          00       NOP
$230f          00       NOP
$2310          00       NOP
$2311          00       NOP
$2312          00       NOP
$2313          00       NOP
$2314          00       NOP
$2315          00       NOP
$2316          00       NOP
$2317          00       NOP
$2318          00       NOP
$2319          00       NOP
$231a          00       NOP
$231b          00       NOP
$231c          00       NOP
$231d          00       NOP
$231e          00       NOP
$231f          00       NOP
$2320          00       NOP
$2321          00       NOP
$2322          00       NOP
HIGH_SCORE_DISP          00       NOP
$2324          00       NOP
$2325          00       NOP
$2326          00       NOP
$2327          00       NOP
$2328          00       NOP
$2329          00       NOP
$232a          00       NOP
$232b          00       NOP
$232c          00       NOP
$232d          00       NOP
$232e          00       NOP
$232f          00       NOP
HIGH_SCORE_DISP2          00       NOP
$2331          00       NOP
$2332          00       NOP
$2333          00       NOP
$2334          00       NOP
$2335          00       NOP
$2336          00       NOP
$2337          00       NOP
$2338          00       NOP
$2339          00       NOP
$233a          00       NOP
$233b          00       NOP
$233c          00       NOP
$233d          00       NOP
$233e          00       NOP
$233f          00       NOP
$2340          00       NOP
$2341          00       NOP
$2342          00       NOP
$2343          00       NOP
$2344          00       NOP
$2345          00       NOP
$2346          00       NOP
$2347          00       NOP
$2348          00       NOP
$2349          00       NOP
$234a          00       NOP
$234b          00       NOP
$234c          00       NOP
$234d          00       NOP
$234e          00       NOP
$234f          00       NOP
$2350          00       NOP
$2351          00       NOP
$2352          00       NOP
$2353          00       NOP
$2354          00       NOP
$2355          00       NOP
$2356          00       NOP
$2357          00       NOP
$2358          00       NOP
$2359          00       NOP
$235a          00       NOP
$235b          00       NOP
$235c          00       NOP
$235d          00       NOP
$235e          00       NOP
PL3_SCORE_1          00       NOP
PL2_SCORE_H          00       NOP
$2361          00       NOP
$2362          00       NOP
PL1_SCORE_1          00       NOP
$2364          00       NOP
$2365          00       NOP
$2366          00       NOP
PL13_SCORE_1          00       NOP
$2368          00       NOP
$2369          00       NOP
$236a          00       NOP
PL2_SCORE_1          00       NOP
$236c          00       NOP
$236d          00       NOP
$236e          00       NOP
PL4_SCORE_1          00       NOP
$2370          00       NOP
$2371          00       NOP
$2372          00       NOP
PL24_SCORE_1          00       NOP
$2374          00       NOP
$2375          00       NOP
$2376          00       NOP
PL1_SCORE_hrm          00       NOP
$2378          00       NOP
$2379          00       NOP
CREDITS_1          00       NOP
BALL_IN_PLAY_hrm          00       NOP
$237c          00       NOP
$237d          00       NOP
$237e          00       NOP
PRICE_1          00       NOP
LAMPS_PAGE_1          00       NOP
$2381          00       NOP
$2382          00       NOP
PL3_SCORE_DISPLAY_2          00       NOP
$2384          00       NOP
$2385          00       NOP
PL1_SCORE_DISPLAY2          00       NOP
$2387          00       NOP
$2388          00       NOP
PL1_AND_3          00       NOP
$238a          00       NOP
$238b          00       NOP
$238c          00       NOP
PL2_SCORE_2          00       NOP
$238e          00       NOP
$238f          00       NOP
PL4_SCORE_2          00       NOP
$2391          00       NOP
$2392          00       NOP
HIGH_SCORE_NOW          00       NOP
$2394          00       NOP
$2395          00       NOP
$2396          00       NOP
SPREAD_4          00       NOP
$2398          00       NOP
$2399          00       NOP
CREDITS_2          00       NOP
BALL_IN_PLAY_1          00       NOP
$239c          00       NOP
$239d          00       NOP
$239e          00       NOP
PRICE_2          00       NOP
LAMPS_PAGE_2          00       NOP
$23a1          00       NOP
$23a2          00       NOP
$23a3          00       NOP
$23a4          00       NOP
$23a5          00       NOP
PL1_SCORE_DISPLAY          00       NOP
$23a7          00       NOP
$23a8          00       NOP
$23a9          00       NOP
$23aa          00       NOP
$23ab          00       NOP
$23ac          00       NOP
PL2_SCORE_3          00       NOP
$23ae          00       NOP
$23af          00       NOP
PL4_SCORE_3          00       NOP
$23b1          00       NOP
$23b2          00       NOP
HIGH_SCORE_DISP3          00       NOP
$23b4          00       NOP
$23b5          00       NOP
$23b6          00       NOP
SPREAD_3          00       NOP
$23b8          00       NOP
$23b9          00       NOP
CREDITS_3          00       NOP
BALL_IN_PLAY_2          00       NOP
$23bc          00       NOP
$23bd          00       NOP
$23be          00       NOP
PRICE_3          00       NOP
$23c0          00       NOP
$23c1          00       NOP
$23c2          00       NOP
$23c3          00       NOP
$23c4          00       NOP
$23c5          00       NOP
$23c6          00       NOP
$23c7          00       NOP
$23c8          00       NOP
$23c9          00       NOP
$23ca          00       NOP
$23cb          00       NOP
$23cc          00       NOP
$23cd          00       NOP
$23ce          00       NOP
$23cf          00       NOP
$23d0          00       NOP
$23d1          00       NOP
$23d2          00       NOP
HIGH_SCORE_DISP4          00       NOP
$23d4          00       NOP
$23d5          00       NOP
$23d6          00       NOP
$23d7          00       NOP
$23d8          00       NOP
$23d9          00       NOP
CREDITS_4          00       NOP
BALL_IN_PLAY_3          00       NOP
$23dc          00       NOP
$23dd          00       NOP
$23de          00       NOP
PRICE_4          00       NOP
$23e0          00       NOP
$23e1          00       NOP
$23e2          00       NOP
$23e3          00       NOP
$23e4          00       NOP
$23e5          00       NOP
$23e6          00       NOP
$23e7          00       NOP
$23e8          00       NOP
$23e9          00       NOP
$23ea          00       NOP
$23eb          00       NOP
$23ec          00       NOP
$23ed          00       NOP
$23ee          00       NOP
$23ef          00       NOP
$23f0          00       NOP
$23f1          00       NOP
$23f2          00       NOP
$23f3          00       NOP
$23f4          00       NOP
$23f5          00       NOP
$23f6          00       NOP
$23f7          00       NOP
$23f8          00       NOP
$23f9          00       NOP
$23fa          00       NOP
$23fb          00       NOP
$23fc          00       NOP
$23fd          00       NOP
PL3_SCORE_2          00       NOP
$23ff          00       NOP
$2400          00       NOP
$2401          00       NOP
$2402          00       NOP
$2403          00       NOP
$2404          00       NOP
$2405          00       NOP
$2406          00       NOP
$2407          00       NOP
$2408          00       NOP
$2409          00       NOP
$240a          00       NOP
$240b          00       NOP
$240c          00       NOP
$240d          00       NOP
$240e          00       NOP
$240f          00       NOP
$2410          00       NOP
$2411          00       NOP
$2412          00       NOP
$2413          00       NOP
$2414          00       NOP
$2415          00       NOP
$2416          00       NOP
$2417          00       NOP
$2418          00       NOP
$2419          00       NOP
$241a          00       NOP
$241b          00       NOP
$241c          00       NOP
$241d          00       NOP
$241e          00       NOP
$241f          00       NOP
$2420          00       NOP
$2421          00       NOP
$2422          00       NOP
$2423          00       NOP
$2424          00       NOP
$2425          00       NOP
$2426          00       NOP
$2427          00       NOP
$2428          00       NOP
$2429          00       NOP
$242a          00       NOP
$242b          00       NOP
$242c          00       NOP
$242d          00       NOP
$242e          00       NOP
$242f          00       NOP
$2430          00       NOP
$2431          00       NOP
$2432          00       NOP
$2433          00       NOP
$2434          00       NOP
$2435          00       NOP
$2436          00       NOP
$2437          00       NOP
$2438          00       NOP
$2439          00       NOP
$243a          00       NOP
$243b          00       NOP
$243c          00       NOP
$243d          00       NOP
$243e          00       NOP
$243f          00       NOP
$2440          00       NOP
$2441          00       NOP
$2442          00       NOP
$2443          00       NOP
$2444          00       NOP
$2445          00       NOP
$2446          00       NOP
$2447          00       NOP
$2448          00       NOP
$2449          00       NOP
$244a          00       NOP
$244b          00       NOP
$244c          00       NOP
$244d          00       NOP
$244e          00       NOP
$244f          00       NOP
$2450          00       NOP
$2451          00       NOP
$2452          00       NOP
$2453          00       NOP
$2454          00       NOP
$2455          00       NOP
$2456          00       NOP
$2457          00       NOP
$2458          00       NOP
$2459          00       NOP
$245a          00       NOP
$245b          00       NOP
$245c          00       NOP
$245d          00       NOP
$245e          00       NOP
$245f          00       NOP
$2460          00       NOP
$2461          00       NOP
$2462          00       NOP
$2463          00       NOP
$2464          00       NOP
$2465          00       NOP
$2466          00       NOP
$2467          00       NOP
$2468          00       NOP
$2469          00       NOP
$246a          00       NOP
$246b          00       NOP
$246c          00       NOP
$246d          00       NOP
$246e          00       NOP
$246f          00       NOP
$2470          00       NOP
$2471          00       NOP
$2472          00       NOP
$2473          00       NOP
$2474          00       NOP
$2475          00       NOP
$2476          00       NOP
$2477          00       NOP
$2478          00       NOP
$2479          00       NOP
$247a          00       NOP
$247b          00       NOP
$247c          00       NOP
$247d          00       NOP
$247e          00       NOP
$247f          00       NOP
$2480          00       NOP
$2481          00       NOP
$2482          00       NOP
$2483          00       NOP
$2484          00       NOP
$2485          00       NOP
$2486          00       NOP
$2487          00       NOP
$2488          00       NOP
$2489          00       NOP
$248a          00       NOP
$248b          00       NOP
$248c          00       NOP
$248d          00       NOP
$248e          00       NOP
$248f          00       NOP
$2490          00       NOP
$2491          00       NOP
$2492          00       NOP
$2493          00       NOP
$2494          00       NOP
$2495          00       NOP
$2496          00       NOP
$2497          00       NOP
$2498          00       NOP
$2499          00       NOP
$249a          00       NOP
$249b          00       NOP
$249c          00       NOP
$249d          00       NOP
$249e          00       NOP
$249f          00       NOP
$24a0          00       NOP
$24a1          00       NOP
$24a2          00       NOP
$24a3          00       NOP
$24a4          00       NOP
$24a5          00       NOP
$24a6          00       NOP
$24a7          00       NOP
$24a8          00       NOP
$24a9          00       NOP
$24aa          00       NOP
$24ab          00       NOP
$24ac          00       NOP
$24ad          00       NOP
$24ae          00       NOP
$24af          00       NOP
$24b0          00       NOP
$24b1          00       NOP
$24b2          00       NOP
$24b3          00       NOP
$24b4          00       NOP
$24b5          00       NOP
$24b6          00       NOP
$24b7          00       NOP
$24b8          00       NOP
$24b9          00       NOP
$24ba          00       NOP
$24bb          00       NOP
$24bc          00       NOP
$24bd          00       NOP
$24be          00       NOP
$24bf          00       NOP
$24c0          00       NOP
$24c1          00       NOP
$24c2          00       NOP
$24c3          00       NOP
$24c4          00       NOP
$24c5          00       NOP
$24c6          00       NOP
$24c7          00       NOP
$24c8          00       NOP
$24c9          00       NOP
$24ca          00       NOP
$24cb          00       NOP
$24cc          00       NOP
$24cd          00       NOP
$24ce          00       NOP
$24cf          00       NOP
$24d0          00       NOP
$24d1          00       NOP
$24d2          00       NOP
$24d3          00       NOP
$24d4          00       NOP
$24d5          00       NOP
$24d6          00       NOP
$24d7          00       NOP
$24d8          00       NOP
$24d9          00       NOP
$24da          00       NOP
$24db          00       NOP
$24dc          00       NOP
$24dd          00       NOP
$24de          00       NOP
$24df          00       NOP
$24e0          00       NOP
$24e1          00       NOP
$24e2          00       NOP
$24e3          00       NOP
$24e4          00       NOP
$24e5          00       NOP
$24e6          00       NOP
$24e7          00       NOP
$24e8          00       NOP
$24e9          00       NOP
$24ea          00       NOP
$24eb          00       NOP
$24ec          00       NOP
$24ed          00       NOP
$24ee          00       NOP
$24ef          00       NOP
$24f0          00       NOP
$24f1          00       NOP
$24f2          00       NOP
$24f3          00       NOP
$24f4          00       NOP
$24f5          00       NOP
$24f6          00       NOP
$24f7          00       NOP
$24f8          00       NOP
$24f9          00       NOP
$24fa          00       NOP
$24fb          00       NOP
$24fc          00       NOP
$24fd          00       NOP
$24fe          00       NOP
$24ff          00       NOP
$2500          00       NOP
$2501          00       NOP
$2502          00       NOP
$2503          00       NOP
$2504          00       NOP
$2505          00       NOP
$2506          00       NOP
$2507          00       NOP
$2508          00       NOP
$2509          00       NOP
$250a          00       NOP
$250b          00       NOP
$250c          00       NOP
$250d          00       NOP
$250e          00       NOP
$250f          00       NOP
$2510          00       NOP
$2511          00       NOP
$2512          00       NOP
$2513          00       NOP
$2514          00       NOP
$2515          00       NOP
$2516          00       NOP
$2517          00       NOP
$2518          00       NOP
$2519          00       NOP
$251a          00       NOP
$251b          00       NOP
$251c          00       NOP
$251d          00       NOP
$251e          00       NOP
$251f          00       NOP
$2520          00       NOP
$2521          00       NOP
$2522          00       NOP
$2523          00       NOP
$2524          00       NOP
$2525          00       NOP
$2526          00       NOP
$2527          00       NOP
$2528          00       NOP
$2529          00       NOP
$252a          00       NOP
$252b          00       NOP
$252c          00       NOP
$252d          00       NOP
$252e          00       NOP
$252f          00       NOP
$2530          00       NOP
$2531          00       NOP
$2532          00       NOP
$2533          00       NOP
$2534          00       NOP
$2535          00       NOP
$2536          00       NOP
$2537          00       NOP
$2538          00       NOP
$2539          00       NOP
$253a          00       NOP
$253b          00       NOP
$253c          00       NOP
$253d          00       NOP
$253e          00       NOP
$253f          00       NOP
$2540          00       NOP
$2541          00       NOP
$2542          00       NOP
$2543          00       NOP
$2544          00       NOP
$2545          00       NOP
$2546          00       NOP
$2547          00       NOP
$2548          00       NOP
$2549          00       NOP
$254a          00       NOP
$254b          00       NOP
$254c          00       NOP
$254d          00       NOP
$254e          00       NOP
$254f          00       NOP
$2550          00       NOP
$2551          00       NOP
$2552          00       NOP
$2553          00       NOP
$2554          00       NOP
$2555          00       NOP
$2556          00       NOP
$2557          00       NOP
$2558          00       NOP
$2559          00       NOP
$255a          00       NOP
$255b          00       NOP
$255c          00       NOP
$255d          00       NOP
$255e          00       NOP
$255f          00       NOP
$2560          00       NOP
$2561          00       NOP
$2562          00       NOP
$2563          00       NOP
$2564          00       NOP
$2565          00       NOP
$2566          00       NOP
$2567          00       NOP
$2568          00       NOP
$2569          00       NOP
$256a          00       NOP
$256b          00       NOP
$256c          00       NOP
$256d          00       NOP
$256e          00       NOP
$256f          00       NOP
$2570          00       NOP
$2571          00       NOP
$2572          00       NOP
$2573          00       NOP
$2574          00       NOP
$2575          00       NOP
$2576          00       NOP
$2577          00       NOP
$2578          00       NOP
$2579          00       NOP
$257a          00       NOP
$257b          00       NOP
$257c          00       NOP
$257d          00       NOP
$257e          00       NOP
$257f          00       NOP
$2580          00       NOP
$2581          00       NOP
$2582          00       NOP
$2583          00       NOP
$2584          00       NOP
$2585          00       NOP
$2586          00       NOP
$2587          00       NOP
$2588          00       NOP
$2589          00       NOP
$258a          00       NOP
$258b          00       NOP
$258c          00       NOP
$258d          00       NOP
$258e          00       NOP
$258f          00       NOP
$2590          00       NOP
$2591          00       NOP
$2592          00       NOP
$2593          00       NOP
$2594          00       NOP
$2595          00       NOP
$2596          00       NOP
$2597          00       NOP
$2598          00       NOP
$2599          00       NOP
$259a          00       NOP
$259b          00       NOP
$259c          00       NOP
$259d          00       NOP
$259e          00       NOP
$259f          00       NOP
$25a0          00       NOP
$25a1          00       NOP
$25a2          00       NOP
$25a3          00       NOP
$25a4          00       NOP
$25a5          00       NOP
$25a6          00       NOP
$25a7          00       NOP
$25a8          00       NOP
$25a9          00       NOP
$25aa          00       NOP
$25ab          00       NOP
$25ac          00       NOP
$25ad          00       NOP
$25ae          00       NOP
$25af          00       NOP
$25b0          00       NOP
$25b1          00       NOP
$25b2          00       NOP
$25b3          00       NOP
$25b4          00       NOP
$25b5          00       NOP
$25b6          00       NOP
$25b7          00       NOP
$25b8          00       NOP
$25b9          00       NOP
$25ba          00       NOP
$25bb          00       NOP
$25bc          00       NOP
$25bd          00       NOP
$25be          00       NOP
$25bf          00       NOP
$25c0          00       NOP
$25c1          00       NOP
$25c2          00       NOP
$25c3          00       NOP
$25c4          00       NOP
$25c5          00       NOP
$25c6          00       NOP
$25c7          00       NOP
$25c8          00       NOP
$25c9          00       NOP
$25ca          00       NOP
$25cb          00       NOP
$25cc          00       NOP
$25cd          00       NOP
$25ce          00       NOP
$25cf          00       NOP
$25d0          00       NOP
$25d1          00       NOP
$25d2          00       NOP
$25d3          00       NOP
$25d4          00       NOP
$25d5          00       NOP
$25d6          00       NOP
$25d7          00       NOP
$25d8          00       NOP
$25d9          00       NOP
$25da          00       NOP
$25db          00       NOP
$25dc          00       NOP
$25dd          00       NOP
$25de          00       NOP
$25df          00       NOP
$25e0          00       NOP
$25e1          00       NOP
$25e2          00       NOP
$25e3          00       NOP
$25e4          00       NOP
$25e5          00       NOP
$25e6          00       NOP
$25e7          00       NOP
$25e8          00       NOP
$25e9          00       NOP
$25ea          00       NOP
$25eb          00       NOP
$25ec          00       NOP
$25ed          00       NOP
$25ee          00       NOP
$25ef          00       NOP
$25f0          00       NOP
$25f1          00       NOP
$25f2          00       NOP
$25f3          00       NOP
$25f4          00       NOP
$25f5          00       NOP
$25f6          00       NOP
$25f7          00       NOP
$25f8          00       NOP
$25f9          00       NOP
$25fa          00       NOP
$25fb          00       NOP
$25fc          00       NOP
$25fd          00       NOP
$25fe          00       NOP
$25ff          00       NOP
$2600          00       NOP
$2601          00       NOP
$2602          00       NOP
$2603          00       NOP
$2604          00       NOP
$2605          00       NOP
$2606          00       NOP
$2607          00       NOP
$2608          00       NOP
$2609          00       NOP
$260a          00       NOP
$260b          00       NOP
$260c          00       NOP
$260d          00       NOP
$260e          00       NOP
$260f          00       NOP
$2610          00       NOP
$2611          00       NOP
$2612          00       NOP
$2613          00       NOP
$2614          00       NOP
$2615          00       NOP
$2616          00       NOP
$2617          00       NOP
$2618          00       NOP
$2619          00       NOP
$261a          00       NOP
$261b          00       NOP
$261c          00       NOP
$261d          00       NOP
$261e          00       NOP
$261f          00       NOP
$2620          00       NOP
$2621          00       NOP
$2622          00       NOP
$2623          00       NOP
$2624          00       NOP
$2625          00       NOP
$2626          00       NOP
$2627          00       NOP
$2628          00       NOP
$2629          00       NOP
$262a          00       NOP
$262b          00       NOP
$262c          00       NOP
$262d          00       NOP
$262e          00       NOP
$262f          00       NOP
$2630          00       NOP
$2631          00       NOP
$2632          00       NOP
$2633          00       NOP
$2634          00       NOP
$2635          00       NOP
$2636          00       NOP
$2637          00       NOP
$2638          00       NOP
$2639          00       NOP
$263a          00       NOP
$263b          00       NOP
$263c          00       NOP
$263d          00       NOP
$263e          00       NOP
$263f          00       NOP
$2640          00       NOP
$2641          00       NOP
$2642          00       NOP
$2643          00       NOP
$2644          00       NOP
$2645          00       NOP
$2646          00       NOP
$2647          00       NOP
$2648          00       NOP
$2649          00       NOP
$264a          00       NOP
$264b          00       NOP
$264c          00       NOP
$264d          00       NOP
$264e          00       NOP
$264f          00       NOP
$2650          00       NOP
$2651          00       NOP
$2652          00       NOP
$2653          00       NOP
$2654          00       NOP
$2655          00       NOP
$2656          00       NOP
$2657          00       NOP
$2658          00       NOP
$2659          00       NOP
$265a          00       NOP
$265b          00       NOP
$265c          00       NOP
$265d          00       NOP
$265e          00       NOP
$265f          00       NOP
$2660          00       NOP
$2661          00       NOP
$2662          00       NOP
$2663          00       NOP
$2664          00       NOP
$2665          00       NOP
$2666          00       NOP
$2667          00       NOP
$2668          00       NOP
$2669          00       NOP
$266a          00       NOP
$266b          00       NOP
$266c          00       NOP
$266d          00       NOP
$266e          00       NOP
$266f          00       NOP
$2670          00       NOP
$2671          00       NOP
$2672          00       NOP
$2673          00       NOP
$2674          00       NOP
$2675          00       NOP
$2676          00       NOP
$2677          00       NOP
$2678          00       NOP
$2679          00       NOP
$267a          00       NOP
$267b          00       NOP
$267c          00       NOP
$267d          00       NOP
$267e          00       NOP
$267f          00       NOP
$2680          00       NOP
$2681          00       NOP
$2682          00       NOP
$2683          00       NOP
$2684          00       NOP
$2685          00       NOP
$2686          00       NOP
$2687          00       NOP
$2688          00       NOP
$2689          00       NOP
$268a          00       NOP
$268b          00       NOP
$268c          00       NOP
$268d          00       NOP
$268e          00       NOP
$268f          00       NOP
$2690          00       NOP
$2691          00       NOP
$2692          00       NOP
$2693          00       NOP
$2694          00       NOP
$2695          00       NOP
$2696          00       NOP
$2697          00       NOP
$2698          00       NOP
$2699          00       NOP
$269a          00       NOP
$269b          00       NOP
$269c          00       NOP
$269d          00       NOP
$269e          00       NOP
$269f          00       NOP
$26a0          00       NOP
$26a1          00       NOP
$26a2          00       NOP
$26a3          00       NOP
$26a4          00       NOP
$26a5          00       NOP
$26a6          00       NOP
$26a7          00       NOP
$26a8          00       NOP
$26a9          00       NOP
$26aa          00       NOP
$26ab          00       NOP
$26ac          00       NOP
$26ad          00       NOP
$26ae          00       NOP
$26af          00       NOP
$26b0          00       NOP
$26b1          00       NOP
$26b2          00       NOP
$26b3          00       NOP
$26b4          00       NOP
$26b5          00       NOP
$26b6          00       NOP
$26b7          00       NOP
$26b8          00       NOP
$26b9          00       NOP
$26ba          00       NOP
$26bb          00       NOP
$26bc          00       NOP
$26bd          00       NOP
$26be          00       NOP
$26bf          00       NOP
$26c0          00       NOP
$26c1          00       NOP
$26c2          00       NOP
$26c3          00       NOP
$26c4          00       NOP
$26c5          00       NOP
$26c6          00       NOP
$26c7          00       NOP
$26c8          00       NOP
$26c9          00       NOP
$26ca          00       NOP
$26cb          00       NOP
$26cc          00       NOP
$26cd          00       NOP
$26ce          00       NOP
$26cf          00       NOP
$26d0          00       NOP
$26d1          00       NOP
$26d2          00       NOP
$26d3          00       NOP
$26d4          00       NOP
$26d5          00       NOP
$26d6          00       NOP
$26d7          00       NOP
$26d8          00       NOP
$26d9          00       NOP
$26da          00       NOP
$26db          00       NOP
$26dc          00       NOP
$26dd          00       NOP
$26de          00       NOP
$26df          00       NOP
$26e0          00       NOP
$26e1          00       NOP
$26e2          00       NOP
$26e3          00       NOP
$26e4          00       NOP
$26e5          00       NOP
$26e6          00       NOP
$26e7          00       NOP
$26e8          00       NOP
$26e9          00       NOP
$26ea          00       NOP
$26eb          00       NOP
$26ec          00       NOP
$26ed          00       NOP
$26ee          00       NOP
$26ef          00       NOP
$26f0          00       NOP
$26f1          00       NOP
$26f2          00       NOP
$26f3          00       NOP
$26f4          00       NOP
$26f5          00       NOP
$26f6          00       NOP
$26f7          00       NOP
$26f8          00       NOP
$26f9          00       NOP
$26fa          00       NOP
$26fb          00       NOP
$26fc          00       NOP
$26fd          00       NOP
$26fe          00       NOP
$26ff          00       NOP
$2700          00       NOP
$2701          00       NOP
$2702          00       NOP
$2703          00       NOP
$2704          00       NOP
$2705          00       NOP
$2706          00       NOP
$2707          00       NOP
$2708          00       NOP
$2709          00       NOP
$270a          00       NOP
$270b          00       NOP
$270c          00       NOP
$270d          00       NOP
$270e          00       NOP
$270f          00       NOP
$2710          00       NOP
$2711          00       NOP
$2712          00       NOP
$2713          00       NOP
$2714          00       NOP
$2715          00       NOP
$2716          00       NOP
$2717          00       NOP
$2718          00       NOP
$2719          00       NOP
$271a          00       NOP
$271b          00       NOP
$271c          00       NOP
$271d          00       NOP
$271e          00       NOP
$271f          00       NOP
$2720          00       NOP
$2721          00       NOP
$2722          00       NOP
$2723          00       NOP
$2724          00       NOP
$2725          00       NOP
$2726          00       NOP
$2727          00       NOP
$2728          00       NOP
$2729          00       NOP
$272a          00       NOP
$272b          00       NOP
$272c          00       NOP
$272d          00       NOP
$272e          00       NOP
$272f          00       NOP
$2730          00       NOP
$2731          00       NOP
$2732          00       NOP
$2733          00       NOP
$2734          00       NOP
$2735          00       NOP
$2736          00       NOP
$2737          00       NOP
$2738          00       NOP
$2739          00       NOP
$273a          00       NOP
$273b          00       NOP
$273c          00       NOP
$273d          00       NOP
$273e          00       NOP
$273f          00       NOP
$2740          00       NOP
$2741          00       NOP
$2742          00       NOP
$2743          00       NOP
$2744          00       NOP
$2745          00       NOP
$2746          00       NOP
$2747          00       NOP
$2748          00       NOP
$2749          00       NOP
$274a          00       NOP
$274b          00       NOP
$274c          00       NOP
$274d          00       NOP
$274e          00       NOP
$274f          00       NOP
$2750          00       NOP
$2751          00       NOP
$2752          00       NOP
$2753          00       NOP
$2754          00       NOP
$2755          00       NOP
$2756          00       NOP
$2757          00       NOP
$2758          00       NOP
$2759          00       NOP
$275a          00       NOP
$275b          00       NOP
$275c          00       NOP
$275d          00       NOP
$275e          00       NOP
$275f          00       NOP
$2760          00       NOP
$2761          00       NOP
$2762          00       NOP
$2763          00       NOP
$2764          00       NOP
$2765          00       NOP
$2766          00       NOP
$2767          00       NOP
$2768          00       NOP
$2769          00       NOP
$276a          00       NOP
$276b          00       NOP
$276c          00       NOP
$276d          00       NOP
$276e          00       NOP
$276f          00       NOP
$2770          00       NOP
$2771          00       NOP
$2772          00       NOP
$2773          00       NOP
$2774          00       NOP
$2775          00       NOP
$2776          00       NOP
$2777          00       NOP
$2778          00       NOP
$2779          00       NOP
$277a          00       NOP
$277b          00       NOP
$277c          00       NOP
$277d          00       NOP
$277e          00       NOP
$277f          00       NOP
$2780          00       NOP
$2781          00       NOP
$2782          00       NOP
$2783          00       NOP
$2784          00       NOP
$2785          00       NOP
$2786          00       NOP
$2787          00       NOP
$2788          00       NOP
$2789          00       NOP
$278a          00       NOP
$278b          00       NOP
$278c          00       NOP
$278d          00       NOP
$278e          00       NOP
$278f          00       NOP
$2790          00       NOP
$2791          00       NOP
$2792          00       NOP
$2793          00       NOP
$2794          00       NOP
$2795          00       NOP
$2796          00       NOP
$2797          00       NOP
$2798          00       NOP
$2799          00       NOP
$279a          00       NOP
$279b          00       NOP
$279c          00       NOP
$279d          00       NOP
$279e          00       NOP
$279f          00       NOP
$27a0          00       NOP
$27a1          00       NOP
$27a2          00       NOP
$27a3          00       NOP
$27a4          00       NOP
$27a5          00       NOP
$27a6          00       NOP
$27a7          00       NOP
$27a8          00       NOP
$27a9          00       NOP
$27aa          00       NOP
$27ab          00       NOP
$27ac          00       NOP
$27ad          00       NOP
$27ae          00       NOP
$27af          00       NOP
$27b0          00       NOP
$27b1          00       NOP
$27b2          00       NOP
$27b3          00       NOP
$27b4          00       NOP
$27b5          00       NOP
$27b6          00       NOP
$27b7          00       NOP
$27b8          00       NOP
$27b9          00       NOP
$27ba          00       NOP
$27bb          00       NOP
$27bc          00       NOP
$27bd          00       NOP
$27be          00       NOP
$27bf          00       NOP
$27c0          00       NOP
$27c1          00       NOP
$27c2          00       NOP
$27c3          00       NOP
$27c4          00       NOP
$27c5          00       NOP
$27c6          00       NOP
$27c7          00       NOP
$27c8          00       NOP
$27c9          00       NOP
$27ca          00       NOP
$27cb          00       NOP
$27cc          00       NOP
$27cd          00       NOP
$27ce          00       NOP
$27cf          00       NOP
$27d0          00       NOP
$27d1          00       NOP
$27d2          00       NOP
$27d3          00       NOP
$27d4          00       NOP
$27d5          00       NOP
$27d6          00       NOP
$27d7          00       NOP
$27d8          00       NOP
$27d9          00       NOP
$27da          00       NOP
$27db          00       NOP
$27dc          00       NOP
$27dd          00       NOP
$27de          00       NOP
$27df          00       NOP
$27e0          00       NOP
$27e1          00       NOP
$27e2          00       NOP
$27e3          00       NOP
$27e4          00       NOP
$27e5          00       NOP
$27e6          00       NOP
$27e7          00       NOP
$27e8          00       NOP
$27e9          00       NOP
$27ea          00       NOP
$27eb          00       NOP
$27ec          00       NOP
$27ed          00       NOP
$27ee          00       NOP
$27ef          00       NOP
$27f0          00       NOP
$27f1          00       NOP
$27f2          00       NOP
$27f3          00       NOP
$27f4          00       NOP
$27f5          00       NOP
$27f6          00       NOP
$27f7          00       NOP
$27f8          00       NOP
$27f9          00       NOP
$27fa          00       NOP
$27fb          00       NOP
$27fc          00       NOP
$27fd          00       NOP
$27fe          00       NOP
$27ff          00       NOP
; extra 2k start
$2800          00       DB #00
$2801          00       DB #00
$2802          00       DB #00
$2803          00       DB #00
$2804          00       DB #00
$2805          00       DB #00
$2806          00       DB #00
$2807          00       DB #00
$2808          00       DB #00
$2809          00       DB #00
$280a          00       DB #00
$280b          00       DB #00
$280c          00       DB #00
$280d          00       DB #00
$280e          00       DB #00
$280f          00       DB #00
$2810          00       DB #00
$2811          00       DB #00
$2812          00       DB #00
$2813          00       DB #00
$2814          00       DB #00
$2815          00       DB #00
$2816          00       DB #00
$2817          00       DB #00
$2818          00       DB #00
$2819          00       DB #00
$281a          00       DB #00
$281b          00       DB #00
$281c          00       DB #00
$281d          00       DB #00
$281e          00       DB #00
$281f          00       DB #00
$2820          00       DB #00
$2821          00       DB #00
$2822          00       DB #00
$2823          00       DB #00
$2824          00       DB #00
$2825          00       DB #00
$2826          00       DB #00
$2827          00       DB #00
$2828          00       DB #00
$2829          00       DB #00
$282a          00       DB #00
$282b          00       DB #00
$282c          00       DB #00
$282d          00       DB #00
$282e          00       DB #00
$282f          00       DB #00
$2830          00       DB #00
$2831          00       DB #00
$2832          00       DB #00
$2833          00       DB #00
$2834          00       DB #00
$2835          00       DB #00
$2836          00       DB #00
$2837          00       DB #00
$2838          00       DB #00
$2839          00       DB #00
$283a          00       DB #00
$283b          00       DB #00
$283c          00       DB #00
$283d          00       DB #00
$283e          00       DB #00
$283f          00       DB #00
$2840          00       DB #00
$2841          00       DB #00
$2842          00       DB #00
$2843          00       DB #00
$2844          00       DB #00
$2845          00       DB #00
$2846          00       DB #00
$2847          00       DB #00
$2848          00       DB #00
$2849          00       DB #00
$284a          00       DB #00
$284b          00       DB #00
$284c          00       DB #00
$284d          00       DB #00
$284e          00       DB #00
$284f          00       DB #00
$2850          00       DB #00
$2851          00       DB #00
$2852          00       DB #00
$2853          00       DB #00
$2854          00       DB #00
$2855          00       DB #00
$2856          00       DB #00
$2857          00       DB #00
$2858          00       DB #00
$2859          00       DB #00
$285a          00       DB #00
$285b          00       DB #00
$285c          00       DB #00
$285d          00       DB #00
$285e          00       DB #00
$285f          00       DB #00
$2860          00       DB #00
$2861          00       DB #00
$2862          00       DB #00
$2863          00       DB #00
$2864          00       DB #00
$2865          00       DB #00
$2866          00       DB #00
$2867          00       DB #00
$2868          00       DB #00
$2869          00       DB #00
$286a          00       DB #00
$286b          00       DB #00
$286c          00       DB #00
$286d          00       DB #00
$286e          00       DB #00
$286f          00       DB #00
$2870          00       DB #00
$2871          00       DB #00
$2872          00       DB #00
$2873          00       DB #00
$2874          00       DB #00
$2875          00       DB #00
$2876          00       DB #00
$2877          00       DB #00
$2878          00       DB #00
$2879          00       DB #00
$287a          00       DB #00
$287b          00       DB #00
$287c          00       DB #00
$287d          00       DB #00
$287e          00       DB #00
$287f          00       DB #00
$2880          00       DB #00
$2881          00       DB #00
$2882          00       DB #00
$2883          00       DB #00
$2884          00       DB #00
$2885          00       DB #00
$2886          00       DB #00
$2887          00       DB #00
$2888          00       DB #00
$2889          00       DB #00
$288a          00       DB #00
$288b          00       DB #00
$288c          00       DB #00
$288d          00       DB #00
$288e          00       DB #00
$288f          00       DB #00
$2890          00       DB #00
$2891          00       DB #00
$2892          00       DB #00
$2893          00       DB #00
$2894          00       DB #00
$2895          00       DB #00
$2896          00       DB #00
$2897          00       DB #00
$2898          00       DB #00
$2899          00       DB #00
$289a          00       DB #00
$289b          00       DB #00
$289c          00       DB #00
$289d          00       DB #00
$289e          00       DB #00
$289f          00       DB #00
$28a0          00       DB #00
$28a1          00       DB #00
$28a2          00       DB #00
$28a3          00       DB #00
$28a4          00       DB #00
$28a5          00       DB #00
$28a6          00       DB #00
$28a7          00       DB #00
$28a8          00       DB #00
$28a9          00       DB #00
$28aa          00       DB #00
$28ab          00       DB #00
$28ac          00       DB #00
$28ad          00       DB #00
$28ae          00       DB #00
$28af          00       DB #00
$28b0          00       DB #00
$28b1          00       DB #00
$28b2          00       DB #00
$28b3          00       DB #00
$28b4          00       DB #00
$28b5          00       DB #00
$28b6          00       DB #00
$28b7          00       DB #00
$28b8          00       DB #00
$28b9          00       DB #00
$28ba          00       DB #00
$28bb          00       DB #00
$28bc          00       DB #00
$28bd          00       DB #00
$28be          00       DB #00
$28bf          00       DB #00
$28c0          00       DB #00
$28c1          00       DB #00
$28c2          00       DB #00
$28c3          00       DB #00
$28c4          00       DB #00
$28c5          00       DB #00
$28c6          00       DB #00
$28c7          00       DB #00
$28c8          00       DB #00
$28c9          00       DB #00
$28ca          00       DB #00
$28cb          00       DB #00
$28cc          00       DB #00
$28cd          00       DB #00
$28ce          00       DB #00
$28cf          00       DB #00
$28d0          00       DB #00
$28d1          00       DB #00
$28d2          00       DB #00
$28d3          00       DB #00
$28d4          00       DB #00
$28d5          00       DB #00
$28d6          00       DB #00
$28d7          00       DB #00
$28d8          00       DB #00
$28d9          00       DB #00
$28da          00       DB #00
$28db          00       DB #00
$28dc          00       DB #00
$28dd          00       DB #00
$28de          00       DB #00
$28df          00       DB #00
$28e0          00       DB #00
$28e1          00       DB #00
$28e2          00       DB #00
$28e3          00       DB #00
$28e4          00       DB #00
$28e5          00       DB #00
$28e6          00       DB #00
$28e7          00       DB #00
$28e8          00       DB #00
$28e9          00       DB #00
$28ea          00       DB #00
$28eb          00       DB #00
$28ec          00       DB #00
$28ed          00       DB #00
$28ee          00       DB #00
$28ef          00       DB #00
$28f0          00       DB #00
$28f1          00       DB #00
$28f2          00       DB #00
$28f3          00       DB #00
$28f4          00       DB #00
$28f5          00       DB #00
$28f6          00       DB #00
$28f7          00       DB #00
$28f8          00       DB #00
$28f9          00       DB #00
$28fa          00       DB #00
$28fb          00       DB #00
$28fc          00       DB #00
$28fd          00       DB #00
$28fe          00       DB #00
$28ff          00       DB #00
$2900          00       DB #00
$2901          00       NOP
$2902          00       NOP
$2903          00       NOP
$2904          00       NOP
$2905          00       NOP
$2906          00       NOP
$2907          00       NOP
$2908          00       NOP
$2909          00       NOP
$290a          00       NOP
$290b          00       NOP
$290c          00       NOP
$290d          00       NOP
$290e          00       NOP
$290f          00       NOP
$2910          00       NOP
$2911          00       NOP
$2912          00       NOP
$2913          00       NOP
$2914          00       NOP
$2915          00       NOP
$2916          00       NOP
$2917          00       NOP
$2918          00       NOP
$2919          00       NOP
$291a          00       NOP
$291b          00       NOP
$291c          00       NOP
$291d          00       NOP
$291e          00       NOP
$291f          00       NOP
$2920          00       NOP
$2921          00       NOP
$2922          00       NOP
$2923          00       NOP
$2924          00       NOP
$2925          00       NOP
$2926          00       NOP
$2927          00       NOP
$2928          00       NOP
$2929          00       NOP
$292a          00       NOP
$292b          00       NOP
$292c          00       NOP
$292d          00       NOP
$292e          00       NOP
$292f          00       NOP
$2930          00       NOP
$2931          00       NOP
$2932          00       NOP
$2933          00       NOP
$2934          00       NOP
$2935          00       NOP
$2936          00       NOP
$2937          00       NOP
$2938          00       NOP
$2939          00       NOP
$293a          00       NOP
$293b          00       NOP
$293c          00       NOP
$293d          00       NOP
$293e          00       NOP
$293f          00       NOP
$2940          00       NOP
$2941          00       NOP
$2942          00       NOP
$2943          00       NOP
$2944          00       NOP
$2945          00       NOP
$2946          00       NOP
$2947          00       NOP
$2948          00       NOP
$2949          00       NOP
$294a          00       NOP
$294b          00       NOP
$294c          00       NOP
$294d          00       NOP
$294e          00       NOP
$294f          00       NOP
$2950          00       NOP
$2951          00       NOP
$2952          00       NOP
$2953          00       NOP
$2954          00       NOP
$2955          00       NOP
$2956          00       NOP
$2957          00       NOP
$2958          00       NOP
$2959          00       NOP
$295a          00       NOP
$295b          00       NOP
$295c          00       NOP
$295d          00       NOP
$295e          00       NOP
$295f          00       NOP
$2960          00       NOP
$2961          00       NOP
$2962          00       NOP
$2963          00       NOP
$2964          00       NOP
$2965          00       NOP
$2966          00       NOP
$2967          00       NOP
$2968          00       NOP
$2969          00       NOP
$296a          00       NOP
$296b          00       NOP
$296c          00       NOP
$296d          00       NOP
$296e          00       NOP
$296f          00       NOP
$2970          00       NOP
$2971          00       NOP
$2972          00       NOP
$2973          00       NOP
$2974          00       NOP
$2975          00       NOP
$2976          00       NOP
$2977          00       NOP
$2978          00       NOP
$2979          00       NOP
$297a          00       NOP
$297b          00       NOP
$297c          00       NOP
$297d          00       NOP
$297e          00       NOP
$297f          00       NOP
$2980          00       NOP
$2981          00       NOP
$2982          00       NOP
$2983          00       NOP
$2984          00       NOP
$2985          00       NOP
$2986          00       NOP
$2987          00       NOP
$2988          00       NOP
$2989          00       NOP
$298a          00       NOP
$298b          00       NOP
$298c          00       NOP
$298d          00       NOP
$298e          00       NOP
$298f          00       NOP
$2990          00       NOP
$2991          00       NOP
$2992          00       NOP
$2993          00       NOP
$2994          00       NOP
$2995          00       NOP
$2996          00       NOP
$2997          00       NOP
$2998          00       NOP
$2999          00       NOP
$299a          00       NOP
$299b          00       NOP
$299c          00       NOP
$299d          00       NOP
$299e          00       NOP
$299f          00       NOP
$29a0          00       NOP
$29a1          00       NOP
$29a2          00       NOP
$29a3          00       NOP
$29a4          00       NOP
$29a5          00       NOP
$29a6          00       NOP
$29a7          00       NOP
$29a8          00       NOP
$29a9          00       NOP
$29aa          00       NOP
$29ab          00       NOP
$29ac          00       NOP
$29ad          00       NOP
$29ae          00       NOP
$29af          00       NOP
$29b0          00       NOP
$29b1          00       NOP
$29b2          00       NOP
$29b3          00       NOP
$29b4          00       NOP
$29b5          00       NOP
$29b6          00       NOP
$29b7          00       NOP
$29b8          00       NOP
$29b9          00       NOP
$29ba          00       NOP
$29bb          00       NOP
$29bc          00       NOP
$29bd          00       NOP
$29be          00       NOP
$29bf          00       NOP
$29c0          00       NOP
$29c1          00       NOP
$29c2          00       NOP
$29c3          00       NOP
$29c4          00       NOP
$29c5          00       NOP
$29c6          00       NOP
$29c7          00       NOP
$29c8          00       NOP
$29c9          00       NOP
$29ca          00       NOP
$29cb          00       NOP
$29cc          00       NOP
$29cd          00       NOP
$29ce          00       NOP
$29cf          00       NOP
$29d0          00       NOP
$29d1          00       NOP
$29d2          00       NOP
$29d3          00       NOP
$29d4          00       NOP
$29d5          00       NOP
$29d6          00       NOP
$29d7          00       NOP
$29d8          00       NOP
$29d9          00       NOP
$29da          00       NOP
$29db          00       NOP
$29dc          00       NOP
$29dd          00       NOP
$29de          00       NOP
$29df          00       NOP
$29e0          00       NOP
$29e1          00       NOP
$29e2          00       NOP
$29e3          00       NOP
$29e4          00       NOP
$29e5          00       NOP
$29e6          00       NOP
$29e7          00       NOP
$29e8          00       NOP
$29e9          00       NOP
$29ea          00       NOP
$29eb          00       NOP
$29ec          00       NOP
$29ed          00       NOP
$29ee          00       NOP
$29ef          00       NOP
$29f0          00       NOP
$29f1          00       NOP
$29f2          00       NOP
$29f3          00       NOP
$29f4          00       NOP
$29f5          00       NOP
$29f6          00       NOP
$29f7          00       NOP
$29f8          00       NOP
$29f9          00       NOP
$29fa          00       NOP
$29fb          00       NOP
$29fc          00       NOP
$29fd          00       NOP
$29fe          00       NOP
$29ff          00       NOP
$2a00          00       NOP
$2a01          00       NOP
$2a02          00       NOP
$2a03          00       NOP
$2a04          00       NOP
$2a05          00       NOP
$2a06          00       NOP
$2a07          00       NOP
$2a08          00       NOP
$2a09          00       NOP
$2a0a          00       NOP
$2a0b          00       NOP
$2a0c          00       NOP
$2a0d          00       NOP
$2a0e          00       NOP
$2a0f          00       NOP
$2a10          00       NOP
$2a11          00       NOP
$2a12          00       NOP
$2a13          00       NOP
$2a14          00       NOP
$2a15          00       NOP
$2a16          00       NOP
$2a17          00       NOP
$2a18          00       NOP
$2a19          00       NOP
$2a1a          00       NOP
$2a1b          00       NOP
$2a1c          00       NOP
$2a1d          00       NOP
$2a1e          00       NOP
$2a1f          00       NOP
$2a20          00       NOP
$2a21          00       NOP
$2a22          00       NOP
$2a23          00       NOP
$2a24          00       NOP
$2a25          00       NOP
$2a26          00       NOP
$2a27          00       NOP
$2a28          00       NOP
$2a29          00       NOP
$2a2a          00       NOP
$2a2b          00       NOP
$2a2c          00       NOP
$2a2d          00       NOP
$2a2e          00       NOP
$2a2f          00       NOP
$2a30          00       NOP
$2a31          00       NOP
$2a32          00       NOP
$2a33          00       NOP
$2a34          00       NOP
$2a35          00       NOP
$2a36          00       NOP
$2a37          00       NOP
$2a38          00       NOP
$2a39          00       NOP
$2a3a          00       NOP
$2a3b          00       NOP
$2a3c          00       NOP
$2a3d          00       NOP
$2a3e          00       NOP
$2a3f          00       NOP
$2a40          00       NOP
$2a41          00       NOP
$2a42          00       NOP
$2a43          00       NOP
$2a44          00       NOP
$2a45          00       NOP
$2a46          00       NOP
$2a47          00       NOP
$2a48          00       NOP
$2a49          00       NOP
$2a4a          00       NOP
$2a4b          00       NOP
$2a4c          00       NOP
$2a4d          00       NOP
$2a4e          00       NOP
$2a4f          00       NOP
$2a50          00       NOP
$2a51          00       NOP
$2a52          00       NOP
$2a53          00       NOP
$2a54          00       NOP
$2a55          00       NOP
$2a56          00       NOP
$2a57          00       NOP
$2a58          00       NOP
$2a59          00       NOP
$2a5a          00       NOP
$2a5b          00       NOP
$2a5c          00       NOP
$2a5d          00       NOP
$2a5e          00       NOP
$2a5f          00       NOP
$2a60          00       NOP
$2a61          00       NOP
$2a62          00       NOP
$2a63          00       NOP
$2a64          00       NOP
$2a65          00       NOP
$2a66          00       NOP
$2a67          00       NOP
$2a68          00       NOP
$2a69          00       NOP
$2a6a          00       NOP
$2a6b          00       NOP
$2a6c          00       NOP
$2a6d          00       NOP
$2a6e          00       NOP
$2a6f          00       NOP
$2a70          00       NOP
$2a71          00       NOP
$2a72          00       NOP
$2a73          00       NOP
$2a74          00       NOP
$2a75          00       NOP
$2a76          00       NOP
$2a77          00       NOP
$2a78          00       NOP
$2a79          00       NOP
$2a7a          00       NOP
$2a7b          00       NOP
$2a7c          00       NOP
$2a7d          00       NOP
$2a7e          00       NOP
$2a7f          00       NOP
$2a80          00       NOP
$2a81          00       NOP
$2a82          00       NOP
$2a83          00       NOP
$2a84          00       NOP
$2a85          00       NOP
$2a86          00       NOP
$2a87          00       NOP
$2a88          00       NOP
$2a89          00       NOP
$2a8a          00       NOP
$2a8b          00       NOP
$2a8c          00       NOP
$2a8d          00       NOP
$2a8e          00       NOP
$2a8f          00       NOP
$2a90          00       NOP
$2a91          00       NOP
$2a92          00       NOP
$2a93          00       NOP
$2a94          00       NOP
$2a95          00       NOP
$2a96          00       NOP
$2a97          00       NOP
$2a98          00       NOP
$2a99          00       NOP
$2a9a          00       NOP
$2a9b          00       NOP
$2a9c          00       NOP
$2a9d          00       NOP
$2a9e          00       NOP
$2a9f          00       NOP
$2aa0          00       NOP
$2aa1          00       NOP
$2aa2          00       NOP
$2aa3          00       NOP
$2aa4          00       NOP
$2aa5          00       NOP
$2aa6          00       NOP
$2aa7          00       NOP
$2aa8          00       NOP
$2aa9          00       NOP
$2aaa          00       NOP
$2aab          00       NOP
$2aac          00       NOP
$2aad          00       NOP
$2aae          00       NOP
$2aaf          00       NOP
$2ab0          00       NOP
$2ab1          00       NOP
$2ab2          00       NOP
$2ab3          00       NOP
$2ab4          00       NOP
$2ab5          00       NOP
$2ab6          00       NOP
$2ab7          00       NOP
$2ab8          00       NOP
$2ab9          00       NOP
$2aba          00       NOP
$2abb          00       NOP
$2abc          00       NOP
$2abd          00       NOP
$2abe          00       NOP
$2abf          00       NOP
$2ac0          00       NOP
$2ac1          00       NOP
$2ac2          00       NOP
$2ac3          00       NOP
$2ac4          00       NOP
$2ac5          00       NOP
$2ac6          00       NOP
$2ac7          00       NOP
$2ac8          00       NOP
$2ac9          00       NOP
$2aca          00       NOP
$2acb          00       NOP
$2acc          00       NOP
$2acd          00       NOP
$2ace          00       NOP
$2acf          00       NOP
$2ad0          00       NOP
$2ad1          00       NOP
$2ad2          00       NOP
$2ad3          00       NOP
$2ad4          00       NOP
$2ad5          00       NOP
$2ad6          00       NOP
$2ad7          00       NOP
$2ad8          00       NOP
$2ad9          00       NOP
$2ada          00       NOP
$2adb          00       NOP
$2adc          00       NOP
$2add          00       NOP
$2ade          00       NOP
$2adf          00       NOP
$2ae0          00       NOP
$2ae1          00       NOP
$2ae2          00       NOP
$2ae3          00       NOP
$2ae4          00       NOP
$2ae5          00       NOP
$2ae6          00       NOP
$2ae7          00       NOP
$2ae8          00       NOP
$2ae9          00       NOP
$2aea          00       NOP
$2aeb          00       NOP
$2aec          00       NOP
$2aed          00       NOP
$2aee          00       NOP
$2aef          00       NOP
$2af0          00       NOP
$2af1          00       NOP
$2af2          00       NOP
$2af3          00       NOP
$2af4          00       NOP
$2af5          00       NOP
$2af6          00       NOP
$2af7          00       NOP
$2af8          00       NOP
$2af9          00       NOP
$2afa          00       NOP
$2afb          00       NOP
$2afc          00       NOP
$2afd          00       NOP
$2afe          00       NOP
$2aff          00       NOP
$2b00          00       NOP
$2b01          00       NOP
$2b02          00       NOP
$2b03          00       NOP
$2b04          00       NOP
$2b05          00       NOP
$2b06          00       NOP
$2b07          00       NOP
$2b08          00       NOP
$2b09          00       NOP
$2b0a          00       NOP
$2b0b          00       NOP
$2b0c          00       NOP
$2b0d          00       NOP
$2b0e          00       NOP
$2b0f          00       NOP
$2b10          00       NOP
$2b11          00       NOP
$2b12          00       NOP
$2b13          00       NOP
$2b14          00       NOP
$2b15          00       NOP
$2b16          00       NOP
$2b17          00       NOP
$2b18          00       NOP
$2b19          00       NOP
$2b1a          00       NOP
$2b1b          00       NOP
$2b1c          00       NOP
$2b1d          00       NOP
$2b1e          00       NOP
$2b1f          00       NOP
$2b20          00       NOP
$2b21          00       NOP
$2b22          00       NOP
$2b23          00       NOP
$2b24          00       NOP
$2b25          00       NOP
$2b26          00       NOP
$2b27          00       NOP
$2b28          00       NOP
$2b29          00       NOP
$2b2a          00       NOP
$2b2b          00       NOP
$2b2c          00       NOP
$2b2d          00       NOP
$2b2e          00       NOP
$2b2f          00       NOP
$2b30          00       NOP
$2b31          00       NOP
$2b32          00       NOP
$2b33          00       NOP
$2b34          00       NOP
$2b35          00       NOP
$2b36          00       NOP
$2b37          00       NOP
$2b38          00       NOP
$2b39          00       NOP
$2b3a          00       NOP
$2b3b          00       NOP
$2b3c          00       NOP
$2b3d          00       NOP
$2b3e          00       NOP
$2b3f          00       NOP
$2b40          00       NOP
$2b41          00       NOP
$2b42          00       NOP
$2b43          00       NOP
$2b44          00       NOP
$2b45          00       NOP
$2b46          00       NOP
$2b47          00       NOP
$2b48          00       NOP
$2b49          00       NOP
$2b4a          00       NOP
$2b4b          00       NOP
$2b4c          00       NOP
$2b4d          00       NOP
$2b4e          00       NOP
$2b4f          00       NOP
$2b50          00       NOP
$2b51          00       NOP
$2b52          00       NOP
$2b53          00       NOP
$2b54          00       NOP
$2b55          00       NOP
$2b56          00       NOP
$2b57          00       NOP
$2b58          00       NOP
$2b59          00       NOP
$2b5a          00       NOP
$2b5b          00       NOP
$2b5c          00       NOP
$2b5d          00       NOP
$2b5e          00       NOP
$2b5f          00       NOP
$2b60          00       NOP
$2b61          00       NOP
$2b62          00       NOP
$2b63          00       NOP
$2b64          00       NOP
$2b65          00       NOP
$2b66          00       NOP
$2b67          00       NOP
$2b68          00       NOP
$2b69          00       NOP
$2b6a          00       NOP
$2b6b          00       NOP
$2b6c          00       NOP
$2b6d          00       NOP
$2b6e          00       NOP
$2b6f          00       NOP
$2b70          00       NOP
$2b71          00       NOP
$2b72          00       NOP
$2b73          00       NOP
$2b74          00       NOP
$2b75          00       NOP
$2b76          00       NOP
$2b77          00       NOP
$2b78          00       NOP
$2b79          00       NOP
$2b7a          00       NOP
$2b7b          00       NOP
$2b7c          00       NOP
$2b7d          00       NOP
$2b7e          00       NOP
$2b7f          00       NOP
$2b80          00       NOP
$2b81          00       NOP
$2b82          00       NOP
$2b83          00       NOP
$2b84          00       NOP
$2b85          00       NOP
$2b86          00       NOP
$2b87          00       NOP
$2b88          00       NOP
$2b89          00       NOP
$2b8a          00       NOP
$2b8b          00       NOP
$2b8c          00       NOP
$2b8d          00       NOP
$2b8e          00       NOP
$2b8f          00       NOP
$2b90          00       NOP
$2b91          00       NOP
$2b92          00       NOP
$2b93          00       NOP
$2b94          00       NOP
$2b95          00       NOP
$2b96          00       NOP
$2b97          00       NOP
$2b98          00       NOP
$2b99          00       NOP
$2b9a          00       NOP
$2b9b          00       NOP
$2b9c          00       NOP
$2b9d          00       NOP
$2b9e          00       NOP
$2b9f          00       NOP
$2ba0          00       NOP
$2ba1          00       NOP
$2ba2          00       NOP
$2ba3          00       NOP
$2ba4          00       NOP
$2ba5          00       NOP
$2ba6          00       NOP
$2ba7          00       NOP
$2ba8          00       NOP
$2ba9          00       NOP
$2baa          00       NOP
$2bab          00       NOP
$2bac          00       NOP
$2bad          00       NOP
$2bae          00       NOP
$2baf          00       NOP
$2bb0          00       NOP
$2bb1          00       NOP
$2bb2          00       NOP
$2bb3          00       NOP
$2bb4          00       NOP
$2bb5          00       NOP
$2bb6          00       NOP
$2bb7          00       NOP
$2bb8          00       NOP
$2bb9          00       NOP
$2bba          00       NOP
$2bbb          00       NOP
$2bbc          00       NOP
$2bbd          00       NOP
$2bbe          00       NOP
$2bbf          00       NOP
$2bc0          00       NOP
$2bc1          00       NOP
$2bc2          00       NOP
$2bc3          00       NOP
$2bc4          00       NOP
$2bc5          00       NOP
$2bc6          00       NOP
$2bc7          00       NOP
$2bc8          00       NOP
$2bc9          00       NOP
$2bca          00       NOP
$2bcb          00       NOP
$2bcc          00       NOP
$2bcd          00       NOP
$2bce          00       NOP
$2bcf          00       NOP
$2bd0          00       NOP
$2bd1          00       NOP
$2bd2          00       NOP
$2bd3          00       NOP
$2bd4          00       NOP
$2bd5          00       NOP
$2bd6          00       NOP
$2bd7          00       NOP
$2bd8          00       NOP
$2bd9          00       NOP
$2bda          00       NOP
$2bdb          00       NOP
$2bdc          00       NOP
$2bdd          00       NOP
$2bde          00       NOP
$2bdf          00       NOP
$2be0          00       NOP
$2be1          00       NOP
$2be2          00       NOP
$2be3          00       NOP
$2be4          00       NOP
$2be5          00       NOP
$2be6          00       NOP
$2be7          00       NOP
$2be8          00       NOP
$2be9          00       NOP
$2bea          00       NOP
$2beb          00       NOP
$2bec          00       NOP
$2bed          00       NOP
$2bee          00       NOP
$2bef          00       NOP
$2bf0          00       NOP
$2bf1          00       NOP
$2bf2          00       NOP
$2bf3          00       NOP
$2bf4          00       NOP
$2bf5          00       NOP
$2bf6          00       NOP
$2bf7          00       NOP
$2bf8          00       NOP
$2bf9          00       NOP
$2bfa          00       NOP
$2bfb          00       NOP
$2bfc          00       NOP
$2bfd          00       NOP
$2bfe          00       NOP
$2bff          00       NOP
$2c00          00       NOP
$2c01          00       NOP
$2c02          00       NOP
$2c03          00       NOP
$2c04          00       NOP
$2c05          00       NOP
$2c06          00       NOP
$2c07          00       NOP
$2c08          00       NOP
$2c09          00       NOP
$2c0a          00       NOP
$2c0b          00       NOP
$2c0c          00       NOP
$2c0d          00       NOP
$2c0e          00       NOP
$2c0f          00       NOP
$2c10          00       NOP
$2c11          00       NOP
$2c12          00       NOP
$2c13          00       NOP
$2c14          00       NOP
$2c15          00       NOP
$2c16          00       NOP
$2c17          00       NOP
$2c18          00       NOP
$2c19          00       NOP
$2c1a          00       NOP
$2c1b          00       NOP
$2c1c          00       NOP
$2c1d          00       NOP
$2c1e          00       NOP
$2c1f          00       NOP
$2c20          00       NOP
$2c21          00       NOP
$2c22          00       NOP
$2c23          00       NOP
$2c24          00       NOP
$2c25          00       NOP
$2c26          00       NOP
$2c27          00       NOP
$2c28          00       NOP
$2c29          00       NOP
$2c2a          00       NOP
$2c2b          00       NOP
$2c2c          00       NOP
$2c2d          00       NOP
$2c2e          00       NOP
$2c2f          00       NOP
$2c30          00       NOP
$2c31          00       NOP
$2c32          00       NOP
$2c33          00       NOP
$2c34          00       NOP
$2c35          00       NOP
$2c36          00       NOP
$2c37          00       NOP
$2c38          00       NOP
$2c39          00       NOP
$2c3a          00       NOP
$2c3b          00       NOP
$2c3c          00       NOP
$2c3d          00       NOP
$2c3e          00       NOP
$2c3f          00       NOP
$2c40          00       NOP
$2c41          00       NOP
$2c42          00       NOP
$2c43          00       NOP
$2c44          00       NOP
$2c45          00       NOP
$2c46          00       NOP
$2c47          00       NOP
$2c48          00       NOP
$2c49          00       NOP
$2c4a          00       NOP
$2c4b          00       NOP
$2c4c          00       NOP
$2c4d          00       NOP
$2c4e          00       NOP
$2c4f          00       NOP
$2c50          00       NOP
$2c51          00       NOP
$2c52          00       NOP
$2c53          00       NOP
$2c54          00       NOP
$2c55          00       NOP
$2c56          00       NOP
$2c57          00       NOP
$2c58          00       NOP
$2c59          00       NOP
$2c5a          00       NOP
$2c5b          00       NOP
$2c5c          00       NOP
$2c5d          00       NOP
$2c5e          00       NOP
$2c5f          00       NOP
$2c60          00       NOP
$2c61          00       NOP
$2c62          00       NOP
$2c63          00       NOP
$2c64          00       NOP
$2c65          00       NOP
$2c66          00       NOP
$2c67          00       NOP
$2c68          00       NOP
$2c69          00       NOP
$2c6a          00       NOP
$2c6b          00       NOP
$2c6c          00       NOP
$2c6d          00       NOP
$2c6e          00       NOP
$2c6f          00       NOP
$2c70          00       NOP
$2c71          00       NOP
$2c72          00       NOP
$2c73          00       NOP
$2c74          00       NOP
$2c75          00       NOP
$2c76          00       NOP
$2c77          00       NOP
$2c78          00       NOP
$2c79          00       NOP
$2c7a          00       NOP
$2c7b          00       NOP
$2c7c          00       NOP
$2c7d          00       NOP
$2c7e          00       NOP
$2c7f          00       NOP
$2c80          00       NOP
$2c81          00       NOP
$2c82          00       NOP
$2c83          00       NOP
$2c84          00       NOP
$2c85          00       NOP
$2c86          00       NOP
$2c87          00       NOP
$2c88          00       NOP
$2c89          00       NOP
$2c8a          00       NOP
$2c8b          00       NOP
$2c8c          00       NOP
$2c8d          00       NOP
$2c8e          00       NOP
$2c8f          00       NOP
$2c90          00       NOP
$2c91          00       NOP
$2c92          00       NOP
$2c93          00       NOP
$2c94          00       NOP
$2c95          00       NOP
$2c96          00       NOP
$2c97          00       NOP
$2c98          00       NOP
$2c99          00       NOP
$2c9a          00       NOP
$2c9b          00       NOP
$2c9c          00       NOP
$2c9d          00       NOP
$2c9e          00       NOP
$2c9f          00       NOP
$2ca0          00       NOP
$2ca1          00       NOP
$2ca2          00       NOP
$2ca3          00       NOP
$2ca4          00       NOP
$2ca5          00       NOP
$2ca6          00       NOP
$2ca7          00       NOP
$2ca8          00       NOP
$2ca9          00       NOP
$2caa          00       NOP
$2cab          00       NOP
$2cac          00       NOP
$2cad          00       NOP
$2cae          00       NOP
$2caf          00       NOP
$2cb0          00       NOP
$2cb1          00       NOP
$2cb2          00       NOP
$2cb3          00       NOP
$2cb4          00       NOP
$2cb5          00       NOP
$2cb6          00       NOP
$2cb7          00       NOP
$2cb8          00       NOP
$2cb9          00       NOP
$2cba          00       NOP
$2cbb          00       NOP
$2cbc          00       NOP
$2cbd          00       NOP
$2cbe          00       NOP
$2cbf          00       NOP
$2cc0          00       NOP
$2cc1          00       NOP
$2cc2          00       NOP
$2cc3          00       NOP
$2cc4          00       NOP
$2cc5          00       NOP
$2cc6          00       NOP
$2cc7          00       NOP
$2cc8          00       NOP
$2cc9          00       NOP
$2cca          00       NOP
$2ccb          00       NOP
$2ccc          00       NOP
$2ccd          00       NOP
$2cce          00       NOP
$2ccf          00       NOP
$2cd0          00       NOP
$2cd1          00       NOP
$2cd2          00       NOP
$2cd3          00       NOP
$2cd4          00       NOP
$2cd5          00       NOP
$2cd6          00       NOP
$2cd7          00       NOP
$2cd8          00       NOP
$2cd9          00       NOP
$2cda          00       NOP
$2cdb          00       NOP
$2cdc          00       NOP
$2cdd          00       NOP
$2cde          00       NOP
$2cdf          00       NOP
$2ce0          00       NOP
$2ce1          00       NOP
$2ce2          00       NOP
$2ce3          00       NOP
$2ce4          00       NOP
$2ce5          00       NOP
$2ce6          00       NOP
$2ce7          00       NOP
$2ce8          00       NOP
$2ce9          00       NOP
$2cea          00       NOP
$2ceb          00       NOP
$2cec          00       NOP
$2ced          00       NOP
$2cee          00       NOP
$2cef          00       NOP
$2cf0          00       NOP
$2cf1          00       NOP
$2cf2          00       NOP
$2cf3          00       NOP
$2cf4          00       NOP
$2cf5          00       NOP
$2cf6          00       NOP
$2cf7          00       NOP
$2cf8          00       NOP
$2cf9          00       NOP
$2cfa          00       NOP
$2cfb          00       NOP
$2cfc          00       NOP
$2cfd          00       NOP
$2cfe          00       NOP
$2cff          00       NOP
$2d00          00       NOP
$2d01          00       NOP
$2d02          00       NOP
$2d03          00       NOP
$2d04          00       NOP
$2d05          00       NOP
$2d06          00       NOP
$2d07          00       NOP
$2d08          00       NOP
$2d09          00       NOP
$2d0a          00       NOP
$2d0b          00       NOP
$2d0c          00       NOP
$2d0d          00       NOP
$2d0e          00       NOP
$2d0f          00       NOP
$2d10          00       NOP
$2d11          00       NOP
$2d12          00       NOP
$2d13          00       NOP
$2d14          00       NOP
$2d15          00       NOP
$2d16          00       NOP
$2d17          00       NOP
$2d18          00       NOP
$2d19          00       NOP
$2d1a          00       NOP
$2d1b          00       NOP
$2d1c          00       NOP
$2d1d          00       NOP
$2d1e          00       NOP
$2d1f          00       NOP
$2d20          00       NOP
$2d21          00       NOP
$2d22          00       NOP
$2d23          00       NOP
$2d24          00       NOP
$2d25          00       NOP
$2d26          00       NOP
$2d27          00       NOP
$2d28          00       NOP
$2d29          00       NOP
$2d2a          00       NOP
$2d2b          00       NOP
$2d2c          00       NOP
$2d2d          00       NOP
$2d2e          00       NOP
$2d2f          00       NOP
$2d30          00       NOP
$2d31          00       NOP
$2d32          00       NOP
$2d33          00       NOP
$2d34          00       NOP
$2d35          00       NOP
$2d36          00       NOP
$2d37          00       NOP
$2d38          00       NOP
$2d39          00       NOP
$2d3a          00       NOP
$2d3b          00       NOP
$2d3c          00       NOP
$2d3d          00       NOP
$2d3e          00       NOP
$2d3f          00       NOP
$2d40          00       NOP
$2d41          00       NOP
$2d42          00       NOP
$2d43          00       NOP
$2d44          00       NOP
$2d45          00       NOP
$2d46          00       NOP
$2d47          00       NOP
$2d48          00       NOP
$2d49          00       NOP
$2d4a          00       NOP
$2d4b          00       NOP
$2d4c          00       NOP
$2d4d          00       NOP
$2d4e          00       NOP
$2d4f          00       NOP
$2d50          00       NOP
$2d51          00       NOP
$2d52          00       NOP
$2d53          00       NOP
$2d54          00       NOP
$2d55          00       NOP
$2d56          00       NOP
$2d57          00       NOP
$2d58          00       NOP
$2d59          00       NOP
$2d5a          00       NOP
$2d5b          00       NOP
$2d5c          00       NOP
$2d5d          00       NOP
$2d5e          00       NOP
$2d5f          00       NOP
$2d60          00       NOP
$2d61          00       NOP
$2d62          00       NOP
$2d63          00       NOP
$2d64          00       NOP
$2d65          00       NOP
$2d66          00       NOP
$2d67          00       NOP
$2d68          00       NOP
$2d69          00       NOP
$2d6a          00       NOP
$2d6b          00       NOP
$2d6c          00       NOP
$2d6d          00       NOP
$2d6e          00       NOP
$2d6f          00       NOP
$2d70          00       NOP
$2d71          00       NOP
$2d72          00       NOP
$2d73          00       NOP
$2d74          00       NOP
$2d75          00       NOP
$2d76          00       NOP
$2d77          00       NOP
$2d78          00       NOP
$2d79          00       NOP
$2d7a          00       NOP
$2d7b          00       NOP
$2d7c          00       NOP
$2d7d          00       NOP
$2d7e          00       NOP
$2d7f          00       NOP
$2d80          00       NOP
$2d81          00       NOP
$2d82          00       NOP
$2d83          00       NOP
$2d84          00       NOP
$2d85          00       NOP
$2d86          00       NOP
$2d87          00       NOP
$2d88          00       NOP
$2d89          00       NOP
$2d8a          00       NOP
$2d8b          00       NOP
$2d8c          00       NOP
$2d8d          00       NOP
$2d8e          00       NOP
$2d8f          00       NOP
$2d90          00       NOP
$2d91          00       NOP
$2d92          00       NOP
$2d93          00       NOP
$2d94          00       NOP
$2d95          00       NOP
$2d96          00       NOP
$2d97          00       NOP
$2d98          00       NOP
$2d99          00       NOP
$2d9a          00       NOP
$2d9b          00       NOP
$2d9c          00       NOP
$2d9d          00       NOP
$2d9e          00       NOP
$2d9f          00       NOP
$2da0          00       NOP
$2da1          00       NOP
$2da2          00       NOP
$2da3          00       NOP
$2da4          00       NOP
$2da5          00       NOP
$2da6          00       NOP
$2da7          00       NOP
$2da8          00       NOP
$2da9          00       NOP
$2daa          00       NOP
$2dab          00       NOP
$2dac          00       NOP
$2dad          00       NOP
$2dae          00       NOP
$2daf          00       NOP
$2db0          00       NOP
$2db1          00       NOP
$2db2          00       NOP
$2db3          00       NOP
$2db4          00       NOP
$2db5          00       NOP
$2db6          00       NOP
$2db7          00       NOP
$2db8          00       NOP
$2db9          00       NOP
$2dba          00       NOP
$2dbb          00       NOP
$2dbc          00       NOP
$2dbd          00       NOP
$2dbe          00       NOP
$2dbf          00       NOP
$2dc0          00       NOP
$2dc1          00       NOP
$2dc2          00       NOP
$2dc3          00       NOP
$2dc4          00       NOP
$2dc5          00       NOP
$2dc6          00       NOP
$2dc7          00       NOP
$2dc8          00       NOP
$2dc9          00       NOP
$2dca          00       NOP
$2dcb          00       NOP
$2dcc          00       NOP
$2dcd          00       NOP
$2dce          00       NOP
$2dcf          00       NOP
$2dd0          00       NOP
$2dd1          00       NOP
$2dd2          00       NOP
$2dd3          00       NOP
$2dd4          00       NOP
$2dd5          00       NOP
$2dd6          00       NOP
$2dd7          00       NOP
$2dd8          00       NOP
$2dd9          00       NOP
$2dda          00       NOP
$2ddb          00       NOP
$2ddc          00       NOP
$2ddd          00       NOP
$2dde          00       NOP
$2ddf          00       NOP
$2de0          00       NOP
$2de1          00       NOP
$2de2          00       NOP
$2de3          00       NOP
$2de4          00       NOP
$2de5          00       NOP
$2de6          00       NOP
$2de7          00       NOP
$2de8          00       NOP
$2de9          00       NOP
$2dea          00       NOP
$2deb          00       NOP
$2dec          00       NOP
$2ded          00       NOP
$2dee          00       NOP
$2def          00       NOP
$2df0          00       NOP
$2df1          00       NOP
$2df2          00       NOP
$2df3          00       NOP
$2df4          00       NOP
$2df5          00       NOP
$2df6          00       NOP
$2df7          00       NOP
$2df8          00       NOP
$2df9          00       NOP
$2dfa          00       NOP
$2dfb          00       NOP
$2dfc          00       NOP
$2dfd          00       NOP
$2dfe          00       NOP
$2dff          00       NOP
$2e00          00       NOP
$2e01          00       NOP
$2e02          00       NOP
$2e03          00       NOP
$2e04          00       NOP
$2e05          00       NOP
$2e06          00       NOP
$2e07          00       NOP
$2e08          00       NOP
$2e09          00       NOP
$2e0a          00       NOP
$2e0b          00       NOP
$2e0c          00       NOP
$2e0d          00       NOP
$2e0e          00       NOP
$2e0f          00       NOP
$2e10          00       NOP
$2e11          00       NOP
$2e12          00       NOP
$2e13          00       NOP
$2e14          00       NOP
$2e15          00       NOP
$2e16          00       NOP
$2e17          00       NOP
$2e18          00       NOP
$2e19          00       NOP
$2e1a          00       NOP
$2e1b          00       NOP
$2e1c          00       NOP
$2e1d          00       NOP
$2e1e          00       NOP
$2e1f          00       NOP
$2e20          00       NOP
$2e21          00       NOP
$2e22          00       NOP
$2e23          00       NOP
$2e24          00       NOP
$2e25          00       NOP
$2e26          00       NOP
$2e27          00       NOP
$2e28          00       NOP
$2e29          00       NOP
$2e2a          00       NOP
$2e2b          00       NOP
$2e2c          00       NOP
$2e2d          00       NOP
$2e2e          00       NOP
$2e2f          00       NOP
$2e30          00       NOP
$2e31          00       NOP
$2e32          00       NOP
$2e33          00       NOP
$2e34          00       NOP
$2e35          00       NOP
$2e36          00       NOP
$2e37          00       NOP
$2e38          00       NOP
$2e39          00       NOP
$2e3a          00       NOP
$2e3b          00       NOP
$2e3c          00       NOP
$2e3d          00       NOP
$2e3e          00       NOP
$2e3f          00       NOP
$2e40          00       NOP
$2e41          00       NOP
$2e42          00       NOP
$2e43          00       NOP
$2e44          00       NOP
$2e45          00       NOP
$2e46          00       NOP
$2e47          00       NOP
$2e48          00       NOP
$2e49          00       NOP
$2e4a          00       NOP
$2e4b          00       NOP
$2e4c          00       NOP
$2e4d          00       NOP
$2e4e          00       NOP
$2e4f          00       NOP
$2e50          00       NOP
$2e51          00       NOP
$2e52          00       NOP
$2e53          00       NOP
$2e54          00       NOP
$2e55          00       NOP
$2e56          00       NOP
$2e57          00       NOP
$2e58          00       NOP
$2e59          00       NOP
$2e5a          00       NOP
$2e5b          00       NOP
$2e5c          00       NOP
$2e5d          00       NOP
$2e5e          00       NOP
$2e5f          00       NOP
$2e60          00       NOP
$2e61          00       NOP
$2e62          00       NOP
$2e63          00       NOP
$2e64          00       NOP
$2e65          00       NOP
$2e66          00       NOP
$2e67          00       NOP
$2e68          00       NOP
$2e69          00       NOP
$2e6a          00       NOP
$2e6b          00       NOP
$2e6c          00       NOP
$2e6d          00       NOP
$2e6e          00       NOP
$2e6f          00       NOP
$2e70          00       NOP
$2e71          00       NOP
$2e72          00       NOP
$2e73          00       NOP
$2e74          00       NOP
$2e75          00       NOP
$2e76          00       NOP
$2e77          00       NOP
$2e78          00       NOP
$2e79          00       NOP
$2e7a          00       NOP
$2e7b          00       NOP
$2e7c          00       NOP
$2e7d          00       NOP
$2e7e          00       NOP
$2e7f          00       NOP
$2e80          00       NOP
$2e81          00       NOP
$2e82          00       NOP
$2e83          00       NOP
$2e84          00       NOP
$2e85          00       NOP
$2e86          00       NOP
$2e87          00       NOP
$2e88          00       NOP
$2e89          00       NOP
$2e8a          00       NOP
$2e8b          00       NOP
$2e8c          00       NOP
$2e8d          00       NOP
$2e8e          00       NOP
$2e8f          00       NOP
$2e90          00       NOP
$2e91          00       NOP
$2e92          00       NOP
$2e93          00       NOP
$2e94          00       NOP
$2e95          00       NOP
$2e96          00       NOP
$2e97          00       NOP
$2e98          00       NOP
$2e99          00       NOP
$2e9a          00       NOP
$2e9b          00       NOP
$2e9c          00       NOP
$2e9d          00       NOP
$2e9e          00       NOP
$2e9f          00       NOP
$2ea0          00       NOP
$2ea1          00       NOP
$2ea2          00       NOP
$2ea3          00       NOP
$2ea4          00       NOP
$2ea5          00       NOP
$2ea6          00       NOP
$2ea7          00       NOP
$2ea8          00       NOP
$2ea9          00       NOP
$2eaa          00       NOP
$2eab          00       NOP
$2eac          00       NOP
$2ead          00       NOP
$2eae          00       NOP
$2eaf          00       NOP
$2eb0          00       NOP
$2eb1          00       NOP
$2eb2          00       NOP
$2eb3          00       NOP
$2eb4          00       NOP
$2eb5          00       NOP
$2eb6          00       NOP
$2eb7          00       NOP
$2eb8          00       NOP
$2eb9          00       NOP
$2eba          00       NOP
$2ebb          00       NOP
$2ebc          00       NOP
$2ebd          00       NOP
$2ebe          00       NOP
$2ebf          00       NOP
$2ec0          00       NOP
$2ec1          00       NOP
$2ec2          00       NOP
$2ec3          00       NOP
$2ec4          00       NOP
$2ec5          00       NOP
$2ec6          00       NOP
$2ec7          00       NOP
$2ec8          00       NOP
$2ec9          00       NOP
$2eca          00       NOP
$2ecb          00       NOP
$2ecc          00       NOP
$2ecd          00       NOP
$2ece          00       NOP
$2ecf          00       NOP
$2ed0          00       NOP
$2ed1          00       NOP
$2ed2          00       NOP
$2ed3          00       NOP
$2ed4          00       NOP
$2ed5          00       NOP
$2ed6          00       NOP
$2ed7          00       NOP
$2ed8          00       NOP
$2ed9          00       NOP
$2eda          00       NOP
$2edb          00       NOP
$2edc          00       NOP
$2edd          00       NOP
$2ede          00       NOP
$2edf          00       NOP
$2ee0          00       NOP
$2ee1          00       NOP
$2ee2          00       NOP
$2ee3          00       NOP
$2ee4          00       NOP
$2ee5          00       NOP
$2ee6          00       NOP
$2ee7          00       NOP
$2ee8          00       NOP
$2ee9          00       NOP
$2eea          00       NOP
$2eeb          00       NOP
$2eec          00       NOP
$2eed          00       NOP
$2eee          00       NOP
$2eef          00       NOP
$2ef0          00       NOP
$2ef1          00       NOP
$2ef2          00       NOP
$2ef3          00       NOP
$2ef4          00       NOP
$2ef5          00       NOP
$2ef6          00       NOP
$2ef7          00       NOP
$2ef8          00       NOP
$2ef9          00       NOP
$2efa          00       NOP
$2efb          00       NOP
$2efc          00       NOP
$2efd          00       NOP
$2efe          00       NOP
$2eff          00       NOP
$2f00          00       NOP
$2f01          00       NOP
$2f02          00       NOP
$2f03          00       NOP
$2f04          00       NOP
$2f05          00       NOP
$2f06          00       NOP
$2f07          00       NOP
$2f08          00       NOP
$2f09          00       NOP
$2f0a          00       NOP
$2f0b          00       NOP
$2f0c          00       NOP
$2f0d          00       NOP
$2f0e          00       NOP
$2f0f          00       NOP
$2f10          00       NOP
$2f11          00       NOP
$2f12          00       NOP
$2f13          00       NOP
$2f14          00       NOP
$2f15          00       NOP
$2f16          00       NOP
$2f17          00       NOP
$2f18          00       NOP
$2f19          00       NOP
$2f1a          00       NOP
$2f1b          00       NOP
$2f1c          00       NOP
$2f1d          00       NOP
$2f1e          00       NOP
$2f1f          00       NOP
$2f20          00       NOP
$2f21          00       NOP
$2f22          00       NOP
$2f23          00       NOP
$2f24          00       NOP
$2f25          00       NOP
$2f26          00       NOP
$2f27          00       NOP
$2f28          00       NOP
$2f29          00       NOP
$2f2a          00       NOP
$2f2b          00       NOP
$2f2c          00       NOP
$2f2d          00       NOP
$2f2e          00       NOP
$2f2f          00       NOP
$2f30          00       NOP
$2f31          00       NOP
$2f32          00       NOP
$2f33          00       NOP
$2f34          00       NOP
$2f35          00       NOP
$2f36          00       NOP
$2f37          00       NOP
$2f38          00       NOP
$2f39          00       NOP
$2f3a          00       NOP
$2f3b          00       NOP
$2f3c          00       NOP
$2f3d          00       NOP
$2f3e          00       NOP
$2f3f          00       NOP
$2f40          00       NOP
$2f41          00       NOP
$2f42          00       NOP
$2f43          00       NOP
$2f44          00       NOP
$2f45          00       NOP
$2f46          00       NOP
$2f47          00       NOP
$2f48          00       NOP
$2f49          00       NOP
$2f4a          00       NOP
$2f4b          00       NOP
$2f4c          00       NOP
$2f4d          00       NOP
$2f4e          00       NOP
$2f4f          00       NOP
$2f50          00       NOP
$2f51          00       NOP
$2f52          00       NOP
$2f53          00       NOP
$2f54          00       NOP
$2f55          00       NOP
$2f56          00       NOP
$2f57          00       NOP
$2f58          00       NOP
$2f59          00       NOP
$2f5a          00       NOP
$2f5b          00       NOP
$2f5c          00       NOP
$2f5d          00       NOP
$2f5e          00       NOP
$2f5f          00       NOP
$2f60          00       NOP
$2f61          00       NOP
$2f62          00       NOP
$2f63          00       NOP
$2f64          00       NOP
$2f65          00       NOP
$2f66          00       NOP
$2f67          00       NOP
$2f68          00       NOP
$2f69          00       NOP
$2f6a          00       NOP
$2f6b          00       NOP
$2f6c          00       NOP
$2f6d          00       NOP
$2f6e          00       NOP
$2f6f          00       NOP
$2f70          00       NOP
$2f71          00       NOP
$2f72          00       NOP
$2f73          00       NOP
$2f74          00       NOP
$2f75          00       NOP
$2f76          00       NOP
$2f77          00       NOP
$2f78          00       NOP
$2f79          00       NOP
$2f7a          00       NOP
$2f7b          00       NOP
$2f7c          00       NOP
$2f7d          00       NOP
$2f7e          00       NOP
$2f7f          00       NOP
$2f80          00       NOP
$2f81          00       NOP
$2f82          00       NOP
$2f83          00       NOP
$2f84          00       NOP
$2f85          00       NOP
$2f86          00       NOP
$2f87          00       NOP
$2f88          00       NOP
$2f89          00       NOP
$2f8a          00       NOP
$2f8b          00       NOP
$2f8c          00       NOP
$2f8d          00       NOP
$2f8e          00       NOP
$2f8f          00       NOP
$2f90          00       NOP
$2f91          00       NOP
$2f92          00       NOP
$2f93          00       NOP
$2f94          00       NOP
$2f95          00       NOP
$2f96          00       NOP
$2f97          00       NOP
$2f98          00       NOP
$2f99          00       NOP
$2f9a          00       NOP
$2f9b          00       NOP
$2f9c          00       NOP
$2f9d          00       NOP
$2f9e          00       NOP
$2f9f          00       NOP
$2fa0          00       NOP
$2fa1          00       NOP
$2fa2          00       NOP
$2fa3          00       NOP
$2fa4          00       NOP
$2fa5          00       NOP
$2fa6          00       NOP
$2fa7          00       NOP
$2fa8          00       NOP
$2fa9          00       NOP
$2faa          00       NOP
$2fab          00       NOP
$2fac          00       NOP
$2fad          00       NOP
$2fae          00       NOP
$2faf          00       NOP
$2fb0          00       NOP
$2fb1          00       NOP
$2fb2          00       NOP
$2fb3          00       NOP
$2fb4          00       NOP
$2fb5          00       NOP
$2fb6          00       NOP
$2fb7          00       NOP
$2fb8          00       NOP
$2fb9          00       NOP
$2fba          00       NOP
$2fbb          00       NOP
$2fbc          00       NOP
$2fbd          00       NOP
$2fbe          00       NOP
$2fbf          00       NOP
$2fc0          00       NOP
$2fc1          00       NOP
$2fc2          00       NOP
$2fc3          00       NOP
$2fc4          00       NOP
$2fc5          00       NOP
$2fc6          00       NOP
$2fc7          00       NOP
$2fc8          00       NOP
$2fc9          00       NOP
$2fca          00       NOP
$2fcb          00       NOP
$2fcc          00       NOP
$2fcd          00       NOP
$2fce          00       NOP
$2fcf          00       NOP
$2fd0          00       NOP
$2fd1          00       NOP
$2fd2          00       NOP
$2fd3          00       NOP
$2fd4          00       NOP
$2fd5          00       NOP
$2fd6          00       NOP
$2fd7          00       NOP
$2fd8          00       NOP
$2fd9          00       NOP
$2fda          00       NOP
$2fdb          00       NOP
$2fdc          00       NOP
$2fdd          00       NOP
$2fde          00       NOP
$2fdf          00       NOP
$2fe0          00       NOP
$2fe1          00       NOP
$2fe2          00       NOP
$2fe3          00       NOP
$2fe4          00       NOP
$2fe5          00       NOP
$2fe6          00       NOP
$2fe7          00       NOP
$2fe8          00       NOP
$2fe9          00       NOP
$2fea          00       NOP
$2feb          00       NOP
$2fec          00       NOP
$2fed          00       NOP
$2fee          00       NOP
$2fef          00       NOP
$2ff0          00       NOP
$2ff1          00       NOP
$2ff2          00       NOP
$2ff3          00       NOP
$2ff4          00       NOP
$2ff5          00       NOP
$2ff6          00       NOP
$2ff7          00       NOP
$2ff8          00       NOP
$2ff9          00       NOP
$2ffa          00       NOP
$2ffb          00       NOP
$2ffc          00       NOP
$2ffd          00       NOP
$2ffe          00       NOP
$2fff          00       NOP
