; Minimal experimental 8085 arbiter.  No game ROM code is used.
; The MAME/Pico host aperture is readable at $3000-$31ff.
;
; A ($3000-$303f) is the 64-byte host-owned output transaction.
; B ($3040-$307f) is the 64-byte 8085-owned switch transaction.
; C ($3080-$30bf) is the 64-byte host-owned coil configuration.

HOST_APERTURE EQU #3000
HOST_SEQUENCE EQU HOST_APERTURE
CPU_ACK_APERTURE EQU #3001
SWITCH_APERTURE EQU #3040
SWITCH_HOST_ACK EQU #3041
CONFIG_APERTURE EQU #3080
CONFIG_HOST_SEQUENCE EQU CONFIG_APERTURE
CONFIG_CPU_ACK_APERTURE EQU #3081
CONFIG_DURATION_SOURCE EQU CONFIG_APERTURE+#02
CONFIG_CANCEL_POLICY_SOURCE EQU CONFIG_APERTURE+#22
CONFIG_RENEW_POLICY_SOURCE EQU CONFIG_APERTURE+#26

LOCAL_SNAPSHOT EQU #2200
CPU_SEQUENCE EQU #2240
SWITCH_CPU_SEQUENCE EQU #2241
COIL_TIMERS EQU #2242
COIL_DURATIONS EQU #2262
COIL_CANCEL_POLICY EQU #2282
COIL_RENEW_POLICY EQU #2286
CONFIG_CPU_SEQUENCE EQU #228a
COIL_COMMAND_BYTE EQU #228b
COIL_CANCEL_POLICY_BYTE EQU #228c
COIL_RENEW_POLICY_BYTE EQU #228d
STACK_TOP EQU #2300

SWITCH_DMA_SOURCE EQU #23e0
SWITCH_DMA_DEST EQU SWITCH_APERTURE+#02
SWITCH_PORT_0_DEST EQU SWITCH_APERTURE+#22
SWITCH_PORT_1_DEST EQU SWITCH_APERTURE+#23
SWITCH_PORT_4_DEST EQU SWITCH_APERTURE+#24
SWITCH_PORT_5_DEST EQU SWITCH_APERTURE+#25

LAMP_OFFSET EQU #02
DISPLAY_OFFSET EQU #0a
DISPLAY_WINDOW EQU #23c0
COIL_OFFSET EQU #2a
TONE_PITCH_OFFSET EQU #2e
TONE_DURATION_OFFSET EQU #2f
TONE_ENABLE_DUR EQU #09
TONE_PITCH EQU #0a

        ORG #0000
        JMP ARB_START

; RST 6.5 is the independent coil-expiration clock.  RST 5.5 and 7.5 remain
; masked; the main loop polls and publishes switch state independently.
        ORG #0034
        JMP COIL_TIMER_ISR

        ORG #0040
ARB_START:
        DI
        LXI SP, STACK_TOP
        SUB A
        STA CPU_SEQUENCE
        STA CPU_ACK_APERTURE
        STA SWITCH_CPU_SEQUENCE
        STA SWITCH_APERTURE
        STA CONFIG_CPU_SEQUENCE
        STA CONFIG_CPU_ACK_APERTURE

; Coils are always off before interrupts or host traffic are enabled.
        LXI H, COIL_TIMERS
        MVI B, #20
CLEAR_COIL_TIMERS:
        MOV M,A
        INX H
        DCR B
        JNZ CLEAR_COIL_TIMERS
        MVI A, #ff
        OUT #05
        OUT #06
        OUT #07
        OUT #08

; Install conservative ROM defaults.  The host may replace these later by
; publishing C, but the closed 8085 self-test never requires a host.
        LXI H, DEFAULT_COIL_DURATIONS
        LXI D, COIL_DURATIONS
        MVI B, #20
COPY_DEFAULT_DURATIONS:
        MOV A,M
        STAX D
        INX H
        INX D
        DCR B
        JNZ COPY_DEFAULT_DURATIONS
        LXI H, DEFAULT_COIL_POLICY
        LXI D, COIL_CANCEL_POLICY
        MVI B, #08
COPY_DEFAULT_POLICY:
        MOV A,M
        STAX D
        INX H
        INX D
        DCR B
        JNZ COPY_DEFAULT_POLICY

; Apply interrupt masks: mask RST 7.5 and 5.5, leave RST 6.5 unmasked.
        MVI A, #0d
        SIM
        EI

ARB_LOOP:
; C is an independent one-slot mailbox.  Its table changes rarely and is
; copied directly into 8085-local configuration before acknowledgement.
        LDA CONFIG_HOST_SEQUENCE
        LXI H, CONFIG_CPU_SEQUENCE
        CMP M
        JZ CHECK_HOST_INPUT
        LXI H, CONFIG_DURATION_SOURCE
        LXI D, COIL_DURATIONS
        MVI B, #28
