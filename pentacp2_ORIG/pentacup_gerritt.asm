0000: C3 40 00  jp   $0040 ' rst 0

0024: C3 69 00  jp   $0069 ' rst 4.5 - trap

002C: C3 30 03  jp   $0330 ' rst 5.5

0034: C3 86 03  jp   $0386 ' rst 6.5

0038: 76        halt       ' rst 7 - irq

003C: C3 00 28  jp   $2800 ' rst 7.5

0040: 3E 21     ld   a,$21
0042: 32 DA 23  ld   ($23da),a
0045: 16 05     ld   d,$05
0047: 21 10 27  ld   hl,$2710
004A: 2B        dec  hl
004B: D3 0F     out  ($0f),a
004D: 7C        ld   a,h
004E: B7        or   a
004F: C2 4A 00  jp   nz,$004a
0052: 15        dec  d
0053: C2 47 00  jp   nz,$0047
0056: DB 04     in   a,($04)
0058: E6 20     and  $20
005A: CA 69 00  jp   z,$0069
005D: 21 00 20  ld   hl,$2000
0060: 97        sub  a
0061: 77        ld   (hl),a
0062: 23        inc  hl
0063: 3E 24     ld   a,$24
0065: BC        cp   h
0066: C2 60 00  jp   nz,$0060

0069: 31 90 21  ld   sp,$2190
006C: 3E 07     ld   a,$07
006E: D3 0E     out  ($0e),a
0070: D3 0D     out  ($0d),a
0072: 3D        dec  a
0073: F2 6E 00  jp   p,$006e
0076: 21 97 21  ld   hl,$2197
0079: 0E 2D     ld   c,$2d
007B: 97        sub  a
007C: 77        ld   (hl),a
007D: 23        inc  hl
007E: 0D        dec  c
007F: C2 7B 00  jp   nz,$007b
0082: 3E 05     ld   a,$05
0084: 32 00 00  ld   ($0000),a
0087: 3E FE     ld   a,$fe
0089: D3 09     out  ($09),a
008B: 3E 02     ld   a,$02
008D: 32 98 21  ld   ($2198),a
0090: 3E FF     ld   a,$ff
0092: 32 93 21  ld   ($2193),a
0095: 3E FC     ld   a,$fc
0097: 32 94 21  ld   ($2194),a
009A: 21 FB 21  ld   hl,$21fb
009D: 22 F9 21  ld   ($21f9),hl
00A0: 21 B4 21  ld   hl,$21b4
00A3: 22 BE 21  ld   ($21be),hl
00A6: 22 C0 21  ld   ($21c0),hl
00A9: 3E 0F     ld   a,$0f
00AB: 32 F8 21  ld   ($21f8),a
00AE: 3A 90 21  ld   a,($2190)
00B1: F6 05     or   $05
00B3: 32 90 21  ld   ($2190),a
00B6: 3E 0C     ld   a,$0c
00B8: 30        sim
00B9: DB 04     in   a,($04)
00BB: E6 20     and  $20
00BD: CA F5 00  jp   z,$00f5
00C0: 21 81 11  ld   hl,$1181 ' 25,000 pts
00C3: 11 2D 22  ld   de,$222d
00C6: 3E 08     ld   a,$08
00C8: CD CF 0E  call $0ecf
00CB: 21 7D 11  ld   hl,$117d ' 10,000 pts
00CE: 11 31 22  ld   de,$2231
00D1: 3E 08     ld   a,$08
00D3: CD CF 0E  call $0ecf
00D6: 3E 71     ld   a,$71
00D8: 32 9F 21  ld   ($219f),a
00DB: 3E 3C     ld   a,$3c
00DD: 32 1F 22  ld   ($221f),a
00E0: 3E 00     ld   a,$00
00E2: 32 20 22  ld   ($2220),a
00E5: 32 21 22  ld   ($2221),a
00E8: 3E 04     ld   a,$04
00EA: 32 22 22  ld   ($2222),a
00ED: 3E 64     ld   a,$64
00EF: 32 4A 22  ld   ($224a),a
00F2: C3 FB 00  jp   $00fb

00F5: CD 17 03  call $0317
00F8: CA 43 01  jp   z,$0143

00FB: 3E 07     ld   a,$07
00FD: 32 C2 21  ld   ($21c2),a
0100: 2F        cpl
0101: D3 05     out  ($05),a
0103: 3E 06     ld   a,$06
0105: 32 A6 21  ld   ($21a6),a
0108: FB        ei
0109: 3A A6 21  ld   a,($21a6)
010C: B7        or   a
010D: C2 08 01  jp   nz,$0108
0110: 3E 28     ld   a,$28
0112: 32 C2 21  ld   ($21c2),a
0115: 2F        cpl
0116: D3 05     out  ($05),a
0118: 3E 20     ld   a,$20
011A: 32 C4 21  ld   ($21c4),a
011D: 2F        cpl
011E: D3 07     out  ($07),a
0120: 3E 02     ld   a,$02
0122: 32 C5 21  ld   ($21c5),a
0125: 2F        cpl
0126: D3 08     out  ($08),a
0128: 3E 06     ld   a,$06
012A: 32 A6 21  ld   ($21a6),a
012D: FB        ei
012E: 3A A6 21  ld   a,($21a6)
0131: B7        or   a
0132: C2 2D 01  jp   nz,$012d
0135: 3E FF     ld   a,$ff
0137: D3 05     out  ($05),a
0139: D3 06     out  ($06),a
013B: D3 07     out  ($07),a
013D: D3 08     out  ($08),a
013F: F3        di
0140: CD 7D 13  call $137d

0143: DB 04     in   a,($04)
0145: E6 20     and  $20
0147: C2 68 01  jp   nz,$0168
014A: 3A 92 21  ld   a,($2192)
014D: E6 DF     and  $df
014F: 32 92 21  ld   ($2192),a
0152: DB 03     in   a,($03)
0154: FE FE     cp   $fe
0156: C2 BF 01  jp   nz,$01bf
0159: DB 02     in   a,($02)
015B: FE FB     cp   $fb
015D: CA 9E 02  jp   z,$029e
0160: FE F7     cp   $f7
0162: CA C8 02  jp   z,$02c8
0165: C3 BF 01  jp   $01bf

0168: CD A8 17  call $17a8
016B: 3E D0     ld   a,$d0
016D: 32 92 21  ld   ($2192),a
0170: 3E 00     ld   a,$00
0172: 32 7E 23  ld   ($237e),a
0175: 32 9E 23  ld   ($239e),a
0178: 32 BE 23  ld   ($23be),a
017B: 32 7A 23  ld   ($237a),a
017E: 32 9A 23  ld   ($239a),a
0181: 32 BA 23  ld   ($23ba),a
0184: 3E 0F     ld   a,$0f
0186: 32 7B 23  ld   ($237b),a
0189: 32 9B 23  ld   ($239b),a
018C: 32 BB 23  ld   ($23bb),a
018F: 32 96 23  ld   ($2396),a
0192: 32 B6 23  ld   ($23b6),a
0195: 21 A3 23  ld   hl,$23a3
0198: 11 20 23  ld   de,$2320
019B: 3E 2E     ld   a,$2e
019D: CD CF 0E  call $0ecf
01A0: 06 01     ld   b,$01
01A2: 11 C6 21  ld   de,$21c6
01A5: CD 8E 17  call $178e
01A8: 21 C9 21  ld   hl,$21c9
01AB: 11 CE 21  ld   de,$21ce
01AE: 3E 0A     ld   a,$0a
01B0: CD CF 0E  call $0ecf
01B3: 21 05 22  ld   hl,$2205
01B6: 06 13     ld   b,$13
01B8: 97        sub  a
01B9: 77        ld   (hl),a
01BA: 23        inc  hl
01BB: 05        dec  b
01BC: C2 B9 01  jp   nz,$01b9

01BF: F3        di
01C0: 3E 30     ld   a,$30
01C2: 32 94 21  ld   ($2194),a
01C5: 3A 92 21  ld   a,($2192)
01C8: E6 80     and  $80
01CA: C2 D2 01  jp   nz,$01d2
01CD: 3E 00     ld   a,$00
01CF: 32 92 21  ld   ($2192),a
01D2: DB 02     in   a,($02)
01D4: 2F        cpl
01D5: 6F        ld   l,a
01D6: DB 04     in   a,($04)
01D8: 2F        cpl
01D9: E6 03     and  $03
01DB: 67        ld   h,a
01DC: 06 0F     ld   b,$0f
01DE: 29        add  hl,hl
01DF: DA E6 01  jp   c,$01e6
01E2: 05        dec  b
01E3: C2 DE 01  jp   nz,$01de
01E6: DB 03     in   a,($03)
01E8: 2F        cpl
01E9: 6F        ld   l,a
01EA: DB 04     in   a,($04)
01EC: 2F        cpl
01ED: E6 0C     and  $0c
01EF: 1F        rra
01F0: 1F        rra
01F1: 67        ld   h,a
01F2: 0E 0F     ld   c,$0f
01F4: 29        add  hl,hl
01F5: DA FC 01  jp   c,$01fc
01F8: 0D        dec  c
01F9: C2 F4 01  jp   nz,$01f4
01FC: 79        ld   a,c
01FD: 17        rla
01FE: 17        rla
01FF: 17        rla
0200: 17        rla
0201: E6 F0     and  $f0
0203: 80        add  a,b
0204: 32 7F 23  ld   ($237f),a
0207: 32 9F 23  ld   ($239f),a
020A: 32 BF 23  ld   ($23bf),a
020D: FB        ei
020E: DB 05     in   a,($05)
0210: 21 16 22  ld   hl,$2216
0213: 77        ld   (hl),a
0214: 06 03     ld   b,$03
0216: 3E 00     ld   a,$00
0218: CD EE 03  call $03ee
021B: C2 28 02  jp   nz,$0228
021E: 04        inc  b
021F: 3E 01     ld   a,$01
0221: CD EE 03  call $03ee
0224: C2 28 02  jp   nz,$0228
0227: 04        inc  b
0228: 78        ld   a,b
0229: 32 13 22  ld   ($2213),a

022C: D3 0F     out  ($0f),a
022E: FB        ei
022F: 00        nop
0230: FB        ei
0231: 00        nop
0232: FB        ei
0233: 00        nop
0234: F3        di
0235: 3A C2 21  ld   a,($21c2)
0238: 2F        cpl
0239: D3 05     out  ($05),a
023B: 3A C3 21  ld   a,($21c3)
023E: 2F        cpl
023F: D3 06     out  ($06),a
0241: 3A C4 21  ld   a,($21c4)
0244: 2F        cpl
0245: D3 07     out  ($07),a
0247: 3A C5 21  ld   a,($21c5)
024A: 2F        cpl
024B: D3 08     out  ($08),a
024D: FB        ei
024E: 00        nop
024F: FB        ei
0250: 00        nop
0251: FB        ei
0252: 00        nop
0253: F3        di
0254: 2A F9 21  ld   hl,($21f9)
0257: 11 FB 21  ld   de,$21fb
025A: 7D        ld   a,l
025B: 93        sub  e
025C: CA 7B 02  jp   z,$027b
025F: FA 67 02  jp   m,$0267
0262: FE 08     cp   $08
0264: DA 70 02  jp   c,$0270
0267: 21 FB 21  ld   hl,$21fb
026A: 22 F9 21  ld   ($21f9),hl
026D: C3 7B 02  jp   $027b

0270: 2B        dec  hl
0271: 7E        ld   a,(hl)
0272: 2B        dec  hl
0273: 22 F9 21  ld   ($21f9),hl
0276: 6E        ld   l,(hl)
0277: 67        ld   h,a
0278: CD 3C 0F  call $0f3c

027B: FB        ei
027C: 21 92 21  ld   hl,$2192
027F: 3E 07     ld   a,$07
0281: CD EE 03  call $03ee
0284: C2 B9 1B  jp   nz,$1bb9
0287: 3A B6 23  ld   a,($23b6)
028A: E6 BF     and  $bf
028C: 32 B6 23  ld   ($23b6),a
028F: C3 2C 02  jp   $022c

0292: EB        ex   de,hl
0293: 2A F9 21  ld   hl,($21f9)
0296: 73        ld   (hl),e
0297: 23        inc  hl
0298: 72        ld   (hl),d
0299: 23        inc  hl
029A: 22 F9 21  ld   ($21f9),hl
029D: C9        ret

029E: 3A 91 21  ld   a,($2191)
02A1: 47        ld   b,a
02A2: E6 01     and  $01
02A4: C2 BF 01  jp   nz,$01bf
02A7: 78        ld   a,b
02A8: F6 01     or   $01
02AA: 32 91 21  ld   ($2191),a
02AD: F3        di
02AE: 3E 30     ld   a,$30
02B0: 32 94 21  ld   ($2194),a
02B3: 3E 7D     ld   a,$7d
02B5: 32 9F 21  ld   ($219f),a
02B8: 3E 3C     ld   a,$3c
02BA: 32 1F 22  ld   ($221f),a
02BD: 3E 00     ld   a,$00
02BF: 32 20 22  ld   ($2220),a
02C2: 32 21 22  ld   ($2221),a
02C5: C3 68 01  jp   $0168

02C8: F3        di
02C9: 21 C0 23  ld   hl,$23c0
02CC: 06 0C     ld   b,$0c
02CE: 36 88     ld   (hl),$88
02D0: 23        inc  hl
02D1: 05        dec  b
02D2: C2 CE 02  jp   nz,$02ce
02D5: 36 F8     ld   (hl),$f8
02D7: 23        inc  hl
02D8: 06 09     ld   b,$09
02DA: 36 88     ld   (hl),$88
02DC: 23        inc  hl
02DD: 05        dec  b
02DE: C2 DA 02  jp   nz,$02da
02E1: 36 F8     ld   (hl),$f8
02E3: 23        inc  hl
02E4: 06 07     ld   b,$07
02E6: 36 88     ld   (hl),$88
02E8: 23        inc  hl
02E9: 05        dec  b
02EA: C2 E6 02  jp   nz,$02e6
02ED: 36 FF     ld   (hl),$ff
02EF: 23        inc  hl
02F0: 36 88     ld   (hl),$88
02F2: 3E 00     ld   a,$00
02F4: D3 00     out  ($00),a
02F6: D3 01     out  ($01),a
02F8: D3 02     out  ($02),a
02FA: D3 03     out  ($03),a
02FC: D3 04     out  ($04),a
02FE: D3 0F     out  ($0f),a
0300: C3 43 01  jp   $0143

0303: 11 3B 23  ld   de,$233b
0306: 01 00 00  ld   bc,$0000
0309: 21 00 00  ld   hl,$0000
030C: 1A        ld   a,(de)
030D: 4F        ld   c,a
030E: 09        add  hl,bc
030F: 13        inc  de
0310: 7B        ld   a,e
0311: FE 5D     cp   $5d
0313: C2 0C 03  jp   nz,$030c
0316: C9        ret

0317: CD 03 03  call $0303
031A: EB        ex   de,hl
031B: 2A 24 22  ld   hl,($2224)
031E: 7B        ld   a,e
031F: BD        cp   l
0320: C0        ret  nz
0321: B7        or   a
0322: CA 28 03  jp   z,$0328
0325: 7A        ld   a,d
0326: BC        cp   h
0327: C9        ret

0328: 7A        ld   a,d
0329: B7        or   a
032A: C2 25 03  jp   nz,$0325
032D: 3C        inc  a
032E: C9        ret

032F: 2D        dec  l

0330: CD 24 06  call $0624
0333: 3A 90 21  ld   a,($2190)
0336: F6 80     or   $80
0338: 32 90 21  ld   ($2190),a
033B: DB 01     in   a,($01)
033D: 11 00 00  ld   de,$0000

0340: B7        or   a
0341: CA 82 03  jp   z,$0382
0344: 1F        rra
0345: DA 4C 03  jp   c,$034c
0348: 1C        inc  e
0349: C3 40 03  jp   $0340

034C: 7B        ld   a,e
034D: 2F        cpl
034E: D3 0E     out  ($0e),a
0350: 2F        cpl
0351: 21 93 21  ld   hl,$2193
0354: CD EE 03  call $03ee
0357: C2 82 03  jp   nz,$0382
035A: CD 24 06  call $0624
035D: 3A 91 21  ld   a,($2191)
0360: E6 02     and  $02
0362: C4 02 04  call nz,$0402
0365: CD 30 06  call $0630
0368: CD D6 03  call $03d6
036B: EB        ex   de,hl
036C: 29        add  hl,hl
036D: 11 B6 03  ld   de,$03b6
0370: 19        add  hl,de
0371: 7E        ld   a,(hl)
0372: 23        inc  hl
0373: 66        ld   h,(hl)
0374: 6F        ld   l,a
0375: E9        jp   (hl)

0376: 21 94 21  ld   hl,$2194
0379: C3 7F 03  jp   $037f

037C: 21 93 21  ld   hl,$2193

037F: CD E1 03  call $03e1

0382: CD 30 06  call $0630
0385: C9        ret

0386: CD 24 06  call $0624
0389: 11 00 00  ld   de,$0000
038C: DB 00     in   a,($00)

038E: B7        or   a
038F: CA 82 03  jp   z,$0382
0392: 1F        rra
0393: DA 9A 03  jp   c,$039a
0396: 1C        inc  e
0397: C3 8E 03  jp   $038e

039A: 7B        ld   a,e
039B: 2F        cpl
039C: D3 0D     out  ($0d),a
039E: 2F        cpl
039F: 21 94 21  ld   hl,$2194
03A2: CD EE 03  call $03ee
03A5: C2 82 03  jp   nz,$0382
03A8: CD D6 03  call $03d6
03AB: EB        ex   de,hl
03AC: 29        add  hl,hl
03AD: 11 C6 03  ld   de,$03c6
03B0: 19        add  hl,de
03B1: 7E        ld   a,(hl)
03B2: 23        inc  hl
03B3: 66        ld   h,(hl)
03B4: 6F        ld   l,a
03B5: E9        jp   (hl)

03B6: 60 07 -> 0760 ' 25 pts bumper
      66 07 -> 0766 ' 50 pts bumper
      6C 07 -> 076C ' 100 pts bumper
      72 07 -> 0772 ' 10 pts bumper
      78 07 -> 0778 ' 1 pt slingshot
      7E 07 -> 077E ' 1 pt slingshot
      84 07 -> 0784 ' enables standup targets!
      82 03 -> 0382 ' nothing

03C6: D9 05 -> 05D9 ' ? called frequently
      BC 13 -> 13BC ' ?
      82 03 -> 0382 ' nothing
      7B 04 -> 047B ' tilt / slam (when switch #5 is closed)
      37 08 -> 0837 ' ?
      09 09 -> 0909 ' ?
      FB 15 -> 15FB ' game start
      7B 04 -> 047B ' tilt / slam (when switch #5 is closed)

03D6: C5        push bc
03D7: 47        ld   b,a
03D8: CD F9 03  call $03f9
03DB: 4E        ld   c,(hl)
03DC: B1        or   c
03DD: 77        ld   (hl),a
03DE: C3 F6 03  jp   $03f6

03E1: C5        push bc
03E2: 47        ld   b,a
03E3: CD F9 03  call $03f9
03E6: 2F        cpl
03E7: 4F        ld   c,a
03E8: 7E        ld   a,(hl)
03E9: A1        and  c
03EA: 77        ld   (hl),a
03EB: C3 F6 03  jp   $03f6

