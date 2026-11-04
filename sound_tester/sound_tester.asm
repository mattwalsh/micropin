; Standalone direct-port comparison: logical pitch $49 versus $50.
; No aperture, Python, game loop or maskable interrupts. All coils stay off.
; High score shows 49 or 50 (hex pitch interpreted as decimal display glyphs).
; Port writes exactly follow ppm TONE_PLAY: ff -> port9, ~pitch -> portA,
; ~duration -> port9. The ff music terminator is never played.
        ORG #0000
        JMP START
        ORG #0008
        RET
        ORG #0010
        RET
        ORG #0018
        RET
        ORG #0020
        RET
        ORG #0024
        RET
        ORG #002c
        RET
        ORG #0034
        RET
        ORG #003c
        RET
        ORG #0040
START:
        DI
        LXI SP,#2190
        MVI A,#ff
        OUT #05
        OUT #06
        OUT #07
        OUT #08
; Startup-only comparison: initialize the lamp banks and source encoders just
; as aperture_roundtrip START does. The subsequent direct sound loop is unchanged.
        OUT #00
        OUT #01
        OUT #02
        OUT #03
        OUT #04
        OUT #0d
        OUT #0e
        OUT #0f
        MVI A,#07
RESET_ENCODERS:
        OUT #0e
        OUT #0d
        DCR A
        JP RESET_ENCODERS
        MVI A,#ff
; Blank the display scan window. Clear mixed LED nibbles separately.
        LXI H,#23c0
        MVI B,#20
CLEAR_DISPLAY:
        MOV M,A
        INX H
        DCR B
        JNZ CLEAR_DISPLAY
        MVI A,#0f
        STA #23cc
        STA #23d6
        SUB A
        STA #23de
; Adopt a stable host-sequence baseline, using the arbiter's aperture reads.
; No response strobes or USB commands are issued by this test.
        LDA #2800
        STA #2200
COMPARE:
; Read the aperture immediately before each direct sound-write sequence.
        LDA #2800
        STA #2200
        LDA #2802
        STA #2201
        LDA #2803
        STA #2202
        MVI A,#49
        STA #23d3
        MVI A,#ff
        OUT #09
        MVI A,#b6
        OUT #0a
        MVI A,#f3
        OUT #09
        CALL SEND_FIXED_REPLY
        CALL WAIT
        CALL STOP_AND_WAIT
        LDA #2800
        STA #2200
        LDA #2802
        STA #2201
        LDA #2803
        STA #2202
        MVI A,#50
        STA #23d3
        MVI A,#ff
        OUT #09
        MVI A,#af
        OUT #0a
        MVI A,#f3
        OUT #09
        CALL SEND_FIXED_REPLY
        CALL WAIT
        CALL STOP_AND_WAIT
        JMP COMPARE
STOP_AND_WAIT:
        MVI A,#fe
        OUT #09
        CALL WAIT
        RET
; About 1.05 seconds at 1.5 MHz; not a calibrated hardware timer.
WAIT:
        LXI B,#ffff
WAIT_LOOP:
        DCX B
; About one read-only mailbox poll per 256 delay iterations. This deliberately
; avoids hammering CE4 every instruction and generates no host response traffic.
        MOV A,C
        ORA A
        JNZ WAIT_NO_APERTURE_POLL
        LDA #2800
        STA #2200
WAIT_NO_APERTURE_POLL:
        MOV A,B
        ORA C
        JNZ WAIT_LOOP
        RET
; Exercise exactly the arbiter's outbound address-strobe transport after each
; note: sequence 00, length 24, 36 zero switch bytes, CRC-8/ATM a5.
; No host is needed. This produces two small frames per complete sound cycle,
; rather than flooding the Pico's receive ring throughout the delay.
SEND_FIXED_REPLY:
        LDA #28e0
        MVI A,#00
        CALL SEND_RAW_BYTE
        MVI A,#24
        CALL SEND_RAW_BYTE
        MVI B,#24
SEND_ZERO_SWITCHES:
        MVI A,#00
        CALL SEND_RAW_BYTE
        DCR B
        JNZ SEND_ZERO_SWITCHES
        MVI A,#a5
        CALL SEND_RAW_BYTE
        LDA #28e1
        RET
; Same nibble read sequence as aperture_roundtrip SEND_RAW_BYTE.
SEND_RAW_BYTE:
        PUSH H
        PUSH PSW
        ANI #f0
        RRC
        RRC
        RRC
        RRC
        ORI #c0
        MOV L,A
        MVI H,#28
        MOV A,M
        POP PSW
        POP H
        PUSH H
        ANI #0f
        ORI #d0
        MOV L,A
        MVI H,#28
        MOV A,M
        POP H
        RET
; Only ROM 1 contains executable code; ROMs 2-4 are zero padding.
        ORG #1fff
        DB #00
