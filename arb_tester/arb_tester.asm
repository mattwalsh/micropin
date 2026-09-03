; Standalone four-ROM Micropin arbiter hardware exerciser.
; No game ROM, host, or ROMulator is required.
;
; A is moved into ordinary motherboard RAM at $2300-$233f.  RST 6.5 clocks
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
TEST_MODE EQU #2293
CONTROL_PREVIOUS EQU #2294
CONTROL_CURRENT EQU #2295
CONTROL_EDGES EQU #2296
CONTROL_CHANGED EQU #2297
ACTIVE_LAMP_NUMBER EQU #2298
ACTIVE_COIL_NUMBER EQU #2299
NEXT_LAMP_NUMBER EQU #229a
NEXT_COIL_NUMBER EQU #229b
FRAME_REQUEST EQU #229c
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

; Make every restart/vector entry deterministic.  On the real motherboard
; these lines come from external logic, so unused vectors must not consist of
; zero-byte NOPs that can fall through into a neighboring vector or startup.
        ORG #0008
        JMP UNEXPECTED_INTERRUPT
        ORG #0010
        JMP UNEXPECTED_INTERRUPT
        ORG #0018
        JMP UNEXPECTED_INTERRUPT
        ORG #0020
        JMP UNEXPECTED_INTERRUPT
        ORG #0024
        JMP UNEXPECTED_INTERRUPT
        ORG #002c
        JMP UNEXPECTED_INTERRUPT

; Keep a valid RST 6.5 entry for defensive purposes.  The standalone tester
; does not depend on the motherboard interrupt cadence; its main loop supplies
; its own counted-delay clock.
        ORG #0034
        JMP COIL_TIMER_ISR

        ORG #003c
        JMP UNEXPECTED_INTERRUPT

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
; deliberately publishes the first frame on the first software clock tick.
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
        SUB A
        STA TEST_MODE
        STA CONTROL_EDGES
        STA CONTROL_CHANGED
        STA ACTIVE_LAMP_NUMBER
        STA ACTIVE_COIL_NUMBER
        STA NEXT_LAMP_NUMBER
        STA NEXT_COIL_NUMBER
; Seed edge detection from the controls' actual boot state.  A button held
; during reset therefore needs to be released and pressed before taking action.
        CALL READ_TEST_CONTROLS
        STA CONTROL_PREVIOUS
        STA CONTROL_CURRENT

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

; Do not depend on the external restart circuitry in this standalone hardware
; exerciser.  The stock game treats a port-0 event as its periodic housekeeping
; tick, while MAME currently synthesizes a fixed RST cadence.  A local counted
; delay behaves consistently in both environments.
        DI

ARB_LOOP:
        CALL SOFTWARE_CLOCK_TICK
; Equality means the A mailbox is empty.  Wait until the host publishes a new
; sequence value, making HOST_SEQUENCE differ from CPU_SEQUENCE.  In this ROM
; the "host" is SELF_TEST_TICK rather than the Pico/Python side.
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
; The standalone tester is deliberately self-clocked; do not enable the
; motherboard's externally generated restart inputs after applying coils.
        DI

; Manifest logical pitch and duration through the original active-low sound
; ports.  Logical duration zero is the protocol's explicit silence command.
        LXI H, LOCAL_SNAPSHOT+TONE_PITCH_OFFSET
; The physical tone circuit expects the stock ROM's complete note-start
; sequence: $ff to reset/arm the duration circuit, then pitch, then duration.
; MAME's simplified tone model did not expose the missing first write.
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
        JMP ARB_LOOP

; Populate A from either the automatic chase or the cabinet-button manual
; controls.  Publish HOST_SEQUENCE last, exactly like the real host.
SELF_TEST_TICK:
; Do not overwrite A until the arbiter has completely consumed its last frame.
        LDA HOST_SEQUENCE
        LXI H, CPU_SEQUENCE
        CMP M
        JNZ SELF_TEST_DONE

        SUB A
        STA FRAME_REQUEST
; Coil commands and sound are pulses.  A newly published status-only frame
; therefore clears them, while the timer array safely finishes live coils.
        LXI H, HOST_APERTURE+COIL_OFFSET
        MVI B, #04
CLEAR_TEST_COILS:
        MOV M,A
        INX H
        DCR B
        JNZ CLEAR_TEST_COILS
        STA HOST_APERTURE+TONE_DURATION_OFFSET

        LDA TEST_MODE
        ORA A
        JNZ MANUAL_TEST_TICK

; Automatic mode advances one lamp every 32 software ticks.  Any cabinet
; switch transition also requests a frame so its live state reaches displays.
        LDA CONTROL_CHANGED
        ORA A
        CZ NO_FRAME_REQUEST
        CNZ REQUEST_TEST_FRAME
        LXI H, TEST_DIVIDER
        DCR M
        JNZ PUBLISH_TEST_IF_REQUESTED
        MVI M, #20
        CALL ADVANCE_TEST_LAMP

