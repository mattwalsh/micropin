; Minimal experimental 8085 arbiter.  No game ROM code is used.
; The MAME/Pico host aperture is readable at $3000-$31ff.

; A is the 64-byte host-owned aperture snapshot.  L is its local 8085 copy.
; The first manifest routine uses L+$0a through L+$29 as an exact image of
; the MAME-visible display window, $23c0 through $23df.
HOST_APERTURE EQU #3000
LOCAL_SNAPSHOT EQU #2200
DISPLAY_OFFSET EQU #0a
DISPLAY_WINDOW EQU #23c0
LAMP_OFFSET EQU #02
COIL_OFFSET EQU #2a

        ORG #0000
        JMP ARB_START

ARB_START:
        DI

ARB_LOOP:
; Copy A -> L.  This will become conditional on sequence counters once the
; mailbox protocol is added; for now it deliberately copies every loop.
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

; Manifest the first 64 host lamp bits through ports 0-4 and $0d-$0f.  The board output
; polarity is active-low, hence CMA before each OUT.  Rewriting port 0 on
; every loop alternates MAME's two scan pages with the same values, yielding
; steady lamps; Python will later own any flashing policy.
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
        JMP ARB_LOOP

; Materialize the whole 5-ROM CPU address image.  Build verifies that the
; physical-ROM-5 gap at $2000-$27ff is zero-filled.
        ORG #3000
