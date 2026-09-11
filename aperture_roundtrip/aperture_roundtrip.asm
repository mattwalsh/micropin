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
;   read $28e0 to start
;   transmit sequence, length, echoed payload, port 0, the RST 5.5-latched
;   Port-1 reflex events, cabinet Port 4, one reserved byte, the 32 raw
;   playfield DMA samples at
;   $23e0-$23ff, and CRC-8 as paired high/low-nibble reads from
;   $28c0+nibble and $28d0+nibble
;   read $28e1 to finish and acknowledge the host sequence

HOST_SEQUENCE EQU #2800
CPU_ACK EQU #2801
HOST_LENGTH EQU #2802
HOST_PAYLOAD EQU #2803

; Diagnostic shadows placed at locations used as ordinary state by the original
; ROM ($2191 CONTROL_FLAGS and $2192 GAME_STATE2). Real-hardware tests show that
; even $2192 sometimes changes after a store, so neither byte is trusted as the
; authority for reflex-coil safety; the 8085's RST 5.5 mask is authoritative.
REFLEX_ENABLED EQU #2191
REFLEX_PRECOMMAND EQU #2192
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
CUP_COIL_TIMERS EQU #2277
CUP_COMMAND_BYTE EQU #227d
PREVIOUS_CUP_COMMAND EQU #227f
DISCARD_BOOT_COMMAND EQU #2280
TRAP_COUNT EQU #2281
RESET_COUNT EQU #2282
SWITCH_DMA_SOURCE EQU #23e0
SWITCH_CHANGE_DISPLAY EQU #23d3
MAX_PAYLOAD EQU #20
STACK_TOP EQU #23c0

        ORG #0000
        JMP RESET_ENTRY

; 8085 TRAP is non-maskable. The real board asserts it repeatedly, so treating
; every occurrence as cold initialization destroys the arbiter's state. Count
; it visibly while preserving PSW, then return to the interrupted work.
        ORG #0024
        JMP TRAP_ENTRY

; Port 1 asserts RST 5.5 for the latency-sensitive bumper, sling, and shared
; standup-bar inputs. Preserve every bit observed between host transactions.
        ORG #002c
        JMP REFLEX_SWITCH_ISR

; Port 0 asserts RST 6.5 for the original game's periodic/internal sources and
; momentary cabinet controls.
        ORG #0034
        JMP CABINET_SWITCH_ISR

        ORG #0040
RESET_ENTRY:
        DI
        LXI SP,STACK_TOP
; Preserve one retained byte across our deliberate full-RAM clear. Its absolute
; value after the very first installation is unimportant; every subsequent
; genuine RESET entry increments it, while TRAP does not.
        LDA RESET_COUNT
        ADI #01
        DAA
        MOV C,A