03EE: C5        push bc
03EF: 47        ld   b,a
03F0: CD F9 03  call $03f9
03F3: 4F        ld   c,a
03F4: 7E        ld   a,(hl)
03F5: A1        and  c

03F6: 78        ld   a,b
03F7: C1        pop  bc
03F8: C9        ret

03F9: 4F        ld   c,a
03FA: 3E 01     ld   a,$01

03FC: 0D        dec  c
03FD: F8        ret  m
03FE: 87        add  a,a
03FF: C3 FC 03  jp   $03fc

0402: 3A 11 22  ld   a,($2211)
0405: 47        ld   b,a
0406: CD 27 04  call $0427
0409: CD EE 03  call $03ee
040C: CA 13 04  jp   z,$0413
040F: EB        ex   de,hl
0410: CD D6 03  call $03d6
0413: 78        ld   a,b
0414: 3C        inc  a
0415: FE 05     cp   $05
0417: C2 1C 04  jp   nz,$041c
041A: 3E 00     ld   a,$00
041C: 32 11 22  ld   ($2211),a
041F: CD 27 04  call $0427
0422: EB        ex   de,hl
0423: CD E1 03  call $03e1
0426: C9        ret

0427: 16 00     ld   d,$00
0429: 5F        ld   e,a
042A: 21 40 04  ld   hl,$0440
042D: 19        add  hl,de
042E: 7E        ld   a,(hl)
042F: 21 45 04  ld   hl,$0445
0432: EB        ex   de,hl
0433: 29        add  hl,hl
0434: 19        add  hl,de
0435: 4E        ld   c,(hl)
0436: 23        inc  hl
0437: 66        ld   h,(hl)
0438: 69        ld   l,c
0439: 11 05 00  ld   de,$0005
043C: EB        ex   de,hl
043D: 19        add  hl,de
043E: EB        ex   de,hl
043F: C9        ret

0440: 04 00 01 02 05

0445: CD 21 -> 21CD
      CC 21 -> 21CC
      CC 21 -> 21CC
      CC 21 -> 21CC
      CA 21 -> 21CA

044F: 3A 90 21  ld   a,($2190)
0452: F6 05     or   $05
0454: 32 90 21  ld   ($2190),a
0457: 3E 00     ld   a,$00
0459: 32 0C 22  ld   ($220c),a
045C: 3E FF     ld   a,$ff
045E: 32 93 21  ld   ($2193),a
0461: 3A 94 21  ld   a,($2194)
0464: F6 30     or   $30
0466: 32 94 21  ld   ($2194),a
0469: C9        ret

046A: 3A 92 21  ld   a,($2192)
046D: E6 40     and  $40
046F: C8        ret  z
0470: 3A 7A 23  ld   a,($237a)
0473: B7        or   a
0474: CA 79 04  jp   z,$0479
0477: BF        cp   a
0478: C9        ret

0479: 3D        dec  a
047A: C9        ret

047B: CD 4F 04  call $044f
047E: 3E 7D     ld   a,$7d
0480: 32 A2 21  ld   ($21a2),a
0483: CD 6A 04  call $046a
0486: C2 82 03  jp   nz,$0382
0489: 3E FA     ld   a,$fa
048B: 32 9E 21  ld   ($219e),a
048E: 3A B6 23  ld   a,($23b6)
0491: F6 10     or   $10
0493: 32 B6 23  ld   ($23b6),a
0496: 3E FF     ld   a,$ff
0498: 32 80 23  ld   ($2380),a
049B: 32 81 23  ld   ($2381),a
049E: 32 82 23  ld   ($2382),a
04A1: 3A 3F 23  ld   a,($233f)
04A4: C6 08     add  a,$08
04A6: 47        ld   b,a
04A7: 3A E4 23  ld   a,($23e4)
04AA: 90        sub  b
04AB: FA 43 05  jp   m,$0543
04AE: 3A 92 21  ld   a,($2192)
04B1: E6 40     and  $40
04B3: C2 43 05  jp   nz,$0543
04B6: 3A 94 21  ld   a,($2194)
04B9: F6 FC     or   $fc
04BB: 32 94 21  ld   ($2194),a
04BE: 3A 47 22  ld   a,($2247)
04C1: F6 40     or   $40
04C3: 32 47 22  ld   ($2247),a
04C6: 3E FF     ld   a,$ff
04C8: 21 C0 23  ld   hl,$23c0
04CB: 06 20     ld   b,$20
04CD: 77        ld   (hl),a
04CE: 23        inc  hl
04CF: 05        dec  b
04D0: C2 CD 04  jp   nz,$04cd
04D3: D3 00     out  ($00),a
04D5: D3 01     out  ($01),a
04D7: D3 02     out  ($02),a
04D9: D3 03     out  ($03),a
04DB: D3 04     out  ($04),a
04DD: D3 05     out  ($05),a
04DF: D3 06     out  ($06),a
04E1: D3 07     out  ($07),a
04E3: D3 08     out  ($08),a
04E5: 3E 00     ld   a,$00
04E7: 3E 0F     ld   a,$0f
04E9: 32 CC 23  ld   ($23cc),a
04EC: 32 D6 23  ld   ($23d6),a
04EF: 32 DE 23  ld   ($23de),a
04F2: 3A 90 21  ld   a,($2190)
04F5: E6 F7     and  $f7
04F7: 32 90 21  ld   ($2190),a
04FA: 3A 96 23  ld   a,($2396)
04FD: E6 DF     and  $df
04FF: 32 96 23  ld   ($2396),a
0502: 3A B6 23  ld   a,($23b6)
0505: E6 DF     and  $df
0507: 32 B6 23  ld   ($23b6),a
050A: 06 30     ld   b,$30
050C: CD 81 1D  call $1d81
050F: 3E D0     ld   a,$d0
0511: 32 92 21  ld   ($2192),a
0514: 3A 13 22  ld   a,($2213)
0517: 32 7B 23  ld   ($237b),a
051A: 21 7E 23  ld   hl,$237e
051D: 7E        ld   a,(hl)
051E: E6 0F     and  $0f
0520: 77        ld   (hl),a
0521: 06 FF     ld   b,$ff

0523: 1F        rra
0524: D2 2B 05  jp   nc,$052b
0527: 04        inc  b
0528: C3 23 05  jp   $0523

052B: 78        ld   a,b
052C: C6 04     add  a,$04
052E: CD D6 03  call $03d6
0531: 3E 01     ld   a,$01
0533: 32 14 22  ld   ($2214),a
0536: 3E 28     ld   a,$28
0538: 32 1B 22  ld   ($221b),a
053B: 3E 02     ld   a,$02
053D: 32 9D 21  ld   ($219d),a
0540: C3 82 03  jp   $0382

0543: 21 C2 12  ld   hl,$12c2 ' tilt sound
0546: CD 61 12  call $1261
0549: C3 82 03  jp   $0382

054C: 3A 1B 22  ld   a,($221b)
054F: 3D        dec  a
0550: 32 1B 22  ld   ($221b),a
0553: CA 69 05  jp   z,$0569
0556: 3E 14     ld   a,$14
0558: 32 9D 21  ld   ($219d),a
055B: 3E FA     ld   a,$fa
055D: 32 9E 21  ld   ($219e),a
0560: 21 BF 12  ld   hl,$12bf ' sound
0563: CD 61 12  call $1261
0566: C3 1E 06  jp   $061e

0569: 3A 47 22  ld   a,($2247)
056C: E6 BF     and  $bf
056E: 32 47 22  ld   ($2247),a
0571: 3E 01     ld   a,$01
0573: 32 A0 21  ld   ($21a0),a
0576: 32 1C 22  ld   ($221c),a
0579: 3A 94 21  ld   a,($2194)
057C: E6 33     and  $33
057E: 32 94 21  ld   ($2194),a
0581: C3 1E 06  jp   $061e

0584: DB 04     in   a,($04)
0586: E6 80     and  $80
0588: CA A2 05  jp   z,$05a2
058B: CD 6A 04  call $046a
058E: C2 A2 05  jp   nz,$05a2
0591: CD 4F 04  call $044f
0594: 3E 7D     ld   a,$7d
0596: 32 A2 21  ld   ($21a2),a
0599: 21 C2 12  ld   hl,$12c2 ' tilt sound
059C: CD 61 12  call $1261
059F: C3 1E 06  jp   $061e

05A2: 3A 94 21  ld   a,($2194)
05A5: E6 77     and  $77
05A7: 32 94 21  ld   ($2194),a
05AA: C3 1E 06  jp   $061e

05AD: 21 92 21  ld   hl,$2192
05B0: 3E 07     ld   a,$07
05B2: CD EE 03  call $03ee
05B5: CA 1E 06  jp   z,$061e
05B8: 3A B6 23  ld   a,($23b6)
05BB: E6 EF     and  $ef
05BD: 32 B6 23  ld   ($23b6),a
05C0: 3E F0     ld   a,$f0
05C2: 32 A0 23  ld   ($23a0),a
05C5: 32 80 23  ld   ($2380),a
05C8: 3E FF     ld   a,$ff
05CA: 32 A1 23  ld   ($23a1),a
05CD: 32 81 23  ld   ($2381),a
05D0: 32 A2 23  ld   ($23a2),a
05D3: 32 82 23  ld   ($2382),a
05D6: C3 1E 06  jp   $061e

05D9: 21 97 21  ld   hl,$2197
05DC: 0E 1A     ld   c,$1a
05DE: 3E FF     ld   a,$ff
05E0: 86        add  a,(hl)
05E1: D2 E8 05  jp   nc,$05e8
05E4: 77        ld   (hl),a
05E5: CA 09 06  jp   z,$0609

05E8: 23        inc  hl
05E9: 0D        dec  c
05EA: C2 DE 05  jp   nz,$05de
05ED: 3A 98 21  ld   a,($2198)
05F0: B7        or   a
05F1: C2 F6 05  jp   nz,$05f6
05F4: 3E 01     ld   a,$01
05F6: E6 3F     and  $3f
05F8: 32 98 21  ld   ($2198),a
05FB: 3A 47 22  ld   a,($2247)
05FE: E6 40     and  $40
0600: CC 36 06  call z,$0636
0603: 3E 00     ld   a,$00
0605: F3        di
0606: C3 76 03  jp   $0376

0609: F3        di
060A: CD 24 06  call $0624
060D: 3E 1A     ld   a,$1a
060F: 91        sub  c
0610: 87        add  a,a
0611: 11 00 00  ld   de,$0000
0614: 5F        ld   e,a
0615: 21 2C 07  ld   hl,$072c
0618: 19        add  hl,de
0619: 7E        ld   a,(hl)
061A: 23        inc  hl
061B: 66        ld   h,(hl)
061C: 6F        ld   l,a
061D: E9        jp   (hl)

061E: CD 30 06  call $0630
0621: C3 E8 05  jp   $05e8

0624: 22 95 21  ld   ($2195),hl
0627: E3        ex   (sp),hl
0628: C5        push bc
0629: D5        push de
062A: F5        push af
062B: E5        push hl
062C: 2A 95 21  ld   hl,($2195)
062F: C9        ret

0630: E1        pop  hl
0631: F1        pop  af
0632: D1        pop  de
0633: C1        pop  bc
0634: E3        ex   (sp),hl
0635: C9        ret

0636: 21 F8 21  ld   hl,$21f8
0639: 35        dec  (hl)
063A: C2 47 06  jp   nz,$0647
063D: 36 14     ld   (hl),$14
063F: 3A 47 22  ld   a,($2247)
0642: C6 80     add  a,$80
0644: 32 47 22  ld   ($2247),a
0647: 3A 47 22  ld   a,($2247)
064A: E6 80     and  $80
064C: CA 7B 06  jp   z,$067b
064F: 21 A0 23  ld   hl,$23a0
0652: 11 C0 23  ld   de,$23c0
0655: 3E 40     ld   a,$40
0657: CD CF 0E  call $0ecf
065A: 3A C9 21  ld   a,($21c9)
065D: 2F        cpl
065E: D3 00     out  ($00),a
0660: 3A CA 21  ld   a,($21ca)
0663: 2F        cpl
0664: D3 01     out  ($01),a
0666: 3A CB 21  ld   a,($21cb)
0669: 2F        cpl
066A: D3 02     out  ($02),a
066C: 3A CC 21  ld   a,($21cc)
066F: 2F        cpl
0670: D3 03     out  ($03),a
0672: 3A CD 21  ld   a,($21cd)
0675: 2F        cpl
0676: D3 04     out  ($04),a
0678: C3 A4 06  jp   $06a4

067B: 21 80 23  ld   hl,$2380
067E: 11 C0 23  ld   de,$23c0
0681: 3E 40     ld   a,$40
0683: CD CF 0E  call $0ecf
0686: 3A CE 21  ld   a,($21ce)
0689: 2F        cpl
068A: D3 00     out  ($00),a
068C: 3A CF 21  ld   a,($21cf)
068F: 2F        cpl
0690: D3 01     out  ($01),a
0692: 3A D0 21  ld   a,($21d0)
0695: 2F        cpl
0696: D3 02     out  ($02),a
0698: 3A D1 21  ld   a,($21d1)
069B: 2F        cpl
069C: D3 03     out  ($03),a
069E: 3A D2 21  ld   a,($21d2)
06A1: 2F        cpl
06A2: D3 04     out  ($04),a

06A4: DB 04     in   a,($04)
06A6: E6 10     and  $10
06A8: C2 B4 06  jp   nz,$06b4
06AB: 3A 92 21  ld   a,($2192)
06AE: F6 20     or   $20
06B0: 32 92 21  ld   ($2192),a
06B3: C9        ret

06B4: 21 92 21  ld   hl,$2192
06B7: 3E 05     ld   a,$05
06B9: CD EE 03  call $03ee
06BC: C8        ret  z
06BD: CD E1 03  call $03e1
06C0: 3A 7A 23  ld   a,($237a)
06C3: FE 99     cp   $99
06C5: C8        ret  z
06C6: 21 C5 21  ld   hl,$21c5
06C9: 3E 03     ld   a,$03
06CB: CD D6 03  call $03d6
06CE: 3E 09     ld   a,$09
06D0: 32 AB 21  ld   ($21ab),a
06D3: 3E 06     ld   a,$06
06D5: 21 76 23  ld   hl,$2376
06D8: CD E1 03  call $03e1
06DB: 21 96 23  ld   hl,$2396
06DE: CD E1 03  call $03e1
06E1: 21 B6 23  ld   hl,$23b6
06E4: CD E1 03  call $03e1
06E7: 06 00     ld   b,$00
06E9: CD 81 1D  call $1d81
06EC: 3A 7A 23  ld   a,($237a)
06EF: 3C        inc  a
06F0: 27        daa
06F1: 32 7A 23  ld   ($237a),a
06F4: 32 9A 23  ld   ($239a),a
06F7: 32 BA 23  ld   ($23ba),a
06FA: 21 41 13  ld   hl,$1341 ' sound
06FD: CD 61 12  call $1261
0700: 21 4A 22  ld   hl,$224a
0703: 35        dec  (hl)
0704: C0        ret  nz
0705: 36 64     ld   (hl),$64
0707: CD AA 1F  call $1faa
070A: C9        ret

070B: 21 C5 21  ld   hl,$21c5
070E: 3E 03     ld   a,$03
0710: CD EE 03  call $03ee
0713: CA 21 07  jp   z,$0721
0716: CD E1 03  call $03e1
0719: 3E 09     ld   a,$09
071B: 32 AB 21  ld   ($21ab),a
071E: C3 1E 06  jp   $061e

0721: 3A 94 21  ld   a,($2194)
0724: E6 BB     and  $bb
0726: 32 94 21  ld   ($2194),a
0729: C3 1E 06  jp   $061e

072C: AA 0B -> 0BAA
      06 12 -> 1206
      CE 07 -> 07CE
      1E 06 -> 061E
      2A 0A -> 0A2A
      70 0A -> 0A70
      4C 05 -> 054C
      AD 05 -> 05AD
      A4 08 -> 08A4
      02 19 -> 1902
      D7 1A -> 1AD7
      84 05 -> 0584
      62 1A -> 1A62
      D5 14 -> 14D5
      BE 0A -> 0ABE
      8F 0B -> 0B8F
      AE 0C -> 0CAE
      70 08 -> 0870
      2D 09 -> 092D
      1E 06 -> 061E
      0B 07 -> 070B
      66 1D -> 1D66
      F3 07 -> 07F3
      CD 18 -> 18CD
      9D 0D -> 0D9D
      1E 06 -> 061E

0760: 11 00 00  ld   de,$0000
0763: C3 8F 07  jp   $078f

0766: 11 01 00  ld   de,$0001
0769: C3 8F 07  jp   $078f

076C: 11 02 00  ld   de,$0002
076F: C3 8F 07  jp   $078f

0772: 11 03 00  ld   de,$0003
0775: C3 8F 07  jp   $078f

0778: 11 04 00  ld   de,$0004
077B: C3 8F 07  jp   $078f

077E: 11 05 00  ld   de,$0005
0781: C3 8F 07  jp   $078f

0784: 3A 91 21  ld   a,($2191)
0787: F6 20     or   $20
0789: 32 91 21  ld   ($2191),a
078C: C3 82 03  jp   $0382

078F: 21 06 08  ld   hl,$0806
0792: 19        add  hl,de
0793: 7E        ld   a,(hl)
0794: EB        ex   de,hl
0795: 29        add  hl,hl
0796: EB        ex   de,hl
0797: 21 0D 08  ld   hl,$080d
079A: 19        add  hl,de
079B: 46        ld   b,(hl)
079C: 23        inc  hl
079D: 66        ld   h,(hl)
079E: 68        ld   l,b
079F: CD D6 03  call $03d6
07A2: 3E 09     ld   a,$09
07A4: 32 99 21  ld   ($2199),a
07A7: 3A C3 21  ld   a,($21c3)
07AA: 2F        cpl
07AB: D3 06     out  ($06),a
07AD: 3A C4 21  ld   a,($21c4)
07B0: 2F        cpl
07B1: D3 07     out  ($07),a
07B3: 21 1B 08  ld   hl,$081b
07B6: 19        add  hl,de
07B7: 46        ld   b,(hl)
07B8: 23        inc  hl
07B9: 66        ld   h,(hl)
07BA: 68        ld   l,b
07BB: D5        push de
07BC: CD 61 12  call $1261
07BF: D1        pop  de
07C0: 21 29 08  ld   hl,$0829
07C3: 19        add  hl,de
07C4: 46        ld   b,(hl)
07C5: 23        inc  hl
07C6: 66        ld   h,(hl)
07C7: 68        ld   l,b
07C8: CD 92 02  call $0292
07CB: C3 82 03  jp   $0382

07CE: 3A C3 21  ld   a,($21c3)
07D1: E6 30     and  $30
07D3: 32 C3 21  ld   ($21c3),a
07D6: 2F        cpl
07D7: D3 06     out  ($06),a
07D9: 3A C4 21  ld   a,($21c4)
07DC: E6 20     and  $20
07DE: 32 C4 21  ld   ($21c4),a
07E1: 2F        cpl
07E2: D3 07     out  ($07),a
07E4: 3A AD 21  ld   a,($21ad)
07E7: B7        or   a
07E8: C2 1E 06  jp   nz,$061e
07EB: 3E 06     ld   a,$06
07ED: 32 AD 21  ld   ($21ad),a
07F0: C3 1E 06  jp   $061e