; Fire/advance a coil only once every COIL_ADVANCE_FRAMES visible lamp frames.
        LXI H, TEST_COIL_DIVIDER
        DCR M
        JNZ AUTO_TEST_TONE
        MVI M, COIL_ADVANCE_FRAMES
        CALL FIRE_TEST_COIL
AUTO_TEST_TONE:
        CALL PREPARE_TEST_TONE
        CALL REQUEST_TEST_FRAME
        JMP PUBLISH_TEST_IF_REQUESTED

; In manual mode, left advances the lamp and right advances/fires the coil.
; Start's rising edge has already toggled TEST_MODE in POLL_CONTROLS.
MANUAL_TEST_TICK:
        LDA CONTROL_CHANGED
        ORA A
        CNZ REQUEST_TEST_FRAME
        LDA CONTROL_EDGES
        ANI #40
        JZ MANUAL_TEST_COIL
        CALL ADVANCE_TEST_LAMP
        CALL PREPARE_TEST_TONE
        CALL REQUEST_TEST_FRAME
MANUAL_TEST_COIL:
        LDA CONTROL_EDGES
        ANI #20
        JZ PUBLISH_TEST_IF_REQUESTED
        CALL FIRE_TEST_COIL
        CALL PREPARE_TEST_TONE
        CALL REQUEST_TEST_FRAME

PUBLISH_TEST_IF_REQUESTED:
        LDA FRAME_REQUEST
        ORA A
        JZ SELF_TEST_DONE
        CALL UPDATE_DIAGNOSTIC_DISPLAYS
; Publish last.  Sequence wrap is harmless because only inequality matters.
        LDA HOST_SEQUENCE
        INR A
        STA HOST_SEQUENCE
SELF_TEST_DONE:
        RET

; Carries a convenient conditional-call target for the zero case above.
NO_FRAME_REQUEST:
        RET
REQUEST_TEST_FRAME:
        MVI A, #01
        STA FRAME_REQUEST
        RET

ADVANCE_TEST_LAMP:
        SUB A
        LXI H, HOST_APERTURE+LAMP_OFFSET
        MVI B, #08
CLEAR_TEST_LAMPS:
        MOV M,A
        INX H
        DCR B
        JNZ CLEAR_TEST_LAMPS
; Set the current one-hot lamp and advance both its cursor and numeric ID.
        LDA NEXT_LAMP_NUMBER
        STA ACTIVE_LAMP_NUMBER
        INR A
        ANI #3f
        STA NEXT_LAMP_NUMBER
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
        RNZ
        LDA TEST_LAMP_BYTE
        INR A
        ANI #07
        STA TEST_LAMP_BYTE
        RET

FIRE_TEST_COIL:
        LDA NEXT_COIL_NUMBER
        STA ACTIVE_COIL_NUMBER
        INR A
        ANI #1f
        STA NEXT_COIL_NUMBER
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
        RNZ
        LDA TEST_COIL_BYTE
        INR A
        ANI #03
        STA TEST_COIL_BYTE
        RET

; A short tone accompanies every automatic frame and manual lamp/coil step.
PREPARE_TEST_TONE:
        LDA TEST_PITCH
        STA HOST_APERTURE+TONE_PITCH_OFFSET
        ADI #07
        STA TEST_PITCH
        MVI A, #04
        STA HOST_APERTURE+TONE_DURATION_OFFSET
        RET

; Diagnostic display convention:
;   Player 1 = active lamp number (00-63)
;   Player 2 = active coil number (00-31)
;   Player 3 = 000SLR, live Start/Left/Right states
;   Player 4 = mode, 0 automatic / 1 manual
;   High Score = ABCDEF nibble/7448 decoder experiment
UPDATE_DIAGNOSTIC_DISPLAYS:
        SUB A
        STA HOST_APERTURE+DISPLAY_OFFSET+#08
        STA HOST_APERTURE+DISPLAY_OFFSET+#07
        STA HOST_APERTURE+DISPLAY_OFFSET+#0f
        STA HOST_APERTURE+DISPLAY_OFFSET+#0e
        STA HOST_APERTURE+DISPLAY_OFFSET+#05
        STA HOST_APERTURE+DISPLAY_OFFSET+#04
        STA HOST_APERTURE+DISPLAY_OFFSET+#03
        STA HOST_APERTURE+DISPLAY_OFFSET+#12
        STA HOST_APERTURE+DISPLAY_OFFSET+#11
