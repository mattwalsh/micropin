; Host/Pico/8085 round-trip proof using no writable data-bus path.
;
; Host transaction at the Pico-served aperture:
;   $2800 sequence (published last)
;   $2801 Pico acknowledgement of the last complete response frame
;   $2802 payload length, capped here at 32
;   $2803... payload
;   immediately following payload: CRC-8 over sequence, length, and payload,
;   followed by its inverse
;
; Response frame uses address strobes:
;   read $2a00 to start
;   transmit sequence, length, echoed payload, port 0, the RST 5.5-latched
;   Port-1 reflex events, ports 4/5, the 32 raw playfield DMA samples at
;   $23e0-$23ff, and CRC-8 as one read from $2900+byte
;   read $2a01 to finish and acknowledge the host sequence

HOST_SEQUENCE EQU #2800
CPU_ACK EQU #2801
HOST_LENGTH EQU #2802
HOST_PAYLOAD EQU #2803

LOCAL_LENGTH EQU #2202
LOCAL_PAYLOAD EQU #2203
LOCAL_PENDING_SEQUENCE EQU #2223
LOCAL_CRC EQU #2224
LOCAL_LAMP_BYTES EQU #2225
LOCAL_SWITCH_0 EQU #222a
LOCAL_SWITCH_1 EQU #222b
LOCAL_SWITCH_4 EQU #222c
LOCAL_SWITCH_DMA EQU #222d
PREVIOUS_SWITCH_DMA EQU #224d
LOCAL_SWITCH_5 EQU #226d
LOCAL_CRC_COMPLEMENT EQU #226e
REFLEX_EVENT_LATCH EQU #226f
CABINET_EVENT_LATCH EQU #2270
REFLEX_COIL_TIMERS EQU #2271
SWITCH_DMA_SOURCE EQU #23e0
SWITCH_CHANGE_DISPLAY EQU #23d3
MAX_PAYLOAD EQU #20
STACK_TOP EQU #23c0

        ORG #0000
        JMP START

; 8085 TRAP is non-maskable. The original game treats it as a reinitialization
; path, so do the same explicitly; framing and acknowledgement recover any
; response that it interrupted.
        ORG #0024
        JMP START

; Port 1 asserts RST 5.5 for the latency-sensitive bumper, sling, and shared
; standup-bar inputs. Preserve every bit observed between host transactions.
        ORG #002c
        JMP REFLEX_SWITCH_ISR

; Port 0 asserts RST 6.5 for the original game's periodic/internal sources and
; momentary cabinet controls.
        ORG #0034
        JMP CABINET_SWITCH_ISR

        ORG #0040
START:
        DI
        LXI SP, STACK_TOP
; All eight lamp banks are active-low. Start with every output dark, including
; the three banks beyond today's 0-37 lamp test range.
        MVI A,#ff
        OUT #00
        OUT #01
        OUT #02
        OUT #03
        OUT #04
        OUT #0d
        OUT #0e
        OUT #0f
; Coil outputs are also active-low. Keep every mechanism de-energized until a
; reflex event explicitly starts a bounded local lease.
        OUT #05
        OUT #06
        OUT #07
        OUT #08
        XRA A
        STA REFLEX_EVENT_LATCH
        STA CABINET_EVENT_LATCH
        LXI H,REFLEX_COIL_TIMERS
        MVI B,#06
CLEAR_REFLEX_TIMERS:
        MOV M,A
        INX H
        DCR B
        JNZ CLEAR_REFLEX_TIMERS
; Establish a baseline for the raw inductive samples. Subsequent transactions
; ignore normal low-nibble measurement jitter and display the highest-numbered
; contact whose $10 state bit changed as three hex byte pairs: contact number
; (01-20), new sample, previous sample. A clear $10 bit means ball present.
        LXI H,SWITCH_DMA_SOURCE
        LXI D,PREVIOUS_SWITCH_DMA
        MVI B,#20
INITIALIZE_SWITCH_BASELINE:
        MOV A,M
        STAX D
        INX H
        INX D
        DCR B
        JNZ INITIALIZE_SWITCH_BASELINE
; Acknowledge stale sources, then unmask RST 5.5 and RST 6.5 while leaving
; RST 7.5 masked. As in the original game, an interrupt leaves maskable
; interrupts disabled until the main loop explicitly opens its next window.
        IN #01
        IN #00
        MVI A,#0c
        SIM