07F3: 21 90 21  ld   hl,$2190
07F6: 3E 02     ld   a,$02
07F8: CD EE 03  call $03ee
07FB: C2 1E 06  jp   nz,$061e
07FE: 3E 80     ld   a,$80
0800: 32 93 21  ld   ($2193),a
0803: C3 1E 06  jp   $061e

0806: 03 00 01 02 03 04 02

080D: C3 21 -> 21C3
      C4 21 -> 21C4
      C4 21 -> 21C4
      C3 21 -> 21C3
      C4 21 -> 21C4
      C4 21 -> 21C4
      C4 21 -> 21C4

081B: AD 12 -> 12AD ' sound
      B0 12 -> 12B0 ' sound
      B3 12 -> 12B3 ' sound
      B6 12 -> 12B6 ' sound
      B9 12 -> 12B9 ' sound
      BC 12 -> 12BC ' sound
      BF 12 -> 12BF ' sound

0829: 55 11 -> 1155 ' 25 pts
      59 11 -> 1159 ' 50 pts
      5D 11 -> 115D ' 100 pts
      51 11 -> 1151 ' 10 pts
      4D 11 -> 114D ' 1 pt
      4D 11 -> 114D ' 1 pt
      49 11 -> 1149 ' no score

0837: 3A C3 21  ld   a,($21c3)
083A: F6 10     or   $10
083C: 32 C3 21  ld   ($21c3),a
083F: 2F        cpl
0840: D3 06     out  ($06),a
0842: 3E 09     ld   a,$09
0844: 32 A8 21  ld   ($21a8),a
0847: 21 90 21  ld   hl,$2190
084A: 3E 05     ld   a,$05
084C: CD EE 03  call $03ee
084F: C2 82 03  jp   nz,$0382
0852: 21 4E 13  ld   hl,$134e ' sound
0855: CD 61 12  call $1261
0858: 3E 04     ld   a,$04
085A: 32 22 22  ld   ($2222),a
085D: 21 91 21  ld   hl,$2191
0860: 3E 00     ld   a,$00
0862: CD EE 03  call $03ee
0865: CA 82 03  jp   z,$0382
0868: 3E 7D     ld   a,$7d
086A: 32 9F 21  ld   ($219f),a
086D: C3 82 03  jp   $0382

0870: 21 C3 21  ld   hl,$21c3
0873: 3E 04     ld   a,$04
0875: CD EE 03  call $03ee
0878: C2 91 08  jp   nz,$0891
087B: 21 90 21  ld   hl,$2190
087E: 3E 02     ld   a,$02
0880: CD EE 03  call $03ee
0883: C2 1E 06  jp   nz,$061e
0886: 3E 04     ld   a,$04
0888: 21 94 21  ld   hl,$2194
088B: CD E1 03  call $03e1
088E: C3 1E 06  jp   $061e

0891: 3A C3 21  ld   a,($21c3)
0894: E6 2F     and  $2f
0896: 32 C3 21  ld   ($21c3),a
0899: 2F        cpl
089A: D3 06     out  ($06),a
089C: 3E 06     ld   a,$06
089E: 32 A8 21  ld   ($21a8),a
08A1: C3 1E 06  jp   $061e

08A4: 3A 91 21  ld   a,($2191)
08A7: E6 01     and  $01
08A9: CA BC 08  jp   z,$08bc
08AC: 3A C3 21  ld   a,($21c3)
08AF: F6 30     or   $30
08B1: 32 C3 21  ld   ($21c3),a
08B4: 3E 09     ld   a,$09
08B6: 32 A8 21  ld   ($21a8),a
08B9: 32 A9 21  ld   ($21a9),a
08BC: 3E 71     ld   a,$71
08BE: 32 9F 21  ld   ($219f),a
08C1: 3A 1F 22  ld   a,($221f)
08C4: 3D        dec  a
08C5: 32 1F 22  ld   ($221f),a
08C8: C2 1E 06  jp   nz,$061e
08CB: 3E 3C     ld   a,$3c
08CD: 32 1F 22  ld   ($221f),a
08D0: 3A 20 22  ld   a,($2220)
08D3: 3C        inc  a
08D4: 27        daa
08D5: 32 20 22  ld   ($2220),a
08D8: FE 60     cp   $60
08DA: C2 1E 06  jp   nz,$061e
08DD: 3E 00     ld   a,$00
08DF: 32 20 22  ld   ($2220),a
08E2: 3A 21 22  ld   a,($2221)
08E5: 3C        inc  a
08E6: 27        daa
08E7: 32 21 22  ld   ($2221),a
08EA: 3A 22 22  ld   a,($2222)
08ED: 3D        dec  a
08EE: 32 22 22  ld   ($2222),a
08F1: C2 1E 06  jp   nz,$061e
08F4: CD AA 1F  call $1faa
08F7: 3E 64     ld   a,$64
08F9: 32 4A 22  ld   ($224a),a
08FC: 3E 04     ld   a,$04
08FE: 32 22 22  ld   ($2222),a
0901: 3E 00     ld   a,$00
0903: 32 9F 21  ld   ($219f),a
0906: C3 1E 06  jp   $061e

0909: 3A C3 21  ld   a,($21c3)
090C: F6 20     or   $20
090E: 32 C3 21  ld   ($21c3),a
0911: 2F        cpl
0912: D3 06     out  ($06),a
0914: 3E 09     ld   a,$09
0916: 32 A9 21  ld   ($21a9),a
0919: 21 90 21  ld   hl,$2190
091C: 3E 05     ld   a,$05
091E: CD EE 03  call $03ee
0921: C2 82 03  jp   nz,$0382
0924: 21 4E 13  ld   hl,$134e ' sound
0927: CD 61 12  call $1261
092A: C3 82 03  jp   $0382

092D: 21 C3 21  ld   hl,$21c3
0930: 3E 05     ld   a,$05
0932: CD EE 03  call $03ee
0935: C2 4E 09  jp   nz,$094e
0938: 21 90 21  ld   hl,$2190
093B: 3E 02     ld   a,$02
093D: CD EE 03  call $03ee
0940: C2 1E 06  jp   nz,$061e
0943: 21 94 21  ld   hl,$2194
0946: 3E 05     ld   a,$05
0948: CD E1 03  call $03e1
094B: C3 1E 06  jp   $061e

094E: 3A C3 21  ld   a,($21c3)
0951: E6 1F     and  $1f
0953: 32 C3 21  ld   ($21c3),a
0956: 2F        cpl
0957: D3 06     out  ($06),a
0959: 3E 06     ld   a,$06
095B: 32 A9 21  ld   ($21a9),a
095E: C3 1E 06  jp   $061e

0961: 06 24     ld   b,$24
0963: 0E 00     ld   c,$00
0965: C3 99 09  jp   $0999

0968: 06 03     ld   b,$03
096A: 0E 01     ld   c,$01
096C: C3 99 09  jp   $0999

096F: 06 0B     ld   b,$0b
0971: 0E 02     ld   c,$02
0973: C3 99 09  jp   $0999

0976: 06 13     ld   b,$13
0978: 0E 03     ld   c,$03
097A: C3 99 09  jp   $0999

097D: 06 29     ld   b,$29
097F: 0E 04     ld   c,$04
0981: C3 99 09  jp   $0999

0984: 3E 04     ld   a,$04
0986: 32 97 21  ld   ($2197),a
0989: 21 08 22  ld   hl,$2208
098C: 3E FF     ld   a,$ff
098E: 86        add  a,(hl)
098F: D2 AE 09  jp   nc,$09ae
0992: 77        ld   (hl),a
0993: CA DF 0B  jp   z,$0bdf
0996: C3 19 14  jp   $1419

0999: 21 08 22  ld   hl,$2208
099C: 3E FF     ld   a,$ff
099E: 86        add  a,(hl)
099F: D2 AE 09  jp   nc,$09ae
09A2: 77        ld   (hl),a
09A3: CA BB 09  jp   z,$09bb
09A6: 3E 04     ld   a,$04
09A8: 32 97 21  ld   ($2197),a
09AB: C3 19 14  jp   $1419

09AE: 3E 64     ld   a,$64
09B0: 32 08 22  ld   ($2208),a
09B3: 3E 04     ld   a,$04
09B5: 32 97 21  ld   ($2197),a
09B8: C3 19 14  jp   $1419

09BB: 21 90 21  ld   hl,$2190
09BE: 3E 07     ld   a,$07
09C0: CD D6 03  call $03d6
09C3: 3E 02     ld   a,$02
09C5: CD EE 03  call $03ee
09C8: CA DA 09  jp   z,$09da
09CB: 79        ld   a,c
09CC: CD 6F 0B  call $0b6f
09CF: CD D6 03  call $03d6
09D2: 3E 06     ld   a,$06
09D4: 32 A6 21  ld   ($21a6),a
09D7: C3 19 14  jp   $1419

09DA: CD 81 1D  call $1d81
09DD: 79        ld   a,c
09DE: 21 C7 21  ld   hl,$21c7
09E1: CD EE 03  call $03ee
09E4: CA 52 0B  jp   z,$0b52
09E7: CD E1 03  call $03e1
09EA: 21 11 22  ld   hl,$2211
09ED: BE        cp   (hl)
09EE: 21 92 21  ld   hl,$2192
09F1: 3E 01     ld   a,$01
09F3: C2 FC 09  jp   nz,$09fc
09F6: CD D6 03  call $03d6
09F9: C3 FF 09  jp   $09ff

09FC: CD E1 03  call $03e1

09FF: 79        ld   a,c
0A00: CD 6F 0B  call $0b6f
0A03: CD 9C 1D  call $1d9c
0A06: CA 14 0A  jp   z,$0a14
0A09: EB        ex   de,hl
0A0A: 19        add  hl,de
0A0B: CD EE 03  call $03ee
0A0E: EB        ex   de,hl
0A0F: 3E 01     ld   a,$01
0A11: CA 24 0A  jp   z,$0a24
0A14: CD 91 1D  call $1d91
0A17: 21 E3 12  ld   hl,$12e3 ' sound
0A1A: CD 61 12  call $1261
0A1D: 3E C8     ld   a,$c8
0A1F: 32 08 22  ld   ($2208),a
0A22: 3E 5A     ld   a,$5a
0A24: 32 9B 21  ld   ($219b),a
0A27: C3 19 14  jp   $1419

0A2A: 21 D5 0B  ld   hl,$0bd5
0A2D: 3A C8 21  ld   a,($21c8)
0A30: 87        add  a,a
0A31: 16 00     ld   d,$00
0A33: 5F        ld   e,a
0A34: 19        add  hl,de
0A35: 7E        ld   a,(hl)
0A36: 23        inc  hl
0A37: 66        ld   h,(hl)
0A38: 6F        ld   l,a
0A39: CD 5C 0E  call $0e5c
0A3C: 21 DD 12  ld   hl,$12dd ' sound
0A3F: CD 61 12  call $1261
0A42: 21 92 21  ld   hl,$2192
0A45: 3E 01     ld   a,$01
0A47: CD EE 03  call $03ee
0A4A: CA 93 0A  jp   z,$0a93
0A4D: CD E1 03  call $03e1
0A50: 21 91 21  ld   hl,$2191
0A53: 3E 01     ld   a,$01
0A55: CD EE 03  call $03ee
0A58: CA 93 0A  jp   z,$0a93
0A5B: CD E1 03  call $03e1
0A5E: 3E FA     ld   a,$fa
0A60: 32 08 22  ld   ($2208),a
0A63: 3E 05     ld   a,$05
0A65: 32 1A 22  ld   ($221a),a
0A68: 3E 28     ld   a,$28
0A6A: 32 9C 21  ld   ($219c),a
0A6D: C3 1E 06  jp   $061e

0A70: 21 71 11  ld   hl,$1171 ' 5,000 pts
0A73: CD 5C 0E  call $0e5c
0A76: 21 35 13  ld   hl,$1335 ' sound
0A79: CD 61 12  call $1261
0A7C: 3A 1A 22  ld   a,($221a)
0A7F: 3D        dec  a
0A80: 32 1A 22  ld   ($221a),a
0A83: CA 93 0A  jp   z,$0a93
0A86: 3E 28     ld   a,$28
0A88: 32 9C 21  ld   ($219c),a
0A8B: 3E FA     ld   a,$fa
0A8D: 32 08 22  ld   ($2208),a
0A90: C3 1E 06  jp   $061e

0A93: 3A C7 21  ld   a,($21c7)
0A96: FE 00     cp   $00
0A98: CA AC 0A  jp   z,$0aac
0A9B: 2A 09 22  ld   hl,($2209)
0A9E: 3A 0B 22  ld   a,($220b)
0AA1: CD D6 03  call $03d6
0AA4: 3E 06     ld   a,$06
0AA6: 32 A6 21  ld   ($21a6),a
0AA9: C3 1E 06  jp   $061e

0AAC: 3E 3C     ld   a,$3c
0AAE: 32 A5 21  ld   ($21a5),a
0AB1: 3E 64     ld   a,$64
0AB3: 32 08 22  ld   ($2208),a
0AB6: 3E 00     ld   a,$00
0AB8: 32 07 22  ld   ($2207),a
0ABB: C3 1E 06  jp   $061e

0ABE: 97        sub  a
0ABF: 32 08 22  ld   ($2208),a
0AC2: 3A 07 22  ld   a,($2207)
0AC5: 3C        inc  a
0AC6: 32 07 22  ld   ($2207),a
0AC9: FE 06     cp   $06
0ACB: CA EC 0A  jp   z,$0aec
0ACE: 16 00     ld   d,$00
0AD0: 5F        ld   e,a
0AD1: 21 B9 0B  ld   hl,$0bb9
0AD4: 19        add  hl,de
0AD5: 46        ld   b,(hl)
0AD6: CD 76 1D  call $1d76
0AD9: 21 DD 12  ld   hl,$12dd ' sound
0ADC: CD 61 12  call $1261
0ADF: 3E 0F     ld   a,$0f
0AE1: 32 A5 21  ld   ($21a5),a
0AE4: 3E 64     ld   a,$64
0AE6: 32 08 22  ld   ($2208),a
0AE9: C3 1E 06  jp   $061e

0AEC: 2A 09 22  ld   hl,($2209)
0AEF: 3A 0B 22  ld   a,($220b)
0AF2: CD D6 03  call $03d6
0AF5: 3E 06     ld   a,$06
0AF7: 32 A6 21  ld   ($21a6),a
0AFA: 3E 1F     ld   a,$1f
0AFC: 32 C7 21  ld   ($21c7),a
0AFF: 3A 46 22  ld   a,($2246)
0B02: 87        add  a,a
0B03: 87        add  a,a
0B04: 87        add  a,a
0B05: 87        add  a,a
0B06: 47        ld   b,a
0B07: 3A BE 23  ld   a,($23be)
0B0A: A0        and  b
0B0B: C2 26 0B  jp   nz,$0b26
0B0E: 21 90 21  ld   hl,$2190
0B11: 3E 03     ld   a,$03
0B13: CD EE 03  call $03ee
0B16: C2 26 0B  jp   nz,$0b26
0B19: 06 31     ld   b,$31
0B1B: CD 9C 1D  call $1d9c
0B1E: C2 26 0B  jp   nz,$0b26
0B21: 06 09     ld   b,$09
0B23: CD 76 1D  call $1d76
0B26: 3A C8 21  ld   a,($21c8)
0B29: 3C        inc  a
0B2A: FE 05     cp   $05
0B2C: CA 44 0B  jp   z,$0b44
0B2F: 32 C8 21  ld   ($21c8),a
0B32: 16 00     ld   d,$00
0B34: 5F        ld   e,a
0B35: 21 BE 0B  ld   hl,$0bbe
0B38: 19        add  hl,de
0B39: 46        ld   b,(hl)
0B3A: E5        push hl
0B3B: CD 76 1D  call $1d76
0B3E: E1        pop  hl
0B3F: 2B        dec  hl
0B40: 46        ld   b,(hl)
0B41: CD 81 1D  call $1d81
0B44: 21 91 21  ld   hl,$2191
0B47: 3E 01     ld   a,$01
0B49: CD EE 03  call $03ee
0B4C: C4 02 04  call nz,$0402
0B4F: C3 1E 06  jp   $061e

0B52: CD 6F 0B  call $0b6f
0B55: CD D6 03  call $03d6
0B58: 3E 06     ld   a,$06
0B5A: 32 A6 21  ld   ($21a6),a
0B5D: CD 9C 1D  call $1d9c
0B60: C2 19 14  jp   nz,$1419
0B63: CD 76 1D  call $1d76
0B66: 21 E0 12  ld   hl,$12e0 ' sound
0B69: CD 61 12  call $1261
0B6C: C3 19 14  jp   $1419

0B6F: 16 00     ld   d,$00
0B71: 5F        ld   e,a
0B72: 21 C3 0B  ld   hl,$0bc3
0B75: 19        add  hl,de
0B76: 46        ld   b,(hl)
0B77: 21 C8 0B  ld   hl,$0bc8
0B7A: 19        add  hl,de
0B7B: 87        add  a,a
0B7C: 5F        ld   e,a
0B7D: 7E        ld   a,(hl)
0B7E: 32 0B 22  ld   ($220b),a
0B81: 4F        ld   c,a
0B82: 21 CD 0B  ld   hl,$0bcd
0B85: 19        add  hl,de
0B86: 7E        ld   a,(hl)
0B87: 23        inc  hl
0B88: 66        ld   h,(hl)
0B89: 6F        ld   l,a
0B8A: 22 09 22  ld   ($2209),hl
0B8D: 79        ld   a,c
0B8E: C9        ret

0B8F: 3E 00     ld   a,$00
0B91: 32 C2 21  ld   ($21c2),a
0B94: 3A C4 21  ld   a,($21c4)
0B97: E6 1F     and  $1f
0B99: 32 C4 21  ld   ($21c4),a
0B9C: 2F        cpl
0B9D: D3 07     out  ($07),a
0B9F: 21 C5 21  ld   hl,$21c5
0BA2: 3E 01     ld   a,$01
0BA4: CD E1 03  call $03e1
0BA7: C3 1E 06  jp   $061e

0BAA: 3E 00     ld   a,$00
0BAC: 32 08 22  ld   ($2208),a
0BAF: 21 92 21  ld   hl,$2192
0BB2: 3E 03     ld   a,$03
0BB4: CD E1 03  call $03e1
0BB7: C3 1E 06  jp   $061e

0BB9: 06 24 03 0B 13

0BBE: 29 23 1C 1B 12

0BC3: 2B 2C 04 0C 14

0BC8: 03 05 02 00 01

0BCD: C2 21 -> 21C2
      C4 21 -> 21C4
      C2 21 -> 21C2
      C2 21 -> 21C2

0BD5: C2 21 -> 21C2
      69 11 -> 1169 ' 2,000 pts
      6D 11 -> 116D ' 4,000 pts
      75 11 -> 1175 ' 6,000 pts
      79 11 -> 1179 ' 8,000 pts

