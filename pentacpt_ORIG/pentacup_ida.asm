ROM:0000	     ;
ROM:0000	     ; +-------------------------------------------------------------------------+
ROM:0000	     ; |   This	file has been generated	by The Interactive Disassembler	(IDA)	 |
ROM:0000	     ; |	Copyright (c) 2009 by Hex-Rays,	<support@hex-rays.com>		 |
ROM:0000	     ; |		      License info: 48-B139-70D4-A8			 |
ROM:0000	     ; |			  Joe Britt, Danger Inc				 |
ROM:0000	     ; +-------------------------------------------------------------------------+
ROM:0000	     ;
ROM:0000	     ; Input MD5   : 920525A3B93F9065B8FA197C0F1AEBDE
ROM:0000
ROM:0000	     ; ---------------------------------------------------------------------------
ROM:0000	     ; File Name   : C:\Users\britt\OneDrive\Desktop\micropin\micropin_matt_walsh_version.bin
ROM:0000	     ; Format	   : Binary file
ROM:0000	     ; Base Address: 0000h Range: 0000h	- 2000h	Loaded length: 2000h
ROM:0000
ROM:0000	     ; Processor       : 8085 []
ROM:0000	     ; Target assembler: Table Driven Assembler	(TASM) by Speech Technology Inc.
ROM:0000
ROM:0000	     ; ===========================================================================
ROM:0000
ROM:0000	     ; Segment type: Pure code
ROM:0000 C3 40 00		     jmp     reset_entry
ROM:0000	     ; ---------------------------------------------------------------------------
ROM:0003 76			     .db  76h ;	v
ROM:0004 76			     .db  76h ;	v
ROM:0005 76			     .db  76h ;	v
ROM:0006 76			     .db  76h ;	v
ROM:0007 76			     .db  76h ;	v
ROM:0008 76			     .db  76h ;	v
ROM:0009 76			     .db  76h ;	v
ROM:000A 76			     .db  76h ;	v
ROM:000B 76			     .db  76h ;	v
ROM:000C 76			     .db  76h ;	v
ROM:000D 76			     .db  76h ;	v
ROM:000E 76			     .db  76h ;	v
ROM:000F 76			     .db  76h ;	v
ROM:0010 76			     .db  76h ;	v
ROM:0011 76			     .db  76h ;	v
ROM:0012 76			     .db  76h ;	v
ROM:0013 76			     .db  76h ;	v
ROM:0014 76			     .db  76h ;	v
ROM:0015 76			     .db  76h ;	v
ROM:0016 76			     .db  76h ;	v
ROM:0017 76			     .db  76h ;	v
ROM:0018 76			     .db  76h ;	v
ROM:0019 76			     .db  76h ;	v
ROM:001A 76			     .db  76h ;	v
ROM:001B 76			     .db  76h ;	v
ROM:001C 76			     .db  76h ;	v
ROM:001D 76			     .db  76h ;	v
ROM:001E 76			     .db  76h ;	v
ROM:001F 76			     .db  76h ;	v
ROM:0020 76			     .db  76h ;	v
ROM:0021 76			     .db  76h ;	v
ROM:0022 76			     .db  76h ;	v
ROM:0023 76			     .db  76h ;	v
ROM:0024	     ; ---------------------------------------------------------------------------
ROM:0024 C3 6E 00		     jmp     handle_TRAP
ROM:0024	     ; ---------------------------------------------------------------------------
ROM:0027 76			     .db  76h ;	v
ROM:0028 76			     .db  76h ;	v
ROM:0029 76			     .db  76h ;	v
ROM:002A 76			     .db  76h ;	v
ROM:002B 46			     .db  46h ;	F
ROM:002C	     ; ---------------------------------------------------------------------------
ROM:002C C3 24 03		     jmp     handle_RST_5_5
ROM:002C	     ; ---------------------------------------------------------------------------
ROM:002F 76			     .db  76h ;	v
ROM:0030 76			     .db  76h ;	v
ROM:0031 76			     .db  76h ;	v
ROM:0032 76			     .db  76h ;	v
ROM:0033 00			     .db    0
ROM:0034	     ; ---------------------------------------------------------------------------
ROM:0034 C3 7E 03		     jmp     handle_RST_6_5
ROM:0034	     ; ---------------------------------------------------------------------------
ROM:0037 76			     .db  76h ;	v
ROM:0038	     ; ---------------------------------------------------------------------------
ROM:0038
ROM:0038	     loc_38:				     ; CODE XREF: ROM:120Ep
ROM:0038						     ; ROM:120Fp ...
ROM:0038 76			     hlt
ROM:0039 76			     hlt
ROM:003A 76			     hlt
ROM:003A	     ; ---------------------------------------------------------------------------
ROM:003B C2			     .db 0C2h ;	Â
ROM:003C	     ; ---------------------------------------------------------------------------
ROM:003C
ROM:003C	     handle_RST_7_5:
ROM:003C C3 00 28		     jmp     2800h
ROM:003C	     ; ---------------------------------------------------------------------------
ROM:003F 76			     .db  76h ;	v
ROM:0040
ROM:0040	     ; =============== S U B R O U T I N E =======================================
ROM:0040
ROM:0040	     ; Attributes: noreturn
ROM:0040
ROM:0040	     reset_entry:			     ; CODE XREF: ROM:0000j
ROM:0040						     ; ROM:03BEp
ROM:0040
ROM:0040	     ; FUNCTION	CHUNK AT ROM:030B SIZE 00000019	BYTES
ROM:0040	     ; FUNCTION	CHUNK AT ROM:1BB4 SIZE 00000071	BYTES
ROM:0040	     ; FUNCTION	CHUNK AT ROM:1C28 SIZE 00000003	BYTES
ROM:0040	     ; FUNCTION	CHUNK AT ROM:1C2E SIZE 0000001F	BYTES
ROM:0040	     ; FUNCTION	CHUNK AT ROM:1C53 SIZE 00000008	BYTES
ROM:0040	     ; FUNCTION	CHUNK AT ROM:1CE1 SIZE 00000013	BYTES
ROM:0040	     ; FUNCTION	CHUNK AT ROM:1CFA SIZE 00000011	BYTES
ROM:0040
ROM:0040 3E 20			     mvi     a,	20h ; ' '
ROM:0042 32 DF 23		     sta     23DFh
ROM:0045 16 05			     mvi     d,	5
ROM:0047
ROM:0047	     loc_47:				     ; CODE XREF: reset_entry+13j
ROM:0047 21 10 27		     lxi     h,	2710h
ROM:004A
ROM:004A	     loc_4A:				     ; CODE XREF: reset_entry+Fj
ROM:004A 2B			     dcx     h
ROM:004B D3 0F			     out     0Fh
ROM:004D 7C			     mov     a,	h
ROM:004E B7			     ora     a
ROM:004F C2 4A 00		     jnz     loc_4A
ROM:0052 15			     dcr     d
ROM:0053 C2 47 00		     jnz     loc_47
ROM:0056 DB 04			     in	     4
ROM:0058 E6 20			     ani     20h
ROM:005A CA 6E 00		     jz	     handle_TRAP
ROM:005D 21 00 20		     lxi     h,	2000h
ROM:0060
ROM:0060	     loc_60:				     ; CODE XREF: reset_entry+26j
ROM:0060 97			     sub     a
ROM:0061 77			     mov     m,	a
ROM:0062 23			     inx     h
ROM:0063 3E 24			     mvi     a,	24h ; '$'
ROM:0065 BC			     cmp     h
ROM:0066 C2 60 00		     jnz     loc_60
ROM:0069 3E 64			     mvi     a,	64h ; 'd'
ROM:006B 32 40 22		     sta     2240h
ROM:006E
ROM:006E	     handle_TRAP:			     ; CODE XREF: ROM:0024j
ROM:006E						     ; reset_entry+1Aj
ROM:006E 31 90 21		     lxi     sp, 2190h
ROM:0071 3E 07			     mvi     a,	7
ROM:0073
ROM:0073	     loc_73:				     ; CODE XREF: reset_entry+38j
ROM:0073 D3 0E			     out     0Eh
ROM:0075 D3 0D			     out     0Dh
ROM:0077 3D			     dcr     a
ROM:0078 F2 73 00		     jp	     loc_73
ROM:007B 21 97 21		     lxi     h,	2197h
ROM:007E 0E 2D			     mvi     c,	2Dh ; '-'
ROM:0080
ROM:0080	     loc_80:				     ; CODE XREF: reset_entry+44j
ROM:0080 97			     sub     a
ROM:0081 77			     mov     m,	a
ROM:0082 23			     inx     h
ROM:0083 0D			     dcr     c
ROM:0084 C2 80 00		     jnz     loc_80
ROM:0087 3E 05			     mvi     a,	5
ROM:0089 32 A3 21		     sta     21A3h
ROM:008C 3E FE			     mvi     a,	0FEh ; 'þ'
ROM:008E D3 09			     out     9
ROM:0090 3E 02			     mvi     a,	2
ROM:0092 32 98 21		     sta     2198h
ROM:0095 3E FF			     mvi     a,	0FFh
ROM:0097 32 93 21		     sta     2193h
ROM:009A 3E FC			     mvi     a,	0FCh ; 'ü'
ROM:009C 32 94 21		     sta     2194h
ROM:009F 21 FB 21		     lxi     h,	21FBh
ROM:00A2 22 F9 21		     shld    21F9h
ROM:00A5 21 B4 21		     lxi     h,	21B4h
ROM:00A8 22 BE 21		     shld    21BEh
ROM:00AB 22 C0 21		     shld    21C0h
ROM:00AE 3E 0F			     mvi     a,	0Fh
ROM:00B0 32 F8 21		     sta     21F8h
ROM:00B3 3A 90 21		     lda     2190h
ROM:00B6 F6 05			     ori     5
ROM:00B8 32 90 21		     sta     2190h
ROM:00BB 3E 0C			     mvi     a,	0Ch
ROM:00BD 30			     sim
ROM:00BE DB 04			     in	     4
ROM:00C0 E6 20			     ani     20h
ROM:00C2 C2 0B 03		     jnz     loc_30B
ROM:00C5 CD F3 02		     call    sub_2F3
ROM:00C8 CA 13 01		     jz	     loc_113
ROM:00CB
ROM:00CB	     loc_CB:				     ; CODE XREF: reset_entry+2E1j
ROM:00CB 3E 07			     mvi     a,	7
ROM:00CD 32 C2 21		     sta     21C2h
ROM:00D0 2F			     cma
ROM:00D1 D3 05			     out     5
ROM:00D3 3E 06			     mvi     a,	6
ROM:00D5 32 A6 21		     sta     21A6h
ROM:00D8
ROM:00D8	     loc_D8:				     ; CODE XREF: reset_entry+9Dj
ROM:00D8 FB			     ei
ROM:00D9 3A A6 21		     lda     21A6h
ROM:00DC B7			     ora     a
ROM:00DD C2 D8 00		     jnz     loc_D8
ROM:00E0 3E 28			     mvi     a,	28h ; '('
ROM:00E2 32 C2 21		     sta     21C2h
ROM:00E5 2F			     cma
ROM:00E6 D3 05			     out     5
ROM:00E8 3E 20			     mvi     a,	20h ; ' '
ROM:00EA 32 C4 21		     sta     21C4h
ROM:00ED 2F			     cma
ROM:00EE D3 07			     out     7
ROM:00F0 3E 02			     mvi     a,	2
ROM:00F2 32 C5 21		     sta     21C5h
ROM:00F5 2F			     cma
ROM:00F6 D3 08			     out     8
ROM:00F8 3E 06			     mvi     a,	6
ROM:00FA 32 A6 21		     sta     21A6h
ROM:00FD
ROM:00FD	     loc_FD:				     ; CODE XREF: reset_entry+C2j
ROM:00FD FB			     ei
ROM:00FE 3A A6 21		     lda     21A6h
ROM:0101 B7			     ora     a
ROM:0102 C2 FD 00		     jnz     loc_FD
ROM:0105 3E FF			     mvi     a,	0FFh
ROM:0107 D3 05			     out     5
ROM:0109 D3 06			     out     6
ROM:010B D3 07			     out     7
ROM:010D D3 08			     out     8
ROM:010F F3			     di
ROM:0110 CD DE 13		     call    sub_13DE
ROM:0113	     ; ---------------------------------------------------------------------------
ROM:0113
ROM:0113	     loc_113:				     ; CODE XREF: reset_entry+88j
ROM:0113						     ; reset_entry+29Cj
ROM:0113 DB 04			     in	     4
ROM:0115 E6 20			     ani     20h
ROM:0117 C2 38 01		     jnz     loc_138
ROM:011A 3A 92 21		     lda     2192h
ROM:011D E6 DF			     ani     0DFh
ROM:011F 32 92 21		     sta     2192h
ROM:0122 DB 03			     in	     3
ROM:0124 FE FE			     cpi     0FEh ; 'þ'
ROM:0126 C2 8F 01		     jnz     loc_18F
ROM:0129 DB 02			     in	     2
ROM:012B FE FB			     cpi     0FBh ; 'û'
ROM:012D CA 7A 02		     jz	     loc_27A
ROM:0130 FE F7			     cpi     0F7h ; '÷'
ROM:0132 CA A4 02		     jz	     loc_2A4
ROM:0135 C3 8F 01		     jmp     loc_18F
ROM:0138	     ; ---------------------------------------------------------------------------
ROM:0138
ROM:0138	     loc_138:				     ; CODE XREF: reset_entry+D7j
ROM:0138						     ; reset_entry+261j
ROM:0138 CD 22 18		     call    sub_1822
ROM:013B 3E D0			     mvi     a,	0D0h ; 'Ð'
ROM:013D 32 92 21		     sta     2192h
ROM:0140 3E 00			     mvi     a,	0
ROM:0142 32 7E 23		     sta     237Eh
ROM:0145 32 9E 23		     sta     239Eh
ROM:0148 32 BE 23		     sta     23BEh
ROM:014B 32 7A 23		     sta     237Ah
ROM:014E 32 9A 23		     sta     239Ah
ROM:0151 32 BA 23		     sta     23BAh
ROM:0154 3E 0F			     mvi     a,	0Fh
ROM:0156 32 7B 23		     sta     237Bh
ROM:0159 32 9B 23		     sta     239Bh
ROM:015C 32 BB 23		     sta     23BBh
ROM:015F 32 96 23		     sta     2396h
ROM:0162 32 B6 23		     sta     23B6h
ROM:0165 21 A3 23		     lxi     h,	23A3h
ROM:0168 11 20 23		     lxi     d,	2320h
ROM:016B 3E 2E			     mvi     a,	2Eh ; '.'
ROM:016D CD 60 0F		     call    sub_F60
ROM:0170 06 01			     mvi     b,	1
ROM:0172 11 C6 21		     lxi     d,	21C6h
ROM:0175 CD 08 18		     call    sub_1808
ROM:0178 21 C9 21		     lxi     h,	21C9h
ROM:017B 11 CE 21		     lxi     d,	21CEh
ROM:017E 3E 0A			     mvi     a,	0Ah
ROM:0180 CD 60 0F		     call    sub_F60
ROM:0183 21 05 22		     lxi     h,	2205h
ROM:0186 06 13			     mvi     b,	13h
ROM:0188 97			     sub     a
ROM:0189
ROM:0189	     loc_189:				     ; CODE XREF: reset_entry+14Cj
ROM:0189 77			     mov     m,	a
ROM:018A 23			     inx     h
ROM:018B 05			     dcr     b
ROM:018C C2 89 01		     jnz     loc_189
ROM:018F
ROM:018F	     loc_18F:				     ; CODE XREF: reset_entry+E6j
ROM:018F						     ; reset_entry+F5j	...
ROM:018F F3			     di
ROM:0190 3E 30			     mvi     a,	30h ; '0'
ROM:0192 32 94 21		     sta     2194h
ROM:0195 3A 92 21		     lda     2192h
ROM:0198 E6 80			     ani     80h
ROM:019A C2 A2 01		     jnz     loc_1A2
ROM:019D 3E 00			     mvi     a,	0
ROM:019F 32 92 21		     sta     2192h
ROM:01A2
ROM:01A2	     loc_1A2:				     ; CODE XREF: reset_entry+15Aj
ROM:01A2						     ; ROM:1C25j ...
ROM:01A2 DB 02			     in	     2
ROM:01A4 0E 00			     mvi     c,	0
ROM:01A6 06 08			     mvi     b,	8
ROM:01A8
ROM:01A8	     loc_1A8:				     ; CODE XREF: reset_entry+172j
ROM:01A8 1F			     rar
ROM:01A9 D2 BC 01		     jnc     loc_1BC
ROM:01AC FB			     ei
ROM:01AD 0C			     inr     c
ROM:01AE 05			     dcr     b
ROM:01AF CA B5 01		     jz	     loc_1B5
ROM:01B2 C3 A8 01		     jmp     loc_1A8
ROM:01B5	     ; ---------------------------------------------------------------------------
ROM:01B5
ROM:01B5	     loc_1B5:				     ; CODE XREF: reset_entry+16Fj
ROM:01B5 DB 04			     in	     4
ROM:01B7 1F			     rar
ROM:01B8 D2 BC 01		     jnc     loc_1BC
ROM:01BB 0C			     inr     c
ROM:01BC
ROM:01BC	     loc_1BC:				     ; CODE XREF: reset_entry+169j
ROM:01BC						     ; reset_entry+178j
ROM:01BC 51			     mov     d,	c
ROM:01BD DB 03			     in	     3
ROM:01BF 0E 00			     mvi     c,	0
ROM:01C1 06 08			     mvi     b,	8
ROM:01C3
ROM:01C3	     loc_1C3:				     ; CODE XREF: reset_entry+18Dj
ROM:01C3 1F			     rar
ROM:01C4 D2 D9 01		     jnc     loc_1D9
ROM:01C7 FB			     ei
ROM:01C8 0C			     inr     c
ROM:01C9 05			     dcr     b
ROM:01CA CA D0 01		     jz	     loc_1D0
ROM:01CD C3 C3 01		     jmp     loc_1C3
ROM:01D0	     ; ---------------------------------------------------------------------------
ROM:01D0
ROM:01D0	     loc_1D0:				     ; CODE XREF: reset_entry+18Aj
ROM:01D0 DB 04			     in	     4
ROM:01D2 1F			     rar
ROM:01D3 1F			     rar
ROM:01D4 1F			     rar
ROM:01D5 D2 D9 01		     jnc     loc_1D9
ROM:01D8 0C			     inr     c
ROM:01D9
ROM:01D9	     loc_1D9:				     ; CODE XREF: reset_entry+184j
ROM:01D9						     ; reset_entry+195j
ROM:01D9 79			     mov     a,	c
ROM:01DA FB			     ei
ROM:01DB 07			     rlc
ROM:01DC 07			     rlc
ROM:01DD 07			     rlc
ROM:01DE 07			     rlc
ROM:01DF B2			     ora     d
ROM:01E0 32 7F 23		     sta     237Fh
ROM:01E3 32 9F 23		     sta     239Fh
ROM:01E6 32 BF 23		     sta     23BFh
ROM:01E9 FB			     ei
ROM:01EA DB 05			     in	     5
ROM:01EC 21 16 22		     lxi     h,	2216h
ROM:01EF 77			     mov     m,	a
ROM:01F0 06 03			     mvi     b,	3
ROM:01F2 3E 00			     mvi     a,	0
ROM:01F4 CD E6 03		     call    sub_3E6
ROM:01F7	     ; ---------------------------------------------------------------------------
ROM:01F7 C2 04 02		     jnz     loc_204
ROM:01FA 04			     inr     b
ROM:01FB 3E 01			     mvi     a,	1
ROM:01FD CD E6 03		     call    sub_3E6
ROM:0200	     ; ---------------------------------------------------------------------------
ROM:0200 C2 04 02		     jnz     loc_204
ROM:0203 04			     inr     b
ROM:0204
ROM:0204	     loc_204:				     ; CODE XREF: reset_entry+1B7j
ROM:0204						     ; reset_entry+1C0j
ROM:0204 78			     mov     a,	b
ROM:0205 32 13 22		     sta     2213h
ROM:0208
ROM:0208	     loc_208:				     ; CODE XREF: reset_entry+22Bj
ROM:0208						     ; ROM:1C5Bj ...
ROM:0208 D3 0F			     out     0Fh
ROM:020A FB			     ei
ROM:020B 00			     nop
ROM:020C FB			     ei
ROM:020D
ROM:020D	     loc_20D:				     ; CODE XREF: ROM:14ACj
ROM:020D 00			     nop
ROM:020E FB			     ei
ROM:020F 00			     nop
ROM:0210 F3			     di
ROM:0211 3A C2 21		     lda     21C2h
ROM:0214 2F			     cma
ROM:0215 D3 05			     out     5
ROM:0217 3A C3 21		     lda     21C3h
ROM:021A 2F			     cma
ROM:021B D3 06			     out     6
ROM:021D 3A C4 21		     lda     21C4h
ROM:0220 2F			     cma
ROM:0221 D3 07			     out     7
ROM:0223 3A C5 21		     lda     21C5h
ROM:0226 2F			     cma
ROM:0227 D3 08			     out     8
ROM:0229 FB			     ei
ROM:022A 00			     nop
ROM:022B FB			     ei
ROM:022C 00			     nop
ROM:022D FB			     ei
ROM:022E 00			     nop
ROM:022F F3			     di
ROM:0230 2A F9 21		     lhld    21F9h
ROM:0233 11 FB 21		     lxi     d,	21FBh
ROM:0236 7D			     mov     a,	l
ROM:0237 93			     sub     e
ROM:0238 CA 57 02		     jz	     loc_257
ROM:023B FA 43 02		     jm	     loc_243
ROM:023E FE 08			     cpi     8
ROM:0240 DA 4C 02		     jc	     loc_24C
ROM:0243
ROM:0243	     loc_243:				     ; CODE XREF: reset_entry+1FBj
ROM:0243 21 FB 21		     lxi     h,	21FBh
ROM:0246 22 F9 21		     shld    21F9h
ROM:0249 C3 57 02		     jmp     loc_257
ROM:024C	     ; ---------------------------------------------------------------------------
ROM:024C
ROM:024C	     loc_24C:				     ; CODE XREF: reset_entry+200j
ROM:024C 2B			     dcx     h
ROM:024D 7E			     mov     a,	m
ROM:024E 2B			     dcx     h
ROM:024F 22 F9 21		     shld    21F9h
ROM:0252 6E			     mov     l,	m
ROM:0253 67			     mov     h,	a
ROM:0254 CD CD 0F		     call    sub_FCD
ROM:0257	     ; ---------------------------------------------------------------------------
ROM:0257
ROM:0257	     loc_257:				     ; CODE XREF: reset_entry+1F8j
ROM:0257						     ; reset_entry+209j
ROM:0257 FB			     ei
ROM:0258 21 92 21		     lxi     h,	2192h
ROM:025B 3E 07			     mvi     a,	7
ROM:025D CD E6 03		     call    sub_3E6
ROM:0260	     ; ---------------------------------------------------------------------------
ROM:0260 C2 B4 1B		     jnz     loc_1BB4
ROM:0263 3A B6 23		     lda     23B6h
ROM:0266 E6 7F			     ani     7Fh
ROM:0268 32 B6 23		     sta     23B6h
ROM:026B C3 08 02		     jmp     loc_208
ROM:026E	     ; ---------------------------------------------------------------------------
ROM:026E
ROM:026E	     loc_26E:				     ; CODE XREF: ROM:074Ap
ROM:026E						     ; ROM:0D7Cp ...
ROM:026E EB			     xchg
ROM:026F 2A F9 21		     lhld    21F9h
ROM:0272 73			     mov     m,	e
ROM:0273 23			     inx     h
ROM:0274 72			     mov     m,	d
ROM:0275 23			     inx     h
ROM:0276 22 F9 21		     shld    21F9h
ROM:0279 C9			     ret
ROM:027A	     ; ---------------------------------------------------------------------------
ROM:027A
ROM:027A	     loc_27A:				     ; CODE XREF: reset_entry+EDj
ROM:027A 3A 91 21		     lda     2191h
ROM:027D 47			     mov     b,	a
ROM:027E E6 01			     ani     1
ROM:0280 C2 8F 01		     jnz     loc_18F
ROM:0283 78			     mov     a,	b
ROM:0284 F6 01			     ori     1
ROM:0286 32 91 21		     sta     2191h
ROM:0289 F3			     di
ROM:028A 3E 30			     mvi     a,	30h ; '0'
ROM:028C 32 94 21		     sta     2194h
ROM:028F 3E 7D			     mvi     a,	7Dh ; '}'
ROM:0291 32 9F 21		     sta     219Fh
ROM:0294 3E 3C			     mvi     a,	3Ch ; '<'
ROM:0296 32 1F 22		     sta     221Fh
ROM:0299 3E 00			     mvi     a,	0
ROM:029B 32 20 22		     sta     2220h
ROM:029E 32 21 22		     sta     2221h
ROM:02A1 C3 38 01		     jmp     loc_138
ROM:02A4	     ; ---------------------------------------------------------------------------
ROM:02A4
ROM:02A4	     loc_2A4:				     ; CODE XREF: reset_entry+F2j
ROM:02A4 F3			     di
ROM:02A5 21 C0 23		     lxi     h,	23C0h
ROM:02A8 06 0C			     mvi     b,	0Ch
ROM:02AA
ROM:02AA	     loc_2AA:				     ; CODE XREF: reset_entry+26Ej
ROM:02AA 36 88			     mvi     m,	88h ; 'ˆ'
ROM:02AC 23			     inx     h
ROM:02AD 05			     dcr     b
ROM:02AE C2 AA 02		     jnz     loc_2AA
ROM:02B1 36 F8			     mvi     m,	0F8h ; 'ø'
ROM:02B3 23			     inx     h
ROM:02B4 06 09			     mvi     b,	9
ROM:02B6
ROM:02B6	     loc_2B6:				     ; CODE XREF: reset_entry+27Aj
ROM:02B6 36 88			     mvi     m,	88h ; 'ˆ'
ROM:02B8 23			     inx     h
ROM:02B9 05			     dcr     b
ROM:02BA C2 B6 02		     jnz     loc_2B6
ROM:02BD 36 F8			     mvi     m,	0F8h ; 'ø'
ROM:02BF 23			     inx     h
ROM:02C0 06 07			     mvi     b,	7
ROM:02C2
ROM:02C2	     loc_2C2:				     ; CODE XREF: reset_entry+286j
ROM:02C2 36 88			     mvi     m,	88h ; 'ˆ'
ROM:02C4 23			     inx     h
ROM:02C5 05			     dcr     b
ROM:02C6 C2 C2 02		     jnz     loc_2C2
ROM:02C9 36 FF			     mvi     m,	0FFh
ROM:02CB 23			     inx     h
ROM:02CC 36 88			     mvi     m,	88h ; 'ˆ'
ROM:02CE 3E 00			     mvi     a,	0
ROM:02D0 D3 00			     out     0
ROM:02D2 D3 01			     out     1
ROM:02D4 D3 02			     out     2
ROM:02D6 D3 03			     out     3
ROM:02D8 D3 04			     out     4
ROM:02DA D3 0F			     out     0Fh
ROM:02DC C3 13 01		     jmp     loc_113
ROM:02DC	     ; End of function reset_entry
ROM:02DC
ROM:02DF
ROM:02DF	     ; =============== S U B R O U T I N E =======================================
ROM:02DF
ROM:02DF
ROM:02DF	     sub_2DF:				     ; CODE XREF: sub_2F3p
ROM:02DF						     ; sub_13DE+38p
ROM:02DF 11 3B 23		     lxi     d,	233Bh
ROM:02E2 01 00 00		     lxi     b,	0
ROM:02E5 21 00 00		     lxi     h,	0
ROM:02E8
ROM:02E8	     loc_2E8:				     ; CODE XREF: sub_2DF+10j
ROM:02E8 1A			     ldax    d
ROM:02E9 4F			     mov     c,	a
ROM:02EA 09			     dad     b
ROM:02EB 13			     inx     d
ROM:02EC 7B			     mov     a,	e
ROM:02ED FE 5D			     cpi     5Dh ; ']'
ROM:02EF C2 E8 02		     jnz     loc_2E8
ROM:02F2 C9			     ret
ROM:02F2	     ; End of function sub_2DF
ROM:02F2
ROM:02F3
ROM:02F3	     ; =============== S U B R O U T I N E =======================================
ROM:02F3
ROM:02F3
ROM:02F3	     sub_2F3:				     ; CODE XREF: reset_entry+85p
ROM:02F3 CD DF 02		     call    sub_2DF
ROM:02F6 EB			     xchg
ROM:02F7 2A 23 22		     lhld    2223h
ROM:02FA 7B			     mov     a,	e
ROM:02FB BD			     cmp     l
ROM:02FC C0			     rnz
ROM:02FD B7			     ora     a
ROM:02FE CA 04 03		     jz	     loc_304
ROM:0301
ROM:0301	     loc_301:				     ; CODE XREF: sub_2F3+13j
ROM:0301 7A			     mov     a,	d
ROM:0302 BC			     cmp     h
ROM:0303 C9			     ret
ROM:0304	     ; ---------------------------------------------------------------------------
ROM:0304
ROM:0304	     loc_304:				     ; CODE XREF: sub_2F3+Bj
ROM:0304 7A			     mov     a,	d
ROM:0305 B7			     ora     a
ROM:0306 C2 01 03		     jnz     loc_301
ROM:0309 3C			     inr     a
ROM:030A C9			     ret
ROM:030A	     ; End of function sub_2F3
ROM:030A
ROM:030B	     ; ---------------------------------------------------------------------------
ROM:030B	     ; START OF	FUNCTION CHUNK FOR reset_entry
ROM:030B
ROM:030B	     loc_30B:				     ; CODE XREF: reset_entry+82j
ROM:030B 21 EB 11		     lxi     h,	11EBh
ROM:030E 11 28 22		     lxi     d,	2228h
ROM:0311 3E 08			     mvi     a,	8
ROM:0313 CD 60 0F		     call    sub_F60
ROM:0316 21 E7 11		     lxi     h,	11E7h
ROM:0319 11 2C 22		     lxi     d,	222Ch
ROM:031C 3E 08			     mvi     a,	8
ROM:031E CD 60 0F		     call    sub_F60
ROM:0321 C3 CB 00		     jmp     loc_CB
ROM:0321	     ; END OF FUNCTION CHUNK FOR reset_entry
ROM:0324	     ; ---------------------------------------------------------------------------
ROM:0324
ROM:0324	     handle_RST_5_5:			     ; CODE XREF: ROM:002Cj
ROM:0324 CD 0E 06		     call    sub_60E
ROM:0327 3A 90 21		     lda     2190h
ROM:032A F6 80			     ori     80h
ROM:032C 32 90 21		     sta     2190h
ROM:032F 97			     sub     a
ROM:0330 32 0C 22		     sta     220Ch
ROM:0333 DB 01			     in	     1
ROM:0335 11 00 00		     lxi     d,	0
ROM:0338
ROM:0338	     loc_338:				     ; CODE XREF: ROM:0341j
ROM:0338 B7			     ora     a
ROM:0339 CA 7A 03		     jz	     loc_37A
ROM:033C 1F			     rar
ROM:033D DA 44 03		     jc	     loc_344
ROM:0340 1C			     inr     e
ROM:0341 C3 38 03		     jmp     loc_338
ROM:0344	     ; ---------------------------------------------------------------------------
ROM:0344
ROM:0344	     loc_344:				     ; CODE XREF: ROM:033Dj
ROM:0344 7B			     mov     a,	e
ROM:0345 2F			     cma
ROM:0346 D3 0E			     out     0Eh
ROM:0348 2F			     cma
ROM:0349 21 93 21		     lxi     h,	2193h
ROM:034C CD E6 03		     call    sub_3E6
ROM:034F	     ; ---------------------------------------------------------------------------
ROM:034F C2 7A 03		     jnz     loc_37A
ROM:0352 CD 0E 06		     call    sub_60E
ROM:0355 3A 91 21		     lda     2191h
ROM:0358 E6 02			     ani     2
ROM:035A C4 FA 03		     cnz     sub_3FA
ROM:035D	     ; ---------------------------------------------------------------------------
ROM:035D CD 1A 06		     call    sub_61A
ROM:0360 CD CE 03		     call    sub_3CE
ROM:0363	     ; ---------------------------------------------------------------------------
ROM:0363 EB			     xchg
ROM:0364 29			     dad     h
ROM:0365 11 AE 03		     lxi     d,	3AEh
ROM:0368 19			     dad     d
ROM:0369 7E			     mov     a,	m
ROM:036A 23			     inx     h
ROM:036B 66			     mov     h,	m
ROM:036C 6F			     mov     l,	a
ROM:036D E9			     pchl
ROM:036E	     ; ---------------------------------------------------------------------------
ROM:036E
ROM:036E	     loc_36E:				     ; CODE XREF: ROM:05F0j
ROM:036E						     ; ROM:0887j ...
ROM:036E 21 94 21		     lxi     h,	2194h
ROM:0371 C3 77 03		     jmp     loc_377
ROM:0371	     ; ---------------------------------------------------------------------------
ROM:0374 21			     .db  21h ;	!
ROM:0375 93			     .db  93h ;	“
ROM:0376 21			     .db  21h ;	!
ROM:0377	     ; ---------------------------------------------------------------------------
ROM:0377
ROM:0377	     loc_377:				     ; CODE XREF: ROM:0371j
ROM:0377 CD D9 03		     call    sub_3D9
ROM:037A	     ; ---------------------------------------------------------------------------
ROM:037A
ROM:037A	     loc_37A:				     ; CODE XREF: ROM:0339j
ROM:037A						     ; ROM:034Fj ...
ROM:037A CD 1A 06		     call    sub_61A
ROM:037D C9			     ret
ROM:037E	     ; ---------------------------------------------------------------------------
ROM:037E
ROM:037E	     handle_RST_6_5:			     ; CODE XREF: ROM:0034j
ROM:037E CD 0E 06		     call    sub_60E
ROM:0381 11 00 00		     lxi     d,	0
ROM:0384 DB 00			     in	     0
ROM:0386
ROM:0386	     loc_386:				     ; CODE XREF: ROM:038Fj
ROM:0386 B7			     ora     a
ROM:0387 CA 7A 03		     jz	     loc_37A
ROM:038A 1F			     rar
ROM:038B DA 92 03		     jc	     loc_392
ROM:038E 1C			     inr     e
ROM:038F C3 86 03		     jmp     loc_386
ROM:0392	     ; ---------------------------------------------------------------------------
ROM:0392
ROM:0392	     loc_392:				     ; CODE XREF: ROM:038Bj
ROM:0392 7B			     mov     a,	e
ROM:0393 2F			     cma
ROM:0394 D3 0D			     out     0Dh
ROM:0396 2F			     cma
ROM:0397 21 94 21		     lxi     h,	2194h
ROM:039A CD E6 03		     call    sub_3E6
ROM:039D	     ; ---------------------------------------------------------------------------
ROM:039D C2 7A 03		     jnz     loc_37A
ROM:03A0 CD CE 03		     call    sub_3CE
ROM:03A3	     ; ---------------------------------------------------------------------------
ROM:03A3 EB			     xchg
ROM:03A4 29			     dad     h
ROM:03A5 11 BE 03		     lxi     d,	3BEh
ROM:03A8 19			     dad     d
ROM:03A9 7E			     mov     a,	m
ROM:03AA 23			     inx     h
ROM:03AB 66			     mov     h,	m
ROM:03AC 6F			     mov     l,	a
ROM:03AD E9			     pchl
ROM:03AE	     ; ---------------------------------------------------------------------------
ROM:03AE E2 06 E8		     jpo     0E806h
ROM:03B1 06 EE			     mvi     b,	0EEh ; 'î'
ROM:03B3 06 F4			     mvi     b,	0F4h ; 'ô'
ROM:03B5 06 FA			     mvi     b,	0FAh ; 'ú'
ROM:03B7 06 00			     mvi     b,	0
ROM:03B9 07			     rlc
ROM:03BA 06 07			     mvi     b,	7
ROM:03BC 7A			     mov     a,	d
ROM:03BD 03			     inx     b
ROM:03BE CB			     rstv
ROM:03BF 05			     dcr     b
ROM:03C0 1D			     dcr     e
ROM:03C1 14			     inr     d
ROM:03C2 2A 09 73		     lhld    7309h
ROM:03C5 04			     inr     b
ROM:03C6 B9			     cmp     c
ROM:03C7 07			     rlc
ROM:03C8 77			     mov     m,	a
ROM:03C9 08			     dsub
ROM:03CA 57			     mov     d,	a
ROM:03CB 16 73			     mvi     d,	73h ; 's'
ROM:03CD 04			     inr     b
ROM:03CE
ROM:03CE	     ; =============== S U B R O U T I N E =======================================
ROM:03CE
ROM:03CE	     ; Attributes: noreturn
ROM:03CE
ROM:03CE	     sub_3CE:				     ; CODE XREF: ROM:0360p
ROM:03CE						     ; ROM:03A0p ...
ROM:03CE C5			     push    b
ROM:03CF 47			     mov     b,	a
ROM:03D0 CD F1 03		     call    sub_3F1
ROM:03D0	     ; End of function sub_3CE
ROM:03D0
ROM:03D0	     ; ---------------------------------------------------------------------------
ROM:03D3 4E			     .db  4Eh ;	N
ROM:03D4 B1			     .db 0B1h ;	±
ROM:03D5 77			     .db  77h ;	w
ROM:03D6 C3			     .db 0C3h ;	Ã
ROM:03D7 EE			     .db 0EEh ;	î
ROM:03D8 03			     .db    3
ROM:03D9
ROM:03D9	     ; =============== S U B R O U T I N E =======================================
ROM:03D9
ROM:03D9	     ; Attributes: noreturn
ROM:03D9
ROM:03D9	     sub_3D9:				     ; CODE XREF: ROM:loc_377p
ROM:03D9						     ; ROM:041Bp ...
ROM:03D9 C5			     push    b
ROM:03DA 47			     mov     b,	a
ROM:03DB CD F1 03		     call    sub_3F1
ROM:03DB	     ; End of function sub_3D9
ROM:03DB
ROM:03DB	     ; ---------------------------------------------------------------------------
ROM:03DE 2F			     .db  2Fh ;	/
ROM:03DF 4F			     .db  4Fh ;	O
ROM:03E0 7E			     .db  7Eh ;	~
ROM:03E1 A1			     .db 0A1h ;	¡
ROM:03E2 77			     .db  77h ;	w
ROM:03E3 C3			     .db 0C3h ;	Ã
ROM:03E4 EE			     .db 0EEh ;	î
ROM:03E5 03			     .db    3
ROM:03E6
ROM:03E6	     ; =============== S U B R O U T I N E =======================================
ROM:03E6
ROM:03E6	     ; Attributes: noreturn
ROM:03E6
ROM:03E6	     sub_3E6:				     ; CODE XREF: reset_entry+1B4p
ROM:03E6						     ; reset_entry+1BDp ...
ROM:03E6 C5			     push    b
ROM:03E7 47			     mov     b,	a
ROM:03E8 CD F1 03		     call    sub_3F1
ROM:03E8	     ; End of function sub_3E6
ROM:03E8
ROM:03E8	     ; ---------------------------------------------------------------------------
ROM:03EB 4F			     .db  4Fh ;	O
ROM:03EC 7E			     .db  7Eh ;	~
ROM:03ED A1			     .db 0A1h ;	¡
ROM:03EE 78			     .db  78h ;	x
ROM:03EF C1			     .db 0C1h ;	Á
ROM:03F0 C9			     .db 0C9h ;	É
ROM:03F1
ROM:03F1	     ; =============== S U B R O U T I N E =======================================
ROM:03F1
ROM:03F1	     ; Attributes: noreturn
ROM:03F1
ROM:03F1	     sub_3F1:				     ; CODE XREF: sub_3CE+2p
ROM:03F1						     ; sub_3D9+2p ...
ROM:03F1 4F			     mov     c,	a
ROM:03F2 3E 01			     mvi     a,	1
ROM:03F4
ROM:03F4	     loc_3F4:				     ; CODE XREF: sub_3F1+6j
ROM:03F4 0D			     dcr     c
ROM:03F5 F8			     rm
ROM:03F6 87			     add     a
ROM:03F7 C3 F4 03		     jmp     loc_3F4
ROM:03F7	     ; End of function sub_3F1
ROM:03F7
ROM:03FA
ROM:03FA	     ; =============== S U B R O U T I N E =======================================
ROM:03FA
ROM:03FA	     ; Attributes: noreturn
ROM:03FA
ROM:03FA	     sub_3FA:				     ; CODE XREF: ROM:035Ap
ROM:03FA						     ; ROM:0C24p ...
ROM:03FA 3A 11 22		     lda     2211h
ROM:03FD 47			     mov     b,	a
ROM:03FE CD 1F 04		     call    sub_41F
ROM:0401 CD E6 03		     call    sub_3E6
ROM:0401	     ; End of function sub_3FA
ROM:0401
ROM:0404	     ; ---------------------------------------------------------------------------
ROM:0404 CA 0B 04		     jz	     loc_40B
ROM:0407 EB			     xchg
ROM:0408 CD CE 03		     call    sub_3CE
ROM:040B	     ; ---------------------------------------------------------------------------
ROM:040B
ROM:040B	     loc_40B:				     ; CODE XREF: ROM:0404j
ROM:040B 78			     mov     a,	b
ROM:040C 3C			     inr     a
ROM:040D FE 05			     cpi     5
ROM:040F C2 14 04		     jnz     loc_414
ROM:0412 3E 00			     mvi     a,	0
ROM:0414
ROM:0414	     loc_414:				     ; CODE XREF: ROM:040Fj
ROM:0414 32 11 22		     sta     2211h
ROM:0417 CD 1F 04		     call    sub_41F
ROM:041A EB			     xchg
ROM:041B CD D9 03		     call    sub_3D9
ROM:041B	     ; ---------------------------------------------------------------------------
ROM:041E C9			     .db 0C9h ;	É
ROM:041F
ROM:041F	     ; =============== S U B R O U T I N E =======================================
ROM:041F
ROM:041F
ROM:041F	     sub_41F:				     ; CODE XREF: sub_3FA+4p
ROM:041F						     ; ROM:0417p
ROM:041F 16 00			     mvi     d,	0
ROM:0421 5F			     mov     e,	a
ROM:0422 21 38 04		     lxi     h,	438h
ROM:0425 19			     dad     d
ROM:0426 7E			     mov     a,	m
ROM:0427 21 3D 04		     lxi     h,	43Dh
ROM:042A EB			     xchg
ROM:042B 29			     dad     h
ROM:042C 19			     dad     d
ROM:042D 4E			     mov     c,	m
ROM:042E 23			     inx     h
ROM:042F 66			     mov     h,	m
ROM:0430 69			     mov     l,	c
ROM:0431 11 05 00		     lxi     d,	5
ROM:0434 EB			     xchg
ROM:0435 19			     dad     d
ROM:0436 EB			     xchg
ROM:0437 C9			     ret
ROM:0437	     ; End of function sub_41F
ROM:0437
ROM:0437	     ; ---------------------------------------------------------------------------
ROM:0438 04			     .db    4
ROM:0439 00			     .db    0
ROM:043A 01			     .db    1
ROM:043B 02			     .db    2
ROM:043C 05			     .db    5
ROM:043D	     ; ---------------------------------------------------------------------------
ROM:043D CD 21 CC		     call    0CC21h
ROM:0440 21 CC 21		     lxi     h,	21CCh
ROM:0443 CC 21 CA		     cz	     0CA21h
ROM:0446
ROM:0446	     loc_446:				     ; CODE XREF: ROM:0473p
ROM:0446						     ; ROM:0583p
ROM:0446 21 3A 90		     lxi     h,	903Ah
ROM:0449 21 F6 05		     lxi     h,	5F6h
ROM:044C 32 90 21		     sta     2190h
ROM:044F 3E 00			     mvi     a,	0
ROM:0451 32 0C 22		     sta     220Ch
ROM:0454 3E FF			     mvi     a,	0FFh
ROM:0456 32 93 21		     sta     2193h
ROM:0459 3A 94 21		     lda     2194h
ROM:045C F6 30			     ori     30h
ROM:045E 32 94 21		     sta     2194h
ROM:0461 C9			     ret
ROM:0462
ROM:0462	     ; =============== S U B R O U T I N E =======================================
ROM:0462
ROM:0462
ROM:0462	     sub_462:				     ; CODE XREF: ROM:047Bp
ROM:0462						     ; ROM:057Dp
ROM:0462 3A 92 21		     lda     2192h
ROM:0465 E6 40			     ani     40h
ROM:0467 C8			     rz
ROM:0468 3A 7A 23		     lda     237Ah
ROM:046B B7			     ora     a
ROM:046C CA 71 04		     jz	     loc_471
ROM:046F BF			     cmp     a
ROM:0470 C9			     ret
ROM:0471	     ; ---------------------------------------------------------------------------
ROM:0471
ROM:0471	     loc_471:				     ; CODE XREF: sub_462+Aj
ROM:0471 3D			     dcr     a
ROM:0472 C9			     ret
ROM:0472	     ; End of function sub_462
ROM:0472
ROM:0473	     ; ---------------------------------------------------------------------------
ROM:0473 CD 47 04		     call    loc_446+1
ROM:0476 3E 7D			     mvi     a,	7Dh ; '}'
ROM:0478 32 A2 21		     sta     21A2h
ROM:047B CD 62 04		     call    sub_462
ROM:047E C2 7A 03		     jnz     loc_37A
ROM:0481 3E FA			     mvi     a,	0FAh ; 'ú'
ROM:0483 32 9E 21		     sta     219Eh
ROM:0486 21 B6 23		     lxi     h,	23B6h
ROM:0489 3E 05			     mvi     a,	5
ROM:048B CD CE 03		     call    sub_3CE
ROM:048E	     ; ---------------------------------------------------------------------------
ROM:048E 3E FF			     mvi     a,	0FFh
ROM:0490 32 80 23		     sta     2380h
ROM:0493 32 81 23		     sta     2381h
ROM:0496 32 82 23		     sta     2382h
ROM:0499 3A 3F 23		     lda     233Fh
ROM:049C C6 08			     adi     8
ROM:049E 47			     mov     b,	a
ROM:049F 3A E4 23		     lda     23E4h
ROM:04A2 90			     sub     b
ROM:04A3 FA 38 05		     jm	     loc_538
ROM:04A6 3A 92 21		     lda     2192h
ROM:04A9 E6 40			     ani     40h
ROM:04AB C2 38 05		     jnz     loc_538
ROM:04AE 3A 94 21		     lda     2194h
ROM:04B1 F6 FC			     ori     0FCh
ROM:04B3 32 94 21		     sta     2194h
ROM:04B6 3E 00			     mvi     a,	0
ROM:04B8 32 A3 21		     sta     21A3h
ROM:04BB 3E FF			     mvi     a,	0FFh
ROM:04BD 21 C0 23		     lxi     h,	23C0h
ROM:04C0 06 20			     mvi     b,	20h ; ' '
ROM:04C2
ROM:04C2	     loc_4C2:				     ; CODE XREF: ROM:04C5j
ROM:04C2 77			     mov     m,	a
ROM:04C3 23			     inx     h
ROM:04C4 05			     dcr     b
ROM:04C5 C2 C2 04		     jnz     loc_4C2
ROM:04C8 D3 00			     out     0
ROM:04CA D3 01			     out     1
ROM:04CC D3 02			     out     2
ROM:04CE D3 03			     out     3
ROM:04D0 D3 04			     out     4
ROM:04D2 D3 05			     out     5
ROM:04D4 D3 06			     out     6
ROM:04D6 D3 07			     out     7
ROM:04D8 D3 08			     out     8
ROM:04DA 3E 00			     mvi     a,	0
ROM:04DC 3E 0F			     mvi     a,	0Fh
ROM:04DE 32 CC 23		     sta     23CCh
ROM:04E1 32 D6 23		     sta     23D6h
ROM:04E4 32 DE 23		     sta     23DEh
ROM:04E7 3A 90 21		     lda     2190h
ROM:04EA E6 F7			     ani     0F7h
ROM:04EC 32 90 21		     sta     2190h
ROM:04EF 3A 96 23		     lda     2396h
ROM:04F2 E6 EF			     ani     0EFh
ROM:04F4 32 96 23		     sta     2396h
ROM:04F7 3A B6 23		     lda     23B6h
ROM:04FA E6 EF			     ani     0EFh
ROM:04FC 32 B6 23		     sta     23B6h
ROM:04FF 06 30			     mvi     b,	30h ; '0'
ROM:0501 CD 82 1D		     call    sub_1D82
ROM:0504	     ; ---------------------------------------------------------------------------
ROM:0504 3E D0			     mvi     a,	0D0h ; 'Ð'
ROM:0506 32 92 21		     sta     2192h
ROM:0509 3A 13 22		     lda     2213h
ROM:050C 32 7B 23		     sta     237Bh
ROM:050F 21 7E 23		     lxi     h,	237Eh
ROM:0512 7E			     mov     a,	m
ROM:0513 E6 0F			     ani     0Fh
ROM:0515 77			     mov     m,	a
ROM:0516 06 FF			     mvi     b,	0FFh
ROM:0518
ROM:0518	     loc_518:				     ; CODE XREF: ROM:051Dj
ROM:0518 1F			     rar
ROM:0519 D2 20 05		     jnc     loc_520
ROM:051C 04			     inr     b
ROM:051D C3 18 05		     jmp     loc_518
ROM:0520	     ; ---------------------------------------------------------------------------
ROM:0520
ROM:0520	     loc_520:				     ; CODE XREF: ROM:0519j
ROM:0520 78			     mov     a,	b
ROM:0521 C6 04			     adi     4
ROM:0523 CD CE 03		     call    sub_3CE
ROM:0526	     ; ---------------------------------------------------------------------------
ROM:0526 3E 01			     mvi     a,	1
ROM:0528 32 14 22		     sta     2214h
ROM:052B 3E 28			     mvi     a,	28h ; '('
ROM:052D 32 1B 22		     sta     221Bh
ROM:0530 3E 02			     mvi     a,	2
ROM:0532 32 9D 21		     sta     219Dh
ROM:0535 C3 7A 03		     jmp     loc_37A
ROM:0538	     ; ---------------------------------------------------------------------------
ROM:0538
ROM:0538	     loc_538:				     ; CODE XREF: ROM:04A3j
ROM:0538						     ; ROM:04ABj
ROM:0538 21 45 13		     lxi     h,	1345h
ROM:053B CD E4 12		     call    sub_12E4
ROM:053E	     ; ---------------------------------------------------------------------------
ROM:053E C3 7A 03		     jmp     loc_37A
ROM:0541	     ; ---------------------------------------------------------------------------
ROM:0541 3A 1B 22		     lda     221Bh
ROM:0544 3D			     dcr     a
ROM:0545 32 1B 22		     sta     221Bh
ROM:0548 CA 5E 05		     jz	     loc_55E
ROM:054B 3E 14			     mvi     a,	14h
ROM:054D 32 9D 21		     sta     219Dh
ROM:0550 3E FA			     mvi     a,	0FAh ; 'ú'
ROM:0552 32 9E 21		     sta     219Eh
ROM:0555 21 42 13		     lxi     h,	1342h
ROM:0558 CD E4 12		     call    sub_12E4
ROM:055B	     ; ---------------------------------------------------------------------------
ROM:055B C3 08 06		     jmp     loc_608
ROM:055E	     ; ---------------------------------------------------------------------------
ROM:055E
ROM:055E	     loc_55E:				     ; CODE XREF: ROM:0548j
ROM:055E 3E 05			     mvi     a,	5
ROM:0560 32 A3 21		     sta     21A3h
ROM:0563 3E 01			     mvi     a,	1
ROM:0565 32 A0 21		     sta     21A0h
ROM:0568 32 1C 22		     sta     221Ch
ROM:056B 3A 94 21		     lda     2194h
ROM:056E E6 33			     ani     33h
ROM:0570 32 94 21		     sta     2194h
ROM:0573 C3 08 06		     jmp     loc_608
ROM:0576	     ; ---------------------------------------------------------------------------
ROM:0576 DB 04			     in	     4
ROM:0578 E6 80			     ani     80h
ROM:057A CA 94 05		     jz	     loc_594
ROM:057D CD 62 04		     call    sub_462
ROM:0580 C2 94 05		     jnz     loc_594
ROM:0583 CD 47 04		     call    loc_446+1
ROM:0586 3E 7D			     mvi     a,	7Dh ; '}'
ROM:0588 32 A2 21		     sta     21A2h
ROM:058B 21 45 13		     lxi     h,	1345h
ROM:058E CD E4 12		     call    sub_12E4
ROM:0591	     ; ---------------------------------------------------------------------------
ROM:0591 C3 08 06		     jmp     loc_608
ROM:0594	     ; ---------------------------------------------------------------------------
ROM:0594
ROM:0594	     loc_594:				     ; CODE XREF: ROM:057Aj
ROM:0594						     ; ROM:0580j
ROM:0594 3A 94 21		     lda     2194h
ROM:0597 E6 77			     ani     77h
ROM:0599 32 94 21		     sta     2194h
ROM:059C C3 08 06		     jmp     loc_608
ROM:059F	     ; ---------------------------------------------------------------------------
ROM:059F 21 92 21		     lxi     h,	2192h
ROM:05A2 3E 07			     mvi     a,	7
ROM:05A4 CD E6 03		     call    sub_3E6
ROM:05A7	     ; ---------------------------------------------------------------------------
ROM:05A7 CA 08 06		     jz	     loc_608
ROM:05AA 21 B6 23		     lxi     h,	23B6h
ROM:05AD 3E 05			     mvi     a,	5
ROM:05AF CD D9 03		     call    sub_3D9
ROM:05B2	     ; ---------------------------------------------------------------------------
ROM:05B2 3E F0			     mvi     a,	0F0h ; 'ð'
ROM:05B4 32 A0 23		     sta     23A0h
ROM:05B7 32 80 23		     sta     2380h
ROM:05BA 3E FF			     mvi     a,	0FFh
ROM:05BC 32 A1 23		     sta     23A1h
ROM:05BF 32 81 23		     sta     2381h
ROM:05C2 32 A2 23		     sta     23A2h
ROM:05C5 32 82 23		     sta     2382h
ROM:05C8 C3 08 06		     jmp     loc_608
ROM:05CB	     ; ---------------------------------------------------------------------------
ROM:05CB 21 97 21		     lxi     h,	2197h
ROM:05CE 0E 1A			     mvi     c,	1Ah
ROM:05D0
ROM:05D0	     loc_5D0:				     ; CODE XREF: ROM:05DCj
ROM:05D0 3E FF			     mvi     a,	0FFh
ROM:05D2 86			     add     m
ROM:05D3 D2 DA 05		     jnc     loc_5DA
ROM:05D6 77			     mov     m,	a
ROM:05D7 CA F3 05		     jz	     loc_5F3
ROM:05DA
ROM:05DA	     loc_5DA:				     ; CODE XREF: ROM:05D3j
ROM:05DA						     ; ROM:060Bj
ROM:05DA 23			     inx     h
ROM:05DB 0D			     dcr     c
ROM:05DC C2 D0 05		     jnz     loc_5D0
ROM:05DF 3A 98 21		     lda     2198h
ROM:05E2 B7			     ora     a
ROM:05E3 C2 E8 05		     jnz     loc_5E8
ROM:05E6 3E 01			     mvi     a,	1
ROM:05E8
ROM:05E8	     loc_5E8:				     ; CODE XREF: ROM:05E3j
ROM:05E8 E6 3F			     ani     3Fh
ROM:05EA 32 98 21		     sta     2198h
ROM:05ED 3E 00			     mvi     a,	0
ROM:05EF F3			     di
ROM:05F0 C3 6E 03		     jmp     loc_36E
ROM:05F3	     ; ---------------------------------------------------------------------------
ROM:05F3
ROM:05F3	     loc_5F3:				     ; CODE XREF: ROM:05D7j
ROM:05F3 F3			     di
ROM:05F4 CD 0E 06		     call    sub_60E
ROM:05F7 3E 1A			     mvi     a,	1Ah
ROM:05F9 91			     sub     c
ROM:05FA 87			     add     a
ROM:05FB 11 00 00		     lxi     d,	0
ROM:05FE 5F			     mov     e,	a
ROM:05FF 21 AE 06		     lxi     h,	6AEh
ROM:0602 19			     dad     d
ROM:0603 7E			     mov     a,	m
ROM:0604 23			     inx     h
ROM:0605 66			     mov     h,	m
ROM:0606 6F			     mov     l,	a
ROM:0607 E9			     pchl
ROM:0608	     ; ---------------------------------------------------------------------------
ROM:0608
ROM:0608	     loc_608:				     ; CODE XREF: ROM:055Bj
ROM:0608						     ; ROM:0573j ...
ROM:0608 CD 1A 06		     call    sub_61A
ROM:060B C3 DA 05		     jmp     loc_5DA
ROM:060E
ROM:060E	     ; =============== S U B R O U T I N E =======================================
ROM:060E
ROM:060E
ROM:060E	     sub_60E:				     ; CODE XREF: ROM:handle_RST_5_5p
ROM:060E						     ; ROM:0352p ...
ROM:060E 22 95 21		     shld    2195h
ROM:0611 E3			     xthl
ROM:0612 C5			     push    b
ROM:0613 D5			     push    d
ROM:0614 F5			     push    psw
ROM:0615 E5			     push    h
ROM:0616 2A 95 21		     lhld    2195h
ROM:0619 C9			     ret
ROM:0619	     ; End of function sub_60E
ROM:0619
ROM:061A
ROM:061A	     ; =============== S U B R O U T I N E =======================================
ROM:061A
ROM:061A
ROM:061A	     sub_61A:				     ; CODE XREF: ROM:035Dp
ROM:061A						     ; ROM:loc_37Ap ...
ROM:061A E1			     pop     h
ROM:061B F1			     pop     psw
ROM:061C D1			     pop     d
ROM:061D C1			     pop     b
ROM:061E E3			     xthl
ROM:061F C9			     ret
ROM:061F	     ; End of function sub_61A
ROM:061F
ROM:0620	     ; ---------------------------------------------------------------------------
ROM:0620 21 F8 21		     lxi     h,	21F8h
ROM:0623 35			     dcr     m
ROM:0624 C2 40 06		     jnz     loc_640
ROM:0627 21 91 21		     lxi     h,	2191h
ROM:062A 3E 04			     mvi     a,	4
ROM:062C CD E6 03		     call    sub_3E6
ROM:062F	     ; ---------------------------------------------------------------------------
ROM:062F C2 38 06		     jnz     loc_638
ROM:0632 CD CE 03		     call    sub_3CE
ROM:0635	     ; ---------------------------------------------------------------------------
ROM:0635 C3 3B 06		     jmp     loc_63B
ROM:0638	     ; ---------------------------------------------------------------------------
ROM:0638
ROM:0638	     loc_638:				     ; CODE XREF: ROM:062Fj
ROM:0638 CD D9 03		     call    sub_3D9
ROM:063B	     ; ---------------------------------------------------------------------------
ROM:063B
ROM:063B	     loc_63B:				     ; CODE XREF: ROM:0635j
ROM:063B 3E 04			     mvi     a,	4
ROM:063D 32 F8 21		     sta     21F8h
ROM:0640
ROM:0640	     loc_640:				     ; CODE XREF: ROM:0624j
ROM:0640 21 91 21		     lxi     h,	2191h
ROM:0643 3E 04			     mvi     a,	4
ROM:0645 CD E6 03		     call    sub_3E6
ROM:0648	     ; ---------------------------------------------------------------------------
ROM:0648 C2 A8 06		     jnz     loc_6A8
ROM:064B 21 80 23		     lxi     h,	2380h
ROM:064E
ROM:064E	     loc_64E:				     ; CODE XREF: ROM:06ABj
ROM:064E 11 C0 23		     lxi     d,	23C0h
ROM:0651 3E 40			     mvi     a,	40h ; '@'
ROM:0653 CD 60 0F		     call    sub_F60
ROM:0656 3E 05			     mvi     a,	5
ROM:0658 32 A3 21		     sta     21A3h
ROM:065B 21 91 21		     lxi     h,	2191h
ROM:065E 3E 04			     mvi     a,	4
ROM:0660 CD E6 03		     call    sub_3E6
ROM:0663	     ; ---------------------------------------------------------------------------
ROM:0663 CA 87 06		     jz	     loc_687
ROM:0666 3A C9 21		     lda     21C9h
ROM:0669 2F			     cma
ROM:066A D3 00			     out     0
ROM:066C 3A CA 21		     lda     21CAh
ROM:066F 2F			     cma
ROM:0670 D3 01			     out     1
ROM:0672 3A CB 21		     lda     21CBh
ROM:0675 2F			     cma
ROM:0676 D3 02			     out     2
ROM:0678 3A CC 21		     lda     21CCh
ROM:067B 2F			     cma
ROM:067C D3 03			     out     3
ROM:067E 3A CD 21		     lda     21CDh
ROM:0681 2F			     cma
ROM:0682 D3 04			     out     4
ROM:0684 C3 08 06		     jmp     loc_608
ROM:0687	     ; ---------------------------------------------------------------------------
ROM:0687
ROM:0687	     loc_687:				     ; CODE XREF: ROM:0663j
ROM:0687 3A CE 21		     lda     21CEh
ROM:068A 2F			     cma
ROM:068B D3 00			     out     0
ROM:068D 3A CF 21		     lda     21CFh
ROM:0690 2F			     cma
ROM:0691 D3 01			     out     1
ROM:0693 3A D0 21		     lda     21D0h
ROM:0696 2F			     cma
ROM:0697 D3 02			     out     2
ROM:0699 3A D1 21		     lda     21D1h
ROM:069C 2F			     cma
ROM:069D D3 03			     out     3
ROM:069F 3A D2 21		     lda     21D2h
ROM:06A2 2F			     cma
ROM:06A3 D3 04			     out     4
ROM:06A5 C3 08 06		     jmp     loc_608
ROM:06A8	     ; ---------------------------------------------------------------------------
ROM:06A8
ROM:06A8	     loc_6A8:				     ; CODE XREF: ROM:0648j
ROM:06A8 21 A0 23		     lxi     h,	23A0h
ROM:06AB C3 4E 06		     jmp     loc_64E
ROM:06AE	     ; ---------------------------------------------------------------------------
ROM:06AE 82			     add     d
ROM:06AF 0C			     inr     c
ROM:06B0 89			     adc     c
ROM:06B1 12			     stax    d
ROM:06B2 50			     mov     d,	b
ROM:06B3 07			     rlc
ROM:06B4 B8			     cmp     b
ROM:06B5 1A			     ldax    d
ROM:06B6 11 0B 57		     lxi     d,	570Bh
ROM:06B9 0B			     dcx     b
ROM:06BA 41			     mov     b,	c
ROM:06BB 05			     dcr     b
ROM:06BC 9F			     sbb     a
ROM:06BD 05			     dcr     b
ROM:06BE 21 08 70		     lxi     h,	7008h
ROM:06C1 19			     dad     d
ROM:06C2 D2 1A 76		     jnc     761Ah
ROM:06C5 05			     dcr     b
ROM:06C6 20			     rim
ROM:06C7 06 36			     mvi     b,	36h ; '6'
ROM:06C9 15			     dcr     d
ROM:06CA A5			     ana     l
ROM:06CB 0B			     dcx     b
ROM:06CC 67			     mov     h,	a
ROM:06CD 0C			     inr     c
ROM:06CE 42			     mov     b,	d
ROM:06CF 0D			     dcr     c
ROM:06D0 ED			     lhlx
ROM:06D1 07			     rlc
ROM:06D2 F6 08			     ori     8
ROM:06D4 F4 09 1A		     cp	     loc_1A08+1
ROM:06D7	     ; ---------------------------------------------------------------------------
ROM:06D7 0A			     ldax    b
ROM:06D8 67			     mov     h,	a
ROM:06D9 1D			     dcr     e
ROM:06DA 75			     mov     m,	l
ROM:06DB 07			     rlc
ROM:06DC 3B			     dcx     sp
ROM:06DD 19			     dad     d
ROM:06DE 2E 0E			     mvi     l,	0Eh
ROM:06E0 D2 08 11		     jnc     loc_1108
ROM:06E3 00			     nop
ROM:06E4 00			     nop
ROM:06E5 C3 11 07		     jmp     loc_711
ROM:06E8	     ; ---------------------------------------------------------------------------
ROM:06E8 11 01 00		     lxi     d,	1
ROM:06EB C3 11 07		     jmp     loc_711
ROM:06EE	     ; ---------------------------------------------------------------------------
ROM:06EE 11 02 00		     lxi     d,	2
ROM:06F1 C3 11 07		     jmp     loc_711
ROM:06F4	     ; ---------------------------------------------------------------------------
ROM:06F4 11 03 00		     lxi     d,	3
ROM:06F7 C3 11 07		     jmp     loc_711
ROM:06FA	     ; ---------------------------------------------------------------------------
ROM:06FA 11 04 00		     lxi     d,	4
ROM:06FD C3 11 07		     jmp     loc_711
ROM:0700	     ; ---------------------------------------------------------------------------
ROM:0700 11 05 00		     lxi     d,	5
ROM:0703 C3 11 07		     jmp     loc_711
ROM:0706	     ; ---------------------------------------------------------------------------
ROM:0706 3A 91 21		     lda     2191h
ROM:0709 F6 20			     ori     20h
ROM:070B 32 91 21		     sta     2191h
ROM:070E C3 7A 03		     jmp     loc_37A
ROM:0711	     ; ---------------------------------------------------------------------------
ROM:0711
ROM:0711	     loc_711:				     ; CODE XREF: ROM:06E5j
ROM:0711						     ; ROM:06EBj ...
ROM:0711 21 88 07		     lxi     h,	788h
ROM:0714 19			     dad     d
ROM:0715 7E			     mov     a,	m
ROM:0716 EB			     xchg
ROM:0717 29			     dad     h
ROM:0718 EB			     xchg
ROM:0719 21 8F 07		     lxi     h,	78Fh
ROM:071C 19			     dad     d
ROM:071D 46			     mov     b,	m
ROM:071E 23			     inx     h
ROM:071F 66			     mov     h,	m
ROM:0720 68			     mov     l,	b
ROM:0721 CD CE 03		     call    sub_3CE
ROM:0724	     ; ---------------------------------------------------------------------------
ROM:0724 3E 09			     mvi     a,	9
ROM:0726 32 99 21		     sta     2199h
ROM:0729 3A C3 21		     lda     21C3h
ROM:072C 2F			     cma
ROM:072D D3 06			     out     6
ROM:072F 3A C4 21		     lda     21C4h
ROM:0732 2F			     cma
ROM:0733 D3 07			     out     7
ROM:0735 21 9D 07		     lxi     h,	79Dh
ROM:0738 19			     dad     d
ROM:0739 46			     mov     b,	m
ROM:073A 23			     inx     h
ROM:073B 66			     mov     h,	m
ROM:073C 68			     mov     l,	b
ROM:073D D5			     push    d
ROM:073E CD E4 12		     call    sub_12E4
ROM:0741	     ; ---------------------------------------------------------------------------
ROM:0741 D1			     pop     d
ROM:0742 21 AB 07		     lxi     h,	7ABh
ROM:0745 19			     dad     d
ROM:0746 46			     mov     b,	m
ROM:0747 23			     inx     h
ROM:0748 66			     mov     h,	m
ROM:0749 68			     mov     l,	b
ROM:074A CD 6E 02		     call    loc_26E
ROM:074D	     ; ---------------------------------------------------------------------------
ROM:074D C3 7A 03		     jmp     loc_37A
ROM:0750	     ; ---------------------------------------------------------------------------
ROM:0750 3A C3 21		     lda     21C3h
ROM:0753 E6 30			     ani     30h
ROM:0755 32 C3 21		     sta     21C3h
ROM:0758 2F			     cma
ROM:0759 D3 06			     out     6
ROM:075B 3A C4 21		     lda     21C4h
ROM:075E E6 20			     ani     20h
ROM:0760 32 C4 21		     sta     21C4h
ROM:0763 2F			     cma
ROM:0764 D3 07			     out     7
ROM:0766 3A AD 21		     lda     21ADh
ROM:0769 B7			     ora     a
ROM:076A C2 08 06		     jnz     loc_608
ROM:076D 3E 06			     mvi     a,	6
ROM:076F 32 AD 21		     sta     21ADh
ROM:0772 C3 08 06		     jmp     loc_608
ROM:0775	     ; ---------------------------------------------------------------------------
ROM:0775 21 90 21		     lxi     h,	2190h
ROM:0778 3E 02			     mvi     a,	2
ROM:077A CD E6 03		     call    sub_3E6
ROM:077D	     ; ---------------------------------------------------------------------------
ROM:077D C2 08 06		     jnz     loc_608
ROM:0780 3E 80			     mvi     a,	80h ; '€'
ROM:0782 32 93 21		     sta     2193h
ROM:0785 C3 08 06		     jmp     loc_608
ROM:0785	     ; ---------------------------------------------------------------------------
ROM:0788 03			     .db    3
ROM:0789 00			     .db    0
ROM:078A 01			     .db    1
ROM:078B 02			     .db    2
ROM:078C 03			     .db    3
ROM:078D 04			     .db    4
ROM:078E 02			     .db    2
ROM:078F	     ; ---------------------------------------------------------------------------
ROM:078F C3 21 C4		     jmp     0C421h
ROM:0792	     ; ---------------------------------------------------------------------------
ROM:0792 21 C4 21		     lxi     h,	21C4h
ROM:0795 C3 21 C4		     jmp     0C421h
ROM:0798	     ; ---------------------------------------------------------------------------
ROM:0798 21 C4 21		     lxi     h,	21C4h
ROM:079B C4 21 30		     cnz     3021h
ROM:079E 13			     inx     d
ROM:079F 33			     inx     sp
ROM:07A0 13			     inx     d
ROM:07A1 36 13			     mvi     m,	13h
ROM:07A3 39			     dad     sp
ROM:07A4 13			     inx     d
ROM:07A5 3C			     inr     a
ROM:07A6 13			     inx     d
ROM:07A7 3F			     cmc
ROM:07A8 13			     inx     d
ROM:07A9 42			     mov     b,	d
ROM:07AA 13			     inx     d
ROM:07AB D8			     rc
ROM:07AC 11 DC 11		     lxi     d,	11DCh
ROM:07AF E0			     rpo
ROM:07B0 11 D4 11		     lxi     d,	11D4h
ROM:07B3 D0			     rnc
ROM:07B4 11 D0 11		     lxi     d,	11D0h
ROM:07B7 CC 11 3A		     cz	     3A11h
ROM:07BA C3 21 F6		     jmp     0F621h
ROM:07BA	     ; ---------------------------------------------------------------------------
ROM:07BD 10			     .db 10h
ROM:07BE 32			     .db  32h ;	2
ROM:07BF	     ; ---------------------------------------------------------------------------
ROM:07BF C3 21 2F		     jmp     2F21h
ROM:07C2	     ; ---------------------------------------------------------------------------
ROM:07C2 D3 06			     out     6
ROM:07C4 3E 09			     mvi     a,	9
ROM:07C6 32 A8 21		     sta     21A8h
ROM:07C9 21 90 21		     lxi     h,	2190h
ROM:07CC 3E 05			     mvi     a,	5
ROM:07CE CD E6 03		     call    sub_3E6
ROM:07D1	     ; ---------------------------------------------------------------------------
ROM:07D1 C2 7A 03		     jnz     loc_37A
ROM:07D4 21 D1 13		     lxi     h,	13D1h
ROM:07D7 CD E4 12		     call    sub_12E4
ROM:07DA	     ; ---------------------------------------------------------------------------
ROM:07DA 21 91 21		     lxi     h,	2191h
ROM:07DD 3E 00			     mvi     a,	0
ROM:07DF CD E6 03		     call    sub_3E6
ROM:07E2	     ; ---------------------------------------------------------------------------
ROM:07E2 CA 7A 03		     jz	     loc_37A
ROM:07E5 3E 7D			     mvi     a,	7Dh ; '}'
ROM:07E7 32 9F 21		     sta     219Fh
ROM:07EA C3 7A 03		     jmp     loc_37A
ROM:07ED	     ; ---------------------------------------------------------------------------
ROM:07ED 21 C3 21		     lxi     h,	21C3h
ROM:07F0 3E 04			     mvi     a,	4
ROM:07F2 CD E6 03		     call    sub_3E6
ROM:07F5	     ; ---------------------------------------------------------------------------
ROM:07F5 C2 0E 08		     jnz     loc_80E
ROM:07F8 21 90 21		     lxi     h,	2190h
ROM:07FB 3E 02			     mvi     a,	2
ROM:07FD CD E6 03		     call    sub_3E6
ROM:0800	     ; ---------------------------------------------------------------------------
ROM:0800 C2 08 06		     jnz     loc_608
ROM:0803 3E 04			     mvi     a,	4
ROM:0805 21 94 21		     lxi     h,	2194h
ROM:0808 CD D9 03		     call    sub_3D9
ROM:080B	     ; ---------------------------------------------------------------------------
ROM:080B C3 08 06		     jmp     loc_608
ROM:080E	     ; ---------------------------------------------------------------------------
ROM:080E
ROM:080E	     loc_80E:				     ; CODE XREF: ROM:07F5j
ROM:080E 3A C3 21		     lda     21C3h
ROM:0811 E6 2F			     ani     2Fh
ROM:0813 32 C3 21		     sta     21C3h
ROM:0816 2F			     cma
ROM:0817 D3 06			     out     6
ROM:0819 3E 06			     mvi     a,	6
ROM:081B 32 A8 21		     sta     21A8h
ROM:081E C3 08 06		     jmp     loc_608
ROM:0821	     ; ---------------------------------------------------------------------------
ROM:0821 3A C3 21		     lda     21C3h
ROM:0824 F6 30			     ori     30h
ROM:0826 32 C3 21		     sta     21C3h
ROM:0829 3E 09			     mvi     a,	9
ROM:082B 32 A8 21		     sta     21A8h
ROM:082E 32 A9 21		     sta     21A9h
ROM:0831 3E 71			     mvi     a,	71h ; 'q'
ROM:0833 32 9F 21		     sta     219Fh
ROM:0836 3A 1F 22		     lda     221Fh
ROM:0839 3D			     dcr     a
ROM:083A 32 1F 22		     sta     221Fh
ROM:083D C2 62 08		     jnz     loc_862
ROM:0840 3E 3C			     mvi     a,	3Ch ; '<'
ROM:0842 32 1F 22		     sta     221Fh
ROM:0845 3A 20 22		     lda     2220h
ROM:0848 3C			     inr     a
ROM:0849 27			     daa
ROM:084A 32 20 22		     sta     2220h
ROM:084D FE 60			     cpi     60h ; '`'
ROM:084F C2 08 06		     jnz     loc_608
ROM:0852 3E 00			     mvi     a,	0
ROM:0854 32 20 22		     sta     2220h
ROM:0857 3A 21 22		     lda     2221h
ROM:085A 3C			     inr     a
ROM:085B 27			     daa
ROM:085C 32 21 22		     sta     2221h
ROM:085F C3 08 06		     jmp     loc_608
ROM:0862	     ; ---------------------------------------------------------------------------
ROM:0862
ROM:0862	     loc_862:				     ; CODE XREF: ROM:083Dj
ROM:0862 3A 20 22		     lda     2220h
ROM:0865 32 9A 23		     sta     239Ah
ROM:0868 32 BA 23		     sta     23BAh
ROM:086B 3A 21 22		     lda     2221h
ROM:086E 32 9F 23		     sta     239Fh
ROM:0871 32 BF 23		     sta     23BFh
ROM:0874 C3 08 06		     jmp     loc_608
ROM:0877	     ; ---------------------------------------------------------------------------
ROM:0877 3A 92 21		     lda     2192h
ROM:087A E6 FE			     ani     0FEh
ROM:087C 47			     mov     b,	a
ROM:087D E6 80			     ani     80h
ROM:087F CA AE 08		     jz	     loc_8AE
ROM:0882 CD 8A 08		     call    sub_88A
ROM:0885 3E 05			     mvi     a,	5
ROM:0887 C3 6E 03		     jmp     loc_36E
ROM:088A
ROM:088A	     ; =============== S U B R O U T I N E =======================================
ROM:088A
ROM:088A
ROM:088A	     sub_88A:				     ; CODE XREF: ROM:0882p
ROM:088A						     ; ROM:0937p
ROM:088A 78			     mov     a,	b
ROM:088B E6 04			     ani     4
ROM:088D 3A 41 22		     lda     2241h
ROM:0890 CA 98 08		     jz	     loc_898
ROM:0893 F6 01			     ori     1
ROM:0895 C3 9A 08		     jmp     loc_89A
ROM:0898	     ; ---------------------------------------------------------------------------
ROM:0898
ROM:0898	     loc_898:				     ; CODE XREF: sub_88A+6j
ROM:0898 E6 FE			     ani     0FEh
ROM:089A
ROM:089A	     loc_89A:				     ; CODE XREF: sub_88A+Bj
ROM:089A 32 41 22		     sta     2241h
ROM:089D 78			     mov     a,	b
ROM:089E F6 04			     ori     4
ROM:08A0 32 92 21		     sta     2192h
ROM:08A3 3E 02			     mvi     a,	2
ROM:08A5 32 B0 21		     sta     21B0h
ROM:08A8 3E 20			     mvi     a,	20h ; ' '
ROM:08AA 32 43 22		     sta     2243h
ROM:08AD C9			     ret
ROM:08AD	     ; End of function sub_88A
ROM:08AD
ROM:08AE	     ; ---------------------------------------------------------------------------
ROM:08AE
ROM:08AE	     loc_8AE:				     ; CODE XREF: ROM:087Fj
ROM:08AE 3A C3 21		     lda     21C3h
ROM:08B1 F6 20			     ori     20h
ROM:08B3 32 C3 21		     sta     21C3h
ROM:08B6 2F			     cma
ROM:08B7 D3 06			     out     6
ROM:08B9 3E 09			     mvi     a,	9
ROM:08BB 32 A9 21		     sta     21A9h
ROM:08BE 21 90 21		     lxi     h,	2190h
ROM:08C1 3E 05			     mvi     a,	5
ROM:08C3 CD E6 03		     call    sub_3E6
ROM:08C6	     ; ---------------------------------------------------------------------------
ROM:08C6 C2 7A 03		     jnz     loc_37A
ROM:08C9 21 D1 13		     lxi     h,	13D1h
ROM:08CC CD E4 12		     call    sub_12E4
ROM:08CF	     ; ---------------------------------------------------------------------------
ROM:08CF C3 7A 03		     jmp     loc_37A
ROM:08D2	     ; ---------------------------------------------------------------------------
ROM:08D2 3A 43 22		     lda     2243h
ROM:08D5 3D			     dcr     a
ROM:08D6 F2 EB 08		     jp	     loc_8EB
ROM:08D9 DB 04			     in	     4
ROM:08DB E6 40			     ani     40h
ROM:08DD C2 EE 08		     jnz     loc_8EE
ROM:08E0 3A 92 21		     lda     2192h
ROM:08E3 E6 FB			     ani     0FBh
ROM:08E5 32 92 21		     sta     2192h
ROM:08E8 C3 08 06		     jmp     loc_608
ROM:08EB	     ; ---------------------------------------------------------------------------
ROM:08EB
ROM:08EB	     loc_8EB:				     ; CODE XREF: ROM:08D6j
ROM:08EB 32 43 22		     sta     2243h
ROM:08EE
ROM:08EE	     loc_8EE:				     ; CODE XREF: ROM:08DDj
ROM:08EE 3E 04			     mvi     a,	4
ROM:08F0 32 B0 21		     sta     21B0h
ROM:08F3 C3 08 06		     jmp     loc_608
ROM:08F6	     ; ---------------------------------------------------------------------------
ROM:08F6 21 C3 21		     lxi     h,	21C3h
ROM:08F9 3E 05			     mvi     a,	5
ROM:08FB CD E6 03		     call    sub_3E6
ROM:08FE	     ; ---------------------------------------------------------------------------
ROM:08FE C2 17 09		     jnz     loc_917
ROM:0901 21 90 21		     lxi     h,	2190h
ROM:0904 3E 02			     mvi     a,	2
ROM:0906 CD E6 03		     call    sub_3E6
ROM:0906	     ; ---------------------------------------------------------------------------
ROM:0909 C2			     .db 0C2h ;	Â
ROM:090A 08			     .db    8
ROM:090B 06			     .db    6
ROM:090C 21			     .db  21h ;	!
ROM:090D 94			     .db  94h ;	”
ROM:090E 21			     .db  21h ;	!
ROM:090F 3E			     .db  3Eh ;	>
ROM:0910 05			     .db    5
ROM:0911 CD			     .db 0CDh ;	Í
ROM:0912 D9			     .db 0D9h ;	Ù
ROM:0913 03			     .db    3
ROM:0914 C3			     .db 0C3h ;	Ã
ROM:0915 08			     .db    8
ROM:0916 06			     .db    6
ROM:0917	     ; ---------------------------------------------------------------------------
ROM:0917
ROM:0917	     loc_917:				     ; CODE XREF: ROM:08FEj
ROM:0917 3A C3 21		     lda     21C3h
ROM:091A E6 1F			     ani     1Fh
ROM:091C 32 C3 21		     sta     21C3h
ROM:091F 2F			     cma
ROM:0920 D3 06			     out     6
ROM:0922 3E 06			     mvi     a,	6
ROM:0924 32 A9 21		     sta     21A9h
ROM:0927 C3 08 06		     jmp     loc_608
ROM:092A	     ; ---------------------------------------------------------------------------
ROM:092A DB 04			     in	     4
ROM:092C E6 10			     ani     10h
ROM:092E CA 3F 09		     jz	     loc_93F
ROM:0931 3A 92 21		     lda     2192h
ROM:0934 E6 FE			     ani     0FEh
ROM:0936 47			     mov     b,	a
ROM:0937 CD 8A 08		     call    sub_88A
ROM:093A 3E 02			     mvi     a,	2
ROM:093C C3 6E 03		     jmp     loc_36E
ROM:093F	     ; ---------------------------------------------------------------------------
ROM:093F
ROM:093F	     loc_93F:				     ; CODE XREF: ROM:092Ej
ROM:093F 3A 92 21		     lda     2192h
ROM:0942 E6 20			     ani     20h
ROM:0944 C2 68 09		     jnz     loc_968
ROM:0947 3E 00			     mvi     a,	0
ROM:0949 32 7C 23		     sta     237Ch
ROM:094C 32 7D 23		     sta     237Dh
ROM:094F 32 9C 23		     sta     239Ch
ROM:0952 32 9D 23		     sta     239Dh
ROM:0955 32 BC 23		     sta     23BCh
ROM:0958 32 BD 23		     sta     23BDh
ROM:095B 21 92 21		     lxi     h,	2192h
ROM:095E 3E 05			     mvi     a,	5
ROM:0960 CD CE 03		     call    sub_3CE
ROM:0963	     ; ---------------------------------------------------------------------------
ROM:0963 3E 02			     mvi     a,	2
ROM:0965 32 AA 21		     sta     21AAh
ROM:0968
ROM:0968	     loc_968:				     ; CODE XREF: ROM:0944j
ROM:0968 CD 8A 09		     call    sub_98A
ROM:096B	     ; ---------------------------------------------------------------------------
ROM:096B DB 05			     in	     5
ROM:096D E6 80			     ani     80h
ROM:096F 3E 01			     mvi     a,	1
ROM:0971 C2 76 09		     jnz     loc_976
ROM:0974 3E 04			     mvi     a,	4
ROM:0976
ROM:0976	     loc_976:				     ; CODE XREF: ROM:0971j
ROM:0976 32 42 22		     sta     2242h
ROM:0979 3A 94 21		     lda     2194h
ROM:097C F6 40			     ori     40h
ROM:097E 32 94 21		     sta     2194h
ROM:0981 21 C4 13		     lxi     h,	13C4h
ROM:0984 CD E4 12		     call    sub_12E4
ROM:0984	     ; ---------------------------------------------------------------------------
ROM:0987 C3			     .db 0C3h ;	Ã
ROM:0988 7A			     .db  7Ah ;	z
ROM:0989 03			     .db    3
ROM:098A
ROM:098A	     ; =============== S U B R O U T I N E =======================================
ROM:098A
ROM:098A	     ; Attributes: noreturn
ROM:098A
ROM:098A	     sub_98A:				     ; CODE XREF: ROM:loc_968p
ROM:098A						     ; ROM:0A37p
ROM:098A 3A 7A 23		     lda     237Ah
ROM:098D FE 99			     cpi     99h ; '™'
ROM:098F C8			     rz
ROM:0990 21 7C 23		     lxi     h,	237Ch
ROM:0993 3A 7F 23		     lda     237Fh
ROM:0996 86			     add     m
ROM:0997 27			     daa
ROM:0998 32 7C 23		     sta     237Ch
ROM:099B 32 9C 23		     sta     239Ch
ROM:099E 32 BC 23		     sta     23BCh
ROM:09A1 23			     inx     h
ROM:09A2 3E 00			     mvi     a,	0
ROM:09A4 8E			     adc     m
ROM:09A5 27			     daa
ROM:09A6 32 7D 23		     sta     237Dh
ROM:09A9 32 9D 23		     sta     239Dh
ROM:09AC 32 BD 23		     sta     23BDh
ROM:09AF 3E 07			     mvi     a,	7
ROM:09B1 21 76 23		     lxi     h,	2376h
ROM:09B4 CD D9 03		     call    sub_3D9
ROM:09B4	     ; End of function sub_98A
ROM:09B4
ROM:09B7	     ; ---------------------------------------------------------------------------
ROM:09B7 21 96 23		     lxi     h,	2396h
ROM:09BA CD D9 03		     call    sub_3D9
ROM:09BD	     ; ---------------------------------------------------------------------------
ROM:09BD 21 B6 23		     lxi     h,	23B6h
ROM:09C0 CD D9 03		     call    sub_3D9
ROM:09C3	     ; ---------------------------------------------------------------------------
ROM:09C3 06 00			     mvi     b,	0
ROM:09C5 CD 82 1D		     call    sub_1D82
ROM:09C8	     ; ---------------------------------------------------------------------------
ROM:09C8 3A 7A 23		     lda     237Ah
ROM:09CB 3C			     inr     a
ROM:09CC 27			     daa
ROM:09CD 32 7A 23		     sta     237Ah
ROM:09D0 32 9A 23		     sta     239Ah
ROM:09D3 32 BA 23		     sta     23BAh
ROM:09D6 21 C5 21		     lxi     h,	21C5h
ROM:09D9 3E 03			     mvi     a,	3
ROM:09DB CD CE 03		     call    sub_3CE
ROM:09DE	     ; ---------------------------------------------------------------------------
ROM:09DE 3E 09			     mvi     a,	9
ROM:09E0 32 AB 21		     sta     21ABh
ROM:09E3 3A 40 22		     lda     2240h
ROM:09E6 3D			     dcr     a
ROM:09E7 32 40 22		     sta     2240h
ROM:09EA C0			     rnz
ROM:09EB CD A8 1F		     call    sub_1FA8
ROM:09EE 3E 64			     mvi     a,	64h ; 'd'
ROM:09F0 32 40 22		     sta     2240h
ROM:09F3 C9			     ret
ROM:09F4	     ; ---------------------------------------------------------------------------
ROM:09F4 DB 04			     in	     4
ROM:09F6 E6 10			     ani     10h
ROM:09F8 CA 0D 0A		     jz	     loc_A0D
ROM:09FB 21 1D 22		     lxi     h,	221Dh
ROM:09FE 35			     dcr     m
ROM:09FF C2 12 0A		     jnz     loc_A12
ROM:0A02 21 92 21		     lxi     h,	2192h
ROM:0A05 3E 05			     mvi     a,	5
ROM:0A07 CD D9 03		     call    sub_3D9
ROM:0A07	     ; ---------------------------------------------------------------------------
ROM:0A0A C3			     .db 0C3h ;	Ã
ROM:0A0B 08			     .db    8
ROM:0A0C 06			     .db    6
ROM:0A0D	     ; ---------------------------------------------------------------------------
ROM:0A0D
ROM:0A0D	     loc_A0D:				     ; CODE XREF: ROM:09F8j
ROM:0A0D 3E 40			     mvi     a,	40h ; '@'
ROM:0A0F 32 1D 22		     sta     221Dh
ROM:0A12
ROM:0A12	     loc_A12:				     ; CODE XREF: ROM:09FFj
ROM:0A12 3E 04			     mvi     a,	4
ROM:0A14 32 AA 21		     sta     21AAh
ROM:0A17 C3 08 06		     jmp     loc_608
ROM:0A1A	     ; ---------------------------------------------------------------------------
ROM:0A1A 21 C5 21		     lxi     h,	21C5h
ROM:0A1D 3E 03			     mvi     a,	3
ROM:0A1F CD E6 03		     call    sub_3E6
ROM:0A22	     ; ---------------------------------------------------------------------------
ROM:0A22 CA 30 0A		     jz	     loc_A30
ROM:0A25 CD D9 03		     call    sub_3D9
ROM:0A28	     ; ---------------------------------------------------------------------------
ROM:0A28 3E 09			     mvi     a,	9
ROM:0A2A 32 AB 21		     sta     21ABh
ROM:0A2D C3 08 06		     jmp     loc_608
ROM:0A30	     ; ---------------------------------------------------------------------------
ROM:0A30
ROM:0A30	     loc_A30:				     ; CODE XREF: ROM:0A22j
ROM:0A30 21 42 22		     lxi     h,	2242h
ROM:0A33 35			     dcr     m
ROM:0A34 CA 3D 0A		     jz	     loc_A3D
ROM:0A37 CD 8A 09		     call    sub_98A
ROM:0A3A	     ; ---------------------------------------------------------------------------
ROM:0A3A C3 08 06		     jmp     loc_608
ROM:0A3D	     ; ---------------------------------------------------------------------------
ROM:0A3D
ROM:0A3D	     loc_A3D:				     ; CODE XREF: ROM:0A34j
ROM:0A3D 3A 94 21		     lda     2194h
ROM:0A40 E6 BB			     ani     0BBh
ROM:0A42 32 94 21		     sta     2194h
ROM:0A45 C3 08 06		     jmp     loc_608
ROM:0A48	     ; ---------------------------------------------------------------------------
ROM:0A48 06 24			     mvi     b,	24h ; '$'
ROM:0A4A 0E 00			     mvi     c,	0
ROM:0A4C C3 80 0A		     jmp     loc_A80
ROM:0A4F	     ; ---------------------------------------------------------------------------
ROM:0A4F 06 03			     mvi     b,	3
ROM:0A51 0E 01			     mvi     c,	1
ROM:0A53 C3 80 0A		     jmp     loc_A80
ROM:0A56	     ; ---------------------------------------------------------------------------
ROM:0A56 06 0B			     mvi     b,	0Bh
ROM:0A58 0E 02			     mvi     c,	2
ROM:0A5A C3 80 0A		     jmp     loc_A80
ROM:0A5D	     ; ---------------------------------------------------------------------------
ROM:0A5D 06 13			     mvi     b,	13h
ROM:0A5F 0E 03			     mvi     c,	3
ROM:0A61 C3 80 0A		     jmp     loc_A80
ROM:0A64	     ; ---------------------------------------------------------------------------
ROM:0A64 06 29			     mvi     b,	29h ; ')'
ROM:0A66 0E 04			     mvi     c,	4
ROM:0A68 C3 80 0A		     jmp     loc_A80
ROM:0A6B	     ; ---------------------------------------------------------------------------
ROM:0A6B 3E 04			     mvi     a,	4
ROM:0A6D 32 97 21		     sta     2197h
ROM:0A70 21 08 22		     lxi     h,	2208h
ROM:0A73 3E FF			     mvi     a,	0FFh
ROM:0A75 86			     add     m
ROM:0A76 D2 95 0A		     jnc     loc_A95
ROM:0A79 77			     mov     m,	a
ROM:0A7A CA B7 0C		     jz	     loc_CB7
ROM:0A7D C3 7A 14		     jmp     loc_147A
ROM:0A80	     ; ---------------------------------------------------------------------------
ROM:0A80
ROM:0A80	     loc_A80:				     ; CODE XREF: ROM:0A4Cj
ROM:0A80						     ; ROM:0A53j ...
ROM:0A80 21 08 22		     lxi     h,	2208h
ROM:0A83 3E FF			     mvi     a,	0FFh
ROM:0A85 86			     add     m
ROM:0A86 D2 95 0A		     jnc     loc_A95
ROM:0A89 77			     mov     m,	a
ROM:0A8A CA A2 0A		     jz	     loc_AA2
ROM:0A8D 3E 04			     mvi     a,	4
ROM:0A8F 32 97 21		     sta     2197h
ROM:0A92 C3 7A 14		     jmp     loc_147A
ROM:0A95	     ; ---------------------------------------------------------------------------
ROM:0A95
ROM:0A95	     loc_A95:				     ; CODE XREF: ROM:0A76j
ROM:0A95						     ; ROM:0A86j
ROM:0A95 3E 64			     mvi     a,	64h ; 'd'
ROM:0A97 32 08 22		     sta     2208h
ROM:0A9A 3E 04			     mvi     a,	4
ROM:0A9C 32 97 21		     sta     2197h
ROM:0A9F C3 7A 14		     jmp     loc_147A
ROM:0AA2	     ; ---------------------------------------------------------------------------
ROM:0AA2
ROM:0AA2	     loc_AA2:				     ; CODE XREF: ROM:0A8Aj
ROM:0AA2 21 90 21		     lxi     h,	2190h
ROM:0AA5 3E 07			     mvi     a,	7
ROM:0AA7 CD CE 03		     call    sub_3CE
ROM:0AAA	     ; ---------------------------------------------------------------------------
ROM:0AAA 3E 02			     mvi     a,	2
ROM:0AAC CD E6 03		     call    sub_3E6
ROM:0AAF	     ; ---------------------------------------------------------------------------
ROM:0AAF CA C1 0A		     jz	     loc_AC1
ROM:0AB2 79			     mov     a,	c
ROM:0AB3 CD 47 0C		     call    sub_C47
ROM:0AB6 CD CE 03		     call    sub_3CE
ROM:0AB9	     ; ---------------------------------------------------------------------------
ROM:0AB9 3E 06			     mvi     a,	6
ROM:0ABB 32 A6 21		     sta     21A6h
ROM:0ABE C3 7A 14		     jmp     loc_147A
ROM:0AC1	     ; ---------------------------------------------------------------------------
ROM:0AC1
ROM:0AC1	     loc_AC1:				     ; CODE XREF: ROM:0AAFj
ROM:0AC1 CD 82 1D		     call    sub_1D82
ROM:0AC4	     ; ---------------------------------------------------------------------------
ROM:0AC4 79			     mov     a,	c
ROM:0AC5 21 C7 21		     lxi     h,	21C7h
ROM:0AC8 CD E6 03		     call    sub_3E6
ROM:0ACB	     ; ---------------------------------------------------------------------------
ROM:0ACB CA 2A 0C		     jz	     loc_C2A
ROM:0ACE CD D9 03		     call    sub_3D9
ROM:0AD1	     ; ---------------------------------------------------------------------------
ROM:0AD1 21 11 22		     lxi     h,	2211h
ROM:0AD4 BE			     cmp     m
ROM:0AD5 21 92 21		     lxi     h,	2192h
ROM:0AD8 3E 01			     mvi     a,	1
ROM:0ADA C2 E3 0A		     jnz     loc_AE3
ROM:0ADD CD CE 03		     call    sub_3CE
ROM:0AE0	     ; ---------------------------------------------------------------------------
ROM:0AE0 C3 E6 0A		     jmp     loc_AE6
ROM:0AE3	     ; ---------------------------------------------------------------------------
ROM:0AE3
ROM:0AE3	     loc_AE3:				     ; CODE XREF: ROM:0ADAj
ROM:0AE3 CD D9 03		     call    sub_3D9
ROM:0AE6	     ; ---------------------------------------------------------------------------
ROM:0AE6
ROM:0AE6	     loc_AE6:				     ; CODE XREF: ROM:0AE0j
ROM:0AE6 79			     mov     a,	c
ROM:0AE7 CD 47 0C		     call    sub_C47
ROM:0AEA CD 9D 1D		     call    sub_1D9D
ROM:0AED	     ; ---------------------------------------------------------------------------
ROM:0AED CA FB 0A		     jz	     loc_AFB
ROM:0AF0 EB			     xchg
ROM:0AF1 19			     dad     d
ROM:0AF2 CD E6 03		     call    sub_3E6
ROM:0AF5	     ; ---------------------------------------------------------------------------
ROM:0AF5 EB			     xchg
ROM:0AF6 3E 01			     mvi     a,	1
ROM:0AF8 CA 0B 0B		     jz	     loc_B0B
ROM:0AFB
ROM:0AFB	     loc_AFB:				     ; CODE XREF: ROM:0AEDj
ROM:0AFB CD 92 1D		     call    sub_1D92
ROM:0AFE	     ; ---------------------------------------------------------------------------
ROM:0AFE 21 66 13		     lxi     h,	1366h
ROM:0B01 CD E4 12		     call    sub_12E4
ROM:0B04	     ; ---------------------------------------------------------------------------
ROM:0B04 3E C8			     mvi     a,	0C8h ; 'È'
ROM:0B06 32 08 22		     sta     2208h
ROM:0B09 3E 5A			     mvi     a,	5Ah ; 'Z'
ROM:0B0B
ROM:0B0B	     loc_B0B:				     ; CODE XREF: ROM:0AF8j
ROM:0B0B 32 9B 21		     sta     219Bh
ROM:0B0E C3 7A 14		     jmp     loc_147A
ROM:0B11	     ; ---------------------------------------------------------------------------
ROM:0B11 21 AD 0C		     lxi     h,	0CADh
ROM:0B14 3A C8 21		     lda     21C8h
ROM:0B17 87			     add     a
ROM:0B18 16 00			     mvi     d,	0
ROM:0B1A 5F			     mov     e,	a
ROM:0B1B 19			     dad     d
ROM:0B1C 7E			     mov     a,	m
ROM:0B1D 23			     inx     h
ROM:0B1E 66			     mov     h,	m
ROM:0B1F 6F			     mov     l,	a
ROM:0B20 CD ED 0E		     call    sub_EED
ROM:0B23	     ; ---------------------------------------------------------------------------
ROM:0B23 21 60 13		     lxi     h,	1360h
ROM:0B26 CD E4 12		     call    sub_12E4
ROM:0B29	     ; ---------------------------------------------------------------------------
ROM:0B29 21 92 21		     lxi     h,	2192h
ROM:0B2C 3E 01			     mvi     a,	1
ROM:0B2E CD E6 03		     call    sub_3E6
ROM:0B31	     ; ---------------------------------------------------------------------------
ROM:0B31 CA 7A 0B		     jz	     loc_B7A
ROM:0B34 CD D9 03		     call    sub_3D9
ROM:0B37	     ; ---------------------------------------------------------------------------
ROM:0B37 21 91 21		     lxi     h,	2191h
ROM:0B3A 3E 01			     mvi     a,	1
ROM:0B3C CD E6 03		     call    sub_3E6
ROM:0B3F	     ; ---------------------------------------------------------------------------
ROM:0B3F CA 7A 0B		     jz	     loc_B7A
ROM:0B42 CD D9 03		     call    sub_3D9
ROM:0B45	     ; ---------------------------------------------------------------------------
ROM:0B45 3E FA			     mvi     a,	0FAh ; 'ú'
ROM:0B47 32 08 22		     sta     2208h
ROM:0B4A 3E 05			     mvi     a,	5
ROM:0B4C 32 1A 22		     sta     221Ah
ROM:0B4F 3E 28			     mvi     a,	28h ; '('
ROM:0B51 32 9C 21		     sta     219Ch
ROM:0B54 C3 08 06		     jmp     loc_608
ROM:0B57	     ; ---------------------------------------------------------------------------
ROM:0B57 21 F4 11		     lxi     h,	11F4h
ROM:0B5A CD ED 0E		     call    sub_EED
ROM:0B5D	     ; ---------------------------------------------------------------------------
ROM:0B5D 21 B8 13		     lxi     h,	13B8h
ROM:0B60 CD E4 12		     call    sub_12E4
ROM:0B63	     ; ---------------------------------------------------------------------------
ROM:0B63 3A 1A 22		     lda     221Ah
ROM:0B66 3D			     dcr     a
ROM:0B67 32 1A 22		     sta     221Ah
ROM:0B6A CA 7A 0B		     jz	     loc_B7A
ROM:0B6D 3E 28			     mvi     a,	28h ; '('
ROM:0B6F 32 9C 21		     sta     219Ch
ROM:0B72 3E FA			     mvi     a,	0FAh ; 'ú'
ROM:0B74 32 08 22		     sta     2208h
ROM:0B77 C3 08 06		     jmp     loc_608
ROM:0B7A	     ; ---------------------------------------------------------------------------
ROM:0B7A
ROM:0B7A	     loc_B7A:				     ; CODE XREF: ROM:0B31j
ROM:0B7A						     ; ROM:0B3Fj ...
ROM:0B7A 3A C7 21		     lda     21C7h
ROM:0B7D FE 00			     cpi     0
ROM:0B7F CA 93 0B		     jz	     loc_B93
ROM:0B82 2A 09 22		     lhld    2209h
ROM:0B85 3A 0B 22		     lda     220Bh
ROM:0B88 CD CE 03		     call    sub_3CE
ROM:0B8B	     ; ---------------------------------------------------------------------------
ROM:0B8B 3E 06			     mvi     a,	6
ROM:0B8D 32 A6 21		     sta     21A6h
ROM:0B90 C3 08 06		     jmp     loc_608
ROM:0B93	     ; ---------------------------------------------------------------------------
ROM:0B93
ROM:0B93	     loc_B93:				     ; CODE XREF: ROM:0B7Fj
ROM:0B93 3E 3C			     mvi     a,	3Ch ; '<'
ROM:0B95 32 A5 21		     sta     21A5h
ROM:0B98 3E 64			     mvi     a,	64h ; 'd'
ROM:0B9A 32 08 22		     sta     2208h
ROM:0B9D 3E 00			     mvi     a,	0
ROM:0B9F 32 07 22		     sta     2207h
ROM:0BA2 C3 08 06		     jmp     loc_608
ROM:0BA5	     ; ---------------------------------------------------------------------------
ROM:0BA5 97			     sub     a
ROM:0BA6 32 08 22		     sta     2208h
ROM:0BA9 3A 07 22		     lda     2207h
ROM:0BAC 3C			     inr     a
ROM:0BAD 32 07 22		     sta     2207h
ROM:0BB0 FE 06			     cpi     6
ROM:0BB2 CA D3 0B		     jz	     loc_BD3
ROM:0BB5 16 00			     mvi     d,	0
ROM:0BB7 5F			     mov     e,	a
ROM:0BB8 21 91 0C		     lxi     h,	0C91h
ROM:0BBB 19			     dad     d
ROM:0BBC 46			     mov     b,	m
ROM:0BBD CD 77 1D		     call    sub_1D77
ROM:0BC0	     ; ---------------------------------------------------------------------------
ROM:0BC0 21 60 13		     lxi     h,	1360h
ROM:0BC3 CD E4 12		     call    sub_12E4
ROM:0BC6	     ; ---------------------------------------------------------------------------
ROM:0BC6 3E 0F			     mvi     a,	0Fh
ROM:0BC8 32 A5 21		     sta     21A5h
ROM:0BCB 3E 64			     mvi     a,	64h ; 'd'
ROM:0BCD 32 08 22		     sta     2208h
ROM:0BD0 C3 08 06		     jmp     loc_608
ROM:0BD3	     ; ---------------------------------------------------------------------------
ROM:0BD3
ROM:0BD3	     loc_BD3:				     ; CODE XREF: ROM:0BB2j
ROM:0BD3 2A 09 22		     lhld    2209h
ROM:0BD6 3A 0B 22		     lda     220Bh
ROM:0BD9 CD CE 03		     call    sub_3CE
ROM:0BDC	     ; ---------------------------------------------------------------------------
ROM:0BDC 3E 06			     mvi     a,	6
ROM:0BDE 32 A6 21		     sta     21A6h
ROM:0BE1 3E 1F			     mvi     a,	1Fh
ROM:0BE3 32 C7 21		     sta     21C7h
ROM:0BE6 21 90 21		     lxi     h,	2190h
ROM:0BE9 3E 03			     mvi     a,	3
ROM:0BEB CD E6 03		     call    sub_3E6
ROM:0BEE	     ; ---------------------------------------------------------------------------
ROM:0BEE C2 FE 0B		     jnz     loc_BFE
ROM:0BF1 06 31			     mvi     b,	31h ; '1'
ROM:0BF3 CD 9D 1D		     call    sub_1D9D
ROM:0BF6	     ; ---------------------------------------------------------------------------
ROM:0BF6 C2 FE 0B		     jnz     loc_BFE
ROM:0BF9 06 09			     mvi     b,	9
ROM:0BFB CD 77 1D		     call    sub_1D77
ROM:0BFE	     ; ---------------------------------------------------------------------------
ROM:0BFE
ROM:0BFE	     loc_BFE:				     ; CODE XREF: ROM:0BEEj
ROM:0BFE						     ; ROM:0BF6j
ROM:0BFE 3A C8 21		     lda     21C8h
ROM:0C01 3C			     inr     a
ROM:0C02 FE 05			     cpi     5
ROM:0C04 CA 1C 0C		     jz	     loc_C1C
ROM:0C07 32 C8 21		     sta     21C8h
ROM:0C0A 16 00			     mvi     d,	0
ROM:0C0C 5F			     mov     e,	a
ROM:0C0D 21 96 0C		     lxi     h,	0C96h
ROM:0C10 19			     dad     d
ROM:0C11 46			     mov     b,	m
ROM:0C12 E5			     push    h
ROM:0C13 CD 77 1D		     call    sub_1D77
ROM:0C16	     ; ---------------------------------------------------------------------------
ROM:0C16 E1			     pop     h
ROM:0C17 2B			     dcx     h
ROM:0C18 46			     mov     b,	m
ROM:0C19 CD 82 1D		     call    sub_1D82
ROM:0C1C	     ; ---------------------------------------------------------------------------
ROM:0C1C
ROM:0C1C	     loc_C1C:				     ; CODE XREF: ROM:0C04j
ROM:0C1C 21 91 21		     lxi     h,	2191h
ROM:0C1F 3E 01			     mvi     a,	1
ROM:0C21 CD E6 03		     call    sub_3E6
ROM:0C24	     ; ---------------------------------------------------------------------------
ROM:0C24 C4 FA 03		     cnz     sub_3FA
ROM:0C27	     ; ---------------------------------------------------------------------------
ROM:0C27 C3 08 06		     jmp     loc_608
ROM:0C2A	     ; ---------------------------------------------------------------------------
ROM:0C2A
ROM:0C2A	     loc_C2A:				     ; CODE XREF: ROM:0ACBj
ROM:0C2A CD 47 0C		     call    sub_C47
ROM:0C2D CD CE 03		     call    sub_3CE
ROM:0C30	     ; ---------------------------------------------------------------------------
ROM:0C30 3E 06			     mvi     a,	6
ROM:0C32 32 A6 21		     sta     21A6h
ROM:0C35 CD 9D 1D		     call    sub_1D9D
ROM:0C38	     ; ---------------------------------------------------------------------------
ROM:0C38 C2 7A 14		     jnz     loc_147A
ROM:0C3B CD 77 1D		     call    sub_1D77
ROM:0C3E	     ; ---------------------------------------------------------------------------
ROM:0C3E 21 63 13		     lxi     h,	1363h
ROM:0C41 CD E4 12		     call    sub_12E4
ROM:0C44	     ; ---------------------------------------------------------------------------
ROM:0C44 C3 7A 14		     jmp     loc_147A
ROM:0C47
ROM:0C47	     ; =============== S U B R O U T I N E =======================================
ROM:0C47
ROM:0C47
ROM:0C47	     sub_C47:				     ; CODE XREF: ROM:0AB3p
ROM:0C47						     ; ROM:0AE7p ...
ROM:0C47 16 00			     mvi     d,	0
ROM:0C49 5F			     mov     e,	a
ROM:0C4A 21 9B 0C		     lxi     h,	0C9Bh
ROM:0C4D 19			     dad     d
ROM:0C4E 46			     mov     b,	m
ROM:0C4F 21 A0 0C		     lxi     h,	0CA0h
ROM:0C52 19			     dad     d
ROM:0C53 87			     add     a
ROM:0C54 5F			     mov     e,	a
ROM:0C55 7E			     mov     a,	m
ROM:0C56 32 0B 22		     sta     220Bh
ROM:0C59 4F			     mov     c,	a
ROM:0C5A 21 A5 0C		     lxi     h,	0CA5h
ROM:0C5D 19			     dad     d
ROM:0C5E 7E			     mov     a,	m
ROM:0C5F 23			     inx     h
ROM:0C60 66			     mov     h,	m
ROM:0C61 6F			     mov     l,	a
ROM:0C62 22 09 22		     shld    2209h
ROM:0C65 79			     mov     a,	c
ROM:0C66 C9			     ret
ROM:0C66	     ; End of function sub_C47
ROM:0C66
ROM:0C67	     ; ---------------------------------------------------------------------------
ROM:0C67 3E 00			     mvi     a,	0
ROM:0C69 32 C2 21		     sta     21C2h
ROM:0C6C 3A C4 21		     lda     21C4h
ROM:0C6F E6 1F			     ani     1Fh
ROM:0C71 32 C4 21		     sta     21C4h
ROM:0C74 2F			     cma
ROM:0C75 D3 07			     out     7
ROM:0C77 21 C5 21		     lxi     h,	21C5h
ROM:0C7A 3E 01			     mvi     a,	1
ROM:0C7C CD D9 03		     call    sub_3D9
ROM:0C7F	     ; ---------------------------------------------------------------------------
ROM:0C7F C3 08 06		     jmp     loc_608
ROM:0C82	     ; ---------------------------------------------------------------------------
ROM:0C82 3E 00			     mvi     a,	0
ROM:0C84 32 08 22		     sta     2208h
ROM:0C87 21 92 21		     lxi     h,	2192h
ROM:0C8A 3E 03			     mvi     a,	3
ROM:0C8C CD D9 03		     call    sub_3D9
ROM:0C8F	     ; ---------------------------------------------------------------------------
ROM:0C8F C3 08 06		     jmp     loc_608
ROM:0C92	     ; ---------------------------------------------------------------------------
ROM:0C92 24			     inr     h
ROM:0C93 03			     inx     b
ROM:0C94 0B			     dcx     b
ROM:0C95 13			     inx     d
ROM:0C96 29			     dad     h
ROM:0C97 23			     inx     h
ROM:0C98 1C			     inr     e
ROM:0C99 1B			     dcx     d
ROM:0C9A 12			     stax    d
ROM:0C9B 2B			     dcx     h
ROM:0C9C 2C			     inr     l
ROM:0C9D 04			     inr     b
ROM:0C9E 0C			     inr     c
ROM:0C9F 14			     inr     d
ROM:0CA0 03			     inx     b
ROM:0CA1 05			     dcr     b
ROM:0CA2 02			     stax    b
ROM:0CA3 00			     nop
ROM:0CA4 01 C2 21		     lxi     b,	21C2h
ROM:0CA7 C4 21 C2		     cnz     0C221h
ROM:0CAA 21 C2 21		     lxi     h,	21C2h
ROM:0CAD C2 21 EC		     jnz     0EC21h
ROM:0CB0 11 F0 11		     lxi     d,	11F0h
ROM:0CB3 F8			     rm
ROM:0CB4 11 FC 11		     lxi     d,	11FCh
ROM:0CB7
ROM:0CB7	     loc_CB7:				     ; CODE XREF: ROM:0A7Aj
ROM:0CB7 06 39			     mvi     b,	39h ; '9'
ROM:0CB9 CD 9D 1D		     call    sub_1D9D
ROM:0CBC	     ; ---------------------------------------------------------------------------
ROM:0CBC CA DE 0D		     jz	     loc_DDE
ROM:0CBF 21 90 21		     lxi     h,	2190h
ROM:0CC2 3E 02			     mvi     a,	2
ROM:0CC4 CD E6 03		     call    sub_3E6
ROM:0CC7	     ; ---------------------------------------------------------------------------
ROM:0CC7 C2 DE 0D		     jnz     loc_DDE
ROM:0CCA 3A 0C 22		     lda     220Ch
ROM:0CCD FE 00			     cpi     0
ROM:0CCF C2 3A 0D		     jnz     loc_D3A
ROM:0CD2 21 5B 23		     lxi     h,	235Bh
ROM:0CD5 11 0D 22		     lxi     d,	220Dh
ROM:0CD8 3E 06			     mvi     a,	6
ROM:0CDA CD 60 0F		     call    sub_F60
ROM:0CDD 06 38			     mvi     b,	38h ; '8'
ROM:0CDF CD 9D 1D		     call    sub_1D9D
ROM:0CE2	     ; ---------------------------------------------------------------------------
ROM:0CE2 CA EA 0C		     jz	     loc_CEA
ROM:0CE5 3E 03			     mvi     a,	3
ROM:0CE7 C3 F9 0C		     jmp     loc_CF9
ROM:0CEA	     ; ---------------------------------------------------------------------------
ROM:0CEA
ROM:0CEA	     loc_CEA:				     ; CODE XREF: ROM:0CE2j
ROM:0CEA 06 11			     mvi     b,	11h
ROM:0CEC CD 9D 1D		     call    sub_1D9D
ROM:0CEF	     ; ---------------------------------------------------------------------------
ROM:0CEF CA F7 0C		     jz	     loc_CF7
ROM:0CF2 3E 02			     mvi     a,	2
ROM:0CF4 C3 F9 0C		     jmp     loc_CF9
ROM:0CF7	     ; ---------------------------------------------------------------------------
ROM:0CF7
ROM:0CF7	     loc_CF7:				     ; CODE XREF: ROM:0CEFj
ROM:0CF7 3E 01			     mvi     a,	1
ROM:0CF9
ROM:0CF9	     loc_CF9:				     ; CODE XREF: ROM:0CE7j
ROM:0CF9						     ; ROM:0CF4j
ROM:0CF9 32 0C 22		     sta     220Ch
ROM:0CFC 06 31			     mvi     b,	31h ; '1'
ROM:0CFE CD 9D 1D		     call    sub_1D9D
ROM:0D01	     ; ---------------------------------------------------------------------------
ROM:0D01 CA 3A 0D		     jz	     loc_D3A
ROM:0D04 21 90 21		     lxi     h,	2190h
ROM:0D07 3E 03			     mvi     a,	3
ROM:0D09 CD E6 03		     call    sub_3E6
ROM:0D0C	     ; ---------------------------------------------------------------------------
ROM:0D0C C2 3A 0D		     jnz     loc_D3A
ROM:0D0F CD CE 03		     call    sub_3CE
ROM:0D12	     ; ---------------------------------------------------------------------------
ROM:0D12 06 31			     mvi     b,	31h ; '1'
ROM:0D14 CD 82 1D		     call    sub_1D82
ROM:0D17	     ; ---------------------------------------------------------------------------
ROM:0D17 06 09			     mvi     b,	9
ROM:0D19 CD 82 1D		     call    sub_1D82
ROM:0D1C	     ; ---------------------------------------------------------------------------
ROM:0D1C 21 A4 13		     lxi     h,	13A4h
ROM:0D1F CD E4 12		     call    sub_12E4
ROM:0D22	     ; ---------------------------------------------------------------------------
ROM:0D22 06 30			     mvi     b,	30h ; '0'
ROM:0D24 CD 77 1D		     call    sub_1D77
ROM:0D27	     ; ---------------------------------------------------------------------------
ROM:0D27 21 96 23		     lxi     h,	2396h
ROM:0D2A 3E 04			     mvi     a,	4
ROM:0D2C CD CE 03		     call    sub_3CE
ROM:0D2F	     ; ---------------------------------------------------------------------------
ROM:0D2F 21 B6 23		     lxi     h,	23B6h
ROM:0D32 CD CE 03		     call    sub_3CE
ROM:0D35	     ; ---------------------------------------------------------------------------
ROM:0D35 3E FA			     mvi     a,	0FAh ; 'ú'
ROM:0D37 C3 3C 0D		     jmp     loc_D3C
ROM:0D3A	     ; ---------------------------------------------------------------------------
ROM:0D3A
ROM:0D3A	     loc_D3A:				     ; CODE XREF: ROM:0CCFj
ROM:0D3A						     ; ROM:0D01j ...
ROM:0D3A 3E 3C			     mvi     a,	3Ch ; '<'
ROM:0D3C
ROM:0D3C	     loc_D3C:				     ; CODE XREF: ROM:0D37j
ROM:0D3C 32 A7 21		     sta     21A7h
ROM:0D3F C3 7A 14		     jmp     loc_147A
ROM:0D42	     ; ---------------------------------------------------------------------------
ROM:0D42 3A 49 23		     lda     2349h
ROM:0D45 47			     mov     b,	a
ROM:0D46 3A EE 23		     lda     23EEh
ROM:0D49 90			     sub     b
ROM:0D4A FA 58 0D		     jm	     loc_D58
ROM:0D4D 3A 94 21		     lda     2194h
ROM:0D50 E6 FD			     ani     0FDh
ROM:0D52 32 94 21		     sta     2194h
ROM:0D55 C3 08 06		     jmp     loc_608
ROM:0D58	     ; ---------------------------------------------------------------------------
ROM:0D58
ROM:0D58	     loc_D58:				     ; CODE XREF: ROM:0D4Aj
ROM:0D58 3E 00			     mvi     a,	0
ROM:0D5A 32 97 21		     sta     2197h
ROM:0D5D 3A 94 21		     lda     2194h
ROM:0D60 F6 02			     ori     2
ROM:0D62 32 94 21		     sta     2194h
ROM:0D65 21 90 21		     lxi     h,	2190h
ROM:0D68 3E 00			     mvi     a,	0
ROM:0D6A CD E6 03		     call    sub_3E6
ROM:0D6D	     ; ---------------------------------------------------------------------------
ROM:0D6D C2 BA 0D		     jnz     loc_DBA
ROM:0D70 21 E8 11		     lxi     h,	11E8h
ROM:0D73 CD 2A 0F		     call    sub_F2A
ROM:0D76 DA 8D 0D		     jc	     loc_D8D
ROM:0D79 21 E8 11		     lxi     h,	11E8h
ROM:0D7C CD 6E 02		     call    loc_26E
ROM:0D7F	     ; ---------------------------------------------------------------------------
ROM:0D7F 3E 0A			     mvi     a,	0Ah
ROM:0D81 32 A7 21		     sta     21A7h
ROM:0D84 21 B5 13		     lxi     h,	13B5h
ROM:0D87 CD E4 12		     call    sub_12E4
ROM:0D87	     ; ---------------------------------------------------------------------------
ROM:0D8A C3			     .db 0C3h ;	Ã
ROM:0D8B 08			     .db    8
ROM:0D8C 06			     .db    6
ROM:0D8D	     ; ---------------------------------------------------------------------------
ROM:0D8D
ROM:0D8D	     loc_D8D:				     ; CODE XREF: ROM:0D76j
ROM:0D8D 21 E8 11		     lxi     h,	11E8h
ROM:0D90 CD ED 0E		     call    sub_EED
ROM:0D93	     ; ---------------------------------------------------------------------------
ROM:0D93 21 5B 23		     lxi     h,	235Bh
ROM:0D96 CD CD 0F		     call    sub_FCD
ROM:0D99	     ; ---------------------------------------------------------------------------
ROM:0D99 21 5B 23		     lxi     h,	235Bh
ROM:0D9C CD 2A 0F		     call    sub_F2A
ROM:0D9F 21 0C 22		     lxi     h,	220Ch
ROM:0DA2 35			     dcr     m
ROM:0DA3 CA BA 0D		     jz	     loc_DBA
ROM:0DA6 21 0D 22		     lxi     h,	220Dh
ROM:0DA9 CD 00 0F		     call    loc_F00
ROM:0DAC	     ; ---------------------------------------------------------------------------
ROM:0DAC 3E 3C			     mvi     a,	3Ch ; '<'
ROM:0DAE 32 A7 21		     sta     21A7h
ROM:0DB1 21 B8 13		     lxi     h,	13B8h
ROM:0DB4
ROM:0DB4	     loc_DB4:				     ; CODE XREF: ROM:0DDBj
ROM:0DB4 CD E4 12		     call    sub_12E4
ROM:0DB7	     ; ---------------------------------------------------------------------------
ROM:0DB7 C3 08 06		     jmp     loc_608
ROM:0DBA	     ; ---------------------------------------------------------------------------
ROM:0DBA
ROM:0DBA	     loc_DBA:				     ; CODE XREF: ROM:0D6Dj
ROM:0DBA						     ; ROM:0DA3j
ROM:0DBA 21 C5 21		     lxi     h,	21C5h
ROM:0DBD 7E			     mov     a,	m
ROM:0DBE F6 02			     ori     2
ROM:0DC0 77			     mov     m,	a
ROM:0DC1 3E 09			     mvi     a,	9
ROM:0DC3 32 A6 21		     sta     21A6h
ROM:0DC6 06 39			     mvi     b,	39h ; '9'
ROM:0DC8 CD 82 1D		     call    sub_1D82
ROM:0DCB	     ; ---------------------------------------------------------------------------
ROM:0DCB 3A 94 21		     lda     2194h
ROM:0DCE E6 FD			     ani     0FDh
ROM:0DD0 32 94 21		     sta     2194h
ROM:0DD3 3E 00			     mvi     a,	0
ROM:0DD5 32 0C 22		     sta     220Ch
ROM:0DD8 21 B8 13		     lxi     h,	13B8h
ROM:0DDB C3 B4 0D		     jmp     loc_DB4
ROM:0DDE	     ; ---------------------------------------------------------------------------
ROM:0DDE
ROM:0DDE	     loc_DDE:				     ; CODE XREF: ROM:0CBCj
ROM:0DDE						     ; ROM:0CC7j
ROM:0DDE 21 C5 21		     lxi     h,	21C5h
ROM:0DE1 3E 01			     mvi     a,	1
ROM:0DE3 CD CE 03		     call    sub_3CE
ROM:0DE6	     ; ---------------------------------------------------------------------------
ROM:0DE6 3E 06			     mvi     a,	6
ROM:0DE8 32 A6 21		     sta     21A6h
ROM:0DEB C3 7A 14		     jmp     loc_147A
ROM:0DEE	     ; ---------------------------------------------------------------------------
ROM:0DEE 3E 2B			     mvi     a,	2Bh ; '+'
ROM:0DF0 C3 07 0E		     jmp     loc_E07
ROM:0DF3	     ; ---------------------------------------------------------------------------
ROM:0DF3 3E 2C			     mvi     a,	2Ch ; ','
ROM:0DF5 C3 07 0E		     jmp     loc_E07
ROM:0DF8	     ; ---------------------------------------------------------------------------
ROM:0DF8 3E 04			     mvi     a,	4
ROM:0DFA C3 07 0E		     jmp     loc_E07
ROM:0DFD	     ; ---------------------------------------------------------------------------
ROM:0DFD 3E 0C			     mvi     a,	0Ch
ROM:0DFF C3 07 0E		     jmp     loc_E07
ROM:0E02	     ; ---------------------------------------------------------------------------
ROM:0E02 3E 14			     mvi     a,	14h
ROM:0E04 C3 07 0E		     jmp     loc_E07
ROM:0E07
ROM:0E07	     loc_E07:				     ; CODE XREF: ROM:0DF0j
ROM:0E07						     ; ROM:0DF5j ...
ROM:0E07 32 25 22		     sta     2225h
ROM:0E0A 3A 90 21		     lda     2190h
ROM:0E0D E6 04			     ani     4
ROM:0E0F C2 7A 14		     jnz     loc_147A
ROM:0E12 3A AF 21		     lda     21AFh
ROM:0E15 B7			     ora     a
ROM:0E16 C2 26 0E		     jnz     loc_E26
ROM:0E19 3A 91 21		     lda     2191h
ROM:0E1C E6 DF			     ani     0DFh
ROM:0E1E 32 91 21		     sta     2191h
ROM:0E21 3E 80			     mvi     a,	80h ; '€'
ROM:0E23 32 93 21		     sta     2193h
ROM:0E26
ROM:0E26	     loc_E26:				     ; CODE XREF: ROM:0E16j
ROM:0E26 3E 03			     mvi     a,	3
ROM:0E28 32 AF 21		     sta     21AFh
ROM:0E2B C3 7A 14		     jmp     loc_147A
ROM:0E2E	     ; ---------------------------------------------------------------------------
ROM:0E2E 3A 91 21		     lda     2191h
ROM:0E31 E6 20			     ani     20h
ROM:0E33 CA 72 0E		     jz	     loc_E72
ROM:0E36 3A C4 21		     lda     21C4h
ROM:0E39 F6 04			     ori     4
ROM:0E3B 32 C4 21		     sta     21C4h
ROM:0E3E 3E 09			     mvi     a,	9
ROM:0E40 32 99 21		     sta     2199h
ROM:0E43 3A 25 22		     lda     2225h
ROM:0E46 47			     mov     b,	a
ROM:0E47 CD 9D 1D		     call    sub_1D9D
ROM:0E4A	     ; ---------------------------------------------------------------------------
ROM:0E4A CA 72 0E		     jz	     loc_E72
ROM:0E4D CD 82 1D		     call    sub_1D82
ROM:0E50	     ; ---------------------------------------------------------------------------
ROM:0E50 CA 62 0E		     jz	     loc_E62
ROM:0E53 21 E8 11		     lxi     h,	11E8h
ROM:0E56 CD 6E 02		     call    loc_26E
ROM:0E59	     ; ---------------------------------------------------------------------------
ROM:0E59 21 63 13		     lxi     h,	1363h
ROM:0E5C CD E4 12		     call    sub_12E4
ROM:0E5F	     ; ---------------------------------------------------------------------------
ROM:0E5F C3 72 0E		     jmp     loc_E72
ROM:0E62	     ; ---------------------------------------------------------------------------
ROM:0E62
ROM:0E62	     loc_E62:				     ; CODE XREF: ROM:0E50j
ROM:0E62 21 F4 11		     lxi     h,	11F4h
ROM:0E65 CD 6E 02		     call    loc_26E
ROM:0E68	     ; ---------------------------------------------------------------------------
ROM:0E68 EB			     xchg
ROM:0E69 CD ED 0E		     call    sub_EED
ROM:0E6C	     ; ---------------------------------------------------------------------------
ROM:0E6C 21 75 13		     lxi     h,	1375h
ROM:0E6F CD E4 12		     call    sub_12E4
ROM:0E72	     ; ---------------------------------------------------------------------------
ROM:0E72
ROM:0E72	     loc_E72:				     ; CODE XREF: ROM:0E33j
ROM:0E72						     ; ROM:0E4Aj ...
ROM:0E72 3A 91 21		     lda     2191h
ROM:0E75 E6 DF			     ani     0DFh
ROM:0E77 32 91 21		     sta     2191h
ROM:0E7A C3 08 06		     jmp     loc_608
ROM:0E7D
ROM:0E7D	     ; =============== S U B R O U T I N E =======================================
ROM:0E7D
ROM:0E7D
ROM:0E7D	     sub_E7D:				     ; CODE XREF: sub_EED+Dp
ROM:0E7D						     ; ROM:1004p ...
ROM:0E7D 11 F3 21		     lxi     d,	21F3h
ROM:0E80 B7			     ora     a
ROM:0E81 F5			     push    psw
ROM:0E82
ROM:0E82	     loc_E82:				     ; CODE XREF: sub_E7D+1Fj
ROM:0E82 DE 02			     sbi     2
ROM:0E84 FA 9F 0E		     jm	     loc_E9F
ROM:0E87 47			     mov     b,	a
ROM:0E88 F1			     pop     psw
ROM:0E89 1A			     ldax    d
ROM:0E8A 8E			     adc     m
ROM:0E8B 27			     daa
ROM:0E8C 12			     stax    d
ROM:0E8D F5			     push    psw
ROM:0E8E 78			     mov     a,	b
ROM:0E8F B7			     ora     a
ROM:0E90 C2 9A 0E		     jnz     loc_E9A
ROM:0E93 F1			     pop     psw
ROM:0E94 3E 00			     mvi     a,	0
ROM:0E96 8F			     adc     a
ROM:0E97 13			     inx     d
ROM:0E98 12			     stax    d
ROM:0E99 C9			     ret
ROM:0E9A	     ; ---------------------------------------------------------------------------
ROM:0E9A
ROM:0E9A	     loc_E9A:				     ; CODE XREF: sub_E7D+13j
ROM:0E9A 23			     inx     h
ROM:0E9B 13			     inx     d
ROM:0E9C C3 82 0E		     jmp     loc_E82
ROM:0E9F	     ; ---------------------------------------------------------------------------
ROM:0E9F
ROM:0E9F	     loc_E9F:				     ; CODE XREF: sub_E7D+7j
ROM:0E9F 7E			     mov     a,	m
ROM:0EA0 E6 0F			     ani     0Fh
ROM:0EA2 47			     mov     b,	a
ROM:0EA3 F1			     pop     psw
ROM:0EA4 1A			     ldax    d
ROM:0EA5 88			     adc     b
ROM:0EA6 27			     daa
ROM:0EA7 12			     stax    d
ROM:0EA8 C9			     ret
ROM:0EA8	     ; End of function sub_E7D
ROM:0EA8
ROM:0EA9
ROM:0EA9	     ; =============== S U B R O U T I N E =======================================
ROM:0EA9
ROM:0EA9
ROM:0EA9	     sub_EA9:				     ; CODE XREF: sub_F2A+Fp
ROM:0EA9						     ; ROM:1050p ...
ROM:0EA9 0E 00			     mvi     c,	0
ROM:0EAB B7			     ora     a
ROM:0EAC 11 F3 21		     lxi     d,	21F3h
ROM:0EAF F5			     push    psw
ROM:0EB0
ROM:0EB0	     loc_EB0:				     ; CODE XREF: sub_EA9+22j
ROM:0EB0 DE 02			     sbi     2
ROM:0EB2 FA CE 0E		     jm	     loc_ECE
ROM:0EB5 47			     mov     b,	a
ROM:0EB6 F1			     pop     psw
ROM:0EB7 3E 9A			     mvi     a,	9Ah ; 'š'
ROM:0EB9 9E			     sbb     m
ROM:0EBA
ROM:0EBA	     loc_EBA:				     ; CODE XREF: sub_EA9+2Fj
ROM:0EBA EB			     xchg
ROM:0EBB 86			     add     m
ROM:0EBC 27			     daa
ROM:0EBD 3F			     cmc
ROM:0EBE 77			     mov     m,	a
ROM:0EBF F5			     push    psw
ROM:0EC0 C2 DB 0E		     jnz     loc_EDB
ROM:0EC3
ROM:0EC3	     loc_EC3:				     ; CODE XREF: sub_EA9+34j
ROM:0EC3 78			     mov     a,	b
ROM:0EC4 B7			     ora     a
ROM:0EC5 CA E0 0E		     jz	     loc_EE0
ROM:0EC8 EB			     xchg
ROM:0EC9 13			     inx     d
ROM:0ECA 23			     inx     h
ROM:0ECB C3 B0 0E		     jmp     loc_EB0
ROM:0ECE	     ; ---------------------------------------------------------------------------
ROM:0ECE
ROM:0ECE	     loc_ECE:				     ; CODE XREF: sub_EA9+9j
ROM:0ECE 7E			     mov     a,	m
ROM:0ECF E6 0F			     ani     0Fh
ROM:0ED1 47			     mov     b,	a
ROM:0ED2 F1			     pop     psw
ROM:0ED3 3E 9A			     mvi     a,	9Ah ; 'š'
ROM:0ED5 98			     sbb     b
ROM:0ED6 06 00			     mvi     b,	0
ROM:0ED8 C3 BA 0E		     jmp     loc_EBA
ROM:0EDB	     ; ---------------------------------------------------------------------------
ROM:0EDB
ROM:0EDB	     loc_EDB:				     ; CODE XREF: sub_EA9+17j
ROM:0EDB 0E FF			     mvi     c,	0FFh
ROM:0EDD C3 C3 0E		     jmp     loc_EC3
ROM:0EE0	     ; ---------------------------------------------------------------------------
ROM:0EE0
ROM:0EE0	     loc_EE0:				     ; CODE XREF: sub_EA9+1Cj
ROM:0EE0 79			     mov     a,	c
ROM:0EE1 B7			     ora     a
ROM:0EE2 CA E9 0E		     jz	     loc_EE9
ROM:0EE5 F1			     pop     psw
ROM:0EE6 D8			     rc
ROM:0EE7 B1			     ora     c
ROM:0EE8 C9			     ret
ROM:0EE9	     ; ---------------------------------------------------------------------------
ROM:0EE9
ROM:0EE9	     loc_EE9:				     ; CODE XREF: sub_EA9+39j
ROM:0EE9 F1			     pop     psw
ROM:0EEA E6 00			     ani     0
ROM:0EEC C9			     ret
ROM:0EEC	     ; End of function sub_EA9
ROM:0EEC
ROM:0EED
ROM:0EED	     ; =============== S U B R O U T I N E =======================================
ROM:0EED
ROM:0EED	     ; Attributes: noreturn
ROM:0EED
ROM:0EED	     sub_EED:				     ; CODE XREF: ROM:0B20p
ROM:0EED						     ; ROM:0B5Ap ...
ROM:0EED 11 F3 21		     lxi     d,	21F3h
ROM:0EF0 3E 08			     mvi     a,	8
ROM:0EF2 CD 60 0F		     call    sub_F60
ROM:0EF5 21 5B 23		     lxi     h,	235Bh
ROM:0EF8 3E 08			     mvi     a,	8
ROM:0EFA CD 7D 0E		     call    sub_E7D
ROM:0EFD 21 F3 21		     lxi     h,	21F3h
ROM:0F00
ROM:0F00	     loc_F00:				     ; CODE XREF: ROM:0DA9p
ROM:0F00						     ; ROM:192Ap ...
ROM:0F00 11 5B 23		     lxi     d,	235Bh
ROM:0F03 3E 08			     mvi     a,	8
ROM:0F05 CD 60 0F		     call    sub_F60
ROM:0F08 21 5B 23		     lxi     h,	235Bh
ROM:0F0B 11 A0 23		     lxi     d,	23A0h
ROM:0F0E 3E 06			     mvi     a,	6
ROM:0F10 CD 7B 0F		     call    sub_F7B
ROM:0F13 3A 90 21		     lda     2190h
ROM:0F16 E6 01			     ani     1
ROM:0F18 C0			     rnz
ROM:0F19 21 A0 23		     lxi     h,	23A0h
ROM:0F1C 11 80 23		     lxi     d,	2380h
ROM:0F1F 3E 06			     mvi     a,	6
ROM:0F21 CD 60 0F		     call    sub_F60
ROM:0F24 06 39			     mvi     b,	39h ; '9'
ROM:0F26 CD 77 1D		     call    sub_1D77
ROM:0F26	     ; End of function sub_EED
ROM:0F26
ROM:0F26	     ; ---------------------------------------------------------------------------
ROM:0F29 C9			     .db 0C9h ;	É
ROM:0F2A
ROM:0F2A	     ; =============== S U B R O U T I N E =======================================
ROM:0F2A
ROM:0F2A
ROM:0F2A	     sub_F2A:				     ; CODE XREF: ROM:0D73p
ROM:0F2A						     ; ROM:0D9Cp ...
ROM:0F2A E5			     push    h
ROM:0F2B 21 5B 23		     lxi     h,	235Bh
ROM:0F2E 11 F3 21		     lxi     d,	21F3h
ROM:0F31 3E 08			     mvi     a,	8
ROM:0F33 CD 60 0F		     call    sub_F60
ROM:0F36 E1			     pop     h
ROM:0F37 3E 08			     mvi     a,	8
ROM:0F39 CD A9 0E		     call    sub_EA9
ROM:0F3C F5			     push    psw
ROM:0F3D 21 F3 21		     lxi     h,	21F3h
ROM:0F40 11 5B 23		     lxi     d,	235Bh
ROM:0F43 3E 08			     mvi     a,	8
ROM:0F45 CD 60 0F		     call    sub_F60
ROM:0F48 21 5B 23		     lxi     h,	235Bh
ROM:0F4B 11 80 23		     lxi     d,	2380h
ROM:0F4E 3E 06			     mvi     a,	6
ROM:0F50 CD 7B 0F		     call    sub_F7B
ROM:0F53 21 80 23		     lxi     h,	2380h
ROM:0F56 11 A0 23		     lxi     d,	23A0h
ROM:0F59 3E 06			     mvi     a,	6
ROM:0F5B CD 60 0F		     call    sub_F60
ROM:0F5E F1			     pop     psw
ROM:0F5F C9			     ret
ROM:0F5F	     ; End of function sub_F2A
ROM:0F5F
ROM:0F60
ROM:0F60	     ; =============== S U B R O U T I N E =======================================
ROM:0F60
ROM:0F60
ROM:0F60	     sub_F60:				     ; CODE XREF: reset_entry+12Dp
ROM:0F60						     ; reset_entry+140p ...
ROM:0F60 B7			     ora     a
ROM:0F61
ROM:0F61	     loc_F61:				     ; CODE XREF: sub_F60+Dj
ROM:0F61 DE 02			     sbi     2
ROM:0F63 FA 71 0F		     jm	     loc_F71
ROM:0F66 47			     mov     b,	a
ROM:0F67 7E			     mov     a,	m
ROM:0F68 12			     stax    d
ROM:0F69 23			     inx     h
ROM:0F6A 13			     inx     d
ROM:0F6B 78			     mov     a,	b
ROM:0F6C B7			     ora     a
ROM:0F6D C2 61 0F		     jnz     loc_F61
ROM:0F70 C9			     ret
ROM:0F71	     ; ---------------------------------------------------------------------------
ROM:0F71
ROM:0F71	     loc_F71:				     ; CODE XREF: sub_F60+3j
ROM:0F71 7E			     mov     a,	m
ROM:0F72 E6 0F			     ani     0Fh
ROM:0F74 47			     mov     b,	a
ROM:0F75 1A			     ldax    d
ROM:0F76 E6 F0			     ani     0F0h
ROM:0F78 B0			     ora     b
ROM:0F79 12			     stax    d
ROM:0F7A C9			     ret
ROM:0F7A	     ; End of function sub_F60
ROM:0F7A
ROM:0F7B
ROM:0F7B	     ; =============== S U B R O U T I N E =======================================
ROM:0F7B
ROM:0F7B
ROM:0F7B	     sub_F7B:				     ; CODE XREF: sub_EED+23p
ROM:0F7B						     ; sub_F2A+26p ...
ROM:0F7B 0F			     rrc
ROM:0F7C F5			     push    psw
ROM:0F7D D2 83 0F		     jnc     loc_F83
ROM:0F80 3C			     inr     a
ROM:0F81 E6 7F			     ani     7Fh
ROM:0F83
ROM:0F83	     loc_F83:				     ; CODE XREF: sub_F7B+2j
ROM:0F83 4F			     mov     c,	a
ROM:0F84 0D			     dcr     c
ROM:0F85 06 00			     mvi     b,	0
ROM:0F87 09			     dad     b
ROM:0F88 EB			     xchg
ROM:0F89 09			     dad     b
ROM:0F8A EB			     xchg
ROM:0F8B F1			     pop     psw
ROM:0F8C DA A5 0F		     jc	     loc_FA5
ROM:0F8F 7E			     mov     a,	m
ROM:0F90
ROM:0F90	     loc_F90:				     ; CODE XREF: sub_F7B+3Cj
ROM:0F90 B7			     ora     a
ROM:0F91 CA BB 0F		     jz	     loc_FBB
ROM:0F94 E6 F0			     ani     0F0h
ROM:0F96 7E			     mov     a,	m
ROM:0F97 C2 9C 0F		     jnz     loc_F9C
ROM:0F9A F6 F0			     ori     0F0h
ROM:0F9C
ROM:0F9C	     loc_F9C:				     ; CODE XREF: sub_F7B+1Cj
ROM:0F9C						     ; sub_F7B+26j ...
ROM:0F9C 12			     stax    d
ROM:0F9D 2B			     dcx     h
ROM:0F9E 1B			     dcx     d
ROM:0F9F 7E			     mov     a,	m
ROM:0FA0 0D			     dcr     c
ROM:0FA1 F2 9C 0F		     jp	     loc_F9C
ROM:0FA4 C9			     ret
ROM:0FA5	     ; ---------------------------------------------------------------------------
ROM:0FA5
ROM:0FA5	     loc_FA5:				     ; CODE XREF: sub_F7B+11j
ROM:0FA5 1A			     ldax    d
ROM:0FA6 E6 F0			     ani     0F0h
ROM:0FA8 47			     mov     b,	a
ROM:0FA9 7E			     mov     a,	m
ROM:0FAA E6 0F			     ani     0Fh
ROM:0FAC C2 C5 0F		     jnz     loc_FC5
ROM:0FAF F6 0F			     ori     0Fh
ROM:0FB1 B0			     ora     b
ROM:0FB2
ROM:0FB2	     loc_FB2:				     ; CODE XREF: sub_F7B+47j
ROM:0FB2 12			     stax    d
ROM:0FB3 2B			     dcx     h
ROM:0FB4 1B			     dcx     d
ROM:0FB5 0D			     dcr     c
ROM:0FB6 7E			     mov     a,	m
ROM:0FB7 F2 90 0F		     jp	     loc_F90
ROM:0FBA C9			     ret
ROM:0FBB	     ; ---------------------------------------------------------------------------
ROM:0FBB
ROM:0FBB	     loc_FBB:				     ; CODE XREF: sub_F7B+16j
ROM:0FBB 79			     mov     a,	c
ROM:0FBC 3D			     dcr     a
ROM:0FBD FA C9 0F		     jm	     loc_FC9
ROM:0FC0 3E FF			     mvi     a,	0FFh
ROM:0FC2 C3 B2 0F		     jmp     loc_FB2
ROM:0FC5	     ; ---------------------------------------------------------------------------
ROM:0FC5
ROM:0FC5	     loc_FC5:				     ; CODE XREF: sub_F7B+31j
ROM:0FC5 B0			     ora     b
ROM:0FC6 C3 9C 0F		     jmp     loc_F9C
ROM:0FC9	     ; ---------------------------------------------------------------------------
ROM:0FC9
ROM:0FC9	     loc_FC9:				     ; CODE XREF: sub_F7B+42j
ROM:0FC9 3E F0			     mvi     a,	0F0h ; 'ð'
ROM:0FCB 12			     stax    d
ROM:0FCC C9			     ret
ROM:0FCC	     ; End of function sub_F7B
ROM:0FCC
ROM:0FCD
ROM:0FCD	     ; =============== S U B R O U T I N E =======================================
ROM:0FCD
ROM:0FCD	     ; Attributes: noreturn
ROM:0FCD
ROM:0FCD	     sub_FCD:				     ; CODE XREF: reset_entry+214p
ROM:0FCD						     ; ROM:0D96p ...
ROM:0FCD 11 F3 21		     lxi     d,	21F3h
ROM:0FD0 3E 08			     mvi     a,	8
ROM:0FD2 CD 60 0F		     call    sub_F60
ROM:0FD5 21 7E 23		     lxi     h,	237Eh
ROM:0FD8 3E 04			     mvi     a,	4
ROM:0FDA CD E6 03		     call    sub_3E6
ROM:0FDA	     ; End of function sub_FCD
ROM:0FDA
ROM:0FDD	     ; ---------------------------------------------------------------------------
ROM:0FDD C2 60 11		     jnz     loc_1160
ROM:0FE0 3C			     inr     a
ROM:0FE1 CD E6 03		     call    sub_3E6
ROM:0FE4	     ; ---------------------------------------------------------------------------
ROM:0FE4 C2 77 11		     jnz     loc_1177
ROM:0FE7 3C			     inr     a
ROM:0FE8 CD E6 03		     call    sub_3E6
ROM:0FEB	     ; ---------------------------------------------------------------------------
ROM:0FEB C2 8E 11		     jnz     loc_118E
ROM:0FEE 21 93 23		     lxi     h,	2393h
ROM:0FF1 E5			     push    h
ROM:0FF2 21 73 23		     lxi     h,	2373h
ROM:0FF5 E5			     push    h
ROM:0FF6 21 6B 23		     lxi     h,	236Bh
ROM:0FF9 E5			     push    h
ROM:0FFA 21 90 23		     lxi     h,	2390h
ROM:0FFD E5			     push    h
ROM:0FFE 21 6F 23		     lxi     h,	236Fh
ROM:1001 E5			     push    h
ROM:1002
ROM:1002	     loc_1002:				     ; CODE XREF: ROM:1174j
ROM:1002						     ; ROM:118Bj ...
ROM:1002 3E 08			     mvi     a,	8
ROM:1004 CD 7D 0E		     call    sub_E7D
ROM:1007 D1			     pop     d
ROM:1008 D5			     push    d
ROM:1009 21 F3 21		     lxi     h,	21F3h
ROM:100C 3E 08			     mvi     a,	8
ROM:100E CD 60 0F		     call    sub_F60
ROM:1011 E1			     pop     h
ROM:1012 D1			     pop     d
ROM:1013 D5			     push    d
ROM:1014 3E 06			     mvi     a,	6
ROM:1016 CD 7B 0F		     call    sub_F7B
ROM:1019 D1			     pop     d
ROM:101A 21 20 00		     lxi     h,	20h ; ' '
ROM:101D 19			     dad     d
ROM:101E EB			     xchg
ROM:101F 3E 06			     mvi     a,	6
ROM:1021 CD 60 0F		     call    sub_F60
ROM:1024 21 7E 23		     lxi     h,	237Eh
ROM:1027 3E 03			     mvi     a,	3
ROM:1029 CD E6 03		     call    sub_3E6
ROM:102C	     ; ---------------------------------------------------------------------------
ROM:102C C2 8D 10		     jnz     loc_108D
ROM:102F E1			     pop     h
ROM:1030 E1			     pop     h
ROM:1031 E1			     pop     h
ROM:1032 3A 7E 23		     lda     237Eh
ROM:1035 E6 0F			     ani     0Fh
ROM:1037 FE 03			     cpi     3
ROM:1039 C0			     rnz
ROM:103A 3A 16 22		     lda     2216h
ROM:103D E6 08			     ani     8
ROM:103F C0			     rnz
ROM:1040 21 63 23		     lxi     h,	2363h
ROM:1043 11 F3 21		     lxi     d,	21F3h
ROM:1046 3E 07			     mvi     a,	7
ROM:1048 CD 60 0F		     call    sub_F60
ROM:104B 21 6B 23		     lxi     h,	236Bh
ROM:104E 3E 07			     mvi     a,	7
ROM:1050 CD A9 0E		     call    sub_EA9
ROM:1053 F5			     push    psw
ROM:1054 DC 79 10		     cc	     sub_1079
ROM:1057 21 F3 21		     lxi     h,	21F3h
ROM:105A 11 77 23		     lxi     d,	2377h
ROM:105D D5			     push    d
ROM:105E 3E 06			     mvi     a,	6
ROM:1060 CD 60 0F		     call    sub_F60
ROM:1063 E1			     pop     h
ROM:1064 E5			     push    h
ROM:1065 11 97 23		     lxi     d,	2397h
ROM:1068 3E 06			     mvi     a,	6
ROM:106A CD 7B 0F		     call    sub_F7B
ROM:106D E1			     pop     h
ROM:106E 11 B7 23		     lxi     d,	23B7h
ROM:1071 3E 06			     mvi     a,	6
ROM:1073 CD 7B 0F		     call    sub_F7B
ROM:1076 C3 E8 10		     jmp     loc_10E8
ROM:1079
ROM:1079	     ; =============== S U B R O U T I N E =======================================
ROM:1079
ROM:1079
ROM:1079	     sub_1079:				     ; CODE XREF: ROM:1054p
ROM:1079 21 6B 23		     lxi     h,	236Bh
ROM:107C 11 F3 21		     lxi     d,	21F3h
ROM:107F 3E 07			     mvi     a,	7
ROM:1081 CD 60 0F		     call    sub_F60
ROM:1084 21 63 23		     lxi     h,	2363h
ROM:1087 3E 07			     mvi     a,	7
ROM:1089 CD A9 0E		     call    sub_EA9
ROM:108C C9			     ret
ROM:108C	     ; End of function sub_1079
ROM:108C
ROM:108D	     ; ---------------------------------------------------------------------------
ROM:108D
ROM:108D	     loc_108D:				     ; CODE XREF: ROM:102Cj
ROM:108D E1			     pop     h
ROM:108E 3E 08			     mvi     a,	8
ROM:1090 CD 7D 0E		     call    sub_E7D
ROM:1093 21 F3 21		     lxi     h,	21F3h
ROM:1096 D1			     pop     d
ROM:1097 D5			     push    d
ROM:1098 3E 07			     mvi     a,	7
ROM:109A CD 60 0F		     call    sub_F60
ROM:109D E1			     pop     h
ROM:109E D1			     pop     d
ROM:109F D5			     push    d
ROM:10A0 3E 07			     mvi     a,	7
ROM:10A2 CD 7B 0F		     call    sub_F7B
ROM:10A5 D1			     pop     d
ROM:10A6 21 20 00		     lxi     h,	20h ; ' '
ROM:10A9 19			     dad     d
ROM:10AA EB			     xchg
ROM:10AB 3E 07			     mvi     a,	7
ROM:10AD CD 60 0F		     call    sub_F60
ROM:10B0 21 67 23		     lxi     h,	2367h
ROM:10B3 11 F3 21		     lxi     d,	21F3h
ROM:10B6 3E 07			     mvi     a,	7
ROM:10B8 CD 60 0F		     call    sub_F60
ROM:10BB 21 73 23		     lxi     h,	2373h
ROM:10BE 3E 07			     mvi     a,	7
ROM:10C0 CD A9 0E		     call    sub_EA9
ROM:10C3 F5			     push    psw
ROM:10C4 DA A5 11		     jc	     loc_11A5
ROM:10C7
ROM:10C7	     loc_10C7:				     ; CODE XREF: ROM:11B8j
ROM:10C7 21 F3 21		     lxi     h,	21F3h
ROM:10CA 11 77 23		     lxi     d,	2377h
ROM:10CD 3E 06			     mvi     a,	6
ROM:10CF CD 60 0F		     call    sub_F60
ROM:10D2 21 77 23		     lxi     h,	2377h
ROM:10D5 11 97 23		     lxi     d,	2397h
ROM:10D8 3E 06			     mvi     a,	6
ROM:10DA CD 7B 0F		     call    sub_F7B
ROM:10DD 21 97 23		     lxi     h,	2397h
ROM:10E0 11 B7 23		     lxi     d,	23B7h
ROM:10E3 3E 06			     mvi     a,	6
ROM:10E5 CD 60 0F		     call    sub_F60
ROM:10E8
ROM:10E8	     loc_10E8:				     ; CODE XREF: ROM:1076j
ROM:10E8 F1			     pop     psw
ROM:10E9 CA 38 11		     jz	     loc_1138
ROM:10EC DA 24 11		     jc	     loc_1124
ROM:10EF 21 6A 23		     lxi     h,	236Ah
ROM:10F2 3E 04			     mvi     a,	4
ROM:10F4 CD E6 03		     call    sub_3E6
ROM:10F7	     ; ---------------------------------------------------------------------------
ROM:10F7 CA FB 10		     jz	     loc_10FB
ROM:10FA C9			     ret
ROM:10FB	     ; ---------------------------------------------------------------------------
ROM:10FB
ROM:10FB	     loc_10FB:				     ; CODE XREF: ROM:10F7j
ROM:10FB CD CE 03		     call    sub_3CE
ROM:10FE	     ; ---------------------------------------------------------------------------
ROM:10FE 3E 05			     mvi     a,	5
ROM:1100
ROM:1100	     loc_1100:				     ; CODE XREF: ROM:1135j
ROM:1100 CD D9 03		     call    sub_3D9
ROM:1103	     ; ---------------------------------------------------------------------------
ROM:1103 E5			     push    h
ROM:1104 C5			     push    b
ROM:1105 21 99 13		     lxi     h,	1399h
ROM:1108
ROM:1108	     loc_1108:				     ; CODE XREF: ROM:06E0j
ROM:1108 CD E4 12		     call    sub_12E4
ROM:110B	     ; ---------------------------------------------------------------------------
ROM:110B 21 A7 21		     lxi     h,	21A7h
ROM:110E 7E			     mov     a,	m
ROM:110F B7			     ora     a
ROM:1110 CA 15 11		     jz	     loc_1115
ROM:1113 36 7D			     mvi     m,	7Dh ; '}'
ROM:1115
ROM:1115	     loc_1115:				     ; CODE XREF: ROM:1110j
ROM:1115 21 AE 21		     lxi     h,	21AEh
ROM:1118 7E			     mov     a,	m
ROM:1119 B7			     ora     a
ROM:111A CA 1F 11		     jz	     loc_111F
ROM:111D 36 7D			     mvi     m,	7Dh ; '}'
ROM:111F
ROM:111F	     loc_111F:				     ; CODE XREF: ROM:111Aj
ROM:111F C1			     pop     b
ROM:1120 E1			     pop     h
ROM:1121 C3 BB 11		     jmp     loc_11BB
ROM:1124	     ; ---------------------------------------------------------------------------
ROM:1124
ROM:1124	     loc_1124:				     ; CODE XREF: ROM:10ECj
ROM:1124 21 6A 23		     lxi     h,	236Ah
ROM:1127 3E 05			     mvi     a,	5
ROM:1129 CD E6 03		     call    sub_3E6
ROM:112C	     ; ---------------------------------------------------------------------------
ROM:112C CA 30 11		     jz	     loc_1130
ROM:112F C9			     ret
ROM:1130	     ; ---------------------------------------------------------------------------
ROM:1130
ROM:1130	     loc_1130:				     ; CODE XREF: ROM:112Cj
ROM:1130 CD CE 03		     call    sub_3CE
ROM:1133	     ; ---------------------------------------------------------------------------
ROM:1133 3E 04			     mvi     a,	4
ROM:1135 C3 00 11		     jmp     loc_1100
ROM:1138	     ; ---------------------------------------------------------------------------
ROM:1138
ROM:1138	     loc_1138:				     ; CODE XREF: ROM:10E9j
ROM:1138 21 6A 23		     lxi     h,	236Ah
ROM:113B 3E 04			     mvi     a,	4
ROM:113D CD D9 03		     call    sub_3D9
ROM:1140	     ; ---------------------------------------------------------------------------
ROM:1140 3E 05			     mvi     a,	5
ROM:1142 CD D9 03		     call    sub_3D9
ROM:1145	     ; ---------------------------------------------------------------------------
ROM:1145 E5			     push    h
ROM:1146 21 08 12		     lxi     h,	1208h
ROM:1149 11 97 23		     lxi     d,	2397h
ROM:114C 3E 06			     mvi     a,	6
ROM:114E CD 60 0F		     call    sub_F60
ROM:1151 21 08 12		     lxi     h,	1208h
ROM:1154 11 B7 23		     lxi     d,	23B7h
ROM:1157 3E 06			     mvi     a,	6
ROM:1159 CD 60 0F		     call    sub_F60
ROM:115C E1			     pop     h
ROM:115D C3 BB 11		     jmp     loc_11BB
ROM:1160	     ; ---------------------------------------------------------------------------
ROM:1160
ROM:1160	     loc_1160:				     ; CODE XREF: ROM:0FDDj
ROM:1160 21 89 23		     lxi     h,	2389h
ROM:1163 E5			     push    h
ROM:1164 21 67 23		     lxi     h,	2367h
ROM:1167 E5			     push    h
ROM:1168 21 5F 23		     lxi     h,	235Fh
ROM:116B E5			     push    h
ROM:116C 21 86 23		     lxi     h,	2386h
ROM:116F E5			     push    h
ROM:1170 21 63 23		     lxi     h,	2363h
ROM:1173 E5			     push    h
ROM:1174 C3 02 10		     jmp     loc_1002
ROM:1177	     ; ---------------------------------------------------------------------------
ROM:1177
ROM:1177	     loc_1177:				     ; CODE XREF: ROM:0FE4j
ROM:1177 21 93 23		     lxi     h,	2393h
ROM:117A E5			     push    h
ROM:117B 21 73 23		     lxi     h,	2373h
ROM:117E E5			     push    h
ROM:117F 21 6F 23		     lxi     h,	236Fh
ROM:1182 E5			     push    h
ROM:1183 21 8D 23		     lxi     h,	238Dh
ROM:1186 E5			     push    h
ROM:1187 21 6B 23		     lxi     h,	236Bh
ROM:118A E5			     push    h
ROM:118B C3 02 10		     jmp     loc_1002
ROM:118E	     ; ---------------------------------------------------------------------------
ROM:118E
ROM:118E	     loc_118E:				     ; CODE XREF: ROM:0FEBj
ROM:118E 21 89 23		     lxi     h,	2389h
ROM:1191 E5			     push    h
ROM:1192 21 67 23		     lxi     h,	2367h
ROM:1195 E5			     push    h
ROM:1196 21 63 23		     lxi     h,	2363h
ROM:1199 E5			     push    h
ROM:119A 21 83 23		     lxi     h,	2383h
ROM:119D E5			     push    h
ROM:119E 21 5F 23		     lxi     h,	235Fh
ROM:11A1 E5			     push    h
ROM:11A2 C3 02 10		     jmp     loc_1002
ROM:11A5	     ; ---------------------------------------------------------------------------
ROM:11A5
ROM:11A5	     loc_11A5:				     ; CODE XREF: ROM:10C4j
ROM:11A5 21 73 23		     lxi     h,	2373h
ROM:11A8 11 F3 21		     lxi     d,	21F3h
ROM:11AB 3E 07			     mvi     a,	7
ROM:11AD CD 60 0F		     call    sub_F60
ROM:11B0 21 67 23		     lxi     h,	2367h
ROM:11B3 3E 07			     mvi     a,	7
ROM:11B5 CD A9 0E		     call    sub_EA9
ROM:11B8 C3 C7 10		     jmp     loc_10C7
ROM:11BB	     ; ---------------------------------------------------------------------------
ROM:11BB
ROM:11BB	     loc_11BB:				     ; CODE XREF: ROM:1121j
ROM:11BB						     ; ROM:115Dj
ROM:11BB 7E			     mov     a,	m
ROM:11BC E6 30			     ani     30h
ROM:11BE 47			     mov     b,	a
ROM:11BF 3A 8C 23		     lda     238Ch
ROM:11C2 E6 0F			     ani     0Fh
ROM:11C4 B0			     ora     b
ROM:11C5 32 8C 23		     sta     238Ch
ROM:11C8 32 AC 23		     sta     23ACh
ROM:11CB C9			     ret
ROM:11CB	     ; ---------------------------------------------------------------------------
ROM:11CC 00			     .db    0
ROM:11CD 00			     .db    0
ROM:11CE 00			     .db    0
ROM:11CF 00			     .db    0
ROM:11D0 01			     .db    1
ROM:11D1 00			     .db    0
ROM:11D2 00			     .db    0
ROM:11D3 00			     .db    0
ROM:11D4 10			     .db  10h
ROM:11D5 00			     .db    0
ROM:11D6 00			     .db    0
ROM:11D7 00			     .db    0
ROM:11D8 25			     .db  25h ;	%
ROM:11D9 00			     .db    0
ROM:11DA 00			     .db    0
ROM:11DB 00			     .db    0
ROM:11DC 50			     .db  50h ;	P
ROM:11DD 00			     .db    0
ROM:11DE 00			     .db    0
ROM:11DF 00			     .db    0
ROM:11E0 00			     .db    0
ROM:11E1 01			     .db    1
ROM:11E2 00			     .db    0
ROM:11E3 00			     .db    0
ROM:11E4 00			     .db    0
ROM:11E5 05			     .db    5
ROM:11E6 00			     .db    0
ROM:11E7 00			     .db    0
ROM:11E8 00			     .db    0
ROM:11E9 10			     .db  10h
ROM:11EA 00			     .db    0
ROM:11EB 00			     .db    0
ROM:11EC 00			     .db    0
ROM:11ED 20			     .db  20h
ROM:11EE 00			     .db    0
ROM:11EF 00			     .db    0
ROM:11F0 00			     .db    0
ROM:11F1 40			     .db  40h ;	@
ROM:11F2 00			     .db    0
ROM:11F3 00			     .db    0
ROM:11F4 00			     .db    0
ROM:11F5 50			     .db  50h ;	P
ROM:11F6 00			     .db    0
ROM:11F7 00			     .db    0
ROM:11F8 00			     .db    0
ROM:11F9 60			     .db  60h ;	`
ROM:11FA 00			     .db    0
ROM:11FB 00			     .db    0
ROM:11FC 00			     .db    0
ROM:11FD 80			     .db  80h ;	€
ROM:11FE 00			     .db    0
ROM:11FF 00			     .db    0
ROM:1200 00			     .db    0
ROM:1201 00			     .db    0
ROM:1202 01			     .db    1
ROM:1203 00			     .db    0
ROM:1204 00			     .db    0
ROM:1205 50			     .db  50h ;	P
ROM:1206 02			     .db    2
ROM:1207 00			     .db    0
ROM:1208 F0			     .db 0F0h ;	ð
ROM:1209 FF			     .db 0FFh
ROM:120A FF			     .db 0FFh
ROM:120B FF			     .db 0FFh
ROM:120C FF			     .db 0FFh
ROM:120D FF			     .db 0FFh
ROM:120E	     ; ---------------------------------------------------------------------------
ROM:120E FF			     rst     7
ROM:120F FF			     rst     7
ROM:1210
ROM:1210	     ; =============== S U B R O U T I N E =======================================
ROM:1210
ROM:1210	     ; Attributes: noreturn
ROM:1210
ROM:1210	     sub_1210:				     ; CODE XREF: ROM:12BEp
ROM:1210						     ; ROM:12DEp
ROM:1210 3E FF			     mvi     a,	0FFh
ROM:1212 D3 09			     out     9
ROM:1214 11 2F 13		     lxi     d,	132Fh
ROM:1217 7D			     mov     a,	l
ROM:1218 93			     sub     e
ROM:1219 7C			     mov     a,	h
ROM:121A 9A			     sbb     d
ROM:121B F8			     rm
ROM:121C 11 DD 13		     lxi     d,	13DDh
ROM:121F 7B			     mov     a,	e
ROM:1220 95			     sub     l
ROM:1221 7A			     mov     a,	d
ROM:1222 9C			     sbb     h
ROM:1223 F8			     rm
ROM:1224 7E			     mov     a,	m
ROM:1225 2F			     cma
ROM:1226 D3 0A			     out     0Ah
ROM:1228 23			     inx     h
ROM:1229 7E			     mov     a,	m
ROM:122A 2F			     cma
ROM:122B D3 09			     out     9
ROM:122D 2F			     cma
ROM:122E 22 B1 21		     shld    21B1h
ROM:1231 11 7F 12		     lxi     d,	127Fh
ROM:1234 FE 00			     cpi     0
ROM:1236 CA 72 12		     jz	     loc_1272
ROM:1239 FE 02			     cpi     2
ROM:123B CA 71 12		     jz	     loc_1271
ROM:123E FE 04			     cpi     4
ROM:1240 CA 70 12		     jz	     loc_1270
ROM:1243 FE 08			     cpi     8
ROM:1245 CA 6F 12		     jz	     loc_126F
ROM:1248 FE 0C			     cpi     0Ch
ROM:124A CA 6E 12		     jz	     loc_126E
ROM:124D FE 10			     cpi     10h
ROM:124F CA 6D 12		     jz	     loc_126D
ROM:1252 FE 2C			     cpi     2Ch ; ','
ROM:1254 CA 6C 12		     jz	     loc_126C
ROM:1257 FE 28			     cpi     28h ; '('
ROM:1259 CA 6B 12		     jz	     loc_126B
ROM:125C FE 24			     cpi     24h ; '$'
ROM:125E CA 6A 12		     jz	     loc_126A
ROM:1261 FE 20			     cpi     20h ; ' '
ROM:1263 CA 69 12		     jz	     loc_1269
ROM:1266 C3 72 12		     jmp     loc_1272
ROM:1269	     ; ---------------------------------------------------------------------------
ROM:1269
ROM:1269	     loc_1269:				     ; CODE XREF: sub_1210+53j
ROM:1269 13			     inx     d
ROM:126A
ROM:126A	     loc_126A:				     ; CODE XREF: sub_1210+4Ej
ROM:126A 13			     inx     d
ROM:126B
ROM:126B	     loc_126B:				     ; CODE XREF: sub_1210+49j
ROM:126B 13			     inx     d
ROM:126C
ROM:126C	     loc_126C:				     ; CODE XREF: sub_1210+44j
ROM:126C 13			     inx     d
ROM:126D
ROM:126D	     loc_126D:				     ; CODE XREF: sub_1210+3Fj
ROM:126D 13			     inx     d
ROM:126E
ROM:126E	     loc_126E:				     ; CODE XREF: sub_1210+3Aj
ROM:126E 13			     inx     d
ROM:126F
ROM:126F	     loc_126F:				     ; CODE XREF: sub_1210+35j
ROM:126F 13			     inx     d
ROM:1270
ROM:1270	     loc_1270:				     ; CODE XREF: sub_1210+30j
ROM:1270 13			     inx     d
ROM:1271
ROM:1271	     loc_1271:				     ; CODE XREF: sub_1210+2Bj
ROM:1271 13			     inx     d
ROM:1272
ROM:1272	     loc_1272:				     ; CODE XREF: sub_1210+26j
ROM:1272						     ; sub_1210+56j
ROM:1272 1A			     ldax    d
ROM:1273 32 98 21		     sta     2198h
ROM:1276 21 90 21		     lxi     h,	2190h
ROM:1279 3E 05			     mvi     a,	5
ROM:127B CD CE 03		     call    sub_3CE
ROM:127B	     ; End of function sub_1210
ROM:127B
ROM:127E	     ; ---------------------------------------------------------------------------
ROM:127E C9			     ret
ROM:127F	     ; ---------------------------------------------------------------------------
ROM:127F 0D			     dcr     c
ROM:1280 0A			     ldax    b
ROM:1281 0E 0A			     mvi     c,	0Ah
ROM:1283 18			     rdel
ROM:1284 20			     rim
ROM:1285 0A			     ldax    b
ROM:1286 05			     dcr     b
ROM:1287 02			     stax    b
ROM:1288 32 21 90		     sta     9021h
ROM:128B 21 3E 05		     lxi     h,	53Eh
ROM:128E CD E6 03		     call    sub_3E6
ROM:1291	     ; ---------------------------------------------------------------------------
ROM:1291 C2 A5 12		     jnz     loc_12A5
ROM:1294 3E 06			     mvi     a,	6
ROM:1296 CD CE 03		     call    sub_3CE
ROM:1299	     ; ---------------------------------------------------------------------------
ROM:1299 3E FE			     mvi     a,	0FEh ; 'þ'
ROM:129B D3 09			     out     9
ROM:129D 3E 02			     mvi     a,	2
ROM:129F 32 98 21		     sta     2198h
ROM:12A2 C3 08 06		     jmp     loc_608
ROM:12A5	     ; ---------------------------------------------------------------------------
ROM:12A5
ROM:12A5	     loc_12A5:				     ; CODE XREF: ROM:1291j
ROM:12A5 CD D9 03		     call    sub_3D9
ROM:12A8	     ; ---------------------------------------------------------------------------
ROM:12A8 3E 06			     mvi     a,	6
ROM:12AA CD E6 03		     call    sub_3E6
ROM:12AD	     ; ---------------------------------------------------------------------------
ROM:12AD C2 D8 12		     jnz     loc_12D8
ROM:12B0 3E FF			     mvi     a,	0FFh
ROM:12B2 D3 09			     out     9
ROM:12B4 2A B1 21		     lhld    21B1h
ROM:12B7 23			     inx     h
ROM:12B8 7E			     mov     a,	m
ROM:12B9 FE FF			     cpi     0FFh
ROM:12BB CA C4 12		     jz	     loc_12C4
ROM:12BE CD 10 12		     call    sub_1210
ROM:12C1	     ; ---------------------------------------------------------------------------
ROM:12C1 C3 08 06		     jmp     loc_608
ROM:12C4	     ; ---------------------------------------------------------------------------
ROM:12C4
ROM:12C4	     loc_12C4:				     ; CODE XREF: ROM:12BBj
ROM:12C4 3A B3 21		     lda     21B3h
ROM:12C7 FE 00			     cpi     0
ROM:12C9 C2 DB 12		     jnz     loc_12DB
ROM:12CC 3E FF			     mvi     a,	0FFh
ROM:12CE D3 09			     out     9
ROM:12D0 3E 0C			     mvi     a,	0Ch
ROM:12D2 32 98 21		     sta     2198h
ROM:12D5 C3 08 06		     jmp     loc_608
ROM:12D8	     ; ---------------------------------------------------------------------------
ROM:12D8
ROM:12D8	     loc_12D8:				     ; CODE XREF: ROM:12ADj
ROM:12D8 CD D9 03		     call    sub_3D9
ROM:12DB	     ; ---------------------------------------------------------------------------
ROM:12DB
ROM:12DB	     loc_12DB:				     ; CODE XREF: ROM:12C9j
ROM:12DB CD 0F 13		     call    sub_130F
ROM:12DE CD 10 12		     call    sub_1210
ROM:12E1	     ; ---------------------------------------------------------------------------
ROM:12E1 C3 08 06		     jmp     loc_608
ROM:12E4
ROM:12E4	     ; =============== S U B R O U T I N E =======================================
ROM:12E4
ROM:12E4	     ; Attributes: noreturn
ROM:12E4
ROM:12E4	     sub_12E4:				     ; CODE XREF: ROM:053Bp
ROM:12E4						     ; ROM:0558p ...
ROM:12E4 EB			     xchg
ROM:12E5 2A BE 21		     lhld    21BEh
ROM:12E8 01 BE 21		     lxi     b,	21BEh
ROM:12EB 79			     mov     a,	c
ROM:12EC 32 B3 21		     sta     21B3h
ROM:12EF 95			     sub     l
ROM:12F0 C2 F6 12		     jnz     loc_12F6
ROM:12F3 21 B4 21		     lxi     h,	21B4h
ROM:12F6
ROM:12F6	     loc_12F6:				     ; CODE XREF: sub_12E4+Cj
ROM:12F6 73			     mov     m,	e
ROM:12F7 23			     inx     h
ROM:12F8 72			     mov     m,	d
ROM:12F9 23			     inx     h
ROM:12FA 22 BE 21		     shld    21BEh
ROM:12FD 21 90 21		     lxi     h,	2190h
ROM:1300 3E 05			     mvi     a,	5
ROM:1302 CD E6 03		     call    sub_3E6
ROM:1302	     ; End of function sub_12E4
ROM:1302
ROM:1305	     ; ---------------------------------------------------------------------------
ROM:1305 C0			     rnz
ROM:1306 CD CE 03		     call    sub_3CE
ROM:1309	     ; ---------------------------------------------------------------------------
ROM:1309 3E 01			     mvi     a,	1
ROM:130B 32 98 21		     sta     2198h
ROM:130E C9			     ret
ROM:130F
ROM:130F	     ; =============== S U B R O U T I N E =======================================
ROM:130F
ROM:130F
ROM:130F	     sub_130F:				     ; CODE XREF: ROM:loc_12DBp
ROM:130F 2A C0 21		     lhld    21C0h
ROM:1312 01 BE 21		     lxi     b,	21BEh
ROM:1315 79			     mov     a,	c
ROM:1316 95			     sub     l
ROM:1317 C2 1D 13		     jnz     loc_131D
ROM:131A 21 B4 21		     lxi     h,	21B4h
ROM:131D
ROM:131D	     loc_131D:				     ; CODE XREF: sub_130F+8j
ROM:131D 5E			     mov     e,	m
ROM:131E 23			     inx     h
ROM:131F 56			     mov     d,	m
ROM:1320 23			     inx     h
ROM:1321 22 C0 21		     shld    21C0h
ROM:1324 D5			     push    d
ROM:1325 7D			     mov     a,	l
ROM:1326 2A BE 21		     lhld    21BEh
ROM:1329 95			     sub     l
ROM:132A 32 B3 21		     sta     21B3h
ROM:132D E1			     pop     h
ROM:132E C9			     ret
ROM:132E	     ; End of function sub_130F
ROM:132E
ROM:132E	     ; ---------------------------------------------------------------------------
ROM:132F FF			     .db 0FFh
ROM:1330	     ; ---------------------------------------------------------------------------
ROM:1330 CA 08 FF		     jz	     0FF08h
ROM:1333 AA			     xra     d
ROM:1334 08			     dsub
ROM:1335 FF			     rst     7
ROM:1336 87			     add     a
ROM:1337 08			     dsub
ROM:1338 FF			     rst     7
ROM:1339 65			     mov     h,	l
ROM:133A 08			     dsub
ROM:133B FF			     rst     7
ROM:133C 1C			     inr     e
ROM:133D 0C			     inr     c
ROM:133E FF			     rst     7
ROM:133F 1C			     inr     e
ROM:1340 0C			     inr     c
ROM:1341 FF			     rst     7
ROM:1342 1C			     inr     e
ROM:1343 00			     nop
ROM:1344 FF			     rst     7
ROM:1345 43			     mov     b,	e
ROM:1346 08			     dsub
ROM:1347 87			     add     a
ROM:1348 08			     dsub
ROM:1349 43			     mov     b,	e
ROM:134A 08			     dsub
ROM:134B 87			     add     a
ROM:134C 08			     dsub
ROM:134D 43			     mov     b,	e
ROM:134E 08			     dsub
ROM:134F 87			     add     a
ROM:1350 08			     dsub
ROM:1351 43			     mov     b,	e
ROM:1352 08			     dsub
ROM:1353 87			     add     a
ROM:1354 08			     dsub
ROM:1355 43			     mov     b,	e
ROM:1356 08			     dsub
ROM:1357 87			     add     a
ROM:1358 08			     dsub
ROM:1359 FF			     rst     7
ROM:135A 55			     mov     d,	l
ROM:135B 08			     dsub
ROM:135C FF			     rst     7
ROM:135D 3C			     inr     a
ROM:135E 08			     dsub
ROM:135F FF			     rst     7
ROM:1360 2B			     dcx     h
ROM:1361 08			     dsub
ROM:1362 FF			     rst     7
ROM:1363 22 08 FF		     shld    0FF08h
ROM:1366 22 28 1E		     shld    loc_1E26+2
ROM:1369 0C			     inr     c
ROM:136A FF			     rst     7
ROM:136B 15			     dcr     d
ROM:136C 02			     stax    b
ROM:136D 15			     dcr     d
ROM:136E 0C			     inr     c
ROM:136F FF			     rst     7
ROM:1370 4C			     mov     c,	h
ROM:1371 08			     dsub
ROM:1372 65			     mov     h,	l
ROM:1373 0C			     inr     c
ROM:1374 FF			     rst     7
ROM:1375 78			     mov     a,	b
ROM:1376 28 50			     ldhi    50h ; 'P'
ROM:1378 28 78			     ldhi    78h ; 'x'
ROM:137A 28 50			     ldhi    50h ; 'P'
ROM:137C 28 78			     ldhi    78h ; 'x'
ROM:137E 28 50			     ldhi    50h ; 'P'
ROM:1380 28 FF			     ldhi    0FFh
ROM:1382 55			     mov     d,	l
ROM:1383 08			     dsub
ROM:1384 65			     mov     h,	l
ROM:1385 08			     dsub
ROM:1386 78			     mov     a,	b
ROM:1387 08			     dsub
ROM:1388 78			     mov     a,	b
ROM:1389 00			     nop
ROM:138A 55			     mov     d,	l
ROM:138B 08			     dsub
ROM:138C 65			     mov     h,	l
ROM:138D 08			     dsub
ROM:138E 78			     mov     a,	b
ROM:138F 08			     dsub
ROM:1390 78			     mov     a,	b
ROM:1391 00			     nop
ROM:1392 55			     mov     d,	l
ROM:1393 08			     dsub
ROM:1394 65			     mov     h,	l
ROM:1395 08			     dsub
ROM:1396 78			     mov     a,	b
ROM:1397 08			     dsub
ROM:1398 FF			     rst     7
ROM:1399 43			     mov     b,	e
ROM:139A 20			     rim
ROM:139B 43			     mov     b,	e
ROM:139C 08			     dsub
ROM:139D 55			     mov     d,	l
ROM:139E 08			     dsub
ROM:139F 65			     mov     h,	l
ROM:13A0 08			     dsub
ROM:13A1 72			     mov     m,	d
ROM:13A2 0C			     inr     c
ROM:13A3 FF			     rst     7
ROM:13A4 43			     mov     b,	e
ROM:13A5 04			     inr     b
ROM:13A6 43			     mov     b,	e
ROM:13A7 04			     inr     b
ROM:13A8 43			     mov     b,	e
ROM:13A9 00			     nop
ROM:13AA 43			     mov     b,	e
ROM:13AB 04			     inr     b
ROM:13AC 43			     mov     b,	e
ROM:13AD 04			     inr     b
ROM:13AE 43			     mov     b,	e
ROM:13AF 00			     nop
ROM:13B0 43			     mov     b,	e
ROM:13B1 04			     inr     b
ROM:13B2 43			     mov     b,	e
ROM:13B3 04			     inr     b
ROM:13B4 FF			     rst     7
ROM:13B5 C6 08			     adi     8
ROM:13B7 FF			     rst     7
ROM:13B8 4C			     mov     c,	h
ROM:13B9 0C			     inr     c
ROM:13BA FF			     rst     7
ROM:13BB CA 08 CA		     jz	     0CA08h
ROM:13BE 08			     dsub
ROM:13BF CA 08 CA		     jz	     0CA08h
ROM:13C2 0C			     inr     c
ROM:13C3 FF			     rst     7
ROM:13C4 78			     mov     a,	b
ROM:13C5 28 65			     ldhi    65h ; 'e'
ROM:13C7 04			     inr     b
ROM:13C8 FF			     rst     7
ROM:13C9 A0			     ana     b
ROM:13CA 2C			     inr     l
ROM:13CB A0			     ana     b
ROM:13CC 0C			     inr     c
ROM:13CD FF			     rst     7
ROM:13CE 15			     dcr     d
ROM:13CF 0C			     inr     c
ROM:13D0 FF			     rst     7
ROM:13D1 CA 00 FF		     jz	     0FF00h
ROM:13D4 43			     mov     b,	e
ROM:13D5 0C			     inr     c
ROM:13D6 55			     mov     d,	l
ROM:13D7 0C			     inr     c
ROM:13D8 65			     mov     h,	l
ROM:13D9 0C			     inr     c
ROM:13DA 72			     mov     m,	d
ROM:13DB 0C			     inr     c
ROM:13DC FF			     rst     7
ROM:13DC	     ; ---------------------------------------------------------------------------
ROM:13DD FE			     .db 0FEh ;	þ
ROM:13DE
ROM:13DE	     ; =============== S U B R O U T I N E =======================================
ROM:13DE
ROM:13DE	     ; Attributes: noreturn
ROM:13DE
ROM:13DE	     sub_13DE:				     ; CODE XREF: reset_entry+D0p
ROM:13DE						     ; sub_13DE+35j ...
ROM:13DE 21 91 21		     lxi     h,	2191h
ROM:13E1 3E 03			     mvi     a,	3
ROM:13E3 CD D9 03		     call    sub_3D9
ROM:13E6	     ; ---------------------------------------------------------------------------
ROM:13E6 D3 0F			     out     0Fh
ROM:13E8 21 E0 23		     lxi     h,	23E0h
ROM:13EB 11 3B 23		     lxi     d,	233Bh
ROM:13EE
ROM:13EE	     loc_13EE:				     ; CODE XREF: sub_13DE+2Dj
ROM:13EE 46			     mov     b,	m
ROM:13EF 1A			     ldax    d
ROM:13F0 C6 04			     adi     4
ROM:13F2 90			     sub     b
ROM:13F3 F2 F8 13		     jp	     loc_13F8
ROM:13F6 2F			     cma
ROM:13F7 3C			     inr     a
ROM:13F8
ROM:13F8	     loc_13F8:				     ; CODE XREF: sub_13DE+15j
ROM:13F8 FE 03			     cpi     3
ROM:13FA DA 05 14		     jc	     loc_1405
ROM:13FD 3A 91 21		     lda     2191h
ROM:1400 F6 08			     ori     8
ROM:1402 32 91 21		     sta     2191h
ROM:1405
ROM:1405	     loc_1405:				     ; CODE XREF: sub_13DE+1Cj
ROM:1405 78			     mov     a,	b
ROM:1406 D6 04			     sui     4
ROM:1408 12			     stax    d
ROM:1409 13			     inx     d
ROM:140A 2C			     inr     l
ROM:140B C2 EE 13		     jnz     loc_13EE
ROM:140E 3A 91 21		     lda     2191h
ROM:1411 E6 08			     ani     8
ROM:1413 C2 DE 13		     jnz     sub_13DE
ROM:1416 CD DF 02		     call    sub_2DF
ROM:1419 22 23 22		     shld    2223h
ROM:141C C9			     ret
ROM:141C	     ; End of function sub_13DE
ROM:141C
ROM:141D	     ; ---------------------------------------------------------------------------
ROM:141D 21 91 21		     lxi     h,	2191h
ROM:1420 3E 06			     mvi     a,	6
ROM:1422 CD CE 03		     call    sub_3CE
ROM:1425	     ; ---------------------------------------------------------------------------
ROM:1425 21 E0 23		     lxi     h,	23E0h
ROM:1428 11 3B 23		     lxi     d,	233Bh
ROM:142B
ROM:142B	     loc_142B:				     ; CODE XREF: ROM:1432j
ROM:142B 1A			     ldax    d
ROM:142C 96			     sub     m
ROM:142D F2 4B 14		     jp	     loc_144B
ROM:1430
ROM:1430	     loc_1430:				     ; CODE XREF: ROM:loc_147Dj
ROM:1430 13			     inx     d
ROM:1431 2C			     inr     l
ROM:1432 C2 2B 14		     jnz     loc_142B
ROM:1435 21 91 21		     lxi     h,	2191h
ROM:1438 3E 06			     mvi     a,	6
ROM:143A CD E6 03		     call    sub_3E6
ROM:143D	     ; ---------------------------------------------------------------------------
ROM:143D CA 45 14		     jz	     loc_1445
ROM:1440 3E 07			     mvi     a,	7
ROM:1442 CD D9 03		     call    sub_3D9
ROM:1445	     ; ---------------------------------------------------------------------------
ROM:1445
ROM:1445	     loc_1445:				     ; CODE XREF: ROM:143Dj
ROM:1445 3E 01			     mvi     a,	1
ROM:1447 F3			     di
ROM:1448 C3 6E 03		     jmp     loc_36E
ROM:144B	     ; ---------------------------------------------------------------------------
ROM:144B
ROM:144B	     loc_144B:				     ; CODE XREF: ROM:142Dj
ROM:144B F3			     di
ROM:144C E5			     push    h
ROM:144D 21 91 21		     lxi     h,	2191h
ROM:1450 3E 06			     mvi     a,	6
ROM:1452 CD D9 03		     call    sub_3D9
ROM:1455	     ; ---------------------------------------------------------------------------
ROM:1455 3C			     inr     a
ROM:1456 CD E6 03		     call    sub_3E6
ROM:1459	     ; ---------------------------------------------------------------------------
ROM:1459 C2 63 14		     jnz     loc_1463
ROM:145C CD CE 03		     call    sub_3CE
ROM:145F	     ; ---------------------------------------------------------------------------
ROM:145F E1			     pop     h
ROM:1460 C3 7D 14		     jmp     loc_147D
ROM:1463	     ; ---------------------------------------------------------------------------
ROM:1463
ROM:1463	     loc_1463:				     ; CODE XREF: ROM:1459j
ROM:1463 CD D9 03		     call    sub_3D9
ROM:1466	     ; ---------------------------------------------------------------------------
ROM:1466 E1			     pop     h
ROM:1467 CD 0E 06		     call    sub_60E
ROM:146A 7D			     mov     a,	l
ROM:146B D6 E0			     sui     0E0h ; 'à'
ROM:146D 6F			     mov     l,	a
ROM:146E 26 00			     mvi     h,	0
ROM:1470 29			     dad     h
ROM:1471 11 80 14		     lxi     d,	1480h
ROM:1474 19			     dad     d
ROM:1475 7E			     mov     a,	m
ROM:1476 23			     inx     h
ROM:1477 66			     mov     h,	m
ROM:1478 6F			     mov     l,	a
ROM:1479 E9			     pchl
ROM:147A	     ; ---------------------------------------------------------------------------
ROM:147A
ROM:147A	     loc_147A:				     ; CODE XREF: ROM:0A7Dj
ROM:147A						     ; ROM:0A92j ...
ROM:147A CD 1A 06		     call    sub_61A
ROM:147D
ROM:147D	     loc_147D:				     ; CODE XREF: ROM:1460j
ROM:147D C3 30 14		     jmp     loc_1430
ROM:1480	     ; ---------------------------------------------------------------------------
ROM:1480 32 16 7A		     sta     7A16h
ROM:1483 14			     inr     d
ROM:1484 7A			     mov     a,	d
ROM:1485 14			     inr     d
ROM:1486 7A			     mov     a,	d
ROM:1487 14			     inr     d
ROM:1488 7A			     mov     a,	d
ROM:1489 14			     inr     d
ROM:148A 7A			     mov     a,	d
ROM:148B 14			     inr     d
ROM:148C 7A			     mov     a,	d
ROM:148D 14			     inr     d
ROM:148E 7A			     mov     a,	d
ROM:148F 14			     inr     d
ROM:1490 08			     dsub
ROM:1491 16 C7			     mvi     d,	0C7h ; 'Ç'
ROM:1493 14			     inr     d
ROM:1494 CE 14			     aci     14h
ROM:1496 E3			     xthl
ROM:1497 14			     inr     d
ROM:1498 D5			     push    d
ROM:1499 14			     inr     d
ROM:149A DC 14 6B		     cc	     6B14h
ROM:149D 0A			     ldax    b
ROM:149E 92			     sub     d
ROM:149F 15			     dcr     d
ROM:14A0 EA 14 F1		     jpe     0F114h
ROM:14A3 14			     inr     d
ROM:14A4 64			     mov     h,	h
ROM:14A5 0A			     ldax    b
ROM:14A6 C0			     rnz
ROM:14A7 14			     inr     d
ROM:14A8 5D			     mov     e,	l
ROM:14A9 0A			     ldax    b
ROM:14AA F8			     rm
ROM:14AB 0D			     dcr     c
ROM:14AC FD 0D 02		     jx5     loc_20D
ROM:14AF 0E 76			     mvi     c,	76h ; 'v'
ROM:14B1 18			     rdel
ROM:14B2 56			     mov     d,	m
ROM:14B3 0A			     ldax    b
ROM:14B4 F3			     di
ROM:14B5 0D			     dcr     c
ROM:14B6 4F			     mov     c,	a
ROM:14B7 0A			     ldax    b
ROM:14B8 EE 0D			     xri     0Dh
ROM:14BA 48			     mov     c,	b
ROM:14BB 0A			     ldax    b
ROM:14BC 08			     dsub
ROM:14BD 16 32			     mvi     d,	32h ; '2'
ROM:14BF 16 0E			     mvi     d,	0Eh
ROM:14C1 00			     nop
ROM:14C2 06 02			     mvi     b,	2
ROM:14C4 C3 F5 14		     jmp     loc_14F5
ROM:14C7	     ; ---------------------------------------------------------------------------
ROM:14C7 0E 01			     mvi     c,	1
ROM:14C9 06 2A			     mvi     b,	2Ah ; '*'
ROM:14CB C3 F5 14		     jmp     loc_14F5
ROM:14CE	     ; ---------------------------------------------------------------------------
ROM:14CE 0E 02			     mvi     c,	2
ROM:14D0 06 10			     mvi     b,	10h
ROM:14D2 C3 F5 14		     jmp     loc_14F5
ROM:14D5	     ; ---------------------------------------------------------------------------
ROM:14D5 0E 03			     mvi     c,	3
ROM:14D7 06 1A			     mvi     b,	1Ah
ROM:14D9 C3 F5 14		     jmp     loc_14F5
ROM:14DC	     ; ---------------------------------------------------------------------------
ROM:14DC 0E 04			     mvi     c,	4
ROM:14DE 06 01			     mvi     b,	1
ROM:14E0 C3 F5 14		     jmp     loc_14F5
ROM:14E3	     ; ---------------------------------------------------------------------------
ROM:14E3 0E 05			     mvi     c,	5
ROM:14E5 06 19			     mvi     b,	19h
ROM:14E7 C3 F5 14		     jmp     loc_14F5
ROM:14EA	     ; ---------------------------------------------------------------------------
ROM:14EA 0E 06			     mvi     c,	6
ROM:14EC 06 21			     mvi     b,	21h ; '!'
ROM:14EE C3 F5 14		     jmp     loc_14F5
ROM:14F1	     ; ---------------------------------------------------------------------------
ROM:14F1 0E 07			     mvi     c,	7
ROM:14F3 06 0A			     mvi     b,	0Ah
ROM:14F5
ROM:14F5	     loc_14F5:				     ; CODE XREF: ROM:14C4j
ROM:14F5						     ; ROM:14CBj ...
ROM:14F5 21 90 21		     lxi     h,	2190h
ROM:14F8 3E 07			     mvi     a,	7
ROM:14FA CD CE 03		     call    sub_3CE
ROM:14FD	     ; ---------------------------------------------------------------------------
ROM:14FD 3E 02			     mvi     a,	2
ROM:14FF CD E6 03		     call    sub_3E6
ROM:1502	     ; ---------------------------------------------------------------------------
ROM:1502 C2 7A 14		     jnz     loc_147A
ROM:1505 79			     mov     a,	c
ROM:1506 21 C6 21		     lxi     h,	21C6h
ROM:1509 CD E6 03		     call    sub_3E6
ROM:150C	     ; ---------------------------------------------------------------------------
ROM:150C CA 7A 14		     jz	     loc_147A
ROM:150F CD D9 03		     call    sub_3D9
ROM:1512	     ; ---------------------------------------------------------------------------
ROM:1512 CD 82 1D		     call    sub_1D82
ROM:1515	     ; ---------------------------------------------------------------------------
ROM:1515 21 E4 11		     lxi     h,	11E4h
ROM:1518 CD 6E 02		     call    loc_26E
ROM:151B	     ; ---------------------------------------------------------------------------
ROM:151B 21 5A 13		     lxi     h,	135Ah
ROM:151E CD E4 12		     call    sub_12E4
ROM:1521	     ; ---------------------------------------------------------------------------
ROM:1521 3A C6 21		     lda     21C6h
ROM:1524 FE 00			     cpi     0
ROM:1526 C2 7A 14		     jnz     loc_147A
ROM:1529 3E 3D			     mvi     a,	3Dh ; '='
ROM:152B 32 A4 21		     sta     21A4h
ROM:152E 3E 00			     mvi     a,	0
ROM:1530 32 05 22		     sta     2205h
ROM:1533 C3 7A 14		     jmp     loc_147A
ROM:1536	     ; ---------------------------------------------------------------------------
ROM:1536 3A 05 22		     lda     2205h
ROM:1539 3C			     inr     a
ROM:153A 32 05 22		     sta     2205h
ROM:153D FE 09			     cpi     9
ROM:153F CA 5B 15		     jz	     loc_155B
ROM:1542 16 00			     mvi     d,	0
ROM:1544 5F			     mov     e,	a
ROM:1545 21 89 15		     lxi     h,	1589h
ROM:1548 19			     dad     d
ROM:1549 46			     mov     b,	m
ROM:154A CD 77 1D		     call    sub_1D77
ROM:154D	     ; ---------------------------------------------------------------------------
ROM:154D 21 5A 13		     lxi     h,	135Ah
ROM:1550 CD E4 12		     call    sub_12E4
ROM:1553	     ; ---------------------------------------------------------------------------
ROM:1553 3E 0A			     mvi     a,	0Ah
ROM:1555 32 A4 21		     sta     21A4h
ROM:1558 C3 08 06		     jmp     loc_608
ROM:155B	     ; ---------------------------------------------------------------------------
ROM:155B
ROM:155B	     loc_155B:				     ; CODE XREF: ROM:153Fj
ROM:155B 06 11			     mvi     b,	11h
ROM:155D CD 9D 1D		     call    sub_1D9D
ROM:1560	     ; ---------------------------------------------------------------------------
ROM:1560 C2 73 15		     jnz     loc_1573
ROM:1563 06 38			     mvi     b,	38h ; '8'
ROM:1565 CD 9D 1D		     call    sub_1D9D
ROM:1568	     ; ---------------------------------------------------------------------------
ROM:1568 C2 7E 15		     jnz     loc_157E
ROM:156B 06 11			     mvi     b,	11h
ROM:156D CD 77 1D		     call    sub_1D77
ROM:1570	     ; ---------------------------------------------------------------------------
ROM:1570 C3 7E 15		     jmp     loc_157E
ROM:1573	     ; ---------------------------------------------------------------------------
ROM:1573
ROM:1573	     loc_1573:				     ; CODE XREF: ROM:1560j
ROM:1573 CD 82 1D		     call    sub_1D82
ROM:1576	     ; ---------------------------------------------------------------------------
ROM:1576 06 38			     mvi     b,	38h ; '8'
ROM:1578 CD 77 1D		     call    sub_1D77
ROM:157B	     ; ---------------------------------------------------------------------------
ROM:157B C3 7E 15		     jmp     loc_157E
ROM:157E
ROM:157E	     loc_157E:				     ; CODE XREF: ROM:1568j
ROM:157E						     ; ROM:1570j
ROM:157E 3E FF			     mvi     a,	0FFh
ROM:1580 32 C6 21		     sta     21C6h
ROM:1583 97			     sub     a
ROM:1584 32 05 22		     sta     2205h
ROM:1587 C3 08 06		     jmp     loc_608
ROM:158A	     ; ---------------------------------------------------------------------------
ROM:158A 02			     stax    b
ROM:158B 2A 10 1A		     lhld    loc_1A10
ROM:158E 01 19 21		     lxi     b,	2119h
ROM:1591 0A			     ldax    b
ROM:1592 21 90 21		     lxi     h,	2190h
ROM:1595 3E 07			     mvi     a,	7
ROM:1597 CD E6 03		     call    sub_3E6
ROM:159A	     ; ---------------------------------------------------------------------------
ROM:159A CA 7A 14		     jz	     loc_147A
ROM:159D CD D9 03		     call    sub_3D9
ROM:15A0	     ; ---------------------------------------------------------------------------
ROM:15A0 3E 02			     mvi     a,	2
ROM:15A2 CD E6 03		     call    sub_3E6
ROM:15A5	     ; ---------------------------------------------------------------------------
ROM:15A5 C2 7A 14		     jnz     loc_147A
ROM:15A8 21 00 12		     lxi     h,	1200h
ROM:15AB CD ED 0E		     call    sub_EED
ROM:15AE	     ; ---------------------------------------------------------------------------
ROM:15AE 21 90 21		     lxi     h,	2190h
ROM:15B1 3E 04			     mvi     a,	4
ROM:15B3 CD E6 03		     call    sub_3E6
ROM:15B6	     ; ---------------------------------------------------------------------------
ROM:15B6 CA E4 15		     jz	     loc_15E4
ROM:15B9 21 91 21		     lxi     h,	2191h
ROM:15BC 3E 01			     mvi     a,	1
ROM:15BE CD E6 03		     call    sub_3E6
ROM:15C1	     ; ---------------------------------------------------------------------------
ROM:15C1 C2 E4 15		     jnz     loc_15E4
ROM:15C4 CD CE 03		     call    sub_3CE
ROM:15C7	     ; ---------------------------------------------------------------------------
ROM:15C7 3A C7 21		     lda     21C7h
ROM:15CA 06 FF			     mvi     b,	0FFh
ROM:15CC
ROM:15CC	     loc_15CC:				     ; CODE XREF: ROM:15CEj
ROM:15CC 04			     inr     b
ROM:15CD 1F			     rar
ROM:15CE D2 CC 15		     jnc     loc_15CC
ROM:15D1 78			     mov     a,	b
ROM:15D2 3D			     dcr     a
ROM:15D3 F2 D8 15		     jp	     loc_15D8
ROM:15D6 3E 04			     mvi     a,	4
ROM:15D8
ROM:15D8	     loc_15D8:				     ; CODE XREF: ROM:15D3j
ROM:15D8 32 11 22		     sta     2211h
ROM:15DB CD FA 03		     call    sub_3FA
ROM:15DE	     ; ---------------------------------------------------------------------------
ROM:15DE 21 BB 13		     lxi     h,	13BBh
ROM:15E1 CD E4 12		     call    sub_12E4
ROM:15E4	     ; ---------------------------------------------------------------------------
ROM:15E4
ROM:15E4	     loc_15E4:				     ; CODE XREF: ROM:15B6j
ROM:15E4						     ; ROM:15C1j
ROM:15E4 21 90 21		     lxi     h,	2190h
ROM:15E7 3E 03			     mvi     a,	3
ROM:15E9 CD E6 03		     call    sub_3E6
ROM:15EC	     ; ---------------------------------------------------------------------------
ROM:15EC C2 FF 15		     jnz     loc_15FF
ROM:15EF 06 09			     mvi     b,	9
ROM:15F1 CD 9D 1D		     call    sub_1D9D
ROM:15F4	     ; ---------------------------------------------------------------------------
ROM:15F4 CA FF 15		     jz	     loc_15FF
ROM:15F7 CD 82 1D		     call    sub_1D82
ROM:15FA	     ; ---------------------------------------------------------------------------
ROM:15FA 06 31			     mvi     b,	31h ; '1'
ROM:15FC CD 92 1D		     call    sub_1D92
ROM:15FF	     ; ---------------------------------------------------------------------------
ROM:15FF
ROM:15FF	     loc_15FF:				     ; CODE XREF: ROM:15ECj
ROM:15FF						     ; ROM:15F4j
ROM:15FF 21 70 13		     lxi     h,	1370h
ROM:1602 CD E4 12		     call    sub_12E4
ROM:1605	     ; ---------------------------------------------------------------------------
ROM:1605 C3 7A 14		     jmp     loc_147A
ROM:1608	     ; ---------------------------------------------------------------------------
ROM:1608 3E FF			     mvi     a,	0FFh
ROM:160A 32 93 21		     sta     2193h
ROM:160D 3A 94 21		     lda     2194h
ROM:1610 F6 30			     ori     30h
ROM:1612 32 94 21		     sta     2194h
ROM:1615 21 90 21		     lxi     h,	2190h
ROM:1618 3E 02			     mvi     a,	2
ROM:161A CD E6 03		     call    sub_3E6
ROM:161D	     ; ---------------------------------------------------------------------------
ROM:161D C2 7A 14		     jnz     loc_147A
ROM:1620 CD CE 03		     call    sub_3CE
ROM:1623	     ; ---------------------------------------------------------------------------
ROM:1623 21 E8 11		     lxi     h,	11E8h
ROM:1626 CD 6E 02		     call    loc_26E
ROM:1629	     ; ---------------------------------------------------------------------------
ROM:1629 21 CE 13		     lxi     h,	13CEh
ROM:162C CD E4 12		     call    sub_12E4
ROM:162F	     ; ---------------------------------------------------------------------------
ROM:162F C3 7A 14		     jmp     loc_147A
ROM:1632	     ; ---------------------------------------------------------------------------
ROM:1632 21 90 21		     lxi     h,	2190h
ROM:1635 3E 02			     mvi     a,	2
ROM:1637 CD E6 03		     call    sub_3E6
ROM:163A	     ; ---------------------------------------------------------------------------
ROM:163A C2 7A 14		     jnz     loc_147A
ROM:163D 3E 07			     mvi     a,	7
ROM:163F CD E6 03		     call    sub_3E6
ROM:1642	     ; ---------------------------------------------------------------------------
ROM:1642 CA 7A 14		     jz	     loc_147A
ROM:1645 CD D9 03		     call    sub_3D9
ROM:1648	     ; ---------------------------------------------------------------------------
ROM:1648 21 E8 11		     lxi     h,	11E8h
ROM:164B CD ED 0E		     call    sub_EED
ROM:164E	     ; ---------------------------------------------------------------------------
ROM:164E 21 B8 13		     lxi     h,	13B8h
ROM:1651 CD E4 12		     call    sub_12E4
ROM:1654	     ; ---------------------------------------------------------------------------
ROM:1654 C3 7A 14		     jmp     loc_147A
ROM:1657	     ; ---------------------------------------------------------------------------
ROM:1657 21 92 21		     lxi     h,	2192h
ROM:165A 3E 00			     mvi     a,	0
ROM:165C CD E6 03		     call    sub_3E6
ROM:165F	     ; ---------------------------------------------------------------------------
ROM:165F C2 03 18		     jnz     loc_1803
ROM:1662 3A 7A 23		     lda     237Ah
ROM:1665 B7			     ora     a
ROM:1666 C2 7C 16		     jnz     loc_167C
ROM:1669 3A 9E 23		     lda     239Eh
ROM:166C E6 08			     ani     8
ROM:166E C2 03 18		     jnz     loc_1803
ROM:1671 3A B6 23		     lda     23B6h
ROM:1674 F6 80			     ori     80h
ROM:1676 32 B6 23		     sta     23B6h
ROM:1679 C3 03 18		     jmp     loc_1803
ROM:167C	     ; ---------------------------------------------------------------------------
ROM:167C
ROM:167C	     loc_167C:				     ; CODE XREF: ROM:1666j
ROM:167C 3A 7B 23		     lda     237Bh
ROM:167F E6 0F			     ani     0Fh
ROM:1681 FE 01			     cpi     1
ROM:1683 CA 49 17		     jz	     loc_1749
ROM:1686 FE 00			     cpi     0
ROM:1688 CA 49 17		     jz	     loc_1749
ROM:168B 21 A3 23		     lxi     h,	23A3h
ROM:168E 11 20 23		     lxi     d,	2320h
ROM:1691 3E 2E			     mvi     a,	2Eh ; '.'
ROM:1693 CD 60 0F		     call    sub_F60
ROM:1696 CD 22 18		     call    sub_1822
ROM:1699 21 92 21		     lxi     h,	2192h
ROM:169C 3E 04			     mvi     a,	4
ROM:169E CD E6 03		     call    sub_3E6
ROM:16A1	     ; ---------------------------------------------------------------------------
ROM:16A1 CA B1 16		     jz	     loc_16B1
ROM:16A4 3E 07			     mvi     a,	7
ROM:16A6 CD E6 03		     call    sub_3E6
ROM:16A9	     ; ---------------------------------------------------------------------------
ROM:16A9 CA B1 16		     jz	     loc_16B1
ROM:16AC 3E 01			     mvi     a,	1
ROM:16AE C3 CD 16		     jmp     loc_16CD
ROM:16B1	     ; ---------------------------------------------------------------------------
ROM:16B1
ROM:16B1	     loc_16B1:				     ; CODE XREF: ROM:16A1j
ROM:16B1						     ; ROM:16A9j
ROM:16B1 3E 06			     mvi     a,	6
ROM:16B3 CD CE 03		     call    sub_3CE
ROM:16B6	     ; ---------------------------------------------------------------------------
ROM:16B6 3A 90 21		     lda     2190h
ROM:16B9 F6 05			     ori     5
ROM:16BB 32 90 21		     sta     2190h
ROM:16BE 3E FF			     mvi     a,	0FFh
ROM:16C0 32 93 21		     sta     2193h
ROM:16C3 3A 94 21		     lda     2194h
ROM:16C6 F6 30			     ori     30h
ROM:16C8 32 94 21		     sta     2194h
ROM:16CB 3E 00			     mvi     a,	0
ROM:16CD
ROM:16CD	     loc_16CD:				     ; CODE XREF: ROM:16AEj
ROM:16CD 32 7B 23		     sta     237Bh
ROM:16D0 32 9B 23		     sta     239Bh
ROM:16D3 32 BB 23		     sta     23BBh
ROM:16D6 3E 11			     mvi     a,	11h
ROM:16D8 32 7E 23		     sta     237Eh
ROM:16DB 32 BE 23		     sta     23BEh
ROM:16DE 3E 01			     mvi     a,	1
ROM:16E0 32 9E 23		     sta     239Eh
ROM:16E3 3E F0			     mvi     a,	0F0h ; 'ð'
ROM:16E5 32 86 23		     sta     2386h
ROM:16E8 32 A6 23		     sta     23A6h
ROM:16EB 32 80 23		     sta     2380h
ROM:16EE 32 A0 23		     sta     23A0h
ROM:16F1 3E 00			     mvi     a,	0
ROM:16F3 32 14 22		     sta     2214h
ROM:16F6 11 D3 21		     lxi     d,	21D3h
ROM:16F9 06 04			     mvi     b,	4
ROM:16FB CD 08 18		     call    sub_1808
ROM:16FE 21 92 21		     lxi     h,	2192h
ROM:1701 3E 06			     mvi     a,	6
ROM:1703 CD D9 03		     call    sub_3D9
ROM:1706	     ; ---------------------------------------------------------------------------
ROM:1706 21 B6 23		     lxi     h,	23B6h
ROM:1709 3E 06			     mvi     a,	6
ROM:170B CD D9 03		     call    sub_3D9
ROM:170E	     ; ---------------------------------------------------------------------------
ROM:170E 21 D3 21		     lxi     h,	21D3h
ROM:1711 11 C6 21		     lxi     d,	21C6h
ROM:1714 3E 10			     mvi     a,	10h
ROM:1716 CD 60 0F		     call    sub_F60
ROM:1719 21 C9 21		     lxi     h,	21C9h
ROM:171C 11 CE 21		     lxi     d,	21CEh
ROM:171F 3E 0A			     mvi     a,	0Ah
ROM:1721 CD 60 0F		     call    sub_F60
ROM:1724 21 90 21		     lxi     h,	2190h
ROM:1727 3E 04			     mvi     a,	4
ROM:1729 CD D9 03		     call    sub_3D9
ROM:172C	     ; ---------------------------------------------------------------------------
ROM:172C
ROM:172C	     loc_172C:				     ; CODE XREF: ROM:17E4j
ROM:172C 3A 7A 23		     lda     237Ah
ROM:172F C6 99			     adi     99h ; '™'
ROM:1731 27			     daa
ROM:1732 32 7A 23		     sta     237Ah
ROM:1735 32 9A 23		     sta     239Ah
ROM:1738 32 BA 23		     sta     23BAh
ROM:173B 3A 14 22		     lda     2214h
ROM:173E 47			     mov     b,	a
ROM:173F 3A 13 22		     lda     2213h
ROM:1742 80			     add     b
ROM:1743 32 14 22		     sta     2214h
ROM:1746 C3 E7 17		     jmp     loc_17E7
ROM:1749	     ; ---------------------------------------------------------------------------
ROM:1749
ROM:1749	     loc_1749:				     ; CODE XREF: ROM:1683j
ROM:1749						     ; ROM:1688j
ROM:1749 3A 7E 23		     lda     237Eh
ROM:174C E6 08			     ani     8
ROM:174E C2 03 18		     jnz     loc_1803
ROM:1751
ROM:1751	     loc_1751:				     ; CODE XREF: ROM:17FAj
ROM:1751 3E 01			     mvi     a,	1
ROM:1753 21 7E 23		     lxi     h,	237Eh
ROM:1756 CD E6 03		     call    sub_3E6
ROM:1759	     ; ---------------------------------------------------------------------------
ROM:1759 CA 94 17		     jz	     loc_1794
ROM:175C 3E 02			     mvi     a,	2
ROM:175E CD E6 03		     call    sub_3E6
ROM:1761	     ; ---------------------------------------------------------------------------
ROM:1761 CA B2 17		     jz	     loc_17B2
ROM:1764 3E 03			     mvi     a,	3
ROM:1766 CD CE 03		     call    sub_3CE
ROM:1769	     ; ---------------------------------------------------------------------------
ROM:1769 3E F0			     mvi     a,	0F0h ; 'ð'
ROM:176B 32 90 23		     sta     2390h
ROM:176E 32 B0 23		     sta     23B0h
ROM:1771 F3			     di
ROM:1772 3A 7E 23		     lda     237Eh
ROM:1775 F5			     push    psw
ROM:1776 3E 1F			     mvi     a,	1Fh
ROM:1778 32 7E 23		     sta     237Eh
ROM:177B 21 CC 11		     lxi     h,	11CCh
ROM:177E CD CD 0F		     call    sub_FCD
ROM:1781	     ; ---------------------------------------------------------------------------
ROM:1781 3E 2F			     mvi     a,	2Fh ; '/'
ROM:1783 32 7E 23		     sta     237Eh
ROM:1786 21 CC 11		     lxi     h,	11CCh
ROM:1789 CD CD 0F		     call    sub_FCD
ROM:178C	     ; ---------------------------------------------------------------------------
ROM:178C F1			     pop     psw
ROM:178D 32 7E 23		     sta     237Eh
ROM:1790 FB			     ei
ROM:1791 C3 D4 17		     jmp     loc_17D4
ROM:1794	     ; ---------------------------------------------------------------------------
ROM:1794
ROM:1794	     loc_1794:				     ; CODE XREF: ROM:1759j
ROM:1794 CD CE 03		     call    sub_3CE
ROM:1797	     ; ---------------------------------------------------------------------------
ROM:1797 3E F0			     mvi     a,	0F0h ; 'ð'
ROM:1799 32 8D 23		     sta     238Dh
ROM:179C 32 AD 23		     sta     23ADh
ROM:179F 3A 16 22		     lda     2216h
ROM:17A2 E6 08			     ani     8
ROM:17A4 C2 D4 17		     jnz     loc_17D4
ROM:17A7 3E F0			     mvi     a,	0F0h ; 'ð'
ROM:17A9 32 97 23		     sta     2397h
ROM:17AC 32 B7 23		     sta     23B7h
ROM:17AF C3 D4 17		     jmp     loc_17D4
ROM:17B2	     ; ---------------------------------------------------------------------------
ROM:17B2
ROM:17B2	     loc_17B2:				     ; CODE XREF: ROM:1761j
ROM:17B2 CD CE 03		     call    sub_3CE
ROM:17B5	     ; ---------------------------------------------------------------------------
ROM:17B5 3E F0			     mvi     a,	0F0h ; 'ð'
ROM:17B7 32 83 23		     sta     2383h
ROM:17BA 32 A3 23		     sta     23A3h
ROM:17BD 3E FF			     mvi     a,	0FFh
ROM:17BF 32 97 23		     sta     2397h
ROM:17C2 32 98 23		     sta     2398h
ROM:17C5 32 99 23		     sta     2399h
ROM:17C8 32 B7 23		     sta     23B7h
ROM:17CB 32 B8 23		     sta     23B8h
ROM:17CE 32 B9 23		     sta     23B9h
ROM:17D1 C3 D4 17		     jmp     loc_17D4
ROM:17D4
ROM:17D4	     loc_17D4:				     ; CODE XREF: ROM:1791j
ROM:17D4						     ; ROM:17A4j ...
ROM:17D4 3A 7E 23		     lda     237Eh
ROM:17D7 32 BE 23		     sta     23BEh
ROM:17DA E6 0F			     ani     0Fh
ROM:17DC 47			     mov     b,	a
ROM:17DD 3A 9E 23		     lda     239Eh
ROM:17E0 B0			     ora     b
ROM:17E1 32 9E 23		     sta     239Eh
ROM:17E4 C3 2C 17		     jmp     loc_172C
ROM:17E7	     ; ---------------------------------------------------------------------------
ROM:17E7
ROM:17E7	     loc_17E7:				     ; CODE XREF: ROM:1746j
ROM:17E7 DB 05			     in	     5
ROM:17E9 E6 80			     ani     80h
ROM:17EB C2 FD 17		     jnz     loc_17FD
ROM:17EE 3A 7A 23		     lda     237Ah
ROM:17F1 B7			     ora     a
ROM:17F2 CA FD 17		     jz	     loc_17FD
ROM:17F5 3A 7E 23		     lda     237Eh
ROM:17F8 E6 08			     ani     8
ROM:17FA CA 51 17		     jz	     loc_1751
ROM:17FD
ROM:17FD	     loc_17FD:				     ; CODE XREF: ROM:17EBj
ROM:17FD						     ; ROM:17F2j
ROM:17FD 21 5D 13		     lxi     h,	135Dh
ROM:1800 CD E4 12		     call    sub_12E4
ROM:1803	     ; ---------------------------------------------------------------------------
ROM:1803
ROM:1803	     loc_1803:				     ; CODE XREF: ROM:165Fj
ROM:1803						     ; ROM:166Ej ...
ROM:1803 3E 06			     mvi     a,	6
ROM:1805 C3 6E 03		     jmp     loc_36E
ROM:1808
ROM:1808	     ; =============== S U B R O U T I N E =======================================
ROM:1808
ROM:1808
ROM:1808	     sub_1808:				     ; CODE XREF: reset_entry+135p
ROM:1808						     ; ROM:16FBp ...
ROM:1808 21 1A 18		     lxi     h,	181Ah
ROM:180B 0E 08			     mvi     c,	8
ROM:180D
ROM:180D	     loc_180D:				     ; CODE XREF: sub_1808+Aj
ROM:180D 7E			     mov     a,	m
ROM:180E 12			     stax    d
ROM:180F 13			     inx     d
ROM:1810 23			     inx     h
ROM:1811 0D			     dcr     c
ROM:1812 C2 0D 18		     jnz     loc_180D
ROM:1815 05			     dcr     b
ROM:1816 C2 08 18		     jnz     sub_1808
ROM:1819 C9			     ret
ROM:1819	     ; End of function sub_1808
ROM:1819
ROM:181A	     ; ---------------------------------------------------------------------------
ROM:181A FF			     rst     7
ROM:181B 1F			     rar
ROM:181C 01 04 39		     lxi     b,	3904h
ROM:181F 2B			     dcx     h
ROM:1820 37			     stc
ROM:1821 37			     stc
ROM:1822
ROM:1822	     ; =============== S U B R O U T I N E =======================================
ROM:1822
ROM:1822
ROM:1822	     sub_1822:				     ; CODE XREF: reset_entry:loc_138p
ROM:1822						     ; ROM:1696p
ROM:1822 21 5B 23		     lxi     h,	235Bh
ROM:1825 3E 00			     mvi     a,	0
ROM:1827 16 1F			     mvi     d,	1Fh
ROM:1829
ROM:1829	     loc_1829:				     ; CODE XREF: sub_1822+Aj
ROM:1829 77			     mov     m,	a
ROM:182A 23			     inx     h
ROM:182B 15			     dcr     d
ROM:182C C2 29 18		     jnz     loc_1829
ROM:182F 21 80 23		     lxi     h,	2380h
ROM:1832 3E FF			     mvi     a,	0FFh
ROM:1834 16 1A			     mvi     d,	1Ah
ROM:1836
ROM:1836	     loc_1836:				     ; CODE XREF: sub_1822+17j
ROM:1836 77			     mov     m,	a
ROM:1837 23			     inx     h
ROM:1838 15			     dcr     d
ROM:1839 C2 36 18		     jnz     loc_1836
ROM:183C 21 A0 23		     lxi     h,	23A0h
ROM:183F 3E FF			     mvi     a,	0FFh
ROM:1841 16 1A			     mvi     d,	1Ah
ROM:1843
ROM:1843	     loc_1843:				     ; CODE XREF: sub_1822+24j
ROM:1843 77			     mov     m,	a
ROM:1844 23			     inx     h
ROM:1845 15			     dcr     d
ROM:1846 C2 43 18		     jnz     loc_1843
ROM:1849 3E 0F			     mvi     a,	0Fh
ROM:184B 32 8C 23		     sta     238Ch
ROM:184E 32 AC 23		     sta     23ACh
ROM:1851 32 96 23		     sta     2396h
ROM:1854 32 B6 23		     sta     23B6h
ROM:1857 C9			     ret
ROM:1857	     ; End of function sub_1822
ROM:1857
ROM:1858
ROM:1858	     ; =============== S U B R O U T I N E =======================================
ROM:1858
ROM:1858	     ; Attributes: noreturn
ROM:1858
ROM:1858	     sub_1858:				     ; CODE XREF: ROM:18EEp
ROM:1858						     ; ROM:196Ap
ROM:1858 3A 7E 23		     lda     237Eh
ROM:185B E6 02			     ani     2
ROM:185D 3E 20			     mvi     a,	20h ; ' '
ROM:185F C8			     rz
ROM:1860 21 90 21		     lxi     h,	2190h
ROM:1863 3E 03			     mvi     a,	3
ROM:1865 CD E6 03		     call    sub_3E6
ROM:1865	     ; End of function sub_1858
ROM:1865
ROM:1868	     ; ---------------------------------------------------------------------------
ROM:1868 3E 20			     mvi     a,	20h ; ' '
ROM:186A C0			     rnz
ROM:186B 3A 14 22		     lda     2214h
ROM:186E FE 01			     cpi     1
ROM:1870 3E 20			     mvi     a,	20h ; ' '
ROM:1872 C8			     rz
ROM:1873 3E 80			     mvi     a,	80h ; '€'
ROM:1875 C9			     ret
ROM:1876	     ; ---------------------------------------------------------------------------
ROM:1876 21 92 21		     lxi     h,	2192h
ROM:1879 3E 04			     mvi     a,	4
ROM:187B CD E6 03		     call    sub_3E6
ROM:187E	     ; ---------------------------------------------------------------------------
ROM:187E C2 7A 14		     jnz     loc_147A
ROM:1881 21 08 22		     lxi     h,	2208h
ROM:1884 3E FF			     mvi     a,	0FFh
ROM:1886 86			     add     m
ROM:1887 D2 91 18		     jnc     loc_1891
ROM:188A 77			     mov     m,	a
ROM:188B CA 99 18		     jz	     loc_1899
ROM:188E C3 7A 14		     jmp     loc_147A
ROM:1891	     ; ---------------------------------------------------------------------------
ROM:1891
ROM:1891	     loc_1891:				     ; CODE XREF: ROM:1887j
ROM:1891 3E 32			     mvi     a,	32h ; '2'
ROM:1893 32 08 22		     sta     2208h
ROM:1896 C3 7A 14		     jmp     loc_147A
ROM:1899	     ; ---------------------------------------------------------------------------
ROM:1899
ROM:1899	     loc_1899:				     ; CODE XREF: ROM:188Bj
ROM:1899 3E FF			     mvi     a,	0FFh
ROM:189B 32 93 21		     sta     2193h
ROM:189E 3E 00			     mvi     a,	0
ROM:18A0 32 0C 22		     sta     220Ch
ROM:18A3 32 C3 21		     sta     21C3h
ROM:18A6 32 A8 21		     sta     21A8h
ROM:18A9 32 A9 21		     sta     21A9h
ROM:18AC 3A 94 21		     lda     2194h
ROM:18AF F6 30			     ori     30h
ROM:18B1 32 94 21		     sta     2194h
ROM:18B4 21 90 21		     lxi     h,	2190h
ROM:18B7 3E 02			     mvi     a,	2
ROM:18B9 CD CE 03		     call    sub_3CE
ROM:18BC	     ; ---------------------------------------------------------------------------
ROM:18BC 21 92 21		     lxi     h,	2192h
ROM:18BF 3E 04			     mvi     a,	4
ROM:18C1 CD CE 03		     call    sub_3CE
ROM:18C4	     ; ---------------------------------------------------------------------------
ROM:18C4 21 6B 13		     lxi     h,	136Bh
ROM:18C7 CD E4 12		     call    sub_12E4
ROM:18CA	     ; ---------------------------------------------------------------------------
ROM:18CA CD A3 1B		     call    sub_1BA3
ROM:18CD	     ; ---------------------------------------------------------------------------
ROM:18CD EB			     xchg
ROM:18CE 21 C6 21		     lxi     h,	21C6h
ROM:18D1 3E 10			     mvi     a,	10h
ROM:18D3 CD 60 0F		     call    sub_F60
ROM:18D6 21 90 21		     lxi     h,	2190h
ROM:18D9 3E 00			     mvi     a,	0
ROM:18DB CD E6 03		     call    sub_3E6
ROM:18DE	     ; ---------------------------------------------------------------------------
ROM:18DE C2 E9 18		     jnz     loc_18E9
ROM:18E1 06 39			     mvi     b,	39h ; '9'
ROM:18E3 CD 9D 1D		     call    sub_1D9D
ROM:18E6	     ; ---------------------------------------------------------------------------
ROM:18E6 C2 F7 18		     jnz     loc_18F7
ROM:18E9
ROM:18E9	     loc_18E9:				     ; CODE XREF: ROM:18DEj
ROM:18E9 3E 02			     mvi     a,	2
ROM:18EB 32 A0 21		     sta     21A0h
ROM:18EE CD 58 18		     call    sub_1858
ROM:18F1	     ; ---------------------------------------------------------------------------
ROM:18F1 32 1C 22		     sta     221Ch
ROM:18F4 C3 7A 14		     jmp     loc_147A
ROM:18F7	     ; ---------------------------------------------------------------------------
ROM:18F7
ROM:18F7	     loc_18F7:				     ; CODE XREF: ROM:18E6j
ROM:18F7 2A 5C 23		     lhld    235Ch
ROM:18FA 29			     dad     h
ROM:18FB 29			     dad     h
ROM:18FC 29			     dad     h
ROM:18FD 29			     dad     h
ROM:18FE 22 F3 21		     shld    21F3h
ROM:1901 2A 5D 23		     lhld    235Dh
ROM:1904 29			     dad     h
ROM:1905 29			     dad     h
ROM:1906 29			     dad     h
ROM:1907 29			     dad     h
ROM:1908 7C			     mov     a,	h
ROM:1909 32 F5 21		     sta     21F5h
ROM:190C 21 F3 21		     lxi     h,	21F3h
ROM:190F 11 0D 22		     lxi     d,	220Dh
ROM:1912 3E 06			     mvi     a,	6
ROM:1914 CD 60 0F		     call    sub_F60
ROM:1917 3E 04			     mvi     a,	4
ROM:1919
ROM:1919	     loc_1919:				     ; CODE XREF: ROM:1924j
ROM:1919 F5			     push    psw
ROM:191A 21 0D 22		     lxi     h,	220Dh
ROM:191D 3E 06			     mvi     a,	6
ROM:191F CD 7D 0E		     call    sub_E7D
ROM:1922 F1			     pop     psw
ROM:1923 3D			     dcr     a
ROM:1924 C2 19 19		     jnz     loc_1919
ROM:1927 21 F3 21		     lxi     h,	21F3h
ROM:192A CD 00 0F		     call    loc_F00
ROM:192D	     ; ---------------------------------------------------------------------------
ROM:192D 3E 3C			     mvi     a,	3Ch ; '<'
ROM:192F 32 AE 21		     sta     21AEh
ROM:1932 21 B8 13		     lxi     h,	13B8h
ROM:1935 CD E4 12		     call    sub_12E4
ROM:1938	     ; ---------------------------------------------------------------------------
ROM:1938 C3 7A 14		     jmp     loc_147A
ROM:193B	     ; ---------------------------------------------------------------------------
ROM:193B 21 E8 11		     lxi     h,	11E8h
ROM:193E CD 2A 0F		     call    sub_F2A
ROM:1941 DA 58 19		     jc	     loc_1958
ROM:1944 21 E8 11		     lxi     h,	11E8h
ROM:1947 CD 6E 02		     call    loc_26E
ROM:194A	     ; ---------------------------------------------------------------------------
ROM:194A 3E 0A			     mvi     a,	0Ah
ROM:194C 32 AE 21		     sta     21AEh
ROM:194F 21 B5 13		     lxi     h,	13B5h
ROM:1952 CD E4 12		     call    sub_12E4
ROM:1955	     ; ---------------------------------------------------------------------------
ROM:1955 C3 08 06		     jmp     loc_608
ROM:1958	     ; ---------------------------------------------------------------------------
ROM:1958
ROM:1958	     loc_1958:				     ; CODE XREF: ROM:1941j
ROM:1958 21 E8 11		     lxi     h,	11E8h
ROM:195B CD ED 0E		     call    sub_EED
ROM:195E	     ; ---------------------------------------------------------------------------
ROM:195E 21 5B 23		     lxi     h,	235Bh
ROM:1961 CD CD 0F		     call    sub_FCD
ROM:1964	     ; ---------------------------------------------------------------------------
ROM:1964 21 5B 23		     lxi     h,	235Bh
ROM:1967 CD 2A 0F		     call    sub_F2A
ROM:196A CD 58 18		     call    sub_1858
ROM:196D	     ; ---------------------------------------------------------------------------
ROM:196D 32 1C 22		     sta     221Ch
ROM:1970 3A 1C 22		     lda     221Ch
ROM:1973 3D			     dcr     a
ROM:1974 32 1C 22		     sta     221Ch
ROM:1977 CA 82 19		     jz	     loc_1982
ROM:197A 3E 02			     mvi     a,	2
ROM:197C 32 A0 21		     sta     21A0h
ROM:197F C3 08 06		     jmp     loc_608
ROM:1982	     ; ---------------------------------------------------------------------------
ROM:1982
ROM:1982	     loc_1982:				     ; CODE XREF: ROM:1977j
ROM:1982 3E 01			     mvi     a,	1
ROM:1984 32 12 22		     sta     2212h
ROM:1987 3E 32			     mvi     a,	32h ; '2'
ROM:1989 32 94 21		     sta     2194h
ROM:198C 21 92 21		     lxi     h,	2192h
ROM:198F 3E 03			     mvi     a,	3
ROM:1991 CD D9 03		     call    sub_3D9
ROM:1994	     ; ---------------------------------------------------------------------------
ROM:1994 21 90 21		     lxi     h,	2190h
ROM:1997 CD E6 03		     call    sub_3E6
ROM:199A	     ; ---------------------------------------------------------------------------
ROM:199A CA B9 19		     jz	     loc_19B9
ROM:199D CD D9 03		     call    sub_3D9
ROM:19A0	     ; ---------------------------------------------------------------------------
ROM:19A0 3E 02			     mvi     a,	2
ROM:19A2 32 12 22		     sta     2212h
ROM:19A5 06 30			     mvi     b,	30h ; '0'
ROM:19A7 CD 92 1D		     call    sub_1D92
ROM:19AA	     ; ---------------------------------------------------------------------------
ROM:19AA 21 96 23		     lxi     h,	2396h
ROM:19AD 3E 04			     mvi     a,	4
ROM:19AF CD D9 03		     call    sub_3D9
ROM:19B2	     ; ---------------------------------------------------------------------------
ROM:19B2 21 14 22		     lxi     h,	2214h
ROM:19B5 34			     inr     m
ROM:19B6 C3 8A 1A		     jmp     loc_1A8A
ROM:19B9	     ; ---------------------------------------------------------------------------
ROM:19B9
ROM:19B9	     loc_19B9:				     ; CODE XREF: ROM:199Aj
ROM:19B9 3A 7B 23		     lda     237Bh
ROM:19BC B7			     ora     a
ROM:19BD 3E 01			     mvi     a,	1
ROM:19BF 21 7E 23		     lxi     h,	237Eh
ROM:19C2 CA 5B 1A		     jz	     loc_1A5B
ROM:19C5 3E 04			     mvi     a,	4
ROM:19C7
ROM:19C7	     loc_19C7:				     ; CODE XREF: ROM:19D0j
ROM:19C7 CD E6 03		     call    sub_3E6
ROM:19CA	     ; ---------------------------------------------------------------------------
ROM:19CA C2 D3 19		     jnz     loc_19D3
ROM:19CD 3C			     inr     a
ROM:19CE FE 08			     cpi     8
ROM:19D0 C2 C7 19		     jnz     loc_19C7
ROM:19D3
ROM:19D3	     loc_19D3:				     ; CODE XREF: ROM:19CAj
ROM:19D3 CD D9 03		     call    sub_3D9
ROM:19D6	     ; ---------------------------------------------------------------------------
ROM:19D6 3C			     inr     a
ROM:19D7 4F			     mov     c,	a
ROM:19D8 D6 04			     sui     4
ROM:19DA CD E6 03		     call    sub_3E6
ROM:19DD	     ; ---------------------------------------------------------------------------
ROM:19DD 79			     mov     a,	c
ROM:19DE C2 69 1A		     jnz     loc_1A69
ROM:19E1 3A 13 22		     lda     2213h
ROM:19E4 3C			     inr     a
ROM:19E5 47			     mov     b,	a
ROM:19E6 3A 7B 23		     lda     237Bh
ROM:19E9 3C			     inr     a
ROM:19EA B8			     cmp     b
ROM:19EB C2 5B 1A		     jnz     loc_1A5B
ROM:19EE 21 91 21		     lxi     h,	2191h
ROM:19F1 3E 00			     mvi     a,	0
ROM:19F3 CD E6 03		     call    sub_3E6
ROM:19F6	     ; ---------------------------------------------------------------------------
ROM:19F6 3E 01			     mvi     a,	1
ROM:19F8 C2 5B 1A		     jnz     loc_1A5B
ROM:19FB 3A 92 21		     lda     2192h
ROM:19FE F6 C0			     ori     0C0h
ROM:1A00 32 92 21		     sta     2192h
ROM:1A03 21 B6 23		     lxi     h,	23B6h
ROM:1A06 3E 06			     mvi     a,	6
ROM:1A08
ROM:1A08	     loc_1A08:				     ; CODE XREF: ROM:06D4p
ROM:1A08 CD CE 03		     call    sub_3CE
ROM:1A0B	     ; ---------------------------------------------------------------------------
ROM:1A0B 3A AC 23		     lda     23ACh
ROM:1A0E E6 30			     ani     30h
ROM:1A10
ROM:1A10	     loc_1A10:				     ; DATA XREF: ROM:158Br
ROM:1A10 CA 1C 1A		     jz	     loc_1A1C
ROM:1A13 FE 10			     cpi     10h
ROM:1A15 3E 05			     mvi     a,	5
ROM:1A17 CA 1C 1A		     jz	     loc_1A1C
ROM:1A1A 3E 0A			     mvi     a,	0Ah
ROM:1A1C
ROM:1A1C	     loc_1A1C:				     ; CODE XREF: ROM:loc_1A10j
ROM:1A1C						     ; ROM:1A17j
ROM:1A1C 32 BE 23		     sta     23BEh
ROM:1A1F 97			     sub     a
ROM:1A20 32 9E 23		     sta     239Eh
ROM:1A23 3A 8C 23		     lda     238Ch
ROM:1A26 E6 0F			     ani     0Fh
ROM:1A28 32 8C 23		     sta     238Ch
ROM:1A2B 21 82 13		     lxi     h,	1382h
ROM:1A2E CD E4 12		     call    sub_12E4
ROM:1A31	     ; ---------------------------------------------------------------------------
ROM:1A31 3E 00			     mvi     a,	0
ROM:1A33 32 9B 23		     sta     239Bh
ROM:1A36 32 BB 23		     sta     23BBh
ROM:1A39 3E FA			     mvi     a,	0FAh ; 'ú'
ROM:1A3B 32 9E 21		     sta     219Eh
ROM:1A3E 3A 16 22		     lda     2216h
ROM:1A41 E6 04			     ani     4
ROM:1A43 CC B8 1D		     cz	     loc_1DB8
ROM:1A46 06 00			     mvi     b,	0
ROM:1A48 CD 9D 1D		     call    sub_1D9D
ROM:1A4B	     ; ---------------------------------------------------------------------------
ROM:1A4B CA 08 06		     jz	     loc_608
ROM:1A4E 3E 7D			     mvi     a,	7Dh ; '}'
ROM:1A50 32 9A 21		     sta     219Ah
ROM:1A53 3E 2D			     mvi     a,	2Dh ; '-'
ROM:1A55 32 17 22		     sta     2217h
ROM:1A58 C3 08 06		     jmp     loc_608
ROM:1A5B	     ; ---------------------------------------------------------------------------
ROM:1A5B
ROM:1A5B	     loc_1A5B:				     ; CODE XREF: ROM:19C2j
ROM:1A5B						     ; ROM:19EBj ...
ROM:1A5B 32 7B 23		     sta     237Bh
ROM:1A5E 32 9B 23		     sta     239Bh
ROM:1A61 32 BB 23		     sta     23BBh
ROM:1A64 3E 04			     mvi     a,	4
ROM:1A66 21 7E 23		     lxi     h,	237Eh
ROM:1A69
ROM:1A69	     loc_1A69:				     ; CODE XREF: ROM:19DEj
ROM:1A69 CD CE 03		     call    sub_3CE
ROM:1A6C	     ; ---------------------------------------------------------------------------
ROM:1A6C 3A 13 22		     lda     2213h
ROM:1A6F 4F			     mov     c,	a
ROM:1A70 3A 7B 23		     lda     237Bh
ROM:1A73 B9			     cmp     c
ROM:1A74 C2 8A 1A		     jnz     loc_1A8A
ROM:1A77 21 90 21		     lxi     h,	2190h
ROM:1A7A 3E 04			     mvi     a,	4
ROM:1A7C CD CE 03		     call    sub_3CE
ROM:1A7F	     ; ---------------------------------------------------------------------------
ROM:1A7F 06 00			     mvi     b,	0
ROM:1A81 CD 9D 1D		     call    sub_1D9D
ROM:1A84	     ; ---------------------------------------------------------------------------
ROM:1A84 CA 8A 1A		     jz	     loc_1A8A
ROM:1A87 CD 92 1D		     call    sub_1D92
ROM:1A8A	     ; ---------------------------------------------------------------------------
ROM:1A8A
ROM:1A8A	     loc_1A8A:				     ; CODE XREF: ROM:19B6j
ROM:1A8A						     ; ROM:1A74j ...
ROM:1A8A 3A 7E 23		     lda     237Eh
ROM:1A8D 32 BE 23		     sta     23BEh
ROM:1A90 47			     mov     b,	a
ROM:1A91 E6 0F			     ani     0Fh
ROM:1A93 32 9E 23		     sta     239Eh
ROM:1A96 21 90 21		     lxi     h,	2190h
ROM:1A99 3E 00			     mvi     a,	0
ROM:1A9B CD D9 03		     call    sub_3D9
ROM:1A9E	     ; ---------------------------------------------------------------------------
ROM:1A9E 3E 03			     mvi     a,	3
ROM:1AA0 CD D9 03		     call    sub_3D9
ROM:1AA3	     ; ---------------------------------------------------------------------------
ROM:1AA3 06 09			     mvi     b,	9
ROM:1AA5 CD 82 1D		     call    sub_1D82
ROM:1AA8	     ; ---------------------------------------------------------------------------
ROM:1AA8 21 B6 23		     lxi     h,	23B6h
ROM:1AAB 3E 05			     mvi     a,	5
ROM:1AAD CD D9 03		     call    sub_3D9
ROM:1AB0	     ; ---------------------------------------------------------------------------
ROM:1AB0 3E 02			     mvi     a,	2
ROM:1AB2 32 A1 21		     sta     21A1h
ROM:1AB5 C3 08 06		     jmp     loc_608
ROM:1AB8	     ; ---------------------------------------------------------------------------
ROM:1AB8 3A 17 22		     lda     2217h
ROM:1ABB 3D			     dcr     a
ROM:1ABC 32 17 22		     sta     2217h
ROM:1ABF C2 CA 1A		     jnz     loc_1ACA
ROM:1AC2 06 00			     mvi     b,	0
ROM:1AC4 CD 82 1D		     call    sub_1D82
ROM:1AC7	     ; ---------------------------------------------------------------------------
ROM:1AC7 C3 08 06		     jmp     loc_608
ROM:1ACA	     ; ---------------------------------------------------------------------------
ROM:1ACA
ROM:1ACA	     loc_1ACA:				     ; CODE XREF: ROM:1ABFj
ROM:1ACA 3E 7D			     mvi     a,	7Dh ; '}'
ROM:1ACC 32 9A 21		     sta     219Ah
ROM:1ACF C3 08 06		     jmp     loc_608
ROM:1AD2	     ; ---------------------------------------------------------------------------
ROM:1AD2 3A 12 22		     lda     2212h
ROM:1AD5 3D			     dcr     a
ROM:1AD6 32 12 22		     sta     2212h
ROM:1AD9 CA EA 1A		     jz	     loc_1AEA
ROM:1ADC 21 A4 13		     lxi     h,	13A4h
ROM:1ADF CD E4 12		     call    sub_12E4
ROM:1AE2	     ; ---------------------------------------------------------------------------
ROM:1AE2 3E A0			     mvi     a,	0A0h ; ' '
ROM:1AE4 32 A1 21		     sta     21A1h
ROM:1AE7 C3 08 06		     jmp     loc_608
ROM:1AEA	     ; ---------------------------------------------------------------------------
ROM:1AEA
ROM:1AEA	     loc_1AEA:				     ; CODE XREF: ROM:1AD9j
ROM:1AEA 21 CC 11		     lxi     h,	11CCh
ROM:1AED CD 00 0F		     call    loc_F00
ROM:1AF0	     ; ---------------------------------------------------------------------------
ROM:1AF0 3A C9 21		     lda     21C9h
ROM:1AF3 32 18 22		     sta     2218h
ROM:1AF6 3A CE 21		     lda     21CEh
ROM:1AF9 32 19 22		     sta     2219h
ROM:1AFC CD A3 1B		     call    sub_1BA3
ROM:1AFF	     ; ---------------------------------------------------------------------------
ROM:1AFF 11 C6 21		     lxi     d,	21C6h
ROM:1B02 3E 10			     mvi     a,	10h
ROM:1B04 CD 60 0F		     call    sub_F60
ROM:1B07 21 C9 21		     lxi     h,	21C9h
ROM:1B0A 11 CE 21		     lxi     d,	21CEh
ROM:1B0D 3E 0A			     mvi     a,	0Ah
ROM:1B0F CD 60 0F		     call    sub_F60
ROM:1B12 06 2B			     mvi     b,	2Bh ; '+'
ROM:1B14 CD 77 1D		     call    sub_1D77
ROM:1B17	     ; ---------------------------------------------------------------------------
ROM:1B17 06 2C			     mvi     b,	2Ch ; ','
ROM:1B19 CD 77 1D		     call    sub_1D77
ROM:1B1C	     ; ---------------------------------------------------------------------------
ROM:1B1C 06 04			     mvi     b,	4
ROM:1B1E CD 77 1D		     call    sub_1D77
ROM:1B21	     ; ---------------------------------------------------------------------------
ROM:1B21 06 0C			     mvi     b,	0Ch
ROM:1B23 CD 77 1D		     call    sub_1D77
ROM:1B26	     ; ---------------------------------------------------------------------------
ROM:1B26 06 14			     mvi     b,	14h
ROM:1B28 CD 77 1D		     call    sub_1D77
ROM:1B2B	     ; ---------------------------------------------------------------------------
ROM:1B2B 06 11			     mvi     b,	11h
ROM:1B2D CD 82 1D		     call    sub_1D82
ROM:1B30	     ; ---------------------------------------------------------------------------
ROM:1B30 06 38			     mvi     b,	38h ; '8'
ROM:1B32 CD 82 1D		     call    sub_1D82
ROM:1B35	     ; ---------------------------------------------------------------------------
ROM:1B35 06 31			     mvi     b,	31h ; '1'
ROM:1B37 CD 82 1D		     call    sub_1D82
ROM:1B3A	     ; ---------------------------------------------------------------------------
ROM:1B3A 06 09			     mvi     b,	9
ROM:1B3C CD 82 1D		     call    sub_1D82
ROM:1B3F	     ; ---------------------------------------------------------------------------
ROM:1B3F 3A 18 22		     lda     2218h
ROM:1B42 E6 41			     ani     41h
ROM:1B44 47			     mov     b,	a
ROM:1B45 3A C9 21		     lda     21C9h
ROM:1B48 E6 BE			     ani     0BEh
ROM:1B4A B0			     ora     b
ROM:1B4B 32 C9 21		     sta     21C9h
ROM:1B4E 3A 19 22		     lda     2219h
ROM:1B51 E6 41			     ani     41h
ROM:1B53 47			     mov     b,	a
ROM:1B54 3A CE 21		     lda     21CEh
ROM:1B57 E6 BE			     ani     0BEh
ROM:1B59 B0			     ora     b
ROM:1B5A 32 CE 21		     sta     21CEh
ROM:1B5D 06 39			     mvi     b,	39h ; '9'
ROM:1B5F CD 82 1D		     call    sub_1D82
ROM:1B62	     ; ---------------------------------------------------------------------------
ROM:1B62 21 92 21		     lxi     h,	2192h
ROM:1B65 3E 07			     mvi     a,	7
ROM:1B67 CD CE 03		     call    sub_3CE
ROM:1B6A	     ; ---------------------------------------------------------------------------
ROM:1B6A 21 C9 13		     lxi     h,	13C9h
ROM:1B6D CD E4 12		     call    sub_12E4
ROM:1B70	     ; ---------------------------------------------------------------------------
ROM:1B70 3A 14 22		     lda     2214h
ROM:1B73 3D			     dcr     a
ROM:1B74 32 14 22		     sta     2214h
ROM:1B77 D6 02			     sui     2
ROM:1B79 FA A0 1B		     jm	     loc_1BA0
ROM:1B7C C2 A0 1B		     jnz     loc_1BA0
ROM:1B7F 3A 7E 23		     lda     237Eh
ROM:1B82 06 00			     mvi     b,	0
ROM:1B84 E6 0F			     ani     0Fh
ROM:1B86
ROM:1B86	     loc_1B86:				     ; CODE XREF: ROM:1B8Bj
ROM:1B86 1F			     rar
ROM:1B87 D2 8E 1B		     jnc     loc_1B8E
ROM:1B8A 04			     inr     b
ROM:1B8B C3 86 1B		     jmp     loc_1B86
ROM:1B8E	     ; ---------------------------------------------------------------------------
ROM:1B8E
ROM:1B8E	     loc_1B8E:				     ; CODE XREF: ROM:1B87j
ROM:1B8E 3A 7A 23		     lda     237Ah
ROM:1B91 90			     sub     b
ROM:1B92 F2 A0 1B		     jp	     loc_1BA0
ROM:1B95 06 00			     mvi     b,	0
ROM:1B97 CD 9D 1D		     call    sub_1D9D
ROM:1B9A	     ; ---------------------------------------------------------------------------
ROM:1B9A C2 A0 1B		     jnz     loc_1BA0
ROM:1B9D CD 77 1D		     call    sub_1D77
ROM:1BA0	     ; ---------------------------------------------------------------------------
ROM:1BA0
ROM:1BA0	     loc_1BA0:				     ; CODE XREF: ROM:1B79j
ROM:1BA0						     ; ROM:1B7Cj ...
ROM:1BA0 C3 08 06		     jmp     loc_608
ROM:1BA3
ROM:1BA3	     ; =============== S U B R O U T I N E =======================================
ROM:1BA3
ROM:1BA3	     ; Attributes: noreturn
ROM:1BA3
ROM:1BA3	     sub_1BA3:				     ; CODE XREF: ROM:18CAp
ROM:1BA3						     ; ROM:1AFCp
ROM:1BA3 3A 7E 23		     lda     237Eh
ROM:1BA6 E6 F0			     ani     0F0h
ROM:1BA8 21 EB 21		     lxi     h,	21EBh
ROM:1BAB 11 F8 FF		     lxi     d,	0FFF8h
ROM:1BAE
ROM:1BAE	     loc_1BAE:				     ; CODE XREF: sub_1BA3+Ej
ROM:1BAE 17			     ral
ROM:1BAF D8			     rc
ROM:1BB0 19			     dad     d
ROM:1BB1 C3 AE 1B		     jmp     loc_1BAE
ROM:1BB1	     ; End of function sub_1BA3
ROM:1BB1
ROM:1BB4	     ; ---------------------------------------------------------------------------
ROM:1BB4	     ; START OF	FUNCTION CHUNK FOR reset_entry
ROM:1BB4
ROM:1BB4	     loc_1BB4:				     ; CODE XREF: reset_entry+220j
ROM:1BB4 FB			     ei
ROM:1BB5 21 15 22		     lxi     h,	2215h
ROM:1BB8 DB 04			     in	     4
ROM:1BBA 77			     mov     m,	a
ROM:1BBB 3A 92 21		     lda     2192h
ROM:1BBE E6 04			     ani     4
ROM:1BC0 C2 53 1C		     jnz     loc_1C53
ROM:1BC3 F3			     di
ROM:1BC4 3A 53 23		     lda     2353h
ROM:1BC7 47			     mov     b,	a
ROM:1BC8 3A F8 23		     lda     23F8h
ROM:1BCB 90			     sub     b
ROM:1BCC 3A 94 21		     lda     2194h
ROM:1BCF FA D7 1B		     jm	     loc_1BD7
ROM:1BD2 E6 DD			     ani     0DDh
ROM:1BD4 C3 DB 1B		     jmp     loc_1BDB
ROM:1BD7	     ; ---------------------------------------------------------------------------
ROM:1BD7
ROM:1BD7	     loc_1BD7:				     ; CODE XREF: reset_entry+1B8Fj
ROM:1BD7 F6 02			     ori     2
ROM:1BD9 E6 DF			     ani     0DFh
ROM:1BDB
ROM:1BDB	     loc_1BDB:				     ; CODE XREF: reset_entry+1B94j
ROM:1BDB 32 94 21		     sta     2194h
ROM:1BDE 3A 92 21		     lda     2192h
ROM:1BE1 E6 01			     ani     1
ROM:1BE3 FB			     ei
ROM:1BE4 CA 05 1C		     jz	     loc_1C05
ROM:1BE7 3A 92 21		     lda     2192h
ROM:1BEA E6 FE			     ani     0FEh
ROM:1BEC 32 92 21		     sta     2192h
ROM:1BEF 21 44 22		     lxi     h,	2244h
ROM:1BF2 11 80 23		     lxi     d,	2380h
ROM:1BF5 3E 34			     mvi     a,	34h ; '4'
ROM:1BF7 CD 60 0F		     call    sub_F60
ROM:1BFA 21 64 22		     lxi     h,	2264h
ROM:1BFD 11 A0 23		     lxi     d,	23A0h
ROM:1C00 3E 34			     mvi     a,	34h ; '4'
ROM:1C02 CD 60 0F		     call    sub_F60
ROM:1C05
ROM:1C05	     loc_1C05:				     ; CODE XREF: reset_entry+1BA4j
ROM:1C05 3A 15 22		     lda     2215h
ROM:1C08 E6 20			     ani     20h
ROM:1C0A C2 E1 1C		     jnz     loc_1CE1
ROM:1C0D FB			     ei
ROM:1C0E 3A 92 21		     lda     2192h
ROM:1C11 E6 40			     ani     40h
ROM:1C13 CA 2E 1C		     jz	     loc_1C2E
ROM:1C16 3A 7A 23		     lda     237Ah
ROM:1C19 B7			     ora     a
ROM:1C1A 21 B6 23		     lxi     h,	23B6h
ROM:1C1D 3E 07			     mvi     a,	7
ROM:1C1F C2 28 1C		     jnz     loc_1C28
ROM:1C22 CD CE 03		     call    sub_3CE
ROM:1C22	     ; END OF FUNCTION CHUNK FOR reset_entry
ROM:1C25	     ; ---------------------------------------------------------------------------
ROM:1C25 C3 A2 01		     jmp     loc_1A2
ROM:1C28	     ; ---------------------------------------------------------------------------
ROM:1C28	     ; START OF	FUNCTION CHUNK FOR reset_entry
ROM:1C28
ROM:1C28	     loc_1C28:				     ; CODE XREF: reset_entry+1BDFj
ROM:1C28 CD D9 03		     call    sub_3D9
ROM:1C28	     ; END OF FUNCTION CHUNK FOR reset_entry
ROM:1C2B	     ; ---------------------------------------------------------------------------
ROM:1C2B C3 A2 01		     jmp     loc_1A2
ROM:1C2E	     ; ---------------------------------------------------------------------------
ROM:1C2E	     ; START OF	FUNCTION CHUNK FOR reset_entry
ROM:1C2E
ROM:1C2E	     loc_1C2E:				     ; CODE XREF: reset_entry+1BD3j
ROM:1C2E 3A 91 21		     lda     2191h
ROM:1C31 E6 01			     ani     1
ROM:1C33 FB			     ei
ROM:1C34 CA A2 01		     jz	     loc_1A2
ROM:1C37 DB 03			     in	     3
ROM:1C39 FE FE			     cpi     0FEh ; 'þ'
ROM:1C3B C2 45 1C		     jnz     loc_1C45
ROM:1C3E DB 02			     in	     2
ROM:1C40 FE FB			     cpi     0FBh ; 'û'
ROM:1C42 CA FA 1C		     jz	     loc_1CFA
ROM:1C45
ROM:1C45	     loc_1C45:				     ; CODE XREF: reset_entry+1BFBj
ROM:1C45 21 91 21		     lxi     h,	2191h
ROM:1C48 3E 00			     mvi     a,	0
ROM:1C4A CD D9 03		     call    sub_3D9
ROM:1C4A	     ; END OF FUNCTION CHUNK FOR reset_entry
ROM:1C4D	     ; ---------------------------------------------------------------------------
ROM:1C4D 32 9F 21		     sta     219Fh
ROM:1C50 C3 A2 01		     jmp     loc_1A2
ROM:1C53	     ; ---------------------------------------------------------------------------
ROM:1C53	     ; START OF	FUNCTION CHUNK FOR reset_entry
ROM:1C53
ROM:1C53	     loc_1C53:				     ; CODE XREF: reset_entry+1B80j
ROM:1C53 21 92 21		     lxi     h,	2192h
ROM:1C56 3E 00			     mvi     a,	0
ROM:1C58 CD E6 03		     call    sub_3E6
ROM:1C58	     ; END OF FUNCTION CHUNK FOR reset_entry
ROM:1C5B	     ; ---------------------------------------------------------------------------
ROM:1C5B C2 08 02		     jnz     loc_208
ROM:1C5E CD CE 03		     call    sub_3CE
ROM:1C61	     ; ---------------------------------------------------------------------------
ROM:1C61 3A 41 22		     lda     2241h
ROM:1C64 E6 01			     ani     1
ROM:1C66 C2 74 1C		     jnz     loc_1C74
ROM:1C69 21 80 23		     lxi     h,	2380h
ROM:1C6C 11 44 22		     lxi     d,	2244h
ROM:1C6F 3E 80			     mvi     a,	80h ; '€'
ROM:1C71 CD 60 0F		     call    sub_F60
ROM:1C74
ROM:1C74	     loc_1C74:				     ; CODE XREF: ROM:1C66j
ROM:1C74 3E FF			     mvi     a,	0FFh
ROM:1C76 21 83 23		     lxi     h,	2383h
ROM:1C79 06 17			     mvi     b,	17h
ROM:1C7B
ROM:1C7B	     loc_1C7B:				     ; CODE XREF: ROM:1C7Ej
ROM:1C7B 77			     mov     m,	a
ROM:1C7C 23			     inx     h
ROM:1C7D 05			     dcr     b
ROM:1C7E C2 7B 1C		     jnz     loc_1C7B
ROM:1C81 3E 0F			     mvi     a,	0Fh
ROM:1C83 32 8C 23		     sta     238Ch
ROM:1C86 3A 16 22		     lda     2216h
ROM:1C89 E6 04			     ani     4
ROM:1C8B C2 96 1C		     jnz     loc_1C96
ROM:1C8E 3A 41 22		     lda     2241h
ROM:1C91 E6 01			     ani     1
ROM:1C93 C2 BB 1C		     jnz     loc_1CBB
ROM:1C96
ROM:1C96	     loc_1C96:				     ; CODE XREF: ROM:1C8Bj
ROM:1C96 21 20 23		     lxi     h,	2320h
ROM:1C99 11 A3 23		     lxi     d,	23A3h
ROM:1C9C 3E 2E			     mvi     a,	2Eh ; '.'
ROM:1C9E CD 60 0F		     call    sub_F60
ROM:1CA1
ROM:1CA1	     loc_1CA1:				     ; CODE XREF: ROM:1CDEj
ROM:1CA1 3A 5A 22		     lda     225Ah
ROM:1CA4 F6 0F			     ori     0Fh
ROM:1CA6 32 96 23		     sta     2396h
ROM:1CA9 3A 7A 22		     lda     227Ah
ROM:1CAC E6 F0			     ani     0F0h
ROM:1CAE 47			     mov     b,	a
ROM:1CAF 3A B6 23		     lda     23B6h
ROM:1CB2 E6 0F			     ani     0Fh
ROM:1CB4 B0			     ora     b
ROM:1CB5 32 B6 23		     sta     23B6h
ROM:1CB8 C3 08 02		     jmp     loc_208
ROM:1CBB	     ; ---------------------------------------------------------------------------
ROM:1CBB
ROM:1CBB	     loc_1CBB:				     ; CODE XREF: ROM:1C93j
ROM:1CBB 21 A3 23		     lxi     h,	23A3h
ROM:1CBE 0E 17			     mvi     c,	17h
ROM:1CC0 3E FF			     mvi     a,	0FFh
ROM:1CC2
ROM:1CC2	     loc_1CC2:				     ; CODE XREF: ROM:1CC5j
ROM:1CC2 77			     mov     m,	a
ROM:1CC3 23			     inx     h
ROM:1CC4 0D			     dcr     c
ROM:1CC5 C2 C2 1C		     jnz     loc_1CC2
ROM:1CC8 11 A9 23		     lxi     d,	23A9h
ROM:1CCB 21 28 22		     lxi     h,	2228h
ROM:1CCE 3E 08			     mvi     a,	8
ROM:1CD0 CD 7B 0F		     call    sub_F7B
ROM:1CD3 11 B3 23		     lxi     d,	23B3h
ROM:1CD6 21 2C 22		     lxi     h,	222Ch
ROM:1CD9 3E 08			     mvi     a,	8
ROM:1CDB CD 7B 0F		     call    sub_F7B
ROM:1CDE C3 A1 1C		     jmp     loc_1CA1
ROM:1CE1	     ; ---------------------------------------------------------------------------
ROM:1CE1	     ; START OF	FUNCTION CHUNK FOR reset_entry
ROM:1CE1
ROM:1CE1	     loc_1CE1:				     ; CODE XREF: reset_entry+1BCAj
ROM:1CE1 3A 53 23		     lda     2353h
ROM:1CE4 47			     mov     b,	a
ROM:1CE5 3A F8 23		     lda     23F8h
ROM:1CE8 90			     sub     b
ROM:1CE9 F2 08 02		     jp	     loc_208
ROM:1CEC 21 92 21		     lxi     h,	2192h
ROM:1CEF 3E 06			     mvi     a,	6
ROM:1CF1 CD E6 03		     call    sub_3E6
ROM:1CF1	     ; END OF FUNCTION CHUNK FOR reset_entry
ROM:1CF4	     ; ---------------------------------------------------------------------------
ROM:1CF4 CA FA 1C		     jz	     loc_1CFA
ROM:1CF7 C3 08 02		     jmp     loc_208
ROM:1CFA	     ; ---------------------------------------------------------------------------
ROM:1CFA	     ; START OF	FUNCTION CHUNK FOR reset_entry
ROM:1CFA
ROM:1CFA	     loc_1CFA:				     ; CODE XREF: reset_entry+1C02j
ROM:1CFA						     ; ROM:1CF4j
ROM:1CFA 3A 7E 23		     lda     237Eh
ROM:1CFD 32 9E 23		     sta     239Eh
ROM:1D00 3A AC 23		     lda     23ACh
ROM:1D03 32 8C 23		     sta     238Ch
ROM:1D06 06 30			     mvi     b,	30h ; '0'
ROM:1D08 CD 82 1D		     call    sub_1D82
ROM:1D08	     ; END OF FUNCTION CHUNK FOR reset_entry
ROM:1D0B	     ; ---------------------------------------------------------------------------
ROM:1D0B 3A 96 23		     lda     2396h
ROM:1D0E E6 CF			     ani     0CFh
ROM:1D10 32 96 23		     sta     2396h
ROM:1D13 3A B6 23		     lda     23B6h
ROM:1D16 E6 CF			     ani     0CFh
ROM:1D18 32 B6 23		     sta     23B6h
ROM:1D1B 21 C2 21		     lxi     h,	21C2h
ROM:1D1E 3E 05			     mvi     a,	5
ROM:1D20 CD CE 03		     call    sub_3CE
ROM:1D23	     ; ---------------------------------------------------------------------------
ROM:1D23 3A C2 21		     lda     21C2h
ROM:1D26 2F			     cma
ROM:1D27 D3 05			     out     5
ROM:1D29 3E 80			     mvi     a,	80h ; '€'
ROM:1D2B 32 93 21		     sta     2193h
ROM:1D2E 3E 06			     mvi     a,	6
ROM:1D30 32 AC 21		     sta     21ACh
ROM:1D33 3E 00			     mvi     a,	0
ROM:1D35 32 94 21		     sta     2194h
ROM:1D38 3A 90 21		     lda     2190h
ROM:1D3B E6 30			     ani     30h
ROM:1D3D F6 80			     ori     80h
ROM:1D3F 32 90 21		     sta     2190h
ROM:1D42 3A 92 21		     lda     2192h
ROM:1D45 E6 67			     ani     67h
ROM:1D47 32 92 21		     sta     2192h
ROM:1D4A 21 91 21		     lxi     h,	2191h
ROM:1D4D 3E 01			     mvi     a,	1
ROM:1D4F CD D9 03		     call    sub_3D9
ROM:1D52	     ; ---------------------------------------------------------------------------
ROM:1D52 21 94 21		     lxi     h,	2194h
ROM:1D55 3E 04			     mvi     a,	4
ROM:1D57 CD CE 03		     call    sub_3CE
ROM:1D5A	     ; ---------------------------------------------------------------------------
ROM:1D5A 3E 06			     mvi     a,	6
ROM:1D5C 32 A8 21		     sta     21A8h
ROM:1D5F 3E 05			     mvi     a,	5
ROM:1D61 32 97 21		     sta     2197h
ROM:1D64 C3 08 02		     jmp     loc_208
ROM:1D67	     ; ---------------------------------------------------------------------------
ROM:1D67 21 C2 21		     lxi     h,	21C2h
ROM:1D6A 3E 05			     mvi     a,	5
ROM:1D6C CD D9 03		     call    sub_3D9
ROM:1D6F	     ; ---------------------------------------------------------------------------
ROM:1D6F F3			     di
ROM:1D70 CD DE 13		     call    sub_13DE
ROM:1D73	     ; ---------------------------------------------------------------------------
ROM:1D73 FB			     ei
ROM:1D74 C3 08 06		     jmp     loc_608
ROM:1D77
ROM:1D77	     ; =============== S U B R O U T I N E =======================================
ROM:1D77
ROM:1D77	     ; Attributes: noreturn
ROM:1D77
ROM:1D77	     sub_1D77:				     ; CODE XREF: ROM:0BBDp
ROM:1D77						     ; ROM:0BFBp ...
ROM:1D77 CD A4 1D		     call    sub_1DA4
ROM:1D7A CD CE 03		     call    sub_3CE
ROM:1D7A	     ; End of function sub_1D77
ROM:1D7A
ROM:1D7D	     ; ---------------------------------------------------------------------------
ROM:1D7D 19			     dad     d
ROM:1D7E CD CE 03		     call    sub_3CE
ROM:1D81	     ; ---------------------------------------------------------------------------
ROM:1D81 C9			     ret
ROM:1D82
ROM:1D82	     ; =============== S U B R O U T I N E =======================================
ROM:1D82
ROM:1D82	     ; Attributes: noreturn
ROM:1D82
ROM:1D82	     sub_1D82:				     ; CODE XREF: ROM:0501p
ROM:1D82						     ; ROM:09C5p ...
ROM:1D82 CD A4 1D		     call    sub_1DA4
ROM:1D85 CD D9 03		     call    sub_3D9
ROM:1D85	     ; End of function sub_1D82
ROM:1D85
ROM:1D88	     ; ---------------------------------------------------------------------------
ROM:1D88 19			     dad     d
ROM:1D89 CD E6 03		     call    sub_3E6
ROM:1D8C	     ; ---------------------------------------------------------------------------
ROM:1D8C F5			     push    psw
ROM:1D8D CD D9 03		     call    sub_3D9
ROM:1D90	     ; ---------------------------------------------------------------------------
ROM:1D90 F1			     pop     psw
ROM:1D91 C9			     ret
ROM:1D92
ROM:1D92	     ; =============== S U B R O U T I N E =======================================
ROM:1D92
ROM:1D92	     ; Attributes: noreturn
ROM:1D92
ROM:1D92	     sub_1D92:				     ; CODE XREF: ROM:loc_AFBp
ROM:1D92						     ; ROM:15FCp ...
ROM:1D92 CD A4 1D		     call    sub_1DA4
ROM:1D95 CD CE 03		     call    sub_3CE
ROM:1D95	     ; End of function sub_1D92
ROM:1D95
ROM:1D98	     ; ---------------------------------------------------------------------------
ROM:1D98 19			     dad     d
ROM:1D99 CD D9 03		     call    sub_3D9
ROM:1D9C	     ; ---------------------------------------------------------------------------
ROM:1D9C C9			     ret
ROM:1D9D
ROM:1D9D	     ; =============== S U B R O U T I N E =======================================
ROM:1D9D
ROM:1D9D	     ; Attributes: noreturn
ROM:1D9D
ROM:1D9D	     sub_1D9D:				     ; CODE XREF: ROM:0AEAp
ROM:1D9D						     ; ROM:0BF3p ...
ROM:1D9D CD A4 1D		     call    sub_1DA4
ROM:1DA0 CD E6 03		     call    sub_3E6
ROM:1DA0	     ; End of function sub_1D9D
ROM:1DA0
ROM:1DA0	     ; ---------------------------------------------------------------------------
ROM:1DA3 C9			     .db 0C9h ;	É
ROM:1DA4
ROM:1DA4	     ; =============== S U B R O U T I N E =======================================
ROM:1DA4
ROM:1DA4
ROM:1DA4	     sub_1DA4:				     ; CODE XREF: sub_1D77p
ROM:1DA4						     ; sub_1D82p ...
ROM:1DA4 21 C9 21		     lxi     h,	21C9h
ROM:1DA7 16 00			     mvi     d,	0
ROM:1DA9 78			     mov     a,	b
ROM:1DAA E6 07			     ani     7
ROM:1DAC 5F			     mov     e,	a
ROM:1DAD 19			     dad     d
ROM:1DAE 78			     mov     a,	b
ROM:1DAF 1F			     rar
ROM:1DB0 1F			     rar
ROM:1DB1 1F			     rar
ROM:1DB2 E6 07			     ani     7
ROM:1DB4 11 05 00		     lxi     d,	5
ROM:1DB7 C9			     ret
ROM:1DB7	     ; End of function sub_1DA4
ROM:1DB7
ROM:1DB8	     ; ---------------------------------------------------------------------------
ROM:1DB8
ROM:1DB8	     loc_1DB8:				     ; CODE XREF: ROM:1A43p
ROM:1DB8 21 63 23		     lxi     h,	2363h
ROM:1DBB CD C8 1F		     call    sub_1FC8
ROM:1DBE 21 6B 23		     lxi     h,	236Bh
ROM:1DC1 E5			     push    h
ROM:1DC2 CD A9 0E		     call    sub_EA9
ROM:1DC5 E1			     pop     h
ROM:1DC6 D2 D5 1D		     jnc     loc_1DD5
ROM:1DC9 22 38 22		     shld    2238h
ROM:1DCC 21 63 23		     lxi     h,	2363h
ROM:1DCF 22 3A 22		     shld    223Ah
ROM:1DD2 C3 DE 1D		     jmp     loc_1DDE
ROM:1DD5	     ; ---------------------------------------------------------------------------
ROM:1DD5
ROM:1DD5	     loc_1DD5:				     ; CODE XREF: ROM:1DC6j
ROM:1DD5 22 3A 22		     shld    223Ah
ROM:1DD8 21 63 23		     lxi     h,	2363h
ROM:1DDB 22 38 22		     shld    2238h
ROM:1DDE
ROM:1DDE	     loc_1DDE:				     ; CODE XREF: ROM:1DD2j
ROM:1DDE 2A 38 22		     lhld    2238h
ROM:1DE1 CD C8 1F		     call    sub_1FC8
ROM:1DE4 21 5F 23		     lxi     h,	235Fh
ROM:1DE7 E5			     push    h
ROM:1DE8 CD A9 0E		     call    sub_EA9
ROM:1DEB E1			     pop     h
ROM:1DEC DA 05 1E		     jc	     loc_1E05
ROM:1DEF E5			     push    h
ROM:1DF0 2A 3A 22		     lhld    223Ah
ROM:1DF3 CD C8 1F		     call    sub_1FC8
ROM:1DF6 E1			     pop     h
ROM:1DF7 E5			     push    h
ROM:1DF8 CD A9 0E		     call    sub_EA9
ROM:1DFB E1			     pop     h
ROM:1DFC DA 10 1E		     jc	     loc_1E10
ROM:1DFF 22 3C 22		     shld    223Ch
ROM:1E02 C3 18 1E		     jmp     loc_1E18
ROM:1E05	     ; ---------------------------------------------------------------------------
ROM:1E05
ROM:1E05	     loc_1E05:				     ; CODE XREF: ROM:1DECj
ROM:1E05 E5			     push    h
ROM:1E06 CD 6B 1E		     call    sub_1E6B
ROM:1E09 E1			     pop     h
ROM:1E0A 22 38 22		     shld    2238h
ROM:1E0D C3 18 1E		     jmp     loc_1E18
ROM:1E10	     ; ---------------------------------------------------------------------------
ROM:1E10
ROM:1E10	     loc_1E10:				     ; CODE XREF: ROM:1DFCj
ROM:1E10 E5			     push    h
ROM:1E11 CD 6B 1E		     call    sub_1E6B
ROM:1E14 E1			     pop     h
ROM:1E15 22 3A 22		     shld    223Ah
ROM:1E18
ROM:1E18	     loc_1E18:				     ; CODE XREF: ROM:1E02j
ROM:1E18						     ; ROM:1E0Dj
ROM:1E18 2A 38 22		     lhld    2238h
ROM:1E1B CD C8 1F		     call    sub_1FC8
ROM:1E1E 21 6F 23		     lxi     h,	236Fh
ROM:1E21 E5			     push    h
ROM:1E22 CD A9 0E		     call    sub_EA9
ROM:1E25 E1			     pop     h
ROM:1E26
ROM:1E26	     loc_1E26:				     ; DATA XREF: ROM:1366w
ROM:1E26 DA 4F 1E		     jc	     loc_1E4F
ROM:1E29 E5			     push    h
ROM:1E2A 2A 3A 22		     lhld    223Ah
ROM:1E2D CD C8 1F		     call    sub_1FC8
ROM:1E30 E1			     pop     h
ROM:1E31 E5			     push    h
ROM:1E32 CD A9 0E		     call    sub_EA9
ROM:1E35 E1			     pop     h
ROM:1E36 DA 5A 1E		     jc	     loc_1E5A
ROM:1E39 E5			     push    h
ROM:1E3A 2A 3C 22		     lhld    223Ch
ROM:1E3D CD C8 1F		     call    sub_1FC8
ROM:1E40 E1			     pop     h
ROM:1E41 E5			     push    h
ROM:1E42 CD A9 0E		     call    sub_EA9
ROM:1E45 E1			     pop     h
ROM:1E46 DA 78 1E		     jc	     loc_1E78
ROM:1E49 22 3E 22		     shld    223Eh
ROM:1E4C C3 83 1E		     jmp     loc_1E83
ROM:1E4F	     ; ---------------------------------------------------------------------------
ROM:1E4F
ROM:1E4F	     loc_1E4F:				     ; CODE XREF: ROM:loc_1E26j
ROM:1E4F E5			     push    h
ROM:1E50 CD 65 1E		     call    sub_1E65
ROM:1E53 E1			     pop     h
ROM:1E54 22 38 22		     shld    2238h
ROM:1E57 C3 83 1E		     jmp     loc_1E83
ROM:1E5A	     ; ---------------------------------------------------------------------------
ROM:1E5A
ROM:1E5A	     loc_1E5A:				     ; CODE XREF: ROM:1E36j
ROM:1E5A E5			     push    h
ROM:1E5B CD 6B 1E		     call    sub_1E6B
ROM:1E5E E1			     pop     h
ROM:1E5F 22 3A 22		     shld    223Ah
ROM:1E62 C3 83 1E		     jmp     loc_1E83
ROM:1E65
ROM:1E65	     ; =============== S U B R O U T I N E =======================================
ROM:1E65
ROM:1E65
ROM:1E65	     sub_1E65:				     ; CODE XREF: ROM:1E50p
ROM:1E65 2A 3C 22		     lhld    223Ch
ROM:1E68 22 3E 22		     shld    223Eh
ROM:1E68	     ; End of function sub_1E65
ROM:1E68
ROM:1E6B
ROM:1E6B	     ; =============== S U B R O U T I N E =======================================
ROM:1E6B
ROM:1E6B
ROM:1E6B	     sub_1E6B:				     ; CODE XREF: ROM:1E06p
ROM:1E6B						     ; ROM:1E11p ...
ROM:1E6B 2A 3A 22		     lhld    223Ah
ROM:1E6E 22 3C 22		     shld    223Ch
ROM:1E71 2A 38 22		     lhld    2238h
ROM:1E74 22 3A 22		     shld    223Ah
ROM:1E77 C9			     ret
ROM:1E77	     ; End of function sub_1E6B
ROM:1E77
ROM:1E78	     ; ---------------------------------------------------------------------------
ROM:1E78
ROM:1E78	     loc_1E78:				     ; CODE XREF: ROM:1E46j
ROM:1E78 E5			     push    h
ROM:1E79 2A 3C 22		     lhld    223Ch
ROM:1E7C 22 3E 22		     shld    223Eh
ROM:1E7F E1			     pop     h
ROM:1E80 22 3C 22		     shld    223Ch
ROM:1E83
ROM:1E83	     loc_1E83:				     ; CODE XREF: ROM:1E4Cj
ROM:1E83						     ; ROM:1E57j ...
ROM:1E83 21 28 22		     lxi     h,	2228h
ROM:1E86 CD C8 1F		     call    sub_1FC8
ROM:1E89 2A 38 22		     lhld    2238h
ROM:1E8C E5			     push    h
ROM:1E8D CD A9 0E		     call    sub_EA9
ROM:1E90 E1			     pop     h
ROM:1E91 DC 5F 1F		     cc	     sub_1F5F
ROM:1E94	     ; ---------------------------------------------------------------------------
ROM:1E94 D8			     rc
ROM:1E95 21 2C 22		     lxi     h,	222Ch
ROM:1E98 CD C8 1F		     call    sub_1FC8
ROM:1E9B 2A 38 22		     lhld    2238h
ROM:1E9E E5			     push    h
ROM:1E9F CD A9 0E		     call    sub_EA9
ROM:1EA2 E1			     pop     h
ROM:1EA3 DC 76 1F		     cc	     sub_1F76
ROM:1EA6	     ; ---------------------------------------------------------------------------
ROM:1EA6 D8			     rc
ROM:1EA7 21 30 22		     lxi     h,	2230h
ROM:1EAA CD C8 1F		     call    sub_1FC8
ROM:1EAD 2A 38 22		     lhld    2238h
ROM:1EB0 E5			     push    h
ROM:1EB1 CD A9 0E		     call    sub_EA9
ROM:1EB4 E1			     pop     h
ROM:1EB5 DC 8D 1F		     cc	     sub_1F8D
ROM:1EB8 D8			     rc
ROM:1EB9 21 34 22		     lxi     h,	2234h
ROM:1EBC CD C8 1F		     call    sub_1FC8
ROM:1EBF 2A 38 22		     lhld    2238h
ROM:1EC2 E5			     push    h
ROM:1EC3 CD A9 0E		     call    sub_EA9
ROM:1EC6 E1			     pop     h
ROM:1EC7 DC 9E 1F		     cc	     sub_1F9E
ROM:1ECA C9			     ret
ROM:1ECB	     ; ---------------------------------------------------------------------------
ROM:1ECB 21 2C 22		     lxi     h,	222Ch
ROM:1ECE CD C8 1F		     call    sub_1FC8
ROM:1ED1 2A 3A 22		     lhld    223Ah
ROM:1ED4 E5			     push    h
ROM:1ED5 CD A9 0E		     call    sub_EA9
ROM:1ED8 E1			     pop     h
ROM:1ED9 DC 76 1F		     cc	     sub_1F76
ROM:1EDC	     ; ---------------------------------------------------------------------------
ROM:1EDC D8			     rc
ROM:1EDD 21 30 22		     lxi     h,	2230h
ROM:1EE0 CD C8 1F		     call    sub_1FC8
ROM:1EE3 2A 3A 22		     lhld    223Ah
ROM:1EE6 E5			     push    h
ROM:1EE7 CD A9 0E		     call    sub_EA9
ROM:1EEA E1			     pop     h
ROM:1EEB DC 8D 1F		     cc	     sub_1F8D
ROM:1EEE D8			     rc
ROM:1EEF 21 34 22		     lxi     h,	2234h
ROM:1EF2 CD C8 1F		     call    sub_1FC8
ROM:1EF5 2A 3A 22		     lhld    223Ah
ROM:1EF8 E5			     push    h
ROM:1EF9 CD A9 0E		     call    sub_EA9
ROM:1EFC E1			     pop     h
ROM:1EFD DC 9E 1F		     cc	     sub_1F9E
ROM:1F00 C9			     ret
ROM:1F01	     ; ---------------------------------------------------------------------------
ROM:1F01 21 30 22		     lxi     h,	2230h
ROM:1F04 CD C8 1F		     call    sub_1FC8
ROM:1F07 2A 3C 22		     lhld    223Ch
ROM:1F0A E5			     push    h
ROM:1F0B CD A9 0E		     call    sub_EA9
ROM:1F0E E1			     pop     h
ROM:1F0F DC 8D 1F		     cc	     sub_1F8D
ROM:1F12 D8			     rc
ROM:1F13 21 34 22		     lxi     h,	2234h
ROM:1F16 CD C8 1F		     call    sub_1FC8
ROM:1F19 2A 3C 22		     lhld    223Ch
ROM:1F1C E5			     push    h
ROM:1F1D CD A9 0E		     call    sub_EA9
ROM:1F20 E1			     pop     h
ROM:1F21 DC 9E 1F		     cc	     sub_1F9E
ROM:1F24 C9			     ret
ROM:1F25	     ; ---------------------------------------------------------------------------
ROM:1F25 21 34 22		     lxi     h,	2234h
ROM:1F28 CD C8 1F		     call    sub_1FC8
ROM:1F2B 2A 3E 22		     lhld    223Eh
ROM:1F2E E5			     push    h
ROM:1F2F CD A9 0E		     call    sub_EA9
ROM:1F32 E1			     pop     h
ROM:1F33 DC 9E 1F		     cc	     sub_1F9E
ROM:1F36 C9			     ret
ROM:1F37
ROM:1F37	     ; =============== S U B R O U T I N E =======================================
ROM:1F37
ROM:1F37
ROM:1F37	     sub_1F37:				     ; CODE XREF: sub_1F5F+3p
ROM:1F37						     ; sub_1F76+3p ...
ROM:1F37 F5			     push    psw
ROM:1F38 21 30 22		     lxi     h,	2230h
ROM:1F3B E5			     push    h
ROM:1F3C 11 34 22		     lxi     d,	2234h
ROM:1F3F 3E 07			     mvi     a,	7
ROM:1F41 CD 60 0F		     call    sub_F60
ROM:1F44 D1			     pop     d
ROM:1F45 F1			     pop     psw
ROM:1F46 3D			     dcr     a
ROM:1F47 C8			     rz
ROM:1F48 F5			     push    psw
ROM:1F49 21 2C 22		     lxi     h,	222Ch
ROM:1F4C E5			     push    h
ROM:1F4D 3E 07			     mvi     a,	7
ROM:1F4F CD 60 0F		     call    sub_F60
ROM:1F52 D1			     pop     d
ROM:1F53 F1			     pop     psw
ROM:1F54 3D			     dcr     a
ROM:1F55 C8			     rz
ROM:1F56 21 28 22		     lxi     h,	2228h
ROM:1F59 3E 07			     mvi     a,	7
ROM:1F5B CD 60 0F		     call    sub_F60
ROM:1F5E C9			     ret
ROM:1F5E	     ; End of function sub_1F37
ROM:1F5E
ROM:1F5F
ROM:1F5F	     ; =============== S U B R O U T I N E =======================================
ROM:1F5F
ROM:1F5F	     ; Attributes: noreturn
ROM:1F5F
ROM:1F5F	     sub_1F5F:				     ; CODE XREF: ROM:1E91p
ROM:1F5F E5			     push    h
ROM:1F60 3E 03			     mvi     a,	3
ROM:1F62 CD 37 1F		     call    sub_1F37
ROM:1F65 E1			     pop     h
ROM:1F66 11 28 22		     lxi     d,	2228h
ROM:1F69 3E 07			     mvi     a,	7
ROM:1F6B CD 60 0F		     call    sub_F60
ROM:1F6E 21 D4 13		     lxi     h,	13D4h
ROM:1F71 CD E4 12		     call    sub_12E4
ROM:1F71	     ; End of function sub_1F5F
ROM:1F71
ROM:1F74	     ; ---------------------------------------------------------------------------
ROM:1F74 3F			     cmc
ROM:1F75 C9			     ret
ROM:1F76
ROM:1F76	     ; =============== S U B R O U T I N E =======================================
ROM:1F76
ROM:1F76	     ; Attributes: noreturn
ROM:1F76
ROM:1F76	     sub_1F76:				     ; CODE XREF: ROM:1EA3p
ROM:1F76						     ; ROM:1ED9p
ROM:1F76 E5			     push    h
ROM:1F77 3E 02			     mvi     a,	2
ROM:1F79 CD 37 1F		     call    sub_1F37
ROM:1F7C E1			     pop     h
ROM:1F7D 11 2C 22		     lxi     d,	222Ch
ROM:1F80 3E 07			     mvi     a,	7
ROM:1F82 CD 60 0F		     call    sub_F60
ROM:1F85 21 D4 13		     lxi     h,	13D4h
ROM:1F88 CD E4 12		     call    sub_12E4
ROM:1F88	     ; End of function sub_1F76
ROM:1F88
ROM:1F8B	     ; ---------------------------------------------------------------------------
ROM:1F8B 3F			     cmc
ROM:1F8C C9			     ret
ROM:1F8D
ROM:1F8D	     ; =============== S U B R O U T I N E =======================================
ROM:1F8D
ROM:1F8D
ROM:1F8D	     sub_1F8D:				     ; CODE XREF: ROM:1EB5p
ROM:1F8D						     ; ROM:1EEBp ...
ROM:1F8D E5			     push    h
ROM:1F8E 3E 01			     mvi     a,	1
ROM:1F90 CD 37 1F		     call    sub_1F37
ROM:1F93 E1			     pop     h
ROM:1F94 11 30 22		     lxi     d,	2230h
ROM:1F97 3E 07			     mvi     a,	7
ROM:1F99 CD 60 0F		     call    sub_F60
ROM:1F9C 3F			     cmc
ROM:1F9D C9			     ret
ROM:1F9D	     ; End of function sub_1F8D
ROM:1F9D
ROM:1F9E
ROM:1F9E	     ; =============== S U B R O U T I N E =======================================
ROM:1F9E
ROM:1F9E
ROM:1F9E	     sub_1F9E:				     ; CODE XREF: ROM:1EC7p
ROM:1F9E						     ; ROM:1EFDp ...
ROM:1F9E 11 34 22		     lxi     d,	2234h
ROM:1FA1 3E 07			     mvi     a,	7
ROM:1FA3 CD 60 0F		     call    sub_F60
ROM:1FA6 3F			     cmc
ROM:1FA7 C9			     ret
ROM:1FA7	     ; End of function sub_1F9E
ROM:1FA7
ROM:1FA8
ROM:1FA8	     ; =============== S U B R O U T I N E =======================================
ROM:1FA8
ROM:1FA8
ROM:1FA8	     sub_1FA8:				     ; CODE XREF: ROM:09EBp
ROM:1FA8 21 2C 22		     lxi     h,	222Ch
ROM:1FAB E5			     push    h
ROM:1FAC 11 28 22		     lxi     d,	2228h
ROM:1FAF 3E 07			     mvi     a,	7
ROM:1FB1 CD 60 0F		     call    sub_F60
ROM:1FB4 D1			     pop     d
ROM:1FB5 21 30 22		     lxi     h,	2230h
ROM:1FB8 E5			     push    h
ROM:1FB9 3E 07			     mvi     a,	7
ROM:1FBB CD 60 0F		     call    sub_F60
ROM:1FBE D1			     pop     d
ROM:1FBF 21 34 22		     lxi     h,	2234h
ROM:1FC2 3E 07			     mvi     a,	7
ROM:1FC4 CD 60 0F		     call    sub_F60
ROM:1FC7 C9			     ret
ROM:1FC7	     ; End of function sub_1FA8
ROM:1FC7
ROM:1FC8
ROM:1FC8	     ; =============== S U B R O U T I N E =======================================
ROM:1FC8
ROM:1FC8
ROM:1FC8	     sub_1FC8:				     ; CODE XREF: ROM:1DBBp
ROM:1FC8						     ; ROM:1DE1p ...
ROM:1FC8 11 F3 21		     lxi     d,	21F3h
ROM:1FCB 3E 00			     mvi     a,	0
ROM:1FCD 06 04			     mvi     b,	4
ROM:1FCF
ROM:1FCF	     loc_1FCF:				     ; CODE XREF: sub_1FC8+Aj
ROM:1FCF 12			     stax    d
ROM:1FD0 13			     inx     d
ROM:1FD1 05			     dcr     b
ROM:1FD2 C2 CF 1F		     jnz     loc_1FCF
ROM:1FD5 11 F3 21		     lxi     d,	21F3h
ROM:1FD8 3E 07			     mvi     a,	7
ROM:1FDA CD 60 0F		     call    sub_F60
ROM:1FDD 3E 07			     mvi     a,	7
ROM:1FDF C9			     ret
ROM:1FDF	     ; End of function sub_1FC8
ROM:1FDF
ROM:1FDF	     ; ---------------------------------------------------------------------------
ROM:1FE0 00			     .db    0
ROM:1FE1 81			     .db  81h ;	
ROM:1FE2 23			     .db  23h ;	#
ROM:1FE3 02			     .db    2
ROM:1FE4 00			     .db    0
ROM:1FE5 00			     .db    0
ROM:1FE6 42			     .db  42h ;	B
ROM:1FE7 4C			     .db  4Ch ;	L
ROM:1FE8 4B			     .db  4Bh ;	K
ROM:1FE9 4D			     .db  4Dh ;	M
ROM:1FEA 56			     .db  56h ;	V
ROM:1FEB 00			     .db    0
ROM:1FEC 00			     .db    0
ROM:1FED 00			     .db    0
ROM:1FEE 00			     .db    0
ROM:1FEF 00			     .db    0
ROM:1FF0 81			     .db  81h ;	
ROM:1FF1 67			     .db  67h ;	g
ROM:1FF2 00			     .db    0
ROM:1FF3 00			     .db    0
ROM:1FF4 00			     .db    0
ROM:1FF5 57			     .db  57h ;	W
ROM:1FF6 4F			     .db  4Fh ;	O
ROM:1FF7 52			     .db  52h ;	R
ROM:1FF8 4B			     .db  4Bh ;	K
ROM:1FF9 33			     .db  33h ;	3
ROM:1FFA B0			     .db 0B0h ;	°
ROM:1FFB 00			     .db    0
ROM:1FFC 00			     .db    0
ROM:1FFD 00			     .db    0
ROM:1FFE 81			     .db  81h ;	
ROM:1FFF 78			     .db  78h ;	x
ROM:1FFF	     ; end of 'ROM'
ROM:1FFF
ROM:1FFF
ROM:1FFF			     .end