READ_INITIAL_ACK:
        LDA CPU_ACK
        MOV B,A
        LDA CPU_ACK
        CMP B
        JNZ READ_INITIAL_ACK
        MOV C,A

POLL_HOST:
; Open one bounded interrupt window per poll. EI takes effect after NOP; an ISR
; returns with interrupts disabled, and DI also closes the no-interrupt path.
        EI
        NOP
        DI
        LDA HOST_SEQUENCE
        MOV B,A
        LDA HOST_SEQUENCE
        CMP B
        JNZ POLL_HOST
        CMP C
        JNZ RECEIVE_HOST_TRANSACTION
        JMP POLL_HOST

RECEIVE_HOST_TRANSACTION:
        MOV A,B
        STA LOCAL_PENDING_SEQUENCE

        LDA HOST_LENGTH
        CPI MAX_PAYLOAD+#01
        JC LENGTH_OK
        MVI A, MAX_PAYLOAD
LENGTH_OK:
        STA LOCAL_LENGTH
        ORA A
        JZ VALIDATE_HOST_TRANSACTION

        MOV B,A
        LXI H, HOST_PAYLOAD
        LXI D, LOCAL_PAYLOAD
COPY_PAYLOAD:
        MOV A,M
        STAX D
        INX H
        INX D
        DCR B
        JNZ COPY_PAYLOAD

VALIDATE_HOST_TRANSACTION:
; Validate the host's CRC before accepting its sequence. If an aperture read
; was corrupted, retry the unchanged mailbox instead of acknowledging it.
        MVI D,#00
        LDA LOCAL_PENDING_SEQUENCE
        CALL CRC_UPDATE
        LDA LOCAL_LENGTH
        CALL CRC_UPDATE
        LDA LOCAL_LENGTH
        ORA A
        JZ COMPARE_HOST_CRC
        MOV B,A
        LXI H,LOCAL_PAYLOAD
CRC_HOST_PAYLOAD:
        MOV A,M
        CALL CRC_UPDATE
        INX H
        DCR B
        JNZ CRC_HOST_PAYLOAD

COMPARE_HOST_CRC:
        MOV A,D
        STA LOCAL_CRC
        CMA
        STA LOCAL_CRC_COMPLEMENT
        LXI H,HOST_PAYLOAD
        LDA LOCAL_LENGTH
        MOV E,A
        MVI D,#00
        DAD D
        MOV A,M
        LXI H,LOCAL_CRC
        CMP M
        JNZ POLL_HOST
        LXI H,HOST_PAYLOAD
        LDA LOCAL_LENGTH
        MOV E,A
        MVI D,#00
        DAD D
        INX H
        MOV A,M
        LXI H,LOCAL_CRC_COMPLEMENT
        CMP M
        JNZ POLL_HOST

; Read the complete published transaction a second time before acting on it.
; The Pico publishes sequence last, but a marginal aperture bus read has on
; rare occasions combined a new sequence with the preceding payload. CRC-8
; normally rejects that; this byte-for-byte second pass makes acceptance
; independent of a lucky checksum/read error.
VERIFY_HOST_SEQUENCE:
        LDA HOST_SEQUENCE
        MOV B,A
        LDA HOST_SEQUENCE
        CMP B
        JNZ VERIFY_HOST_SEQUENCE
        LXI H,LOCAL_PENDING_SEQUENCE
        CMP M
        JNZ POLL_HOST
VERIFY_HOST_LENGTH:
        LDA HOST_LENGTH
        MOV B,A
        LDA HOST_LENGTH
        CMP B
        JNZ VERIFY_HOST_LENGTH
        LXI H,LOCAL_LENGTH
        CMP M
        JNZ POLL_HOST
        ORA A
        JZ VERIFY_HOST_CRC_AGAIN
        MOV B,A
        LXI H,HOST_PAYLOAD
        LXI D,LOCAL_PAYLOAD
VERIFY_HOST_PAYLOAD:
        MOV A,M
        XCHG
        CMP M
        XCHG
        JNZ POLL_HOST
        INX H
        INX D
        DCR B
        JNZ VERIFY_HOST_PAYLOAD
VERIFY_HOST_CRC_AGAIN:
        LXI H,HOST_PAYLOAD
        LDA LOCAL_LENGTH
        MOV E,A
        MVI D,#00
        DAD D
        MOV A,M
        LXI H,LOCAL_CRC
        CMP M
        JNZ POLL_HOST
        LXI H,HOST_PAYLOAD
        LDA LOCAL_LENGTH
        MOV E,A
        MVI D,#00
        DAD D
        INX H
        MOV A,M
        LXI H,LOCAL_CRC_COMPLEMENT
        CMP M
        JNZ POLL_HOST

        CALL MANIFEST_LAMP_COMMAND