0BDF: 06 39     ld   b,$39
0BE1: CD 9C 1D  call $1d9c
0BE4: CA 4D 0D  jp   z,$0d4d
0BE7: 21 90 21  ld   hl,$2190
0BEA: 3E 02     ld   a,$02
0BEC: CD EE 03  call $03ee
0BEF: C2 4D 0D  jp   nz,$0d4d
0BF2: 3A 0C 22  ld   a,($220c)
0BF5: E6 03     and  $03
0BF7: C2 A6 0C  jp   nz,$0ca6
0BFA: 21 5B 23  ld   hl,$235b
0BFD: 11 0D 22  ld   de,$220d
0C00: 3E 06     ld   a,$06
0C02: CD CF 0E  call $0ecf
0C05: 06 38     ld   b,$38
0C07: CD 9C 1D  call $1d9c
0C0A: CA 12 0C  jp   z,$0c12
0C0D: 3E 03     ld   a,$03
0C0F: C3 21 0C  jp   $0c21

0C12: 06 11     ld   b,$11
0C14: CD 9C 1D  call $1d9c
0C17: CA 1F 0C  jp   z,$0c1f
0C1A: 3E 02     ld   a,$02
0C1C: C3 21 0C  jp   $0c21

0C1F: 3E 01     ld   a,$01

0C21: 32 0C 22  ld   ($220c),a
0C24: 06 31     ld   b,$31
0C26: CD 9C 1D  call $1d9c
0C29: CA A6 0C  jp   z,$0ca6
0C2C: 06 31     ld   b,$31
0C2E: CD 81 1D  call $1d81
0C31: 06 09     ld   b,$09
0C33: CD 81 1D  call $1d81
0C36: 21 21 13  ld   hl,$1321 ' sound
0C39: CD 61 12  call $1261
0C3C: 21 8A 23  ld   hl,$238a
0C3F: 3A BE 23  ld   a,($23be)
0C42: E6 F0     and  $f0
0C44: 4F        ld   c,a
0C45: 1E 04     ld   e,$04
0C47: 06 4F     ld   b,$4f
0C49: FE 80     cp   $80
0C4B: CA 77 0C  jp   z,$0c77
0C4E: 23        inc  hl
0C4F: 1E 03     ld   e,$03
0C51: 06 03     ld   b,$03
0C53: 7E        ld   a,(hl)
0C54: E6 F0     and  $f0
0C56: B0        or   b
0C57: 47        ld   b,a
0C58: 79        ld   a,c
0C59: FE 40     cp   $40
0C5B: CA 77 0C  jp   z,$0c77
0C5E: 1E 02     ld   e,$02
0C60: 06 20     ld   b,$20
0C62: 7E        ld   a,(hl)
0C63: E6 0F     and  $0f
0C65: B0        or   b
0C66: 47        ld   b,a
0C67: 79        ld   a,c
0C68: FE 20     cp   $20
0C6A: CA 77 0C  jp   z,$0c77
0C6D: 23        inc  hl
0C6E: 1E 01     ld   e,$01
0C70: 06 01     ld   b,$01
0C72: 7E        ld   a,(hl)
0C73: E6 F0     and  $f0
0C75: B0        or   b
0C76: 47        ld   b,a
0C77: 70        ld   (hl),b
0C78: 16 00     ld   d,$00
0C7A: D5        push de
0C7B: 11 20 00  ld   de,$0020
0C7E: 19        add  hl,de
0C7F: 70        ld   (hl),b
0C80: 79        ld   a,c
0C81: 07        rlca
0C82: 07        rlca
0C83: 07        rlca
0C84: 07        rlca
0C85: 4F        ld   c,a
0C86: 3A 46 22  ld   a,($2246)
0C89: B1        or   c
0C8A: 32 46 22  ld   ($2246),a
0C8D: 21 28 22  ld   hl,$2228
0C90: D1        pop  de
0C91: 19        add  hl,de
0C92: 73        ld   (hl),e
0C93: 21 96 23  ld   hl,$2396
0C96: 3E 05     ld   a,$05
0C98: CD D6 03  call $03d6
0C9B: 21 B6 23  ld   hl,$23b6
0C9E: CD D6 03  call $03d6
0CA1: 3E FA     ld   a,$fa
0CA3: C3 A8 0C  jp   $0ca8

0CA6: 3E 3C     ld   a,$3c

0CA8: 32 A7 21  ld   ($21a7),a
0CAB: C3 19 14  jp   $1419

0CAE: 3A 49 23  ld   a,($2349)
0CB1: 47        ld   b,a
0CB2: 3A EE 23  ld   a,($23ee)
0CB5: 90        sub  b
0CB6: FA C4 0C  jp   m,$0cc4
0CB9: 3A 94 21  ld   a,($2194)
0CBC: E6 FD     and  $fd
0CBE: 32 94 21  ld   ($2194),a
0CC1: C3 1E 06  jp   $061e

0CC4: 3E 00     ld   a,$00
0CC6: 32 97 21  ld   ($2197),a
0CC9: 3A 94 21  ld   a,($2194)
0CCC: F6 02     or   $02
0CCE: 32 94 21  ld   ($2194),a
0CD1: 21 90 21  ld   hl,$2190
0CD4: 3E 00     ld   a,$00
0CD6: CD EE 03  call $03ee
0CD9: C2 29 0D  jp   nz,$0d29
0CDC: 21 65 11  ld   hl,$1165 ' 1,000 pts
0CDF: CD 99 0E  call $0e99
0CE2: DA F9 0C  jp   c,$0cf9
0CE5: 21 65 11  ld   hl,$1165 ' 1,000 pts
0CE8: CD 92 02  call $0292
0CEB: 3E 0A     ld   a,$0a
0CED: 32 A7 21  ld   ($21a7),a
0CF0: 21 32 13  ld   hl,$1332 ' sound
0CF3: CD 61 12  call $1261
0CF6: C3 1E 06  jp   $061e

0CF9: 21 65 11  ld   hl,$1165 ' 1,000 pts
0CFC: CD 5C 0E  call $0e5c
0CFF: 21 5B 23  ld   hl,$235b
0D02: CD 3C 0F  call $0f3c
0D05: 21 5B 23  ld   hl,$235b
0D08: CD 99 0E  call $0e99
0D0B: 21 0C 22  ld   hl,$220c
0D0E: 35        dec  (hl)
0D0F: CA 29 0D  jp   z,$0d29
0D12: FA 29 0D  jp   m,$0d29
0D15: 21 0D 22  ld   hl,$220d
0D18: CD 6F 0E  call $0e6f
0D1B: 3E 3C     ld   a,$3c
0D1D: 32 A7 21  ld   ($21a7),a
0D20: 21 35 13  ld   hl,$1335 ' sound

0D23: CD 61 12  call $1261
0D26: C3 1E 06  jp   $061e

0D29: 21 C5 21  ld   hl,$21c5
0D2C: 7E        ld   a,(hl)
0D2D: F6 02     or   $02
0D2F: 77        ld   (hl),a
0D30: 3E 09     ld   a,$09
0D32: 32 A6 21  ld   ($21a6),a
0D35: 06 39     ld   b,$39
0D37: CD 81 1D  call $1d81
0D3A: 3A 94 21  ld   a,($2194)
0D3D: E6 FD     and  $fd
0D3F: 32 94 21  ld   ($2194),a
0D42: 3E 00     ld   a,$00
0D44: 32 0C 22  ld   ($220c),a
0D47: 21 35 13  ld   hl,$1335 ' sound
0D4A: C3 23 0D  jp   $0d23

0D4D: 21 C5 21  ld   hl,$21c5
0D50: 3E 01     ld   a,$01
0D52: CD D6 03  call $03d6
0D55: 3E 06     ld   a,$06
0D57: 32 A6 21  ld   ($21a6),a
0D5A: C3 19 14  jp   $1419

0D5D: 3E 2B     ld   a,$2b
0D5F: C3 76 0D  jp   $0d76

0D62: 3E 2C     ld   a,$2c
0D64: C3 76 0D  jp   $0d76

0D67: 3E 04     ld   a,$04
0D69: C3 76 0D  jp   $0d76

0D6C: 3E 0C     ld   a,$0c
0D6E: C3 76 0D  jp   $0d76

0D71: 3E 14     ld   a,$14
0D73: C3 76 0D  jp   $0d76

0D76: 32 26 22  ld   ($2226),a
0D79: 3A 90 21  ld   a,($2190)
0D7C: E6 04     and  $04
0D7E: C2 19 14  jp   nz,$1419
0D81: 3A AF 21  ld   a,($21af)
0D84: B7        or   a
0D85: C2 95 0D  jp   nz,$0d95
0D88: 3A 91 21  ld   a,($2191)
0D8B: E6 DF     and  $df
0D8D: 32 91 21  ld   ($2191),a
0D90: 3E 80     ld   a,$80
0D92: 32 93 21  ld   ($2193),a
0D95: 3E 03     ld   a,$03
0D97: 32 AF 21  ld   ($21af),a
0D9A: C3 19 14  jp   $1419

0D9D: 3A 91 21  ld   a,($2191)
0DA0: E6 20     and  $20
0DA2: CA E1 0D  jp   z,$0de1
0DA5: 3A C4 21  ld   a,($21c4)
0DA8: F6 04     or   $04
0DAA: 32 C4 21  ld   ($21c4),a
0DAD: 3E 09     ld   a,$09
0DAF: 32 99 21  ld   ($2199),a
0DB2: 3A 26 22  ld   a,($2226)
0DB5: 47        ld   b,a
0DB6: CD 9C 1D  call $1d9c
0DB9: CA E1 0D  jp   z,$0de1
0DBC: CD 81 1D  call $1d81
0DBF: CA D1 0D  jp   z,$0dd1
0DC2: 21 65 11  ld   hl,$1165 ' 1,000 pts
0DC5: CD 92 02  call $0292
0DC8: 21 E0 12  ld   hl,$12e0 ' sound
0DCB: CD 61 12  call $1261
0DCE: C3 E1 0D  jp   $0de1

0DD1: 21 71 11  ld   hl,$1171 ' 5,000 pts
0DD4: CD 92 02  call $0292
0DD7: EB        ex   de,hl
0DD8: CD 5C 0E  call $0e5c
0DDB: 21 F2 12  ld   hl,$12f2 ' sound
0DDE: CD 61 12  call $1261

0DE1: 3A 91 21  ld   a,($2191)
0DE4: E6 DF     and  $df
0DE6: 32 91 21  ld   ($2191),a
0DE9: C3 1E 06  jp   $061e

0DEC: 11 F3 21  ld   de,$21f3
0DEF: B7        or   a
0DF0: F5        push af

0DF1: DE 02     sub  $02
0DF3: FA 0E 0E  jp   m,$0e0e
0DF6: 47        ld   b,a
0DF7: F1        pop  af
0DF8: 1A        ld   a,(de)
0DF9: 8E        adc  a,(hl)
0DFA: 27        daa
0DFB: 12        ld   (de),a
0DFC: F5        push af
0DFD: 78        ld   a,b
0DFE: B7        or   a
0DFF: C2 09 0E  jp   nz,$0e09
0E02: F1        pop  af
0E03: 3E 00     ld   a,$00
0E05: 8F        adc  a,a
0E06: 13        inc  de
0E07: 12        ld   (de),a
0E08: C9        ret

0E09: 23        inc  hl
0E0A: 13        inc  de
0E0B: C3 F1 0D  jp   $0df1

0E0E: 7E        ld   a,(hl)
0E0F: E6 0F     and  $0f
0E11: 47        ld   b,a
0E12: F1        pop  af
0E13: 1A        ld   a,(de)
0E14: 88        adc  a,b
0E15: 27        daa
0E16: 12        ld   (de),a
0E17: C9        ret

0E18: 0E 00     ld   c,$00
0E1A: B7        or   a
0E1B: 11 F3 21  ld   de,$21f3
0E1E: F5        push af

0E1F: DE 02     sub  $02
0E21: FA 3D 0E  jp   m,$0e3d
0E24: 47        ld   b,a
0E25: F1        pop  af
0E26: 3E 9A     ld   a,$9a
0E28: 9E        sbc  a,(hl)

0E29: EB        ex   de,hl
0E2A: 86        add  a,(hl)
0E2B: 27        daa
0E2C: 3F        ccf
0E2D: 77        ld   (hl),a
0E2E: F5        push af
0E2F: C2 4A 0E  jp   nz,$0e4a

0E32: 78        ld   a,b
0E33: B7        or   a
0E34: CA 4F 0E  jp   z,$0e4f
0E37: EB        ex   de,hl
0E38: 13        inc  de
0E39: 23        inc  hl
0E3A: C3 1F 0E  jp   $0e1f

0E3D: 7E        ld   a,(hl)
0E3E: E6 0F     and  $0f
0E40: 47        ld   b,a
0E41: F1        pop  af
0E42: 3E 9A     ld   a,$9a
0E44: 98        sbc  a,b
0E45: 06 00     ld   b,$00
0E47: C3 29 0E  jp   $0e29

0E4A: 0E FF     ld   c,$ff
0E4C: C3 32 0E  jp   $0e32

0E4F: 79        ld   a,c
0E50: B7        or   a
0E51: CA 58 0E  jp   z,$0e58
0E54: F1        pop  af
0E55: D8        ret  c
0E56: B1        or   c
0E57: C9        ret

0E58: F1        pop  af
0E59: E6 00     and  $00
0E5B: C9        ret

0E5C: 11 F3 21  ld   de,$21f3
0E5F: 3E 08     ld   a,$08
0E61: CD CF 0E  call $0ecf
0E64: 21 5B 23  ld   hl,$235b
0E67: 3E 08     ld   a,$08
0E69: CD EC 0D  call $0dec
0E6C: 21 F3 21  ld   hl,$21f3
0E6F: 11 5B 23  ld   de,$235b
0E72: 3E 08     ld   a,$08
0E74: CD CF 0E  call $0ecf
0E77: 21 5B 23  ld   hl,$235b
0E7A: 11 A0 23  ld   de,$23a0
0E7D: 3E 06     ld   a,$06
0E7F: CD EA 0E  call $0eea
0E82: 3A 90 21  ld   a,($2190)
0E85: E6 01     and  $01
0E87: C0        ret  nz
0E88: 21 A0 23  ld   hl,$23a0
0E8B: 11 80 23  ld   de,$2380
0E8E: 3E 06     ld   a,$06
0E90: CD CF 0E  call $0ecf
0E93: 06 39     ld   b,$39
0E95: CD 76 1D  call $1d76
0E98: C9        ret

0E99: E5        push hl
0E9A: 21 5B 23  ld   hl,$235b
0E9D: 11 F3 21  ld   de,$21f3
0EA0: 3E 08     ld   a,$08
0EA2: CD CF 0E  call $0ecf
0EA5: E1        pop  hl
0EA6: 3E 08     ld   a,$08
0EA8: CD 18 0E  call $0e18
0EAB: F5        push af
0EAC: 21 F3 21  ld   hl,$21f3
0EAF: 11 5B 23  ld   de,$235b
0EB2: 3E 08     ld   a,$08
0EB4: CD CF 0E  call $0ecf
0EB7: 21 5B 23  ld   hl,$235b
0EBA: 11 80 23  ld   de,$2380
0EBD: 3E 06     ld   a,$06
0EBF: CD EA 0E  call $0eea
0EC2: 21 80 23  ld   hl,$2380
0EC5: 11 A0 23  ld   de,$23a0
0EC8: 3E 06     ld   a,$06
0ECA: CD CF 0E  call $0ecf
0ECD: F1        pop  af
0ECE: C9        ret

0ECF: B7        or   a
0ED0: DE 02     sub  $02
0ED2: FA E0 0E  jp   m,$0ee0
0ED5: 47        ld   b,a
0ED6: 7E        ld   a,(hl)
0ED7: 12        ld   (de),a
0ED8: 23        inc  hl
0ED9: 13        inc  de
0EDA: 78        ld   a,b
0EDB: B7        or   a
0EDC: C2 D0 0E  jp   nz,$0ed0
0EDF: C9        ret

0EE0: 7E        ld   a,(hl)
0EE1: E6 0F     and  $0f
0EE3: 47        ld   b,a
0EE4: 1A        ld   a,(de)
0EE5: E6 F0     and  $f0
0EE7: B0        or   b
0EE8: 12        ld   (de),a
0EE9: C9        ret

0EEA: 0F        rrca
0EEB: F5        push af
0EEC: D2 F2 0E  jp   nc,$0ef2
0EEF: 3C        inc  a
0EF0: E6 7F     and  $7f
0EF2: 4F        ld   c,a
0EF3: 0D        dec  c
0EF4: 06 00     ld   b,$00
0EF6: 09        add  hl,bc
0EF7: EB        ex   de,hl
0EF8: 09        add  hl,bc
0EF9: EB        ex   de,hl
0EFA: F1        pop  af
0EFB: DA 14 0F  jp   c,$0f14
0EFE: 7E        ld   a,(hl)
0EFF: B7        or   a
0F00: CA 2A 0F  jp   z,$0f2a
0F03: E6 F0     and  $f0
0F05: 7E        ld   a,(hl)
0F06: C2 0B 0F  jp   nz,$0f0b
0F09: F6 F0     or   $f0

0F0B: 12        ld   (de),a
0F0C: 2B        dec  hl
0F0D: 1B        dec  de
0F0E: 7E        ld   a,(hl)
0F0F: 0D        dec  c
0F10: F2 0B 0F  jp   p,$0f0b
0F13: C9        ret

0F14: 1A        ld   a,(de)
0F15: E6 F0     and  $f0
0F17: 47        ld   b,a
0F18: 7E        ld   a,(hl)
0F19: E6 0F     and  $0f
0F1B: C2 34 0F  jp   nz,$0f34
0F1E: F6 0F     or   $0f
0F20: B0        or   b

0F21: 12        ld   (de),a
0F22: 2B        dec  hl
0F23: 1B        dec  de
0F24: 0D        dec  c
0F25: 7E        ld   a,(hl)
0F26: F2 FF 0E  jp   p,$0eff
0F29: C9        ret

0F2A: 79        ld   a,c
0F2B: 3D        dec  a
0F2C: FA 38 0F  jp   m,$0f38
0F2F: 3E FF     ld   a,$ff
0F31: C3 21 0F  jp   $0f21

0F34: B0        or   b
0F35: C3 0B 0F  jp   $0f0b

0F38: 3E F0     ld   a,$f0
0F3A: 12        ld   (de),a
0F3B: C9        ret

0F3C: 11 F3 21  ld   de,$21f3
0F3F: 3E 08     ld   a,$08
0F41: CD CF 0E  call $0ecf
0F44: 21 7E 23  ld   hl,$237e
0F47: 3E 04     ld   a,$04
0F49: CD EE 03  call $03ee
0F4C: C2 DD 10  jp   nz,$10dd
0F4F: 3C        inc  a
0F50: CD EE 03  call $03ee
0F53: C2 F4 10  jp   nz,$10f4
0F56: 3C        inc  a
0F57: CD EE 03  call $03ee
0F5A: C2 0B 11  jp   nz,$110b
0F5D: 21 93 23  ld   hl,$2393
0F60: E5        push hl
0F61: 21 73 23  ld   hl,$2373
0F64: E5        push hl
0F65: 21 6B 23  ld   hl,$236b
0F68: E5        push hl
0F69: 21 90 23  ld   hl,$2390
0F6C: E5        push hl
0F6D: 21 6F 23  ld   hl,$236f
0F70: E5        push hl