; Display RAM is ordered least-significant pair first: $23d3 receives EF,
; $23d4 receives CD, and $23d5 receives AB to read ABCDEF left-to-right.
        MVI A, #ef
        STA HOST_APERTURE+DISPLAY_OFFSET+#13
        MVI A, #cd
        STA HOST_APERTURE+DISPLAY_OFFSET+#14
        MVI A, #ab
        STA HOST_APERTURE+DISPLAY_OFFSET+#15
        LDA ACTIVE_LAMP_NUMBER
        CALL NUMBER_TO_BCD
        STA HOST_APERTURE+DISPLAY_OFFSET+#06
        LDA ACTIVE_COIL_NUMBER
        CALL NUMBER_TO_BCD
        STA HOST_APERTURE+DISPLAY_OFFSET+#0d

; Start occupies the low digit of Player 3's middle byte.
        LDA CONTROL_CURRENT
        ANI #80
        JZ DISPLAY_NO_START
        MVI A, #01
DISPLAY_NO_START:
        STA HOST_APERTURE+DISPLAY_OFFSET+#04
; Left/right occupy the final two Player 3 digits and remain independently
; visible when both contacts are held.
        MVI B, #00
        LDA CONTROL_CURRENT
        ANI #40
        JZ DISPLAY_NO_LEFT
        MVI B, #10
DISPLAY_NO_LEFT:
        LDA CONTROL_CURRENT
        ANI #20
        JZ DISPLAY_NO_RIGHT
        MOV A,B
        ORI #01
        MOV B,A
DISPLAY_NO_RIGHT:
        MOV A,B
        STA HOST_APERTURE+DISPLAY_OFFSET+#03
        LDA TEST_MODE
        STA HOST_APERTURE+DISPLAY_OFFSET+#10
        RET

; Convert A=0..99 binary to packed BCD for the two rightmost score digits.
NUMBER_TO_BCD:
        MVI B, #00
NUMBER_TO_BCD_TENS:
        CPI #0a
        JC NUMBER_TO_BCD_DONE
        SUI #0a
        INR B
        JMP NUMBER_TO_BCD_TENS
NUMBER_TO_BCD_DONE:
        MOV C,A
        MOV A,B
        RLC
        RLC
        RLC
        RLC
        ORA C
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

; The unused RST 6.5 path acknowledges its hardware source and preserves all
; registers.  Normal tester timing comes from SOFTWARE_CLOCK_TICK below.
COIL_TIMER_ISR:
        PUSH PSW
; RST 6.5 is the motherboard's SWITCH_PORT service interrupt.  Reading port 0
; acknowledges the external source.  MAME clears its synthetic line on a
; timer phase, but omitting this read can leave real hardware in an immediate
; interrupt/re-entry storm.
        IN #00
        PUSH B
        PUSH D
        PUSH H
        CALL COIL_TIMER_TICK
        POP H
        POP D
        POP B
        POP PSW
        RET

; Roughly 4.8 ms at the board's believed 1.5 MHz CPU clock.  Exact timing is
; unimportant here; it merely gives the physical outputs human-visible pacing
; without relying on undocumented interrupt-generation hardware.
SOFTWARE_CLOCK_TICK:
        MVI B, #02
SOFTWARE_DELAY_OUTER:
        MVI C, #ff
SOFTWARE_DELAY_INNER:
        DCR C
        JNZ SOFTWARE_DELAY_INNER
        DCR B
        JNZ SOFTWARE_DELAY_OUTER
        CALL POLL_CONTROLS
        CALL COIL_TIMER_TICK
        RET

; Normalize the cabinet controls into right=$20, left=$40, start=$80.
; The flipper hold contacts are on port 4, but Enter Players is auxiliary
; switch 6 on port 0 ($40).  Port 4's physical $80 is not the start button.
READ_TEST_CONTROLS:
        IN #04
        ANI #60
        MOV B,A
        IN #00
        ANI #40
        RLC
        ORA B
        RET

; Preserve both live control state and rising edges.  Start toggles
; automatic/manual mode on its rising edge.
POLL_CONTROLS:
        CALL READ_TEST_CONTROLS
        MOV B,A
        STA CONTROL_CURRENT
        LDA CONTROL_PREVIOUS
        XRA B
        STA CONTROL_CHANGED
        ANA B
        STA CONTROL_EDGES
        MOV A,B
        STA CONTROL_PREVIOUS
        LDA CONTROL_EDGES
        ANI #80
        RZ
        LDA TEST_MODE
        XRI #01
        STA TEST_MODE
        RET

COIL_TIMER_TICK:
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
        RET

; Defensive handler for every interrupt/restart the tester does not use.
; Read both hardware input banks to acknowledge a potentially pending source,
; reset the RST 7.5 latch, and return with maskable interrupts still disabled.
UNEXPECTED_INTERRUPT:
        PUSH PSW
        IN #00
        IN #01
        MVI A, #1d
        SIM
        POP PSW
        DI
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
