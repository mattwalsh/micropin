; Minimal experimental 8085 arbiter.  No game ROM code is used.
; The MAME/Pico host aperture is readable at $3000-$31ff.

; A is the 64-byte host-owned aperture snapshot.  L is its local 8085 copy.
; The first manifest routine uses L+$0a through L+$29 as an exact image of
; the MAME-visible display window, $23c0 through $23df.  L+$2a-$2d holds
; coils; L+$2e and L+$2f hold logical tone pitch and duration.
HOST_APERTURE EQU #3000
HOST_SEQUENCE EQU HOST_APERTURE
CPU_ACK_APERTURE EQU #3001
LOCAL_SNAPSHOT EQU #2200
CPU_SEQUENCE EQU #2240
SWITCH_CPU_SEQUENCE EQU #2241
SWITCH_APERTURE EQU #3040
SWITCH_HOST_ACK EQU #3041
SWITCH_DMA_SOURCE EQU #23e0
SWITCH_DMA_DEST EQU SWITCH_APERTURE+#02
SWITCH_PORT_0_DEST EQU SWITCH_APERTURE+#22
SWITCH_PORT_1_DEST EQU SWITCH_APERTURE+#23
SWITCH_PORT_4_DEST EQU SWITCH_APERTURE+#24
SWITCH_PORT_5_DEST EQU SWITCH_APERTURE+#25
DISPLAY_OFFSET EQU #0a
DISPLAY_WINDOW EQU #23c0
LAMP_OFFSET EQU #02
COIL_OFFSET EQU #2a
TONE_PITCH_OFFSET EQU #2e
TONE_DURATION_OFFSET EQU #2f
TONE_ENABLE_DUR EQU #09
TONE_PITCH EQU #0a

        ORG #0000
        JMP ARB_START

ARB_START:
        DI
        SUB A
        STA CPU_SEQUENCE
        STA CPU_ACK_APERTURE
        STA SWITCH_CPU_SEQUENCE
        STA SWITCH_APERTURE

ARB_LOOP:
; Equality means the one-slot mailbox is empty.  Wait until the host publishes
; a new sequence value, making HOST_SEQUENCE differ from CPU_SEQUENCE.
        LDA HOST_SEQUENCE
        LXI H, CPU_SEQUENCE
        CMP M
        JZ CHECK_SWITCH_OUTPUT

; Copy A -> L while the host is forbidden from modifying A.
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

; The private copy is complete.  Acknowledge its sequence immediately so the
; host can prepare the next A snapshot while we manifest this L snapshot.
        LDA LOCAL_SNAPSHOT
        STA CPU_SEQUENCE
        STA CPU_ACK_APERTURE

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

; Manifest the first 64 host lamp bits through ports 0-4 and $0d-$0f.  The
; board output polarity is active-low, hence CMA before each OUT.  These are
; literal latch values; Python owns any flashing policy.
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

; Manifest 32 coil bits through ports 5-8.  Like lamps, these outputs are
; active-low at the board interface.  This is intentionally level-driven for
; the initial visualization test; the later protocol will add pulse leases.
        LXI H, LOCAL_SNAPSHOT+COIL_OFFSET
        MOV A,M
        CMA
        OUT #05
        INX H
        MOV A,M
        CMA
        OUT #06
        INX H
        MOV A,M
        CMA
        OUT #07
        INX H
        MOV A,M
        CMA
        OUT #08

; Manifest the host's logical pitch and duration through the original sound
; ports.  Both board latches are active-low.  A logical duration of zero is
; our protocol's explicit silence value; raw $fe is the game's normal stop
; command.  Nonzero durations retain the original hardware programming model.
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
        JMP CHECK_SWITCH_OUTPUT
MANIFEST_TONE_DURATION:
        CMA
        OUT TONE_ENABLE_DUR

CHECK_SWITCH_OUTPUT:
; The 8085 is producer in this direction.  If the host has not acknowledged
; the previous switch snapshot, leave it untouched and keep servicing A.
        LDA SWITCH_HOST_ACK
        LXI H, SWITCH_CPU_SEQUENCE
        CMP M
        JNZ ARB_LOOP

; Port 0 advances the existing Micropin/MAME switch scan and presents its raw
; timing/auxiliary byte.  Preserve all four hardware-facing input bytes.
        IN #00
        STA SWITCH_PORT_0_DEST
        IN #01
        STA SWITCH_PORT_1_DEST
        IN #04
        STA SWITCH_PORT_4_DEST
        IN #05
        STA SWITCH_PORT_5_DEST

; Preserve all 32 inductive samples verbatim.  Their current active contact
; indication is bit 7, but the host may later use additional timing detail.
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

; Materialize the whole 5-ROM CPU address image.  Build verifies that the
; physical-ROM-5 gap at $2000-$27ff is zero-filled.
        ORG #3000