0F71: 3E 08     ld   a,$08
0F73: CD EC 0D  call $0dec
0F76: D1        pop  de
0F77: D5        push de
0F78: 21 F3 21  ld   hl,$21f3
0F7B: 3E 08     ld   a,$08
0F7D: CD CF 0E  call $0ecf
0F80: E1        pop  hl
0F81: D1        pop  de
0F82: D5        push de
0F83: 3E 06     ld   a,$06
0F85: CD EA 0E  call $0eea
0F88: D1        pop  de
0F89: D5        push de
0F8A: 21 20 00  ld   hl,$0020
0F8D: 19        add  hl,de
0F8E: EB        ex   de,hl
0F8F: 3E 06     ld   a,$06
0F91: CD CF 0E  call $0ecf
0F94: D1        pop  de
0F95: 3A F6 21  ld   a,($21f6)
0F98: E6 0F     and  $0f
0F9A: CA A5 0F  jp   z,$0fa5
0F9D: 21 89 11  ld   hl,$1189
0FA0: 3E 06     ld   a,$06
0FA2: CD CF 0E  call $0ecf
0FA5: 21 7E 23  ld   hl,$237e
0FA8: 3E 03     ld   a,$03
0FAA: CD EE 03  call $03ee
0FAD: C2 08 10  jp   nz,$1008
0FB0: E1        pop  hl
0FB1: E1        pop  hl
0FB2: E1        pop  hl
0FB3: 3A 7E 23  ld   a,($237e)
0FB6: E6 0F     and  $0f
0FB8: FE 03     cp   $03
0FBA: C0        ret  nz
0FBB: 21 63 23  ld   hl,$2363
0FBE: 11 F3 21  ld   de,$21f3
0FC1: 3E 07     ld   a,$07
0FC3: CD CF 0E  call $0ecf
0FC6: 21 6B 23  ld   hl,$236b
0FC9: 3E 07     ld   a,$07
0FCB: CD 18 0E  call $0e18
0FCE: F5        push af
0FCF: DC F4 0F  call c,$0ff4
0FD2: 21 F3 21  ld   hl,$21f3
0FD5: 11 77 23  ld   de,$2377
0FD8: D5        push de
0FD9: 3E 06     ld   a,$06
0FDB: CD CF 0E  call $0ecf
0FDE: E1        pop  hl
0FDF: E5        push hl
0FE0: 11 97 23  ld   de,$2397
0FE3: 3E 06     ld   a,$06
0FE5: CD EA 0E  call $0eea
0FE8: E1        pop  hl
0FE9: 11 B7 23  ld   de,$23b7
0FEC: 3E 06     ld   a,$06
0FEE: CD EA 0E  call $0eea
0FF1: C3 52 10  jp   $1052

0FF4: 21 6B 23  ld   hl,$236b
0FF7: 11 F3 21  ld   de,$21f3
0FFA: 3E 07     ld   a,$07
0FFC: CD CF 0E  call $0ecf
0FFF: 21 63 23  ld   hl,$2363
1002: 3E 07     ld   a,$07
1004: CD 18 0E  call $0e18
1007: C9        ret

1008: E1        pop  hl
1009: 3E 08     ld   a,$08
100B: CD EC 0D  call $0dec
100E: 21 F3 21  ld   hl,$21f3
1011: D1        pop  de
1012: D5        push de
1013: 3E 07     ld   a,$07
1015: CD CF 0E  call $0ecf
1018: E1        pop  hl
1019: D1        pop  de
101A: 21 67 23  ld   hl,$2367
101D: 11 F3 21  ld   de,$21f3
1020: 3E 07     ld   a,$07
1022: CD CF 0E  call $0ecf
1025: 21 73 23  ld   hl,$2373
1028: 3E 07     ld   a,$07
102A: CD 18 0E  call $0e18
102D: F5        push af
102E: DA 22 11  jp   c,$1122

1031: 21 F3 21  ld   hl,$21f3
1034: 11 77 23  ld   de,$2377
1037: 3E 06     ld   a,$06
1039: CD CF 0E  call $0ecf
103C: 21 77 23  ld   hl,$2377
103F: 11 97 23  ld   de,$2397
1042: 3E 06     ld   a,$06
1044: CD EA 0E  call $0eea
1047: 21 97 23  ld   hl,$2397
104A: 11 B7 23  ld   de,$23b7
104D: 3E 06     ld   a,$06
104F: CD CF 0E  call $0ecf

1052: 3A F6 21  ld   a,($21f6)
1055: E6 0F     and  $0f
1057: CA 65 10  jp   z,$1065
105A: 21 89 11  ld   hl,$1189
105D: 11 97 23  ld   de,$2397
1060: 3E 06     ld   a,$06
1062: CD CF 0E  call $0ecf
1065: F1        pop  af
1066: CA B5 10  jp   z,$10b5
1069: DA A1 10  jp   c,$10a1
106C: 21 6A 23  ld   hl,$236a
106F: 3E 04     ld   a,$04
1071: CD EE 03  call $03ee
1074: CA 78 10  jp   z,$1078
1077: C9        ret

1078: CD D6 03  call $03d6
107B: 3E 05     ld   a,$05

107D: CD E1 03  call $03e1
1080: E5        push hl
1081: C5        push bc
1082: 21 16 13  ld   hl,$1316 ' sound
1085: CD 61 12  call $1261
1088: 21 A7 21  ld   hl,$21a7
108B: 7E        ld   a,(hl)
108C: B7        or   a
108D: CA 92 10  jp   z,$1092
1090: 36 7D     ld   (hl),$7d
1092: 21 AE 21  ld   hl,$21ae
1095: 7E        ld   a,(hl)
1096: B7        or   a
1097: CA 9C 10  jp   z,$109c
109A: 36 7D     ld   (hl),$7d
109C: C1        pop  bc
109D: E1        pop  hl
109E: C3 38 11  jp   $1138

10A1: 21 6A 23  ld   hl,$236a
10A4: 3E 05     ld   a,$05
10A6: CD EE 03  call $03ee
10A9: CA AD 10  jp   z,$10ad
10AC: C9        ret

10AD: CD D6 03  call $03d6
10B0: 3E 04     ld   a,$04
10B2: C3 7D 10  jp   $107d

10B5: 21 6A 23  ld   hl,$236a
10B8: 3E 04     ld   a,$04
10BA: CD E1 03  call $03e1
10BD: 3E 05     ld   a,$05
10BF: CD E1 03  call $03e1
10C2: E5        push hl
10C3: 21 85 11  ld   hl,$1185
10C6: 11 97 23  ld   de,$2397
10C9: 3E 06     ld   a,$06
10CB: CD CF 0E  call $0ecf
10CE: 21 85 11  ld   hl,$1185
10D1: 11 B7 23  ld   de,$23b7
10D4: 3E 06     ld   a,$06
10D6: CD CF 0E  call $0ecf
10D9: E1        pop  hl
10DA: C3 38 11  jp   $1138

10DD: 21 89 23  ld   hl,$2389
10E0: E5        push hl
10E1: 21 67 23  ld   hl,$2367
10E4: E5        push hl
10E5: 21 5F 23  ld   hl,$235f
10E8: E5        push hl
10E9: 21 86 23  ld   hl,$2386
10EC: E5        push hl
10ED: 21 63 23  ld   hl,$2363
10F0: E5        push hl
10F1: C3 71 0F  jp   $0f71

10F4: 21 93 23  ld   hl,$2393
10F7: E5        push hl
10F8: 21 73 23  ld   hl,$2373
10FB: E5        push hl
10FC: 21 6F 23  ld   hl,$236f
10FF: E5        push hl
1100: 21 8D 23  ld   hl,$238d
1103: E5        push hl
1104: 21 6B 23  ld   hl,$236b
1107: E5        push hl
1108: C3 71 0F  jp   $0f71

110B: 21 89 23  ld   hl,$2389
110E: E5        push hl
110F: 21 67 23  ld   hl,$2367
1112: E5        push hl
1113: 21 63 23  ld   hl,$2363
1116: E5        push hl
1117: 21 83 23  ld   hl,$2383
111A: E5        push hl
111B: 21 5F 23  ld   hl,$235f
111E: E5        push hl
111F: C3 71 0F  jp   $0f71

1122: 21 73 23  ld   hl,$2373
1125: 11 F3 21  ld   de,$21f3
1128: 3E 07     ld   a,$07
112A: CD CF 0E  call $0ecf
112D: 21 67 23  ld   hl,$2367
1130: 3E 07     ld   a,$07
1132: CD 18 0E  call $0e18
1135: C3 31 10  jp   $1031

1138: 7E        ld   a,(hl)
1139: E6 30     and  $30
113B: 47        ld   b,a
113C: 3A 8C 23  ld   a,($238c)
113F: E6 0F     and  $0f
1141: B0        or   b
1142: 32 8C 23  ld   ($238c),a
1145: 32 AC 23  ld   ($23ac),a
1148: C9        ret

1149: 00 00 00 00 ' 0
114D: 01 00 00 00 ' 1
1151: 10 00 00 00 ' 10
1155: 25 00 00 00 ' 25
1159: 50 00 00 00 ' 50
115D: 00 01 00 00 ' 100
1161: 00 05 00 00 ' 500
1165: 00 10 00 00 ' 1,000
1169: 00 20 00 00 ' 2,000
116D: 00 40 00 00 ' 4,000
1171: 00 50 00 00 ' 5,000
1175: 00 60 00 00 ' 6,000
1179: 00 80 00 00 ' 8,000
117D: 00 00 01 00 ' 10,000
1181: 00 50 02 00 ' 25,000

1185: F0 FF FF FF
1189: FF FF FF FF

118D: 3E FF     ld   a,$ff
118F: D3 09     out  ($09),a
1191: 11 AC 12  ld   de,$12ac ' $FF
1194: 7D        ld   a,l
1195: 93        sub  e
1196: 7C        ld   a,h
1197: 9A        sbc  a,d
1198: F8        ret  m
1199: 11 7C 13  ld   de,$137c ' $FE
119C: 7B        ld   a,e
119D: 95        sub  l
119E: 7A        ld   a,d
119F: 9C        sbc  a,h
11A0: F8        ret  m
11A1: 7E        ld   a,(hl)
11A2: 2F        cpl
11A3: D3 0A     out  ($0a),a
11A5: 23        inc  hl
11A6: 7E        ld   a,(hl)
11A7: 2F        cpl
11A8: D3 09     out  ($09),a
11AA: 2F        cpl
11AB: 22 B1 21  ld   ($21b1),hl
11AE: 11 FC 11  ld   de,$11fc
11B1: FE 00     cp   $00
11B3: CA EF 11  jp   z,$11ef
11B6: FE 02     cp   $02
11B8: CA EE 11  jp   z,$11ee
11BB: FE 04     cp   $04
11BD: CA ED 11  jp   z,$11ed
11C0: FE 08     cp   $08
11C2: CA EC 11  jp   z,$11ec
11C5: FE 0C     cp   $0c
11C7: CA EB 11  jp   z,$11eb
11CA: FE 10     cp   $10
11CC: CA EA 11  jp   z,$11ea
11CF: FE 2C     cp   $2c
11D1: CA E9 11  jp   z,$11e9
11D4: FE 28     cp   $28
11D6: CA E8 11  jp   z,$11e8
11D9: FE 24     cp   $24
11DB: CA E7 11  jp   z,$11e7
11DE: FE 20     cp   $20
11E0: CA E6 11  jp   z,$11e6
11E3: C3 EF 11  jp   $11ef

11E6: 13        inc  de
11E7: 13        inc  de
11E8: 13        inc  de
11E9: 13        inc  de
11EA: 13        inc  de
11EB: 13        inc  de
11EC: 13        inc  de
11ED: 13        inc  de
11EE: 13        inc  de

11EF: 1A        ld   a,(de)
11F0: 32 98 21  ld   ($2198),a
11F3: 21 90 21  ld   hl,$2190
11F6: 3E 05     ld   a,$05
11F8: CD D6 03  call $03d6
11FB: C9        ret

11FC: 0D 0A 0E 0A 18 20 0A 05 02 32

1206: 21 90 21  ld   hl,$2190
1209: 3E 05     ld   a,$05
120B: CD EE 03  call $03ee
120E: C2 22 12  jp   nz,$1222
1211: 3E 06     ld   a,$06
1213: CD D6 03  call $03d6
1216: 3E FE     ld   a,$fe
1218: D3 09     out  ($09),a
121A: 3E 02     ld   a,$02
121C: 32 98 21  ld   ($2198),a
121F: C3 1E 06  jp   $061e

1222: CD E1 03  call $03e1
1225: 3E 06     ld   a,$06
1227: CD EE 03  call $03ee
122A: C2 55 12  jp   nz,$1255
122D: 3E FF     ld   a,$ff
122F: D3 09     out  ($09),a
1231: 2A B1 21  ld   hl,($21b1)
1234: 23        inc  hl
1235: 7E        ld   a,(hl)
1236: FE FF     cp   $ff
1238: CA 41 12  jp   z,$1241
123B: CD 8D 11  call $118d
123E: C3 1E 06  jp   $061e

1241: 3A B3 21  ld   a,($21b3)
1244: FE 00     cp   $00
1246: C2 58 12  jp   nz,$1258
1249: 3E FF     ld   a,$ff
124B: D3 09     out  ($09),a
124D: 3E 0C     ld   a,$0c
124F: 32 98 21  ld   ($2198),a
1252: C3 1E 06  jp   $061e

1255: CD E1 03  call $03e1
1258: CD 8C 12  call $128c
125B: CD 8D 11  call $118d
125E: C3 1E 06  jp   $061e

1261: EB        ex   de,hl
1262: 2A BE 21  ld   hl,($21be)
1265: 01 BE 21  ld   bc,$21be
1268: 79        ld   a,c
1269: 32 B3 21  ld   ($21b3),a
126C: 95        sub  l
126D: C2 73 12  jp   nz,$1273
1270: 21 B4 21  ld   hl,$21b4
1273: 73        ld   (hl),e
1274: 23        inc  hl
1275: 72        ld   (hl),d
1276: 23        inc  hl
1277: 22 BE 21  ld   ($21be),hl
127A: 21 90 21  ld   hl,$2190
127D: 3E 05     ld   a,$05
127F: CD EE 03  call $03ee
1282: C0        ret  nz
1283: CD D6 03  call $03d6
1286: 3E 01     ld   a,$01
1288: 32 98 21  ld   ($2198),a
128B: C9        ret

128C: 2A C0 21  ld   hl,($21c0)
128F: 01 BE 21  ld   bc,$21be
1292: 79        ld   a,c
1293: 95        sub  l
1294: C2 9A 12  jp   nz,$129a
1297: 21 B4 21  ld   hl,$21b4
129A: 5E        ld   e,(hl)
129B: 23        inc  hl
129C: 56        ld   d,(hl)
129D: 23        inc  hl
129E: 22 C0 21  ld   ($21c0),hl
12A1: D5        push de
12A2: 7D        ld   a,l
12A3: 2A BE 21  ld   hl,($21be)
12A6: 95        sub  l
12A7: 32 B3 21  ld   ($21b3),a
12AA: E1        pop  hl
12AB: C9        ret

12AC: FF

12AD: CA 08 FF
12B0: AA 08 FF
12B3: 87 08 FF
12B6: 65 08 FF
12B9: 1C 0C FF
12BC: 1C 0C FF
12BF: 1C 00 FF

12C2: 43 08 87 08 43 08 87 08 43 08 87 08 43 08 87 08 43 08 87 08 FF
12D7: 55 08 FF
12DA: 3C 08 FF
12DD: 2B 08 FF
12E0: 22 08 FF
12E3: 22 28 1E 0C FF
12E8: 15 02 15 0C FF
12ED: 4C 08 65 0C FF
12F2: 78 28 50 28 78 28 50 28 78 28 50 28 FF
12FF: 55 08 65 08 78 08 78 00 55 08 65 08 78 08 78 00 55 08 65 08 78 08 FF
1316: 43 20 43 08 55 08 65 08 72 0C FF
1321: 43 04 43 04 43 00 43 04 43 04 43 00 43 04 43 04 FF
1332: C6 08 FF
1335: 4C 0C FF
1338: CA 08 CA 08 CA 08 CA 0C FF
1341: 78 28 65 04 FF
1346: A0 2C A0 0C FF
134B: 15 0C FF
134E: CA 00 FF
1351: 65 0C 87 0C AA 0C CA 0C CA 00 CA 08 CA 08 CA 08 AA 00 AA 0C AA 00 AA 08 AA 08 AA 08 87 00 87 0C AA 0C 87 0C 65 0C 65 20 65 20 FF

137C: FE

137D: 21 91 21  ld   hl,$2191
1380: 3E 03     ld   a,$03
1382: CD E1 03  call $03e1
1385: D3 0F     out  ($0f),a
1387: 21 E0 23  ld   hl,$23e0
138A: 11 3B 23  ld   de,$233b
138D: 46        ld   b,(hl)
138E: 1A        ld   a,(de)
138F: C6 04     add  a,$04
1391: 90        sub  b
1392: F2 97 13  jp   p,$1397
1395: 2F        cpl
1396: 3C        inc  a
1397: FE 03     cp   $03
1399: DA A4 13  jp   c,$13a4
139C: 3A 91 21  ld   a,($2191)
139F: F6 08     or   $08
13A1: 32 91 21  ld   ($2191),a
13A4: 78        ld   a,b
13A5: D6 04     sub  $04
13A7: 12        ld   (de),a
13A8: 13        inc  de
13A9: 2C        inc  l
13AA: C2 8D 13  jp   nz,$138d
13AD: 3A 91 21  ld   a,($2191)
13B0: E6 08     and  $08
13B2: C2 7D 13  jp   nz,$137d
13B5: CD 03 03  call $0303
13B8: 22 24 22  ld   ($2224),hl
13BB: C9        ret

13BC: 21 91 21  ld   hl,$2191
13BF: 3E 06     ld   a,$06
13C1: CD D6 03  call $03d6
13C4: 21 E0 23  ld   hl,$23e0
13C7: 11 3B 23  ld   de,$233b
13CA: 1A        ld   a,(de)
13CB: 96        sub  (hl)
13CC: F2 EA 13  jp   p,$13ea

13CF: 13        inc  de
13D0: 2C        inc  l
13D1: C2 CA 13  jp   nz,$13ca
13D4: 21 91 21  ld   hl,$2191
13D7: 3E 06     ld   a,$06
13D9: CD EE 03  call $03ee
13DC: CA E4 13  jp   z,$13e4
13DF: 3E 07     ld   a,$07
13E1: CD E1 03  call $03e1
13E4: 3E 01     ld   a,$01
13E6: F3        di
13E7: C3 76 03  jp   $0376

13EA: F3        di
13EB: E5        push hl
13EC: 21 91 21  ld   hl,$2191
13EF: 3E 06     ld   a,$06
13F1: CD E1 03  call $03e1
13F4: 3C        inc  a
13F5: CD EE 03  call $03ee
13F8: C2 02 14  jp   nz,$1402
13FB: CD D6 03  call $03d6
13FE: E1        pop  hl
13FF: C3 1C 14  jp   $141c

1402: CD E1 03  call $03e1
1405: E1        pop  hl
1406: CD 24 06  call $0624
1409: 7D        ld   a,l
140A: D6 E0     sub  $e0
140C: 6F        ld   l,a
140D: 26 00     ld   h,$00
140F: 29        add  hl,hl
1410: 11 1F 14  ld   de,$141f
1413: 19        add  hl,de
1414: 7E        ld   a,(hl)
1415: 23        inc  hl
1416: 66        ld   h,(hl)
1417: 6F        ld   l,a
1418: E9        jp   (hl)