; Capture one coherent input snapshot for this transaction. Retransmissions
; reuse these bytes rather than changing the response underneath its sequence.
; Atomically consume the Port-0 and Port-1 events accumulated by their ISRs.
        DI
        LDA CABINET_EVENT_LATCH
        STA LOCAL_SWITCH_0
        XRA A
        STA CABINET_EVENT_LATCH
        LDA REFLEX_EVENT_LATCH
        STA LOCAL_SWITCH_1
        XRA A
        STA REFLEX_EVENT_LATCH
        IN #04
        STA LOCAL_SWITCH_4
        IN #05
        STA LOCAL_SWITCH_5
        LXI H,SWITCH_DMA_SOURCE
        LXI D,LOCAL_SWITCH_DMA
        MVI B,#20
CAPTURE_SWITCH_DMA:
        MOV A,M
        STAX D
        INX H
        INX D
        DCR B
        JNZ CAPTURE_SWITCH_DMA
        CALL DISPLAY_SWITCH_CHANGE
        LDA LOCAL_PENDING_SEQUENCE
        MOV C,A

TRANSMIT_RESPONSE:
        LDA #2a00
        MVI D,#00
        MOV A,C
        CALL SEND_BYTE
        LDA LOCAL_LENGTH
        ADI #24
        CALL SEND_BYTE

        LDA LOCAL_LENGTH
        ORA A
        JZ SEND_SWITCH_SNAPSHOT
        MOV B,A
        LXI H, LOCAL_PAYLOAD
SEND_PAYLOAD:
        MOV A,M
        CALL SEND_BYTE
        INX H
        DCR B
        JNZ SEND_PAYLOAD

SEND_SWITCH_SNAPSHOT:
        LDA LOCAL_SWITCH_0
        CALL SEND_BYTE
        LDA LOCAL_SWITCH_1
        CALL SEND_BYTE
        LDA LOCAL_SWITCH_4
        CALL SEND_BYTE
        LDA LOCAL_SWITCH_5
        CALL SEND_BYTE
        MVI B,#20
        LXI H,LOCAL_SWITCH_DMA
SEND_SWITCH_DMA:
        MOV A,M
        CALL SEND_BYTE
        INX H
        DCR B
        JNZ SEND_SWITCH_DMA

FINISH_RESPONSE:
        MOV A,D
        CALL SEND_RAW_BYTE
        LDA #2a01

; The host cannot publish another sequence until the Pico has accepted this
; response. Thus an advanced HOST_SEQUENCE proves acknowledgement without a
; timing-sensitive CPU_ACK read. While it remains unchanged, retransmit; the
; Pico deduplicates already accepted frames.
WAIT_FOR_NEXT_OR_RETRY:
        MVI E,#ff
WAIT_FOR_NEXT_SEQUENCE:
        LDA HOST_SEQUENCE
        MOV B,A
        LDA HOST_SEQUENCE
        CMP B
        JNZ WAIT_FOR_NEXT_SEQUENCE
        CMP C
        JNZ RECEIVE_HOST_TRANSACTION
        DCR E
        JNZ WAIT_FOR_NEXT_SEQUENCE
        JMP TRANSMIT_RESPONSE

; RST 6.5 uses the same priority/acknowledge shape as the reflex handler, but
; reads Port 0 and acknowledges the selected source through output port $0d.
CABINET_SWITCH_ISR:
        PUSH PSW
        PUSH B
        PUSH D
        PUSH H
; RST 6.5 itself is the coil-expiration cadence. Do this on every entry rather
; than only when Port-0 bit zero happens to be the selected pending source.
        CALL REFLEX_TIMER_TICK
        IN #00
        ORA A
        JZ CABINET_SWITCH_DONE
        MVI B,#00
FIND_CABINET_BIT:
        RAR
        JC CABINET_BIT_FOUND
        INR B
        JMP FIND_CABINET_BIT
CABINET_BIT_FOUND:
        MOV A,B
        CMA
        OUT #0d

        MVI C,#01
        MOV A,B
        ORA A
        JZ CABINET_MASK_READY
BUILD_CABINET_MASK:
        MOV A,C
        RLC
        MOV C,A
        DCR B
        JNZ BUILD_CABINET_MASK