COPY_COIL_CONFIGURATION:
        MOV A,M
        STAX D
        INX H
        INX D
        DCR B
        JNZ COPY_COIL_CONFIGURATION
        LDA CONFIG_HOST_SEQUENCE
        STA CONFIG_CPU_SEQUENCE
        STA CONFIG_CPU_ACK_APERTURE

CHECK_HOST_INPUT:
; Equality means the A mailbox is empty.  Wait until the host publishes a new
; sequence value, making HOST_SEQUENCE differ from CPU_SEQUENCE.
        LDA HOST_SEQUENCE
        LXI H, CPU_SEQUENCE
        CMP M
        JZ CHECK_SWITCH_OUTPUT

; Copy A -> L while the sequence protocol forbids the host from modifying A.
        LXI H, HOST_APERTURE
        LXI D, LOCAL_SNAPSHOT
        MVI B, #40
COPY_APERTURE:
        MOV A,M
        STAX D
        INX H
        INX D
        DCR B
        JNZ COPY_APERTURE

; Manifest L's full display image directly to the display output window.
        LXI H, LOCAL_SNAPSHOT+DISPLAY_OFFSET
        LXI D, DISPLAY_WINDOW
        MVI B, #20
MANIFEST_DISPLAY:
        MOV A,M
        STAX D
        INX H
        INX D
        DCR B
        JNZ MANIFEST_DISPLAY

; Manifest 64 host lamp bits through ports 0-4 and $0d-$0f.  Board output
; polarity is active-low.  Python owns any flashing policy.
        LXI H, LOCAL_SNAPSHOT+LAMP_OFFSET
        MOV A,M
        CMA
        OUT #00
        INX H
        MOV A,M
        CMA
        OUT #01
        INX H
        MOV A,M
        CMA
        OUT #02
        INX H
        MOV A,M
        CMA
        OUT #03
        INX H
        MOV A,M
        CMA
        OUT #04
        INX H
        MOV A,M
        CMA
        OUT #0d
        INX H
        MOV A,M
        CMA
        OUT #0e
        INX H
        MOV A,M
        CMA
        OUT #0f

; Apply the four coil command bytes atomically with respect to RST 6.5.  An
; asserted bit starts an idle timer.  While active, it reloads only when the
; coil's renew policy permits it.  A clear bit either leaves the live lease
; counting down or cancels it immediately according to the other policy.
        DI
        LXI H, COIL_DURATIONS
        LXI D, COIL_TIMERS
        LDA COIL_RENEW_POLICY
        STA COIL_RENEW_POLICY_BYTE
        LDA COIL_CANCEL_POLICY
        MOV C,A
        LDA LOCAL_SNAPSHOT+COIL_OFFSET
        CALL APPLY_COIL_BANK
        LDA COIL_RENEW_POLICY+#01
        STA COIL_RENEW_POLICY_BYTE
        LDA COIL_CANCEL_POLICY+#01
        MOV C,A
        LDA LOCAL_SNAPSHOT+COIL_OFFSET+#01
        CALL APPLY_COIL_BANK
        LDA COIL_RENEW_POLICY+#02
        STA COIL_RENEW_POLICY_BYTE
        LDA COIL_CANCEL_POLICY+#02
        MOV C,A
        LDA LOCAL_SNAPSHOT+COIL_OFFSET+#02
        CALL APPLY_COIL_BANK
        LDA COIL_RENEW_POLICY+#03
        STA COIL_RENEW_POLICY_BYTE
        LDA COIL_CANCEL_POLICY+#03
        MOV C,A
        LDA LOCAL_SNAPSHOT+COIL_OFFSET+#03
        CALL APPLY_COIL_BANK
        CALL WRITE_COIL_PORTS
        EI

; Manifest logical pitch and duration through the original active-low sound
; ports.  Logical duration zero is the protocol's explicit silence command.
        LXI H, LOCAL_SNAPSHOT+TONE_PITCH_OFFSET
; Match the physical tone circuit's stock-ROM note-start sequence: reset/arm
; the duration circuit before supplying the new pitch and duration.
        MVI A, #ff
        OUT TONE_ENABLE_DUR
        MOV A,M
        CMA
        OUT TONE_PITCH
        INX H
        MOV A,M
        ORA A
        JNZ MANIFEST_TONE_DURATION
        MVI A, #fe
        OUT TONE_ENABLE_DUR
        JMP ACK_HOST_INPUT
MANIFEST_TONE_DURATION:
        CMA
        OUT TONE_ENABLE_DUR

; Acknowledge only after the complete output transaction has been applied.
ACK_HOST_INPUT:
        LDA LOCAL_SNAPSHOT
        STA CPU_SEQUENCE
        STA CPU_ACK_APERTURE

CHECK_SWITCH_OUTPUT:
; The 8085 is producer in this direction.  If the host has not acknowledged
; the previous switch snapshot, leave it untouched and keep servicing A/C.
        LDA SWITCH_HOST_ACK
        LXI H, SWITCH_CPU_SEQUENCE
        CMP M
        JNZ ARB_LOOP