1419: CD 30 06  call $0630

141C: C3 CF 13  jp   $13cf

141F: D6 15 -> 15D6 ' 1,000 bonus inlane
      19 14 -> 1419 ' nothing
      19 14 -> 1419 ' nothing
      19 14 -> 1419 ' nothing
      19 14 -> 1419 ' nothing, but may trigger slam tilt when machine is tilted
      19 14 -> 1419 ' nothing
      19 14 -> 1419 ' nothing
      19 14 -> 1419 ' nothing

      AC 15 -> 15AC ' 1,000 pts outlane
      66 14 -> 1466 ' 500 pts rollover #2
      6D 14 -> 146D ' 500 pts rollover #3
      82 14 -> 1482 ' 500 pts rollover #6
      74 14 -> 1474 ' 500 pts rollover #4
      7B 14 -> 147B ' 500 pts rollover #5
      84 09 -> 0984 ' right saucer
      36 15 -> 1536 ' 10,000 bonus / extra ball lane

      89 14 -> 1489 ' 500 pts rollover #7
      90 14 -> 1490 ' 500 pts rollover #8
      7D 09 -> 097D ' penta-cup #5
      5F 14 -> 145F ' 500 pts rollover #1
      76 09 -> 0976 ' penta-cup #4
      67 0D -> 0D67 ' standup target #3
      6C 0D -> 0D6C ' standup target #4
      71 0D -> 0D71 ' standup target #5

      08 18 -> 1808 ' outhole
      6F 09 -> 096F ' penta-cup #3
      62 0D -> 0D62 ' standup target #2
      68 09 -> 0968 ' penta-cup #2
      5D 0D -> 0D5D ' standup target #1
      61 09 -> 0961 ' penta-cup #1
      AC 15 -> 15AC ' 1,000 pts outlane
      D6 15 -> 15D6 ' 1,000 bonus inlane

145F: 0E 00     ld   c,$00
1461: 06 02     ld   b,$02
1463: C3 94 14  jp   $1494

1466: 0E 01     ld   c,$01
1468: 06 2A     ld   b,$2a
146A: C3 94 14  jp   $1494

146D: 0E 02     ld   c,$02
146F: 06 10     ld   b,$10
1471: C3 94 14  jp   $1494

1474: 0E 03     ld   c,$03
1476: 06 1A     ld   b,$1a
1478: C3 94 14  jp   $1494

147B: 0E 04     ld   c,$04
147D: 06 01     ld   b,$01
147F: C3 94 14  jp   $1494

1482: 0E 05     ld   c,$05
1484: 06 19     ld   b,$19
1486: C3 94 14  jp   $1494

1489: 0E 06     ld   c,$06
148B: 06 21     ld   b,$21
148D: C3 94 14  jp   $1494

1490: 0E 07     ld   c,$07
1492: 06 0A     ld   b,$0a

1494: 21 90 21  ld   hl,$2190
1497: 3E 07     ld   a,$07
1499: CD D6 03  call $03d6
149C: 3E 02     ld   a,$02
149E: CD EE 03  call $03ee
14A1: C2 19 14  jp   nz,$1419
14A4: 79        ld   a,c
14A5: 21 C6 21  ld   hl,$21c6
14A8: CD EE 03  call $03ee
14AB: CA 19 14  jp   z,$1419
14AE: CD E1 03  call $03e1
14B1: CD 81 1D  call $1d81
14B4: 21 61 11  ld   hl,$1161 ' 500 pts
14B7: CD 92 02  call $0292
14BA: 21 D7 12  ld   hl,$12d7 ' sound
14BD: CD 61 12  call $1261
14C0: 3A C6 21  ld   a,($21c6)
14C3: FE 00     cp   $00
14C5: C2 19 14  jp   nz,$1419
14C8: 3E 3D     ld   a,$3d
14CA: 32 A4 21  ld   ($21a4),a
14CD: 3E 00     ld   a,$00
14CF: 32 05 22  ld   ($2205),a
14D2: C3 19 14  jp   $1419

14D5: 3A 05 22  ld   a,($2205)
14D8: 3C        inc  a
14D9: 32 05 22  ld   ($2205),a
14DC: FE 09     cp   $09
14DE: CA FA 14  jp   z,$14fa
14E1: 16 00     ld   d,$00
14E3: 5F        ld   e,a
14E4: 21 2D 15  ld   hl,$152d
14E7: 19        add  hl,de
14E8: 46        ld   b,(hl)
14E9: CD 76 1D  call $1d76
14EC: 21 D7 12  ld   hl,$12d7 ' sound
14EF: CD 61 12  call $1261
14F2: 3E 0A     ld   a,$0a
14F4: 32 A4 21  ld   ($21a4),a
14F7: C3 1E 06  jp   $061e

14FA: 3E 00     ld   a,$00
14FC: 32 0C 22  ld   ($220c),a
14FF: 06 11     ld   b,$11
1501: CD 9C 1D  call $1d9c
1504: C2 17 15  jp   nz,$1517
1507: 06 38     ld   b,$38
1509: CD 9C 1D  call $1d9c
150C: C2 22 15  jp   nz,$1522
150F: 06 11     ld   b,$11
1511: CD 76 1D  call $1d76
1514: C3 22 15  jp   $1522

1517: CD 81 1D  call $1d81
151A: 06 38     ld   b,$38
151C: CD 76 1D  call $1d76
151F: C3 22 15  jp   $1522

1522: 3E FF     ld   a,$ff
1524: 32 C6 21  ld   ($21c6),a
1527: 97        sub  a
1528: 32 05 22  ld   ($2205),a
152B: C3 1E 06  jp   $061e

152E: 02        ld   (bc),a
152F: 2A 10 1A  ld   hl,($1a10)
1532: 01 19 21  ld   bc,$2119
1535: 0A        ld   a,(bc)

1536: 21 90 21  ld   hl,$2190
1539: 3E 07     ld   a,$07
153B: CD EE 03  call $03ee
153E: CA 19 14  jp   z,$1419
1541: CD E1 03  call $03e1
1544: 3E 02     ld   a,$02
1546: CD EE 03  call $03ee
1549: C2 19 14  jp   nz,$1419
154C: 21 7D 11  ld   hl,$117d ' 10,000 pts
154F: CD 5C 0E  call $0e5c
1552: 21 90 21  ld   hl,$2190
1555: 3E 04     ld   a,$04
1557: CD EE 03  call $03ee
155A: CA 88 15  jp   z,$1588
155D: 21 91 21  ld   hl,$2191
1560: 3E 01     ld   a,$01
1562: CD EE 03  call $03ee
1565: C2 88 15  jp   nz,$1588
1568: CD D6 03  call $03d6
156B: 3A C7 21  ld   a,($21c7)
156E: 06 FF     ld   b,$ff
1570: 04        inc  b
1571: 1F        rra
1572: D2 70 15  jp   nc,$1570
1575: 78        ld   a,b
1576: 3D        dec  a
1577: F2 7C 15  jp   p,$157c
157A: 3E 04     ld   a,$04
157C: 32 11 22  ld   ($2211),a
157F: CD 02 04  call $0402
1582: 21 38 13  ld   hl,$1338 ' sound
1585: CD 61 12  call $1261
1588: 21 90 21  ld   hl,$2190
158B: 3E 03     ld   a,$03
158D: CD EE 03  call $03ee
1590: C2 A3 15  jp   nz,$15a3
1593: 06 09     ld   b,$09
1595: CD 9C 1D  call $1d9c
1598: CA A3 15  jp   z,$15a3
159B: CD 81 1D  call $1d81
159E: 06 31     ld   b,$31
15A0: CD 91 1D  call $1d91
15A3: 21 ED 12  ld   hl,$12ed ' sound
15A6: CD 61 12  call $1261
15A9: C3 19 14  jp   $1419

15AC: 3E FF     ld   a,$ff
15AE: 32 93 21  ld   ($2193),a
15B1: 3A 94 21  ld   a,($2194)
15B4: F6 30     or   $30
15B6: 32 94 21  ld   ($2194),a
15B9: 21 90 21  ld   hl,$2190
15BC: 3E 02     ld   a,$02
15BE: CD EE 03  call $03ee
15C1: C2 19 14  jp   nz,$1419
15C4: CD D6 03  call $03d6
15C7: 21 65 11  ld   hl,$1165 ' 1,000 pts
15CA: CD 92 02  call $0292
15CD: 21 4B 13  ld   hl,$134b ' sound
15D0: CD 61 12  call $1261
15D3: C3 19 14  jp   $1419

15D6: 21 90 21  ld   hl,$2190
15D9: 3E 02     ld   a,$02
15DB: CD EE 03  call $03ee
15DE: C2 19 14  jp   nz,$1419
15E1: 3E 07     ld   a,$07
15E3: CD EE 03  call $03ee
15E6: CA 19 14  jp   z,$1419
15E9: CD E1 03  call $03e1
15EC: 21 65 11  ld   hl,$1165 ' 1,000 pts
15EF: CD 5C 0E  call $0e5c
15F2: 21 35 13  ld   hl,$1335 ' sound
15F5: CD 61 12  call $1261
15F8: C3 19 14  jp   $1419

15FB: 21 92 21  ld   hl,$2192
15FE: 3E 00     ld   a,$00
1600: CD EE 03  call $03ee
1603: C2 89 17  jp   nz,$1789
1606: 3A 7A 23  ld   a,($237a)
1609: B7        or   a
160A: C2 20 16  jp   nz,$1620
160D: 3A 9E 23  ld   a,($239e)
1610: E6 08     and  $08
1612: C2 89 17  jp   nz,$1789
1615: 3A B6 23  ld   a,($23b6)
1618: F6 40     or   $40
161A: 32 B6 23  ld   ($23b6),a
161D: C3 89 17  jp   $1789

1620: 3A 7B 23  ld   a,($237b)
1623: E6 0F     and  $0f
1625: FE 01     cp   $01
1627: CA ED 16  jp   z,$16ed
162A: FE 00     cp   $00
162C: CA ED 16  jp   z,$16ed
162F: 21 A3 23  ld   hl,$23a3
1632: 11 20 23  ld   de,$2320
1635: 3E 2E     ld   a,$2e
1637: CD CF 0E  call $0ecf
163A: CD A8 17  call $17a8
163D: 21 92 21  ld   hl,$2192
1640: 3E 04     ld   a,$04
1642: CD EE 03  call $03ee
1645: CA 55 16  jp   z,$1655
1648: 3E 07     ld   a,$07
164A: CD EE 03  call $03ee
164D: CA 55 16  jp   z,$1655
1650: 3E 01     ld   a,$01
1652: C3 71 16  jp   $1671

1655: 3E 06     ld   a,$06
1657: CD D6 03  call $03d6
165A: 3A 90 21  ld   a,($2190)
165D: F6 05     or   $05
165F: 32 90 21  ld   ($2190),a
1662: 3E FF     ld   a,$ff
1664: 32 93 21  ld   ($2193),a
1667: 3A 94 21  ld   a,($2194)
166A: F6 30     or   $30
166C: 32 94 21  ld   ($2194),a
166F: 3E 00     ld   a,$00

1671: 32 7B 23  ld   ($237b),a
1674: 32 9B 23  ld   ($239b),a
1677: 32 BB 23  ld   ($23bb),a
167A: 3E 11     ld   a,$11
167C: 32 7E 23  ld   ($237e),a
167F: 32 BE 23  ld   ($23be),a
1682: 3E 01     ld   a,$01
1684: 32 9E 23  ld   ($239e),a
1687: 3E F0     ld   a,$f0
1689: 32 86 23  ld   ($2386),a
168C: 32 A6 23  ld   ($23a6),a
168F: 32 80 23  ld   ($2380),a
1692: 32 A0 23  ld   ($23a0),a
1695: 3E 00     ld   a,$00
1697: 32 14 22  ld   ($2214),a
169A: 11 D3 21  ld   de,$21d3
169D: 06 04     ld   b,$04
169F: CD 8E 17  call $178e
16A2: 21 92 21  ld   hl,$2192
16A5: 3E 06     ld   a,$06
16A7: CD E1 03  call $03e1
16AA: 3A B6 23  ld   a,($23b6)
16AD: E6 7F     and  $7f
16AF: 32 B6 23  ld   ($23b6),a
16B2: 21 D3 21  ld   hl,$21d3
16B5: 11 C6 21  ld   de,$21c6
16B8: 3E 10     ld   a,$10
16BA: CD CF 0E  call $0ecf
16BD: 21 C9 21  ld   hl,$21c9
16C0: 11 CE 21  ld   de,$21ce
16C3: 3E 0A     ld   a,$0a
16C5: CD CF 0E  call $0ecf
16C8: 3A 90 21  ld   a,($2190)
16CB: E6 E7     and  $e7
16CD: 32 90 21  ld   ($2190),a

16D0: 3A 7A 23  ld   a,($237a)
16D3: C6 99     add  a,$99
16D5: 27        daa
16D6: 32 7A 23  ld   ($237a),a
16D9: 32 9A 23  ld   ($239a),a
16DC: 32 BA 23  ld   ($23ba),a
16DF: 3A 14 22  ld   a,($2214)
16E2: 47        ld   b,a
16E3: 3A 13 22  ld   a,($2213)
16E6: 80        add  a,b
16E7: 32 14 22  ld   ($2214),a
16EA: C3 83 17  jp   $1783

16ED: 3A 7E 23  ld   a,($237e)
16F0: E6 08     and  $08
16F2: C2 89 17  jp   nz,$1789
16F5: 3E 01     ld   a,$01
16F7: 21 7E 23  ld   hl,$237e
16FA: CD EE 03  call $03ee
16FD: CA 38 17  jp   z,$1738
1700: 3E 02     ld   a,$02
1702: CD EE 03  call $03ee
1705: CA 4E 17  jp   z,$174e
1708: 3E 03     ld   a,$03
170A: CD D6 03  call $03d6
170D: 3E F0     ld   a,$f0
170F: 32 90 23  ld   ($2390),a
1712: 32 B0 23  ld   ($23b0),a
1715: F3        di
1716: 3A 7E 23  ld   a,($237e)
1719: F5        push af
171A: 3E 1F     ld   a,$1f
171C: 32 7E 23  ld   ($237e),a
171F: 21 49 11  ld   hl,$1149 ' no score
1722: CD 3C 0F  call $0f3c
1725: 3E 2F     ld   a,$2f
1727: 32 7E 23  ld   ($237e),a
172A: 21 49 11  ld   hl,$1149 ' no score
172D: CD 3C 0F  call $0f3c
1730: F1        pop  af
1731: 32 7E 23  ld   ($237e),a
1734: FB        ei
1735: C3 D0 16  jp   $16d0

1738: CD D6 03  call $03d6
173B: 3E F0     ld   a,$f0
173D: 32 8D 23  ld   ($238d),a
1740: 32 AD 23  ld   ($23ad),a
1743: 3E F0     ld   a,$f0
1745: 32 97 23  ld   ($2397),a
1748: 32 B7 23  ld   ($23b7),a
174B: C3 D0 16  jp   $16d0

174E: CD D6 03  call $03d6
1751: 3E F0     ld   a,$f0
1753: 32 83 23  ld   ($2383),a
1756: 32 A3 23  ld   ($23a3),a
1759: 3E FF     ld   a,$ff
175B: 32 97 23  ld   ($2397),a
175E: 32 98 23  ld   ($2398),a
1761: 32 99 23  ld   ($2399),a
1764: 32 B7 23  ld   ($23b7),a
1767: 32 B8 23  ld   ($23b8),a
176A: 32 B9 23  ld   ($23b9),a
176D: C3 D0 16  jp   $16d0

1770: 3A 7E 23  ld   a,($237e)
1773: 32 BE 23  ld   ($23be),a
1776: E6 0F     and  $0f
1778: 47        ld   b,a
1779: 3A 9E 23  ld   a,($239e)
177C: B0        or   b
177D: 32 9E 23  ld   ($239e),a
1780: C3 D0 16  jp   $16d0

1783: 21 DA 12  ld   hl,$12da ' sound
1786: CD 61 12  call $1261

1789: 3E 06     ld   a,$06
178B: C3 76 03  jp   $0376

178E: 21 A0 17  ld   hl,$17a0
1791: 0E 08     ld   c,$08
1793: 7E        ld   a,(hl)
1794: 12        ld   (de),a
1795: 13        inc  de
1796: 23        inc  hl
1797: 0D        dec  c
1798: C2 93 17  jp   nz,$1793
179B: 05        dec  b
179C: C2 8E 17  jp   nz,$178e
179F: C9        ret

17A0: FF 1F 01 04 39 2B 37 37

17A8: 21 5B 23  ld   hl,$235b
17AB: 3E 00     ld   a,$00
17AD: 16 1F     ld   d,$1f
17AF: 77        ld   (hl),a
17B0: 23        inc  hl
17B1: 15        dec  d
17B2: C2 AF 17  jp   nz,$17af
17B5: 32 46 22  ld   ($2246),a
17B8: 21 80 23  ld   hl,$2380
17BB: 3E FF     ld   a,$ff
17BD: 16 1A     ld   d,$1a
17BF: 77        ld   (hl),a
17C0: 23        inc  hl
17C1: 15        dec  d
17C2: C2 BF 17  jp   nz,$17bf
17C5: 21 A0 23  ld   hl,$23a0
17C8: 3E FF     ld   a,$ff
17CA: 16 1A     ld   d,$1a
17CC: 77        ld   (hl),a
17CD: 23        inc  hl
17CE: 15        dec  d
17CF: C2 CC 17  jp   nz,$17cc
17D2: 3E 0F     ld   a,$0f
17D4: 32 8C 23  ld   ($238c),a
17D7: 32 AC 23  ld   ($23ac),a
17DA: 32 96 23  ld   ($2396),a
17DD: 32 B6 23  ld   ($23b6),a
17E0: 21 FF FF  ld   hl,$ffff
17E3: 22 9C 23  ld   ($239c),hl
17E6: 22 BC 23  ld   ($23bc),hl
17E9: C9        ret

17EA: 3A 7E 23  ld   a,($237e)
17ED: E6 02     and  $02
17EF: 3E 20     ld   a,$20
17F1: C8        ret  z
17F2: 21 90 21  ld   hl,$2190
17F5: 3E 03     ld   a,$03
17F7: CD EE 03  call $03ee
17FA: 3E 20     ld   a,$20
17FC: C0        ret  nz
17FD: 3A 14 22  ld   a,($2214)
1800: FE 01     cp   $01
1802: 3E 20     ld   a,$20
1804: C8        ret  z
1805: 3E 80     ld   a,$80
1807: C9        ret

1808: 21 92 21  ld   hl,$2192
180B: 3E 04     ld   a,$04
180D: CD EE 03  call $03ee
1810: C2 19 14  jp   nz,$1419
1813: 21 08 22  ld   hl,$2208
1816: 3E FF     ld   a,$ff
1818: 86        add  a,(hl)
1819: D2 23 18  jp   nc,$1823
181C: 77        ld   (hl),a
181D: CA 2B 18  jp   z,$182b
1820: C3 19 14  jp   $1419

1823: 3E 32     ld   a,$32
1825: 32 08 22  ld   ($2208),a
1828: C3 19 14  jp   $1419

