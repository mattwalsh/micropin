; AY-3-8912 smoke test for the Micropin optional PSG socket.
;
; This is deliberately a tiny, self-contained four-ROM image.  It first
; writes the normal inactive value to every lamp/coil bank, then alternates
; AY channel A between two port-mapping hypotheses.  It never services switches and
; never deliberately energizes a coil.
;
; Hardware hypotheses under test:
;   OUT $0b = select AY register, OUT $0c = write selected register
;   OUT $0c = select AY register, OUT $0b = write selected register
;
; $0b/$0c are unused by the production output map, making them the next safe
; two-port candidate.  Do not substitute U67 output numbers $03/$04, which
; are production lamp ports.

        ORG #0000
        JMP RESET

; The motherboard can assert these vectors even in this minimal test ROM.
; Keep them harmless; maskable interrupts remain disabled in RESET.
        ORG #0024
        RET
        ORG #002c
        RET
        ORG #0034
        RET

        ORG #0040
RESET:
        DI
; $23e0-$23ff is live motherboard DMA switch data, so the stack must stay
; below it.  $23c0 is the proven safe boundary used by the aperture firmware.
        LXI SP,#23c0

; Establish the benign state of the board outputs: lamps dark and coils off.
; All of these output banks are active low.
        MVI A,#ff
        OUT #00
        OUT #01
        OUT #02
        OUT #03
        OUT #04
        OUT #05
        OUT #06
        OUT #07
        OUT #08
        OUT #0d
        OUT #0e
        OUT #0f

; Clear the 32-byte display scan window and put a persistent 001246 on the
; high-score display.  Display RAM is low-significance first: $23d3 = 35,
; $23d4 = 12, $23d5 = 00.  This is an independent proof that this ROM started
; even if the PSG port hypothesis is still wrong.
        LXI H,#23c0
        MVI B,#20
        MVI A,#ff
CLEAR_DISPLAY:
        MOV M,A
        INX H
        DCR B
        JNZ CLEAR_DISPLAY
        MVI A,#0f
        STA #23cc
        STA #23d6
        XRA A
        STA #23de
        STA #23d5
        MVI A,#12
        STA #23d4
        MVI A,#46
        STA #23d3

; The 8085 OUT instruction embeds its port number in ROM, so it cannot usually
; scan a variable port.  Put a three-byte OUT <port>; RET stub in unused RAM
; at $2000 and patch only its immediate port byte before each call.  This lets
; us scan every xB/xC alias without writing to any known lamp/coil low nibble.
        MVI A,#d3             ; opcode for OUT immediate
        STA #2000
        MVI A,#c9             ; RET
        STA #2002

; C is candidate register-select port; D is candidate data port.  For each
; upper nibble 0 through F, the visible four-digit display becomes 124H
; (H = current candidate upper nibble), then sends dense bursts in both
; possible directions.
        MVI C,#0b
        MVI D,#0c
        MVI B,#10
SCAN_CANDIDATE:
        MOV A,C
        ANI #f0
        ORI #40
        STA #23d3

        LXI H,#1000
BURST_C_REGISTER:
        CALL OUT_C_REGISTER_ZERO
        CALL OUT_D_DATA_40
        DCX H
        MOV A,H
        ORA L
        JNZ BURST_C_REGISTER

        LXI H,#1000
BURST_D_REGISTER:
        CALL OUT_D_REGISTER_ZERO
        CALL OUT_C_DATA_80
        DCX H
        MOV A,H
        ORA L
        JNZ BURST_D_REGISTER

        MVI A,#10
        ADD C
        MOV C,A
        MVI A,#10
        ADD D
        MOV D,A
        DCR B
        JNZ SCAN_CANDIDATE
        JMP RESET

; Patch the RAM stub's port-byte operand from C or D, then write the requested
; AY-style byte through it.  The scan data values 00/40/80 are benign even if
; a candidate is the real AY pair; this test is for decoder activity, not music.
OUT_C_REGISTER_ZERO:
        MOV A,C
        STA #2001
        MVI A,#00
        CALL #2000
        RET

OUT_D_REGISTER_ZERO:
        MOV A,D
        STA #2001
        MVI A,#00
        CALL #2000
        RET

OUT_D_DATA_40:
        MOV A,D
        STA #2001
        MVI A,#40
        CALL #2000
        RET

OUT_C_DATA_80:
        MOV A,C
        STA #2001
        MVI A,#80
        CALL #2000
        RET

; The physical ROMulator image is four 2 KiB parts.  Leave the rest blank.
        ORG #2000