; Port 0 advances the Micropin/MAME switch scan.  Preserve all four external
; input bytes plus all 32 inductive DMA samples verbatim.
        IN #00
        STA SWITCH_PORT_0_DEST
        IN #01
        STA SWITCH_PORT_1_DEST
        IN #04
        STA SWITCH_PORT_4_DEST
        IN #05
        STA SWITCH_PORT_5_DEST
        LXI H, SWITCH_DMA_SOURCE
        LXI D, SWITCH_DMA_DEST
        MVI B, #20
COPY_SWITCH_DMA:
        MOV A,M
        STAX D
        INX H
        INX D
        DCR B
        JNZ COPY_SWITCH_DMA

; Publish last, after the complete outbound payload is stable.
        LDA SWITCH_CPU_SEQUENCE
        INR A
        STA SWITCH_CPU_SEQUENCE
        STA SWITCH_APERTURE
        JMP ARB_LOOP

; A=command byte, C=cancel-on-clear policy, HL=duration table, DE=timers.
; Both pointers advance eight entries so four consecutive calls cover all 32.
APPLY_COIL_BANK:
        STA COIL_COMMAND_BYTE
        MOV A,C
        STA COIL_CANCEL_POLICY_BYTE
        MVI C, #01
        MVI B, #08
APPLY_COIL_BIT:
        LDA COIL_COMMAND_BYTE
        ANA C
        JZ APPLY_COIL_CLEAR
; An idle coil always starts.  An active coil reloads only when explicitly
; configured as renewable (for example, a holdable flipper).
        LDAX D
        ORA A
        JZ APPLY_COIL_RELOAD
        LDA COIL_RENEW_POLICY_BYTE
        ANA C
        JZ APPLY_COIL_NEXT
APPLY_COIL_RELOAD:
        MOV A,M
        STAX D
        JMP APPLY_COIL_NEXT
APPLY_COIL_CLEAR:
        LDA COIL_CANCEL_POLICY_BYTE
        ANA C
        JZ APPLY_COIL_NEXT
        SUB A
        STAX D
APPLY_COIL_NEXT:
        INX H
        INX D
        MOV A,C
        RLC
        MOV C,A
        DCR B
        JNZ APPLY_COIL_BIT
        RET

; Construct the four physical output bytes from the timers, the single source
; of coil truth.  BUILD_COIL_BYTE advances HL across one bank of eight timers.
WRITE_COIL_PORTS:
        LXI H, COIL_TIMERS
        CALL BUILD_COIL_BYTE
        CMA
        OUT #05
        CALL BUILD_COIL_BYTE
        CMA
        OUT #06
        CALL BUILD_COIL_BYTE
        CMA
        OUT #07
        CALL BUILD_COIL_BYTE
        CMA
        OUT #08
        RET

BUILD_COIL_BYTE:
        MVI B, #08
        MVI C, #00
        MVI D, #01
BUILD_COIL_BIT:
        MOV A,M
        ORA A
        JZ BUILD_COIL_NEXT
        MOV A,C
        ORA D
        MOV C,A
BUILD_COIL_NEXT:
        INX H
        MOV A,D
        RLC
        MOV D,A
        DCR B
        JNZ BUILD_COIL_BIT
        MOV A,C
        RET

; RST 6.5 automatically pushes the interrupted PC.  Maskable interrupts stay
; disabled until EI;RET, so this fixed-depth stack cannot nest recursively.
COIL_TIMER_ISR:
        PUSH PSW
        PUSH B
        PUSH D
        PUSH H
        LXI H, COIL_TIMERS
        MVI B, #20
DECREMENT_COIL_TIMERS:
        MOV A,M
        ORA A
        JZ NEXT_COIL_TIMER
        DCR M
NEXT_COIL_TIMER:
        INX H
        DCR B
        JNZ DECREMENT_COIL_TIMERS
        CALL WRITE_COIL_PORTS
        POP H
        POP D
        POP B
        POP PSW
        EI
        RET

; Five ticks is deliberately boring and conservative.  At the currently
; modeled 227 Hz RST 6.5 rate it is about 22 ms.  Duration zero disables a coil.
DEFAULT_COIL_DURATIONS:
        DB #05,#05,#05,#05,#05,#05,#05,#05
        DB #05,#05,#05,#05,#05,#05,#05,#05
        DB #05,#05,#05,#05,#05,#05,#05,#05
        DB #05,#05,#05,#05,#05,#05,#05,#05
DEFAULT_COIL_POLICY:
        DB #00,#00,#00,#00
; Non-renewing one-shots are the safer default.  Holdable mechanisms must be
; explicitly opted into renewal by the host configuration.
        DB #00,#00,#00,#00

; Materialize the whole 5-ROM CPU address image.  Build verifies that the
; physical-ROM-5 gap at $2000-$27ff is zero-filled.
        ORG #3000