182B: 3E FF     ld   a,$ff
182D: 32 93 21  ld   ($2193),a
1830: 3E 00     ld   a,$00
1832: 32 0C 22  ld   ($220c),a
1835: 32 C3 21  ld   ($21c3),a
1838: 32 A8 21  ld   ($21a8),a
183B: 32 A9 21  ld   ($21a9),a
183E: 3A 94 21  ld   a,($2194)
1841: F6 30     or   $30
1843: 32 94 21  ld   ($2194),a
1846: 21 90 21  ld   hl,$2190
1849: 3E 02     ld   a,$02
184B: CD D6 03  call $03d6
184E: 21 92 21  ld   hl,$2192
1851: 3E 04     ld   a,$04
1853: CD D6 03  call $03d6
1856: 21 E8 12  ld   hl,$12e8 ' sound
1859: CD 61 12  call $1261
185C: CD A8 1B  call $1ba8
185F: EB        ex   de,hl
1860: 21 C6 21  ld   hl,$21c6
1863: 3E 10     ld   a,$10
1865: CD CF 0E  call $0ecf
1868: 21 90 21  ld   hl,$2190
186B: 3E 00     ld   a,$00
186D: CD EE 03  call $03ee
1870: C2 7B 18  jp   nz,$187b
1873: 06 39     ld   b,$39
1875: CD 9C 1D  call $1d9c
1878: C2 89 18  jp   nz,$1889
187B: 3E 02     ld   a,$02
187D: 32 A0 21  ld   ($21a0),a
1880: CD EA 17  call $17ea
1883: 32 1C 22  ld   ($221c),a
1886: C3 19 14  jp   $1419

1889: 2A 5C 23  ld   hl,($235c)
188C: 29        add  hl,hl
188D: 29        add  hl,hl
188E: 29        add  hl,hl
188F: 29        add  hl,hl
1890: 22 F3 21  ld   ($21f3),hl
1893: 2A 5D 23  ld   hl,($235d)
1896: 29        add  hl,hl
1897: 29        add  hl,hl
1898: 29        add  hl,hl
1899: 29        add  hl,hl
189A: 7C        ld   a,h
189B: 32 F5 21  ld   ($21f5),a
189E: 21 F3 21  ld   hl,$21f3
18A1: 11 0D 22  ld   de,$220d
18A4: 3E 06     ld   a,$06
18A6: CD CF 0E  call $0ecf
18A9: 3E 04     ld   a,$04
18AB: F5        push af
18AC: 21 0D 22  ld   hl,$220d
18AF: 3E 06     ld   a,$06
18B1: CD EC 0D  call $0dec
18B4: F1        pop  af
18B5: 3D        dec  a
18B6: C2 AB 18  jp   nz,$18ab
18B9: 21 F3 21  ld   hl,$21f3
18BC: CD 6F 0E  call $0e6f
18BF: 3E 3C     ld   a,$3c
18C1: 32 AE 21  ld   ($21ae),a
18C4: 21 35 13  ld   hl,$1335 ' sound
18C7: CD 61 12  call $1261
18CA: C3 19 14  jp   $1419

18CD: 21 65 11  ld   hl,$1165 ' 1,000 pts
18D0: CD 99 0E  call $0e99
18D3: DA EA 18  jp   c,$18ea
18D6: 21 65 11  ld   hl,$1165 ' 1,000 pts
18D9: CD 92 02  call $0292
18DC: 3E 0A     ld   a,$0a
18DE: 32 AE 21  ld   ($21ae),a
18E1: 21 32 13  ld   hl,$1332 ' sound
18E4: CD 61 12  call $1261
18E7: C3 1E 06  jp   $061e

18EA: 21 65 11  ld   hl,$1165 ' 1,000 pts
18ED: CD 5C 0E  call $0e5c
18F0: 21 5B 23  ld   hl,$235b
18F3: CD 3C 0F  call $0f3c
18F6: 21 5B 23  ld   hl,$235b
18F9: CD 99 0E  call $0e99
18FC: CD EA 17  call $17ea
18FF: 32 1C 22  ld   ($221c),a

1902: 3A 1C 22  ld   a,($221c)
1905: 3D        dec  a
1906: 32 1C 22  ld   ($221c),a
1909: CA 14 19  jp   z,$1914
190C: 3E 02     ld   a,$02
190E: 32 A0 21  ld   ($21a0),a
1911: C3 1E 06  jp   $061e

1914: 3E 01     ld   a,$01
1916: 32 12 22  ld   ($2212),a
1919: 3E 32     ld   a,$32
191B: 32 94 21  ld   ($2194),a
191E: 21 92 21  ld   hl,$2192
1921: 3E 03     ld   a,$03
1923: CD E1 03  call $03e1
1926: 21 7B 23  ld   hl,$237b
1929: 3A 13 22  ld   a,($2213)
192C: 96        sub  (hl)
192D: F2 3B 19  jp   p,$193b
1930: CD 3A 1A  call $1a3a
1933: 7E        ld   a,(hl)
1934: B0        or   b
1935: 77        ld   (hl),a
1936: 19        add  hl,de
1937: 77        ld   (hl),a
1938: C3 76 19  jp   $1976

193B: 3A 7B 23  ld   a,($237b)
193E: B7        or   a
193F: 3E 01     ld   a,$01
1941: 21 7E 23  ld   hl,$237e
1944: CA 8A 1A  jp   z,$1a8a
1947: 3E 04     ld   a,$04
1949: CD EE 03  call $03ee
194C: C2 55 19  jp   nz,$1955
194F: 3C        inc  a
1950: FE 08     cp   $08
1952: C2 49 19  jp   nz,$1949
1955: CD E1 03  call $03e1
1958: 3C        inc  a
1959: 4F        ld   c,a
195A: D6 04     sub  $04
195C: CD EE 03  call $03ee
195F: 79        ld   a,c
1960: C2 98 1A  jp   nz,$1a98
1963: 3A 13 22  ld   a,($2213)
1966: 3C        inc  a
1967: 47        ld   b,a
1968: 3A 7B 23  ld   a,($237b)
196B: 3C        inc  a
196C: B8        cp   b
196D: C2 8A 1A  jp   nz,$1a8a
1970: 32 7B 23  ld   ($237b),a
1973: 32 BB 23  ld   ($23bb),a

1976: 3E FF     ld   a,$ff
1978: 32 9B 23  ld   ($239b),a
197B: 3A 46 22  ld   a,($2246)
197E: B7        or   a
197F: CA BF 19  jp   z,$19bf
1982: 21 7E 23  ld   hl,$237e
1985: 47        ld   b,a
1986: 7E        ld   a,(hl)
1987: E6 0F     and  $0f
1989: 77        ld   (hl),a
198A: 78        ld   a,b
198B: 06 00     ld   b,$00

198D: 1F        rra
198E: DA 95 19  jp   c,$1995
1991: 04        inc  b
1992: C3 8D 19  jp   $198d

1995: EB        ex   de,hl
1996: 21 46 22  ld   hl,$2246
1999: 78        ld   a,b
199A: 32 45 22  ld   ($2245),a
199D: CD E1 03  call $03e1
19A0: C6 04     add  a,$04
19A2: EB        ex   de,hl
19A3: CD D6 03  call $03d6
19A6: CD 3A 1A  call $1a3a
19A9: 7E        ld   a,(hl)
19AA: B0        or   b
19AB: 77        ld   (hl),a
19AC: 3A 96 23  ld   a,($2396)
19AF: E6 DF     and  $df
19B1: 32 96 23  ld   ($2396),a
19B4: 3A 90 21  ld   a,($2190)
19B7: F6 08     or   $08
19B9: 32 90 21  ld   ($2190),a
19BC: C3 AE 1A  jp   $1aae

19BF: 21 91 21  ld   hl,$2191
19C2: 3E 00     ld   a,$00
19C4: CD EE 03  call $03ee
19C7: 3E 01     ld   a,$01
19C9: C2 8A 1A  jp   nz,$1a8a
19CC: 3A 92 21  ld   a,($2192)
19CF: F6 C0     or   $c0
19D1: 32 92 21  ld   ($2192),a
19D4: CD B7 1D  call $1db7
19D7: 21 B6 23  ld   hl,$23b6
19DA: 3E 07     ld   a,$07
19DC: CD D6 03  call $03d6
19DF: 3A 96 23  ld   a,($2396)
19E2: E6 CF     and  $cf
19E4: 32 96 23  ld   ($2396),a
19E7: 3A B6 23  ld   a,($23b6)
19EA: E6 CF     and  $cf
19EC: 32 B6 23  ld   ($23b6),a
19EF: 3A AC 23  ld   a,($23ac)
19F2: E6 30     and  $30
19F4: CA 00 1A  jp   z,$1a00
19F7: FE 10     cp   $10
19F9: 3E 05     ld   a,$05
19FB: CA 00 1A  jp   z,$1a00
19FE: 3E 0A     ld   a,$0a
1A00: 32 BE 23  ld   ($23be),a
1A03: 97        sub  a
1A04: 32 9E 23  ld   ($239e),a
1A07: 3A 8C 23  ld   a,($238c)
1A0A: E6 0F     and  $0f
1A0C: 32 8C 23  ld   ($238c),a
1A0F: 3A 47 22  ld   a,($2247)
1A12: E6 08     and  $08
1A14: CA 24 1A  jp   z,$1a24
1A17: 3E 04     ld   a,$04
1A19: 32 17 22  ld   ($2217),a
1A1C: 3E 7A     ld   a,$7a
1A1E: 32 A3 21  ld   ($21a3),a
1A21: C3 2A 1A  jp   $1a2a

1A24: 21 FF 12  ld   hl,$12ff ' game over sound
1A27: CD 61 12  call $1261

1A2A: 3E 00     ld   a,$00
1A2C: 32 9B 23  ld   ($239b),a
1A2F: 32 BB 23  ld   ($23bb),a
1A32: 3E FA     ld   a,$fa
1A34: 32 9E 21  ld   ($219e),a
1A37: C3 1E 06  jp   $061e

1A3A: 21 56 1A  ld   hl,$1a56
1A3D: 3A 45 22  ld   a,($2245)
1A40: 87        add  a,a
1A41: 01 00 00  ld   bc,$0000
1A44: 4F        ld   c,a
1A45: 09        add  hl,bc
1A46: 5E        ld   e,(hl)
1A47: 23        inc  hl
1A48: 56        ld   d,(hl)
1A49: 21 5E 1A  ld   hl,$1a5e
1A4C: 79        ld   a,c
1A4D: 1F        rra
1A4E: 4F        ld   c,a
1A4F: 09        add  hl,bc
1A50: 46        ld   b,(hl)
1A51: EB        ex   de,hl
1A52: 11 20 00  ld   de,$0020
1A55: C9        ret

1A56: 8C 23 -> 238C
      8B 23 -> 238B
      8B 23 -> 238B
      8A 23 -> 238A
1A5E: 0F F0 0F F0

1A62: 21 17 22  ld   hl,$2217
1A65: 35        dec  (hl)
1A66: CA 71 1A  jp   z,$1a71
1A69: 3E 72     ld   a,$72
1A6B: 32 A3 21  ld   ($21a3),a
1A6E: C3 1E 06  jp   $061e

1A71: CD D3 06  call $06d3
1A74: 3A 47 22  ld   a,($2247)
1A77: E6 F7     and  $f7
1A79: 32 47 22  ld   ($2247),a
1A7C: 3E 07     ld   a,$07
1A7E: 21 B3 23  ld   hl,$23b3
1A81: 11 93 23  ld   de,$2393
1A84: CD CF 0E  call $0ecf
1A87: C3 1E 06  jp   $061e

1A8A: 32 7B 23  ld   ($237b),a
1A8D: 32 9B 23  ld   ($239b),a
1A90: 32 BB 23  ld   ($23bb),a
1A93: 3E 04     ld   a,$04
1A95: 21 7E 23  ld   hl,$237e
1A98: CD D6 03  call $03d6
1A9B: 3A 13 22  ld   a,($2213)
1A9E: 4F        ld   c,a
1A9F: 3A 7B 23  ld   a,($237b)
1AA2: B9        cp   c
1AA3: C2 AE 1A  jp   nz,$1aae
1AA6: 21 90 21  ld   hl,$2190
1AA9: 3E 04     ld   a,$04
1AAB: CD D6 03  call $03d6

1AAE: 3A 7E 23  ld   a,($237e)
1AB1: 32 BE 23  ld   ($23be),a
1AB4: 47        ld   b,a
1AB5: E6 0F     and  $0f
1AB7: 32 9E 23  ld   ($239e),a
1ABA: 21 90 21  ld   hl,$2190
1ABD: 3E 00     ld   a,$00
1ABF: CD E1 03  call $03e1
1AC2: 06 09     ld   b,$09
1AC4: CD 81 1D  call $1d81
1AC7: 21 B6 23  ld   hl,$23b6
1ACA: 3E 04     ld   a,$04
1ACC: CD E1 03  call $03e1
1ACF: 3E 02     ld   a,$02
1AD1: 32 A1 21  ld   ($21a1),a
1AD4: C3 1E 06  jp   $061e

1AD7: 3A 12 22  ld   a,($2212)
1ADA: 3D        dec  a
1ADB: 32 12 22  ld   ($2212),a
1ADE: CA EF 1A  jp   z,$1aef
1AE1: 21 21 13  ld   hl,$1321 ' sound
1AE4: CD 61 12  call $1261
1AE7: 3E A0     ld   a,$a0
1AE9: 32 A1 21  ld   ($21a1),a
1AEC: C3 1E 06  jp   $061e

1AEF: 21 49 11  ld   hl,$1149 ' no score
1AF2: CD 6F 0E  call $0e6f
1AF5: 3A C9 21  ld   a,($21c9)
1AF8: 32 18 22  ld   ($2218),a
1AFB: 3A CE 21  ld   a,($21ce)
1AFE: 32 19 22  ld   ($2219),a
1B01: CD A8 1B  call $1ba8
1B04: 11 C6 21  ld   de,$21c6
1B07: 3E 10     ld   a,$10
1B09: CD CF 0E  call $0ecf
1B0C: 21 C9 21  ld   hl,$21c9
1B0F: 11 CE 21  ld   de,$21ce
1B12: 3E 0A     ld   a,$0a
1B14: CD CF 0E  call $0ecf
1B17: 06 2B     ld   b,$2b
1B19: CD 76 1D  call $1d76
1B1C: 06 2C     ld   b,$2c
1B1E: CD 76 1D  call $1d76
1B21: 06 04     ld   b,$04
1B23: CD 76 1D  call $1d76
1B26: 06 0C     ld   b,$0c
1B28: CD 76 1D  call $1d76
1B2B: 06 14     ld   b,$14
1B2D: CD 76 1D  call $1d76
1B30: 06 11     ld   b,$11
1B32: CD 81 1D  call $1d81
1B35: 06 38     ld   b,$38
1B37: CD 81 1D  call $1d81
1B3A: 06 31     ld   b,$31
1B3C: CD 81 1D  call $1d81
1B3F: 06 09     ld   b,$09
1B41: CD 81 1D  call $1d81
1B44: 3A 18 22  ld   a,($2218)
1B47: E6 41     and  $41
1B49: 47        ld   b,a
1B4A: 3A C9 21  ld   a,($21c9)
1B4D: E6 BE     and  $be
1B4F: B0        or   b
1B50: 32 C9 21  ld   ($21c9),a
1B53: 3A 19 22  ld   a,($2219)
1B56: E6 41     and  $41
1B58: 47        ld   b,a
1B59: 3A CE 21  ld   a,($21ce)
1B5C: E6 BE     and  $be
1B5E: B0        or   b
1B5F: 32 CE 21  ld   ($21ce),a
1B62: 06 39     ld   b,$39
1B64: CD 81 1D  call $1d81
1B67: 21 92 21  ld   hl,$2192
1B6A: 3E 07     ld   a,$07
1B6C: CD D6 03  call $03d6
1B6F: 21 46 13  ld   hl,$1346 ' sound
1B72: CD 61 12  call $1261
1B75: 3A 14 22  ld   a,($2214)
1B78: 3D        dec  a
1B79: 32 14 22  ld   ($2214),a
1B7C: D6 02     sub  $02
1B7E: FA A5 1B  jp   m,$1ba5
1B81: C2 A5 1B  jp   nz,$1ba5
1B84: 3A 7E 23  ld   a,($237e)
1B87: 06 00     ld   b,$00
1B89: E6 0F     and  $0f

1B8B: 1F        rra
1B8C: D2 93 1B  jp   nc,$1b93
1B8F: 04        inc  b
1B90: C3 8B 1B  jp   $1b8b

1B93: 3A 7A 23  ld   a,($237a)
1B96: 90        sub  b
1B97: F2 A5 1B  jp   p,$1ba5
1B9A: 06 00     ld   b,$00
1B9C: CD 9C 1D  call $1d9c
1B9F: C2 A5 1B  jp   nz,$1ba5
1BA2: CD 76 1D  call $1d76
1BA5: C3 1E 06  jp   $061e

1BA8: 3A 7E 23  ld   a,($237e)
1BAB: E6 F0     and  $f0
1BAD: 21 EB 21  ld   hl,$21eb
1BB0: 11 F8 FF  ld   de,$fff8

1BB3: 17        rla
1BB4: D8        ret  c
1BB5: 19        add  hl,de
1BB6: C3 B3 1B  jp   $1bb3

1BB9: FB        ei
1BBA: 21 15 22  ld   hl,$2215
1BBD: DB 04     in   a,($04)
1BBF: 77        ld   (hl),a
1BC0: E6 40     and  $40
1BC2: C2 73 1C  jp   nz,$1c73
1BC5: F3        di
1BC6: 3A 53 23  ld   a,($2353)
1BC9: 47        ld   b,a
1BCA: 3A F8 23  ld   a,($23f8)
1BCD: 90        sub  b
1BCE: 3A 94 21  ld   a,($2194)
1BD1: FA D9 1B  jp   m,$1bd9
1BD4: E6 FD     and  $fd
1BD6: C3 DB 1B  jp   $1bdb

1BD9: F6 02     or   $02

1BDB: 32 94 21  ld   ($2194),a
1BDE: 3A 92 21  ld   a,($2192)
1BE1: 47        ld   b,a
1BE2: E6 01     and  $01
1BE4: CA 04 1C  jp   z,$1c04
1BE7: 78        ld   a,b
1BE8: E6 FE     and  $fe
1BEA: 32 92 21  ld   ($2192),a
1BED: FB        ei
1BEE: 21 4B 22  ld   hl,$224b
1BF1: 11 80 23  ld   de,$2380
1BF4: 3E 34     ld   a,$34
1BF6: CD CF 0E  call $0ecf
1BF9: 21 6B 22  ld   hl,$226b
1BFC: 11 A0 23  ld   de,$23a0
1BFF: 3E 34     ld   a,$34
1C01: CD CF 0E  call $0ecf
1C04: 3A 15 22  ld   a,($2215)
1C07: E6 20     and  $20
1C09: C2 C3 1C  jp   nz,$1cc3
1C0C: FB        ei
1C0D: 21 2D 22  ld   hl,$222d
1C10: 11 B3 23  ld   de,$23b3
1C13: 3E 07     ld   a,$07
1C15: CD EA 0E  call $0eea
1C18: 21 89 11  ld   hl,$1189
1C1B: 3A 47 22  ld   a,($2247)
1C1E: E6 08     and  $08
1C20: C2 26 1C  jp   nz,$1c26
1C23: 21 B3 23  ld   hl,$23b3
1C26: 11 93 23  ld   de,$2393
1C29: 3E 07     ld   a,$07
1C2B: CD CF 0E  call $0ecf
1C2E: 3A 92 21  ld   a,($2192)
1C31: E6 40     and  $40
1C33: CA 4E 1C  jp   z,$1c4e
1C36: 3A 7A 23  ld   a,($237a)
1C39: B7        or   a
1C3A: 21 B6 23  ld   hl,$23b6
1C3D: 3E 06     ld   a,$06
1C3F: C2 48 1C  jp   nz,$1c48
1C42: CD D6 03  call $03d6
1C45: C3 D2 01  jp   $01d2