; Visible cold-entry witness, deliberately confined to the reset vector so a
; TRAP cannot restart the delay. De-energize every coil first, light lamp output
; 13 (cup #5) for roughly 0.26 s at 1.5 MHz, then proceed to normal START.
        MVI A,#ff
        OUT #05
        OUT #06
        OUT #07
        OUT #08
        OUT #00
        OUT #01
        OUT #02
        OUT #03
        OUT #04
        MVI A,#df
        OUT #01
        LXI D,#4000
RESET_WITNESS_DELAY:
        DCX D
        MOV A,D
        ORA E
        JNZ RESET_WITNESS_DELAY
        MVI A,#ff
        OUT #01
        JMP START

TRAP_ENTRY:
        PUSH PSW
        LDA TRAP_COUNT
        ADI #01
        DAA
        STA TRAP_COUNT
        STA SWITCH_CHANGE_DISPLAY+#01
        POP PSW
        RET

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
; Match the original initialization reached from both reset and TRAP ($0069).
; Ports $0d/$0e also acknowledge the two interrupt-source encoders, so walking
; their selector values from seven through zero may reset more than lamp state.
        MVI A,#07
RESET_INTERRUPT_ENCODERS:
        OUT #0e
        OUT #0d
        DCR A
        JP RESET_INTERRUPT_ENCODERS
; The original motherboard retains the entire 1 KiB RAM image. Never trust it
; across reset: interrupted writes and previous experimental state can leave
; both ordinary variables and output state inconsistent. Coils are already off
; and interrupts remain disabled, so clearing through the future stack area is
; safe here (nothing has been pushed yet).
        LXI H,#2000
        MVI B,#04
        XRA A
CLEAR_RAM_PAGE:
        MOV M,A
        INR L
        JNZ CLEAR_RAM_PAGE
        INR H
        DCR B
        JNZ CLEAR_RAM_PAGE

; The full clear deliberately erases the old diagnostic and RESET_COUNT. Restore
; the count carried in C. In RAM-byte order this is 01 TT RR; the physical
; display presents those bytes as RR TT 01: retained genuine-reset count,
; TRAP count since this reset, and a fixed marker.
        MOV A,C
        STA SWITCH_CHANGE_DISPLAY+#02
        STA RESET_COUNT
        XRA A
        STA TRAP_COUNT
        STA SWITCH_CHANGE_DISPLAY+#01
        MVI A,#01
        STA SWITCH_CHANGE_DISPLAY
        XRA A

        STA REFLEX_EVENT_LATCH
        STA CABINET_EVENT_LATCH
        STA PREVIOUS_CUP_COMMAND
        LXI H,REFLEX_COIL_TIMERS
        MVI B,#0c
CLEAR_LOCAL_COIL_TIMERS:
        MOV M,A
        INX H
        DCR B
        JNZ CLEAR_LOCAL_COIL_TIMERS
; Local reflexes are enabled by default for the present de-ablation test.
; This lets the six bumper/slingshot paths run without a host connection while
; cup and host-commanded coils remain disabled. A later validated host command
; may still inhibit them.
        MVI A,#01
        STA REFLEX_ENABLED
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
; RST 7.5 masked. RST 5.5 drives the six local reflex coils; RST 6.5 supplies
; their bounded expiration cadence.
        IN #01
        IN #00
        MVI A,#0c
        SIM
; One-way host-to-8085 diagnostic mode. Adopt the current sequence as the
; baseline so retained pre-reset data is ignored. Only a later host update is
; acted upon; there is deliberately no CPU acknowledgement or response.
READ_INITIAL_HOST_SEQUENCE:
        LDA HOST_SEQUENCE
        MOV B,A
        LDA HOST_SEQUENCE
        CMP B
        JNZ READ_INITIAL_HOST_SEQUENCE
        MOV C,A
        JMP POLL_HOST

POLL_HOST:
; Do not hammer the physical CE4 aperture at the maximum 8085 bus rate while
; idle. The Pico must also satisfy timing-critical instruction fetches from the
; four ROM chip selects. About 128 short loop iterations gives roughly a 1 ms
; mailbox cadence at 1.5 MHz, still far faster than the USB host round trip.
        MVI A,#80
IDLE_POLL_DELAY:
        DCR A
        JNZ IDLE_POLL_DELAY
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

; Echo de-ablation test: manifest byte zero as a lamp selector, then return
; only the validated sequence, length and payload. Switch capture and the
; 8085-side acknowledgement/retry handshake remain out of the active path.
        CALL MANIFEST_LAMP_COMMAND
        LDA LOCAL_PENDING_SEQUENCE
        MOV C,A
        JMP TRANSMIT_RESPONSE

; Retained temporarily for comparison, but unreachable in this build.
CAPTURE_HOST_RESPONSE:
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
; Cabinet controls do not need interrupt latency; sample Port 4 once per host
; transaction. Port 5 contains DIP switches and is intentionally omitted in
; aperture mode. Keep one reserved zero byte so the established 36-byte switch
; trailer and its host parsers remain stable.
        IN #04
        STA LOCAL_SWITCH_4
        XRA A
        STA LOCAL_SWITCH_5
; Keep the timing-sensitive response transmitter at its previously tested ROM
; addresses. Replacing LDA+RIM with IN+XRA made this block one byte shorter.
        NOP
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
        LDA LOCAL_PENDING_SEQUENCE
        MOV C,A

TRANSMIT_RESPONSE:
        LDA #28e0
        MVI D,#00
        MOV A,C
        CALL SEND_BYTE
        LDA LOCAL_LENGTH
        CALL SEND_BYTE

        LDA LOCAL_LENGTH
        ORA A
        JZ FINISH_RESPONSE
        MOV B,A
        LXI H, LOCAL_PAYLOAD
SEND_PAYLOAD:
        MOV A,M
        CALL SEND_BYTE
        INX H
        DCR B
        JNZ SEND_PAYLOAD
        JMP FINISH_RESPONSE

; Retained temporarily for comparison, but unreachable in the echo-only test.
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
        LDA #28e1
        JMP POLL_HOST

; Retained temporarily for comparison, but unreachable in the echo-only test.
WAIT_FOR_NEXT_OR_RETRY:
        MVI E,#ff
WAIT_FOR_NEXT_SEQUENCE:
        MVI A,#80
RESPONSE_POLL_DELAY:
        DCR A
        JNZ RESPONSE_POLL_DELAY
; Host traffic must not starve the real-time switch handlers. The first version
; reached this loop after a response with interrupts still disabled, making
; reflexes weak while the client was active and leaving them that way after a
; disconnected client. Open the same one-instruction interrupt window used by
; POLL_HOST before each stable sequence probe.
        EI
        NOP
        DI
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
; Port-0 bit zero is the board's periodic source and supplies the expiration
; cadence. Acknowledge it before doing the timer work, and do not burden the
; higher-priority RST 6.5 path for DMA/cabinet events with a timer scan.
        MOV A,B
        ORA A
        JNZ CABINET_TIMER_DONE
        CALL REFLEX_TIMER_TICK
CABINET_TIMER_DONE:

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
; RST 5.5's mask bit inside the 8085 is the authoritative reflex-enable state.
; Do not trust motherboard RAM for this safety decision.
        RIM
        ANI #01
        RNZ
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
        CALL WRITE_LOCAL_COILS
        RET

REFLEX_TIMER_TICK:
        LXI H,REFLEX_COIL_TIMERS
        MVI B,#0c
DECREMENT_LOCAL_COIL_TIMER:
        MOV A,M
        ORA A
        JZ NEXT_LOCAL_COIL_TIMER
        DCR M
NEXT_LOCAL_COIL_TIMER:
        INX H
        DCR B
        JNZ DECREMENT_LOCAL_COIL_TIMER
        CALL WRITE_LOCAL_COILS
        RET

; Build active-high logical state from the local timers, then complement it for
; the motherboard's active-low coil ports. Reflex mapping from the ROM vectors:
;   Port-1 bit 0 -> coil 11 -> port 6 bit 3
;   Port-1 bit 1 -> coil 16 -> port 7 bit 0
;   Port-1 bit 2 -> coil 17 -> port 7 bit 1
;   Port-1 bit 3 -> coil 10 -> port 6 bit 2
;   Port-1 bit 4 -> coil 19 -> port 7 bit 3
;   Port-1 bit 5 -> coil 20 -> port 7 bit 4
WRITE_LOCAL_COILS:
        PUSH B
        MVI B,#00
        MVI C,#00
        MVI D,#00
        MVI E,#00
        LXI H,REFLEX_COIL_TIMERS

; Enforce the internal RST 5.5 mask again at the final hardware-output boundary.
        RIM
        ANI #01
        JNZ READ_CUP_COILS

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
        JZ READ_CUP_COILS
        MVI A,#10
        ORA D
        MOV D,A
READ_CUP_COILS:
; The five main cups use outputs 3, 21, 2, 0 and 1. The separate side bonus
; payout cup uses output 25 (port 8 bit 1).
; TEMPORARY DIAGNOSTIC: keep every cup output hard-off while isolating the
; reflex-enable path on real hardware. The retained cup implementation below
; can be restored once the inhibit indicator test explains the weak kicks.
        JMP LOCAL_COILS_READY
        LXI H,CUP_COIL_TIMERS
        MOV A,M
        ORA A
        JZ CUP_COIL_2
        MVI A,#08
        ORA E
        MOV E,A
CUP_COIL_2:
        INX H
        MOV A,M
        ORA A
        JZ CUP_COIL_3
        MVI A,#20
        ORA D
        MOV D,A
CUP_COIL_3:
        INX H
        MOV A,M
        ORA A
        JZ CUP_COIL_4
        MVI A,#04
        ORA E
        MOV E,A
CUP_COIL_4:
        INX H
        MOV A,M
        ORA A
        JZ CUP_COIL_5
        MVI A,#01
        ORA E
        MOV E,A
CUP_COIL_5:
        INX H
        MOV A,M
        ORA A
        JZ SIDE_CUP_COIL
        MVI A,#02
        ORA E
        MOV E,A
SIDE_CUP_COIL:
        INX H
        MOV A,M
        ORA A
        JZ LOCAL_COILS_READY
        MVI A,#02
        ORA B
        MOV B,A
LOCAL_COILS_READY:
        MOV A,E
        CMA
        OUT #05
        MOV A,C
        CMA
        OUT #06
        MOV A,D
        CMA
        OUT #07
        MOV A,B
        CMA
        OUT #08
        POP B
        RET

; Add A to CRC-8 D, then send it as two observable reads while preserving the
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

; Optional extended command bytes retain compatibility with the one-byte lamp
; exerciser. Byte 1 bit 0 enables local reflex firing. Byte 2 bits 0-5 request
; the five main-cup ejects plus the side bonus payout cup; only rising edges
; start non-renewing bounded pulses.
MANIFEST_CONTROL_COMMANDS:
        PUSH B
        PUSH D
        PUSH H

        LDA LOCAL_LENGTH
        CPI #02
        JC NO_CONTROL_COMMAND
        LDA REFLEX_ENABLED
        STA REFLEX_PRECOMMAND
        LDA LOCAL_PAYLOAD+#01
        ANI #01
        STA REFLEX_ENABLED
; MSE=1 and M7.5=1 in both values. Bit zero masks RST 5.5 only when local
; reflexes are inhibited; RST 6.5 remains available for timing and controls.
        ORA A
        MVI A,#0d
        JZ STORE_REFLEX_INTERRUPT_MASK
        MVI A,#0c
STORE_REFLEX_INTERRUPT_MASK:
        SIM
        RIM
        ANI #01
        JZ CHECK_CUP_COMMAND
; Tilt/inhibit cancels active reflex pulses immediately, but deliberately does
; not disturb cup ejectors or other host-owned non-reflex mechanisms.
        LXI H,REFLEX_COIL_TIMERS
        MVI B,#06
        XRA A
CANCEL_REFLEX_TIMERS:
        MOV M,A
        INX H
        DCR B
        JNZ CANCEL_REFLEX_TIMERS
        CALL WRITE_LOCAL_COILS

CHECK_CUP_COMMAND:
        LDA LOCAL_LENGTH
        CPI #03
        JNC HAVE_CUP_COMMAND
NO_CONTROL_COMMAND:
        XRA A
        STA PREVIOUS_CUP_COMMAND
        JMP CONTROL_COMMAND_DONE

HAVE_CUP_COMMAND:
        LDA LOCAL_PAYLOAD+#02
        ANI #3f
        STA CUP_COMMAND_BYTE
        LXI H,PREVIOUS_CUP_COMMAND
        MOV B,M
        MOV M,A
        MOV A,B
        CMA
        MOV B,A
        LDA CUP_COMMAND_BYTE
        ANA B
        STA CUP_COMMAND_BYTE

        LXI H,CUP_COIL_TIMERS
        MVI B,#06
        MVI C,#01
START_CUP_TIMERS:
        LDA CUP_COMMAND_BYTE
        ANA C
        JZ NEXT_CUP_TIMER
        MOV A,M
        ORA A
        JNZ NEXT_CUP_TIMER
        MVI M,#09
NEXT_CUP_TIMER:
        INX H
        MOV A,C
        RLC
        MOV C,A
        DCR B
        JNZ START_CUP_TIMERS
        CALL WRITE_LOCAL_COILS

CONTROL_COMMAND_DONE:
        POP H
        POP D
        POP B
        RET

        ORG #2000