CABINET_MASK_READY:
        MOV A,C
        LXI H,CABINET_EVENT_LATCH
        ORA M
        MOV M,A
; Display 65, accumulated event mask, 00 for a Port-0/RST-6.5 event.
        STA SWITCH_CHANGE_DISPLAY+#01
        MVI A,#65
        STA SWITCH_CHANGE_DISPLAY
        XRA A
        STA SWITCH_CHANGE_DISPLAY+#02
CABINET_SWITCH_DONE:
        POP H
        POP D
        POP B
        POP PSW
        RET

; RST 5.5 is generated by the dedicated fast-switch hardware. The original
; game selects only the lowest asserted Port-1 bit, then writes the inverse of
; its bit number to port $0e before dispatch. Preserve that hardware handshake
; while replacing the dispatch with a one-hot event latch for the host.
REFLEX_SWITCH_ISR:
        PUSH PSW
        PUSH B
        PUSH D
        PUSH H
        IN #01
        ORA A
        JZ REFLEX_SWITCH_DONE
        MVI B,#00
FIND_REFLEX_BIT:
        RAR
        JC REFLEX_BIT_FOUND
        INR B
        JMP FIND_REFLEX_BIT
REFLEX_BIT_FOUND:
; This seemingly lamp-like write is present in the original RST 5.5 handler
; and appears necessary to acknowledge or advance the fast-switch hardware.
        MOV A,B
        CMA
        OUT #0e
        CALL FIRE_REFLEX_COIL

; Convert the selected bit number back to a one-hot event mask.
        MVI C,#01
        MOV A,B
        ORA A
        JZ REFLEX_MASK_READY
BUILD_REFLEX_MASK:
        MOV A,C
        RLC
        MOV C,A
        DCR B
        JNZ BUILD_REFLEX_MASK
REFLEX_MASK_READY:
        MOV A,C
        LXI H,REFLEX_EVENT_LATCH
        ORA M
        MOV M,A
; Make a reflex event visible without a host: 55, accumulated event mask, 00.
        STA SWITCH_CHANGE_DISPLAY+#01
        MVI A,#55
        STA SWITCH_CHANGE_DISPLAY
        XRA A
        STA SWITCH_CHANGE_DISPLAY+#02
REFLEX_SWITCH_DONE:
        POP H
        POP D
        POP B
        POP PSW
        RET

; Port-1 bits 0-5 map to the six direct-action bumper/slingshot coils. Bit 6
; is the common standup bar and deliberately remains a host-only event.
; A nonzero timer is never renewed, so a stuck or bouncing input cannot extend
; one pulse indefinitely.
FIRE_REFLEX_COIL:
        MOV A,B
        CPI #06
        RNC
        MOV E,A
        MVI D,#00
        LXI H,REFLEX_COIL_TIMERS
        DAD D
        MOV A,M
        ORA A
        RNZ
        MVI M,#09
        CALL WRITE_REFLEX_COILS
        RET

REFLEX_TIMER_TICK:
        LXI H,REFLEX_COIL_TIMERS
        MVI B,#06
DECREMENT_REFLEX_TIMER:
        MOV A,M
        ORA A
        JZ NEXT_REFLEX_TIMER
        DCR M
NEXT_REFLEX_TIMER:
        INX H
        DCR B
        JNZ DECREMENT_REFLEX_TIMER
        CALL WRITE_REFLEX_COILS
        RET

; Build active-high logical state from the six timers, then complement it for
; the motherboard's active-low coil ports. Mapping from the original vectors:
;   Port-1 bit 0 -> coil 11 -> port 6 bit 3
;   Port-1 bit 1 -> coil 16 -> port 7 bit 0
;   Port-1 bit 2 -> coil 17 -> port 7 bit 1
;   Port-1 bit 3 -> coil 10 -> port 6 bit 2
;   Port-1 bit 4 -> coil 19 -> port 7 bit 3
;   Port-1 bit 5 -> coil 20 -> port 7 bit 4
WRITE_REFLEX_COILS:
        MVI C,#00
        MVI D,#00
        LXI H,REFLEX_COIL_TIMERS

        MOV A,M
        ORA A
        JZ REFLEX_COIL_1
        MVI A,#08
        ORA C
        MOV C,A
REFLEX_COIL_1:
        INX H
        MOV A,M
        ORA A
        JZ REFLEX_COIL_2
        MVI A,#01
        ORA D
        MOV D,A