1C48: CD E1 03  call $03e1
1C4B: C3 D2 01  jp   $01d2

1C4E: 3A 91 21  ld   a,($2191)
1C51: E6 01     and  $01
1C53: FB        ei
1C54: CA D2 01  jp   z,$01d2
1C57: DB 03     in   a,($03)
1C59: FE FE     cp   $fe
1C5B: C2 65 1C  jp   nz,$1c65
1C5E: DB 02     in   a,($02)
1C60: FE FB     cp   $fb
1C62: CA DC 1C  jp   z,$1cdc
1C65: 21 91 21  ld   hl,$2191
1C68: 3E 00     ld   a,$00
1C6A: CD E1 03  call $03e1
1C6D: 32 9F 21  ld   ($219f),a
1C70: C3 D2 01  jp   $01d2

1C73: 21 92 21  ld   hl,$2192
1C76: 3E 00     ld   a,$00
1C78: CD EE 03  call $03ee
1C7B: C2 2C 02  jp   nz,$022c
1C7E: CD D6 03  call $03d6
1C81: 21 80 23  ld   hl,$2380
1C84: 11 4B 22  ld   de,$224b
1C87: 3E 80     ld   a,$80
1C89: CD CF 0E  call $0ecf
1C8C: 3E FF     ld   a,$ff
1C8E: 21 83 23  ld   hl,$2383
1C91: 06 17     ld   b,$17
1C93: 77        ld   (hl),a
1C94: 23        inc  hl
1C95: 05        dec  b
1C96: C2 93 1C  jp   nz,$1c93
1C99: 3E 0F     ld   a,$0f
1C9B: 32 8C 23  ld   ($238c),a
1C9E: 21 20 23  ld   hl,$2320
1CA1: 11 A3 23  ld   de,$23a3
1CA4: 3E 2E     ld   a,$2e
1CA6: CD CF 0E  call $0ecf
1CA9: 3A 61 22  ld   a,($2261)
1CAC: F6 0F     or   $0f
1CAE: 32 96 23  ld   ($2396),a
1CB1: 3A 81 22  ld   a,($2281)
1CB4: E6 F0     and  $f0
1CB6: 47        ld   b,a
1CB7: 3A B6 23  ld   a,($23b6)
1CBA: E6 0F     and  $0f
1CBC: B0        or   b
1CBD: 32 B6 23  ld   ($23b6),a
1CC0: C3 2C 02  jp   $022c

1CC3: 3A 53 23  ld   a,($2353)
1CC6: 47        ld   b,a
1CC7: 3A F8 23  ld   a,($23f8)
1CCA: 90        sub  b
1CCB: F2 2C 02  jp   p,$022c
1CCE: 21 92 21  ld   hl,$2192
1CD1: 3E 06     ld   a,$06
1CD3: CD EE 03  call $03ee
1CD6: CA DC 1C  jp   z,$1cdc
1CD9: C3 2C 02  jp   $022c

1CDC: 3A 7E 23  ld   a,($237e)
1CDF: 32 9E 23  ld   ($239e),a
1CE2: 3A AC 23  ld   a,($23ac)
1CE5: 32 8C 23  ld   ($238c),a
1CE8: 3A BB 23  ld   a,($23bb)
1CEB: 32 9B 23  ld   ($239b),a
1CEE: 3A AA 23  ld   a,($23aa)
1CF1: 32 8A 23  ld   ($238a),a
1CF4: 3A AB 23  ld   a,($23ab)
1CF7: 32 8B 23  ld   ($238b),a
1CFA: 3A AC 23  ld   a,($23ac)
1CFD: 32 8C 23  ld   ($238c),a
1D00: 3A 96 23  ld   a,($2396)
1D03: E6 EF     and  $ef
1D05: 32 96 23  ld   ($2396),a
1D08: 3A B6 23  ld   a,($23b6)
1D0B: E6 EF     and  $ef
1D0D: 32 B6 23  ld   ($23b6),a
1D10: E6 20     and  $20
1D12: 47        ld   b,a
1D13: 3A 96 23  ld   a,($2396)
1D16: B0        or   b
1D17: 32 96 23  ld   ($2396),a
1D1A: 21 C2 21  ld   hl,$21c2
1D1D: 3E 05     ld   a,$05
1D1F: CD D6 03  call $03d6
1D22: 3A C2 21  ld   a,($21c2)
1D25: 2F        cpl
1D26: D3 05     out  ($05),a
1D28: 3E 80     ld   a,$80
1D2A: 32 93 21  ld   ($2193),a
1D2D: 3E 06     ld   a,$06
1D2F: 32 AC 21  ld   ($21ac),a
1D32: 3E 00     ld   a,$00
1D34: 32 94 21  ld   ($2194),a
1D37: 3A 90 21  ld   a,($2190)
1D3A: E6 38     and  $38
1D3C: F6 80     or   $80
1D3E: 32 90 21  ld   ($2190),a
1D41: 3A 92 21  ld   a,($2192)
1D44: E6 67     and  $67
1D46: 32 92 21  ld   ($2192),a
1D49: 21 91 21  ld   hl,$2191
1D4C: 3E 01     ld   a,$01
1D4E: CD E1 03  call $03e1
1D51: 21 94 21  ld   hl,$2194
1D54: 3E 04     ld   a,$04
1D56: CD D6 03  call $03d6
1D59: 3E 06     ld   a,$06
1D5B: 32 A8 21  ld   ($21a8),a
1D5E: 3E 05     ld   a,$05
1D60: 32 97 21  ld   ($2197),a
1D63: C3 2C 02  jp   $022c

1D66: 21 C2 21  ld   hl,$21c2
1D69: 3E 05     ld   a,$05
1D6B: CD E1 03  call $03e1
1D6E: F3        di
1D6F: CD 7D 13  call $137d
1D72: FB        ei
1D73: C3 1E 06  jp   $061e

1D76: CD A3 1D  call $1da3
1D79: CD D6 03  call $03d6
1D7C: 19        add  hl,de
1D7D: CD D6 03  call $03d6
1D80: C9        ret

1D81: CD A3 1D  call $1da3
1D84: CD E1 03  call $03e1
1D87: 19        add  hl,de
1D88: CD EE 03  call $03ee
1D8B: F5        push af
1D8C: CD E1 03  call $03e1
1D8F: F1        pop  af
1D90: C9        ret

1D91: CD A3 1D  call $1da3
1D94: CD D6 03  call $03d6
1D97: 19        add  hl,de
1D98: CD E1 03  call $03e1
1D9B: C9        ret

1D9C: CD A3 1D  call $1da3
1D9F: CD EE 03  call $03ee
1DA2: C9        ret

1DA3: 21 C9 21  ld   hl,$21c9
1DA6: 16 00     ld   d,$00
1DA8: 78        ld   a,b
1DA9: E6 07     and  $07
1DAB: 5F        ld   e,a
1DAC: 19        add  hl,de
1DAD: 78        ld   a,b
1DAE: 1F        rra
1DAF: 1F        rra
1DB0: 1F        rra
1DB1: E6 07     and  $07
1DB3: 11 05 00  ld   de,$0005
1DB6: C9        ret

1DB7: 21 63 23  ld   hl,$2363
1DBA: CD D4 1F  call $1fd4
1DBD: 21 6B 23  ld   hl,$236b
1DC0: E5        push hl
1DC1: CD 18 0E  call $0e18
1DC4: E1        pop  hl
1DC5: D2 D4 1D  jp   nc,$1dd4
1DC8: 22 3D 22  ld   ($223d),hl
1DCB: 21 63 23  ld   hl,$2363
1DCE: 22 3F 22  ld   ($223f),hl
1DD1: C3 DD 1D  jp   $1ddd

1DD4: 22 3F 22  ld   ($223f),hl
1DD7: 21 63 23  ld   hl,$2363
1DDA: 22 3D 22  ld   ($223d),hl

1DDD: 2A 3D 22  ld   hl,($223d)
1DE0: CD D4 1F  call $1fd4
1DE3: 21 5F 23  ld   hl,$235f
1DE6: E5        push hl
1DE7: CD 18 0E  call $0e18
1DEA: E1        pop  hl
1DEB: DA 04 1E  jp   c,$1e04
1DEE: E5        push hl
1DEF: 2A 3F 22  ld   hl,($223f)
1DF2: CD D4 1F  call $1fd4
1DF5: E1        pop  hl
1DF6: E5        push hl
1DF7: CD 18 0E  call $0e18
1DFA: E1        pop  hl
1DFB: DA 0F 1E  jp   c,$1e0f
1DFE: 22 41 22  ld   ($2241),hl
1E01: C3 17 1E  jp   $1e17

1E04: E5        push hl
1E05: CD 6A 1E  call $1e6a
1E08: E1        pop  hl
1E09: 22 3D 22  ld   ($223d),hl
1E0C: C3 17 1E  jp   $1e17

1E0F: E5        push hl
1E10: CD 6A 1E  call $1e6a
1E13: E1        pop  hl
1E14: 22 3F 22  ld   ($223f),hl

1E17: 2A 3D 22  ld   hl,($223d)
1E1A: CD D4 1F  call $1fd4
1E1D: 21 6F 23  ld   hl,$236f
1E20: E5        push hl
1E21: CD 18 0E  call $0e18
1E24: E1        pop  hl
1E25: DA 4E 1E  jp   c,$1e4e
1E28: E5        push hl
1E29: 2A 3F 22  ld   hl,($223f)
1E2C: CD D4 1F  call $1fd4
1E2F: E1        pop  hl
1E30: E5        push hl
1E31: CD 18 0E  call $0e18
1E34: E1        pop  hl
1E35: DA 59 1E  jp   c,$1e59
1E38: E5        push hl
1E39: 2A 41 22  ld   hl,($2241)
1E3C: CD D4 1F  call $1fd4
1E3F: E1        pop  hl
1E40: E5        push hl
1E41: CD 18 0E  call $0e18
1E44: E1        pop  hl
1E45: DA 77 1E  jp   c,$1e77
1E48: 22 43 22  ld   ($2243),hl
1E4B: C3 82 1E  jp   $1e82

1E4E: E5        push hl
1E4F: CD 64 1E  call $1e64
1E52: E1        pop  hl
1E53: 22 3D 22  ld   ($223d),hl
1E56: C3 82 1E  jp   $1e82

1E59: E5        push hl
1E5A: CD 6A 1E  call $1e6a
1E5D: E1        pop  hl
1E5E: 22 3F 22  ld   ($223f),hl
1E61: C3 82 1E  jp   $1e82

1E64: 2A 41 22  ld   hl,($2241)
1E67: 22 43 22  ld   ($2243),hl
1E6A: 2A 3F 22  ld   hl,($223f)
1E6D: 22 41 22  ld   ($2241),hl
1E70: 2A 3D 22  ld   hl,($223d)
1E73: 22 3F 22  ld   ($223f),hl
1E76: C9        ret

1E77: E5        push hl
1E78: 2A 41 22  ld   hl,($2241)
1E7B: 22 43 22  ld   ($2243),hl
1E7E: E1        pop  hl
1E7F: 22 41 22  ld   ($2241),hl

1E82: 21 2D 22  ld   hl,$222d
1E85: CD D4 1F  call $1fd4
1E88: 2A 3D 22  ld   hl,($223d)
1E8B: E5        push hl
1E8C: CD 18 0E  call $0e18
1E8F: E1        pop  hl
1E90: DC 5E 1F  call c,$1f5e
1E93: D8        ret  c
1E94: 21 31 22  ld   hl,$2231
1E97: CD D4 1F  call $1fd4
1E9A: 2A 3D 22  ld   hl,($223d)
1E9D: E5        push hl
1E9E: CD 18 0E  call $0e18
1EA1: E1        pop  hl
1EA2: DC 7E 1F  call c,$1f7e
1EA5: D8        ret  c
1EA6: 21 35 22  ld   hl,$2235
1EA9: CD D4 1F  call $1fd4
1EAC: 2A 3D 22  ld   hl,($223d)
1EAF: E5        push hl
1EB0: CD 18 0E  call $0e18
1EB3: E1        pop  hl
1EB4: DC 8F 1F  call c,$1f8f
1EB7: D8        ret  c
1EB8: 21 39 22  ld   hl,$2239
1EBB: CD D4 1F  call $1fd4
1EBE: 2A 3D 22  ld   hl,($223d)
1EC1: E5        push hl
1EC2: CD 18 0E  call $0e18
1EC5: E1        pop  hl
1EC6: DC A0 1F  call c,$1fa0
1EC9: C9        ret

1ECA: 21 31 22  ld   hl,$2231
1ECD: CD D4 1F  call $1fd4
1ED0: 2A 3F 22  ld   hl,($223f)
1ED3: E5        push hl
1ED4: CD 18 0E  call $0e18
1ED7: E1        pop  hl
1ED8: DC 7E 1F  call c,$1f7e
1EDB: D8        ret  c
1EDC: 21 35 22  ld   hl,$2235
1EDF: CD D4 1F  call $1fd4
1EE2: 2A 3F 22  ld   hl,($223f)
1EE5: E5        push hl
1EE6: CD 18 0E  call $0e18
1EE9: E1        pop  hl
1EEA: DC 8F 1F  call c,$1f8f
1EED: D8        ret  c
1EEE: 21 39 22  ld   hl,$2239
1EF1: CD D4 1F  call $1fd4
1EF4: 2A 3F 22  ld   hl,($223f)
1EF7: E5        push hl
1EF8: CD 18 0E  call $0e18
1EFB: E1        pop  hl
1EFC: DC A0 1F  call c,$1fa0
1EFF: C9        ret

1F00: 21 35 22  ld   hl,$2235
1F03: CD D4 1F  call $1fd4
1F06: 2A 41 22  ld   hl,($2241)
1F09: E5        push hl
1F0A: CD 18 0E  call $0e18
1F0D: E1        pop  hl
1F0E: DC 8F 1F  call c,$1f8f
1F11: D8        ret  c
1F12: 21 39 22  ld   hl,$2239
1F15: CD D4 1F  call $1fd4
1F18: 2A 41 22  ld   hl,($2241)
1F1B: E5        push hl
1F1C: CD 18 0E  call $0e18
1F1F: E1        pop  hl
1F20: DC A0 1F  call c,$1fa0
1F23: C9        ret

1F24: 21 39 22  ld   hl,$2239
1F27: CD D4 1F  call $1fd4
1F2A: 2A 43 22  ld   hl,($2243)
1F2D: E5        push hl
1F2E: CD 18 0E  call $0e18
1F31: E1        pop  hl
1F32: DC A0 1F  call c,$1fa0
1F35: C9        ret

1F36: F5        push af
1F37: 21 35 22  ld   hl,$2235
1F3A: E5        push hl
1F3B: 11 39 22  ld   de,$2239
1F3E: 3E 07     ld   a,$07
1F40: CD CF 0E  call $0ecf
1F43: D1        pop  de
1F44: F1        pop  af
1F45: 3D        dec  a
1F46: C8        ret  z
1F47: F5        push af
1F48: 21 31 22  ld   hl,$2231
1F4B: E5        push hl
1F4C: 3E 07     ld   a,$07
1F4E: CD CF 0E  call $0ecf
1F51: D1        pop  de
1F52: F1        pop  af
1F53: 3D        dec  a
1F54: C8        ret  z
1F55: 21 2D 22  ld   hl,$222d
1F58: 3E 07     ld   a,$07
1F5A: CD CF 0E  call $0ecf
1F5D: C9        ret

1F5E: E5        push hl
1F5F: 3E 03     ld   a,$03
1F61: CD 36 1F  call $1f36
1F64: E1        pop  hl
1F65: 11 2D 22  ld   de,$222d
1F68: 3E 07     ld   a,$07
1F6A: CD CF 0E  call $0ecf
1F6D: 21 51 13  ld   hl,$1351 ' new HSTD sound
1F70: CD 61 12  call $1261
1F73: 3A 47 22  ld   a,($2247)
1F76: F6 08     or   $08
1F78: 32 47 22  ld   ($2247),a
1F7B: B7        or   a
1F7C: 3F        ccf
1F7D: C9        ret

1F7E: E5        push hl
1F7F: 3E 02     ld   a,$02
1F81: CD 36 1F  call $1f36
1F84: E1        pop  hl
1F85: 11 31 22  ld   de,$2231
1F88: 3E 07     ld   a,$07
1F8A: CD CF 0E  call $0ecf
1F8D: 3F        ccf
1F8E: C9        ret

1F8F: E5        push hl
1F90: 3E 01     ld   a,$01
1F92: CD 36 1F  call $1f36
1F95: E1        pop  hl
1F96: 11 35 22  ld   de,$2235
1F99: 3E 07     ld   a,$07
1F9B: CD CF 0E  call $0ecf
1F9E: 3F        ccf
1F9F: C9        ret

1FA0: 11 39 22  ld   de,$2239
1FA3: 3E 07     ld   a,$07
1FA5: CD CF 0E  call $0ecf
1FA8: 3F        ccf
1FA9: C9        ret

1FAA: 21 31 22  ld   hl,$2231
1FAD: E5        push hl
1FAE: 11 2D 22  ld   de,$222d
1FB1: 3E 07     ld   a,$07
1FB3: CD CF 0E  call $0ecf
1FB6: D1        pop  de
1FB7: 21 35 22  ld   hl,$2235
1FBA: E5        push hl
1FBB: 3E 07     ld   a,$07
1FBD: CD CF 0E  call $0ecf
1FC0: D1        pop  de
1FC1: 21 39 22  ld   hl,$2239
1FC4: E5        push hl
1FC5: 3E 07     ld   a,$07
1FC7: CD CF 0E  call $0ecf
1FCA: 21 81 11  ld   hl,$1181 ' 25,000 pts
1FCD: D1        pop  de
1FCE: 3E 07     ld   a,$07
1FD0: CD CF 0E  call $0ecf
1FD3: C9        ret

1FD4: 11 F3 21  ld   de,$21f3
1FD7: 3E 00     ld   a,$00
1FD9: 06 04     ld   b,$04
1FDB: 12        ld   (de),a
1FDC: 13        inc  de
1FDD: 05        dec  b
1FDE: C2 DB 1F  jp   nz,$1fdb
1FE1: 11 F3 21  ld   de,$21f3
1FE4: 3E 07     ld   a,$07
1FE6: CD CF 0E  call $0ecf
1FE9: 3E 07     ld   a,$07
1FEB: C9        ret

1FEC: 00 00 00 60 2C 02 00 00

1FF4: 4C 4F 4F 50 32 3E ' "LOOP2."

1FFA: B1 00 00 00 60 92
