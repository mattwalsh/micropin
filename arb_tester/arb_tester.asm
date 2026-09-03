; Standalone four-ROM Micropin arbiter hardware exerciser.
; No game ROM, host, or ROMulator is required.
;
; A is moved into ordinary motherboard RAM at $2300-$233f.  RST 5.5 acts as
; the test producer; the normal arbiter loop copies A to L and manifests it.

HOST_APERTURE EQU #2300
HOST_SEQUENCE EQU HOST_APERTURE
CPU_ACK_APERTURE EQU HOST_APERTURE+#01

LOCAL_SNAPSHOT EQU #2200
CPU_SEQUENCE EQU #2240
TEST_DIVIDER EQU #2241
COIL_TIMERS EQU #2242
COIL_DURATIONS EQU #2262
COIL_CANCEL_POLICY EQU #2282
COIL_RENEW_POLICY EQU #2286
TEST_LAMP_BYTE EQU #228a
TEST_LAMP_BIT EQU #228b
TEST_COIL_BYTE EQU #228c
TEST_COIL_BIT EQU #228d
TEST_PITCH EQU #228e
COIL_COMMAND_BYTE EQU #228f
COIL_CANCEL_POLICY_BYTE EQU #2290
COIL_RENEW_POLICY_BYTE EQU #2291
TEST_COIL_DIVIDER EQU #2292
STACK_TOP EQU #23c0

COIL_ADVANCE_FRAMES EQU #08

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

; RST 6.5 is both the coil-expiration clock and, through a divide-by-32
; prescaler, the producer of autonomous test frames.  RST 5.5 stays masked so
; the test does not depend on the auxiliary-switch interrupt path.
        ORG #0034
        JMP COIL_TIMER_ISR

        ORG #0040
ARB_START:
        DI
        LXI SP, STACK_TOP
        SUB A
        STA CPU_SEQUENCE
        STA CPU_ACK_APERTURE

; Clear A before either interrupt may publish or consume a frame.
        LXI H, HOST_APERTURE
        MVI B, #40
CLEAR_HOST_APERTURE:
        MOV M,A
        INX H
        DCR B
        JNZ CLEAR_HOST_APERTURE

; Initialize the first one-hot lamp/coil positions and test tone.  Divider one
; deliberately publishes the first frame on the first RST 5.5 interrupt.
        INR A
        STA TEST_DIVIDER
        STA TEST_LAMP_BIT
        STA TEST_COIL_BIT
        DCR A
        STA TEST_LAMP_BYTE
        STA TEST_COIL_BYTE
        MVI A, #20
        STA TEST_PITCH
        MVI A, COIL_ADVANCE_FRAMES
        STA TEST_COIL_DIVIDER

; Coils are always off before interrupts or host traffic are enabled.
        SUB A
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

; Install conservative ROM defaults.  All coils are finite, non-renewing
; one-shots; each new test frame selects a different coil.
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

; Apply interrupt masks: mask RST 7.5 and 5.5, enable RST 6.5.
        MVI A, #0d
        SIM
        EI

ARB_LOOP:
; Equality means the A mailbox is empty.  Wait until the host publishes a new
; sequence value, making HOST_SEQUENCE differ from CPU_SEQUENCE.  In this ROM
; the "host" is SELF_TEST_ISR rather than the Pico/Python side.
        LDA HOST_SEQUENCE
        LXI H, CPU_SEQUENCE
        CMP M
        JZ ARB_LOOP

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
        JMP ARB_LOOP

; Every 32nd RST 6.5 interrupt, populate A with one lamp, one coil pulse, and
; a changing pitch.  The enclosing ISR has already saved every register.
; Publish HOST_SEQUENCE last, exactly like the real host.
SELF_TEST_TICK:
        LXI H, TEST_DIVIDER
        DCR M
        JNZ SELF_TEST_DONE
        MVI M, #20

; Do not overwrite A until the arbiter has completely consumed its last frame.
        LDA HOST_SEQUENCE
        LXI H, CPU_SEQUENCE
        CMP M
        JNZ SELF_TEST_DONE

        SUB A
        LXI H, HOST_APERTURE+LAMP_OFFSET
        MVI B, #08
CLEAR_TEST_LAMPS:
        MOV M,A
        INX H
        DCR B
        JNZ CLEAR_TEST_LAMPS
        LXI H, HOST_APERTURE+COIL_OFFSET
        MVI B, #04
CLEAR_TEST_COILS:
        MOV M,A
        INX H
        DCR B
        JNZ CLEAR_TEST_COILS

; Set the current one-hot lamp and advance its byte/bit cursor.
        LDA TEST_LAMP_BYTE
        MOV E,A
        MVI D, #00
        LXI H, HOST_APERTURE+LAMP_OFFSET
        DAD D
        LDA TEST_LAMP_BIT
        MOV M,A
        RLC
        STA TEST_LAMP_BIT
        CPI #01
        JNZ TEST_COIL_FRAME
        LDA TEST_LAMP_BYTE
        INR A
        ANI #07
        STA TEST_LAMP_BYTE

; Fire/advance a coil only once every COIL_ADVANCE_FRAMES visible lamp frames.
; The coil command bytes remain zero on intermediate frames, preventing the
; current coil from being retriggered while its cursor waits to advance.
TEST_COIL_FRAME:
        LXI H, TEST_COIL_DIVIDER
        DCR M
        JNZ TEST_TONE_FRAME
        MVI M, COIL_ADVANCE_FRAMES
        LDA TEST_COIL_BYTE
        MOV E,A
        MVI D, #00
        LXI H, HOST_APERTURE+COIL_OFFSET
        DAD D
        LDA TEST_COIL_BIT
        MOV M,A
        RLC
        STA TEST_COIL_BIT
        CPI #01
        JNZ TEST_TONE_FRAME
        LDA TEST_COIL_BYTE
        INR A
        ANI #03
        STA TEST_COIL_BYTE

; A short tone is restarted with a new pitch for every visible test frame.
TEST_TONE_FRAME:
        LDA TEST_PITCH
        STA HOST_APERTURE+TONE_PITCH_OFFSET
        ADI #07
        STA TEST_PITCH
        MVI A, #04
        STA HOST_APERTURE+TONE_DURATION_OFFSET

; Publish last.  Sequence wrap is harmless because only inequality matters.
        LDA HOST_SEQUENCE
        INR A
        STA HOST_SEQUENCE

SELF_TEST_DONE:
        RET

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
        CALL SELF_TEST_TICK
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

; Materialize exactly four 2 KiB ROM images.  All executable code fits in ROM 1;
; ROMs 2-4 are padding so this can run on an unmodified motherboard.
        ORG #2000
