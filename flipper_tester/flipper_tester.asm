; Standalone Micropin Rev. 2 flipper PWM hardware exerciser.
;
; This deliberately contains no game code and enables no interrupts.  Port 4
; is polled for the two physical cabinet buttons and port 6 directly drives
; the two flipper coils.  The output ports are active-low.
;
; Proven ppm_hold mapping:
;   port 4 bit $20 -> port 6 logical bit $10
;   port 4 bit $40 -> port 6 logical bit $20
;
; Each rising edge receives a short 100% pull-in interval.  Thereafter the
; requested coil is PWM-held until its button is released.

BUTTON_PREVIOUS EQU #2200
DESIRED_COILS EQU #2201
PULL_COILS EQU #2202
LEFT_PULL_COUNT EQU #2203
RIGHT_PULL_COUNT EQU #2204
STACK_TOP EQU #23c0

; Timing knobs.  At the believed 1.5 MHz CPU clock these produce roughly a
; 109 Hz carrier at the experimentally selected 41% command duty.  The block
; counts let us stretch both phases beyond an eight-bit delay while preserving
; their ratio.  Scope measurements on the real board are authoritative.
PWM_ON_BLOCKS EQU #02
PWM_ON_COUNT EQU #c0
PWM_OFF_BLOCKS EQU #03
PWM_OFF_COUNT EQU #c0
PULL_IN_CYCLES EQU #07

        ORG #0000
        JMP TEST_START

; Make every restart/vector deterministic even though maskable interrupts are
; disabled.  TRAP cannot be masked, so give it a harmless return path too.
        ORG #0008
        JMP SPURIOUS_INTERRUPT
        ORG #0010
        JMP SPURIOUS_INTERRUPT
        ORG #0018
        JMP SPURIOUS_INTERRUPT
        ORG #0020
        JMP SPURIOUS_INTERRUPT
        ORG #0024
        JMP SPURIOUS_INTERRUPT
        ORG #002c
        JMP SPURIOUS_INTERRUPT
        ORG #0034
        JMP SPURIOUS_INTERRUPT
        ORG #003c
        JMP SPURIOUS_INTERRUPT

        ORG #0040
TEST_START:
        DI
        LXI SP, STACK_TOP

; All coils off before examining any cabinet input.
        MVI A, #ff
        OUT #05
        OUT #06
        OUT #07
        OUT #08

        SUB A
        STA DESIRED_COILS
        STA PULL_COILS
        STA LEFT_PULL_COUNT
        STA RIGHT_PULL_COUNT

; Seed the edge detector from the boot state.  A button held during reset must
; be released and pressed again before it can energize a flipper.
        CALL READ_FLIPPERS
        STA BUTTON_PREVIOUS

PWM_LOOP:
; Start/restart the long on portion using the most recently sampled buttons.
        LDA DESIRED_COILS
        CMA
        OUT #06
        MVI E, PWM_ON_BLOCKS
PWM_ON_BLOCK:
        MVI C, PWM_ON_COUNT
PWM_ON_DELAY:
        DCR C
        JNZ PWM_ON_DELAY
        DCR E
        JNZ PWM_ON_BLOCK

; Input processing occurs while the coils remain on, not during the short off
; notch.  A released button is reflected by the immediately following output.
        CALL UPDATE_FLIPPERS

; During pull-in, PULL_COILS keeps that flipper energized through the nominal
; off phase.  Once its countdown expires, this output creates the PWM notch.
        LDA PULL_COILS
        CMA
        OUT #06
        MVI E, PWM_OFF_BLOCKS
PWM_OFF_BLOCK:
        MVI C, PWM_OFF_COUNT
PWM_OFF_DELAY:
        DCR C
        JNZ PWM_OFF_DELAY
        DCR E
        JNZ PWM_OFF_BLOCK
        JMP PWM_LOOP

; Return desired logical port-6 bits in A from the two port-4 contacts.
READ_FLIPPERS:
        IN #04
        MOV B,A
        MVI C, #00
        ANI #20
        JZ READ_RIGHT_FLIPPER
        MVI C, #10
READ_RIGHT_FLIPPER:
        MOV A,B
        ANI #40
        JZ READ_FLIPPERS_DONE
        MOV A,C
        ORI #20
        MOV C,A
READ_FLIPPERS_DONE:
        MOV A,C
        RET

UPDATE_FLIPPERS:
        CALL READ_FLIPPERS
        MOV B,A

; Rising edges start independent full-power pull-in leases.
        LDA BUTTON_PREVIOUS
        CMA
        ANA B
        MOV D,A
        MOV A,B
        STA DESIRED_COILS
        STA BUTTON_PREVIOUS

        MOV A,D
        ANI #10
        JZ NO_LEFT_EDGE
        MVI A, PULL_IN_CYCLES
        STA LEFT_PULL_COUNT
NO_LEFT_EDGE:
        MOV A,D
        ANI #20
        JZ NO_RIGHT_EDGE
        MVI A, PULL_IN_CYCLES
        STA RIGHT_PULL_COUNT
NO_RIGHT_EDGE:

; Build the set of coils that remain at 100% during this cycle.  ANDing it
; with the current buttons guarantees immediate release even if a pull-in
; countdown has not yet expired.
        MVI C, #00
        LDA LEFT_PULL_COUNT
        ORA A
        JZ LEFT_PULL_DONE
        DCR A
        STA LEFT_PULL_COUNT
        MOV A,C
        ORI #10
        MOV C,A
LEFT_PULL_DONE:
        LDA RIGHT_PULL_COUNT
        ORA A
        JZ RIGHT_PULL_DONE
        DCR A
        STA RIGHT_PULL_COUNT
        MOV A,C
        ORI #20
        MOV C,A
RIGHT_PULL_DONE:
        MOV A,C
        ANA B
        STA PULL_COILS
        RET

SPURIOUS_INTERRUPT:
        DI
        RET

; Materialize exactly four 2 KiB ROM images.  Only ROM 1 contains code.
        ORG #2000