REFLEX_COIL_2:
        INX H
        MOV A,M
        ORA A
        JZ REFLEX_COIL_3
        MVI A,#02
        ORA D
        MOV D,A
REFLEX_COIL_3:
        INX H
        MOV A,M
        ORA A
        JZ REFLEX_COIL_4
        MVI A,#04
        ORA C
        MOV C,A
REFLEX_COIL_4:
        INX H
        MOV A,M
        ORA A
        JZ REFLEX_COIL_5
        MVI A,#08
        ORA D
        MOV D,A
REFLEX_COIL_5:
        INX H
        MOV A,M
        ORA A
        JZ REFLEX_COILS_READY
        MVI A,#10
        ORA D
        MOV D,A
REFLEX_COILS_READY:
        MOV A,C
        CMA
        OUT #06
        MOV A,D
        CMA
        OUT #07
        RET

; Mirror playfield contact transitions onto the high-score display. Real-game
; measurements show low-nibble timing jitter while bit $10 cleanly distinguishes
; open from ball-present. If several contacts change together, the highest one
; remains visible.
DISPLAY_SWITCH_CHANGE:
        LXI H,LOCAL_SWITCH_DMA
        LXI D,PREVIOUS_SWITCH_DMA
        MVI B,#20
        MVI C,#01
CHECK_SWITCH_CHANGE:
        LDAX D
        XRA M
        ANI #10
        JZ UPDATE_PREVIOUS_SWITCH
        LDAX D
        STA SWITCH_CHANGE_DISPLAY+#02
        MOV A,M
        STA SWITCH_CHANGE_DISPLAY+#01
        MOV A,C
        STA SWITCH_CHANGE_DISPLAY
UPDATE_PREVIOUS_SWITCH:
        MOV A,M
        STAX D
        INX H
        INX D
        INR C
        DCR B
        JNZ CHECK_SWITCH_CHANGE
        RET

; Add A to CRC-8 D, then send it as one observable read while preserving the
; caller's HL, B, and original A value until the raw transmitter receives it.
SEND_BYTE:
        PUSH PSW
        CALL CRC_UPDATE
        POP PSW
        JMP SEND_RAW_BYTE

; Update CRC-8/ATM D with A, preserving B. A is scratch on return.
CRC_UPDATE:
        XRA D
        MOV D,A
        PUSH B
        MVI B,#08
CRC_BIT:
        MOV A,D
        ADD A
        MOV D,A
        JNC CRC_NO_POLY
        XRI #07
        MOV D,A
CRC_NO_POLY:
        DCR B
        JNZ CRC_BIT
        POP B
        RET

SEND_RAW_BYTE:
        PUSH H
        MOV L,A
        MVI H,#29
; The old two-nibble encoder incidentally left substantial ROM-fetch time
; between observable CE4 reads. Preserve a modest gap so the Pico can finish
; parsing one address before the next strobe arrives. These fetches do not add
; any events to the protocol and are negligible beside USB round-trip time.
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        MOV A,M
        POP H
        RET

; Payload byte zero through 37 selects one lamp. Values outside that range
; clear all lamps. Outputs are one-hot in software and active-low on the board.
MANIFEST_LAMP_COMMAND:
        PUSH B
        PUSH D
        PUSH H

        LXI H,LOCAL_LAMP_BYTES
        MVI B,#05
        XRA A
CLEAR_LOCAL_LAMPS:
        MOV M,A
        INX H
        DCR B
        JNZ CLEAR_LOCAL_LAMPS

        LDA LOCAL_LENGTH
        ORA A
        JZ OUTPUT_LOCAL_LAMPS
        LDA LOCAL_PAYLOAD
        CPI #26
        JNC OUTPUT_LOCAL_LAMPS

        MOV E,A
        ANI #07
        MOV C,A
        ORA A
        MVI A,#01
        JZ LAMP_MASK_READY
BUILD_LAMP_MASK:
        RLC
        DCR C
        JNZ BUILD_LAMP_MASK
LAMP_MASK_READY:
        MOV D,A

        MOV A,E
        RRC
        RRC
        RRC
        ANI #07
        MOV E,A
        LXI H,LOCAL_LAMP_BYTES
        MOV A,L
        ADD E
        MOV L,A
        MOV M,D

OUTPUT_LOCAL_LAMPS:
        LXI H,LOCAL_LAMP_BYTES
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

        POP H
        POP D
        POP B
        RET

        ORG #2000
