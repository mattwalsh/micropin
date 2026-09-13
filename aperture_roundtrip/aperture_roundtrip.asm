; Host/Pico/8085 round-trip proof using no writable data-bus path.
;
; Host transaction at the Pico-served aperture:
;   $2800 sequence (published last)
;   $2801 Pico acknowledgement of the last complete response frame
;   $2802 payload length, capped here at 64
;   $2803... payload
;   immediately following payload: CRC-8 over sequence, length, and payload,
;   followed by its inverse
;
; Response frame uses address strobes:
;   read $28e0 to start
;   transmit sequence, length, echoed payload, port 0, the RST 5.5-latched
;   Port-1 reflex events, cabinet Port 4, latched rollover edges, the 32 raw
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
LOCAL_PENDING_SEQUENCE EQU #2243
LOCAL_CRC EQU #2244
LOCAL_LAMP_BYTES EQU #2245
LOCAL_SWITCH_0 EQU #224a
LOCAL_SWITCH_1 EQU #224b
LOCAL_SWITCH_4 EQU #224c
LOCAL_SWITCH_DMA EQU #224d
PREVIOUS_SWITCH_DMA EQU #226d
LOCAL_SWITCH_5 EQU #228d
LOCAL_CRC_COMPLEMENT EQU #228e
REFLEX_EVENT_LATCH EQU #228f
CABINET_EVENT_LATCH EQU #2290
REFLEX_COIL_TIMERS EQU #2291
CUP_COIL_TIMERS EQU #2297
CUP_COMMAND_BYTE EQU #229d
PREVIOUS_CUP_COMMAND EQU #229f
DISCARD_BOOT_COMMAND EQU #22a0
TRAP_COUNT EQU #22a1
RESET_COUNT EQU #22a2
FLIPPER_COIL_TIMERS EQU #22a3
LAUNCHER_COIL_TIMER EQU #22a5
PREVIOUS_LAUNCH_COMMAND EQU #22a6
FLIPPER_PWM_MASK EQU #22a7
ROLLOVER_PREVIOUS EQU #22a8
ROLLOVER_HIT_LATCH EQU #22a9
SWITCH_DMA_SOURCE EQU #23e0
SWITCH_CHANGE_DISPLAY EQU #23d3
MAX_PAYLOAD EQU #40
LEGACY_CONTROL_LENGTH EQU #06
CONTROL_LENGTH EQU #08
DISPLAY_BYTE_COUNT EQU #20
LEGACY_DISPLAY_COMMAND_LENGTH EQU #26
DISPLAY_COMMAND_LENGTH EQU #28
DISPLAY_LAMP_BITMAP_COMMAND_LENGTH EQU #2d
DISPLAY_PAYLOAD EQU LOCAL_PAYLOAD+#06
SHORT_SOUND_PAYLOAD EQU LOCAL_PAYLOAD+#06
DISPLAY_SOUND_PAYLOAD EQU LOCAL_PAYLOAD+#26
LAMP_BITMAP_PAYLOAD EQU LOCAL_PAYLOAD+#28
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
        STA FLIPPER_COIL_TIMERS
        STA FLIPPER_COIL_TIMERS+#01
        STA LAUNCHER_COIL_TIMER
        STA PREVIOUS_LAUNCH_COMMAND
        MVI A,#ff
        STA FLIPPER_PWM_MASK
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
; Establish the eight rollover contact levels without reporting a hit merely
; because a ball was already resting on one when power came up.
        CALL SCAN_ROLLOVERS
        XRA A
        STA ROLLOVER_HIT_LATCH
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
; Open one bounded interrupt window per poll. The former single-NOP window was
; only about 2.7 us at 1.5 MHz and could miss a short Start-button encoder
; pulse. Sixteen delay iterations hold the safe idle window open for roughly
; 150 us, while DI still protects every aperture read below. An accepted ISR
; returns with interrupts disabled; the delay then simply finishes that poll.
        EI
        MVI A,#10
CABINET_SAMPLE_WINDOW:
        DCR A
        JNZ CABINET_SAMPLE_WINDOW
        DI
; Poll the eight short-lived rollover contacts at the ~1 ms idle cadence,
; independently of the much slower host transaction rate.
        CALL SCAN_ROLLOVERS
        LDA HOST_SEQUENCE
        MOV B,A
        LDA HOST_SEQUENCE
        CMP B
        JNZ POLL_HOST
        CMP C
        JZ POLL_HOST
; Mailbox validation and response run with interrupts disabled. Force an active
; held flipper on across that bounded critical section so an OFF carrier phase
; cannot be stretched long enough for the return spring to win. The Port-6
; helper preserves B because B still contains the pending host sequence here.
        LXI H,FLIPPER_COIL_TIMERS
        MOV A,M
        INX H
        ORA M
        JZ RECEIVE_HOST_TRANSACTION
        MVI A,#ff
        STA FLIPPER_PWM_MASK
        CALL WRITE_LOCAL_COIL_PORT6
        JMP RECEIVE_HOST_TRANSACTION

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

; Switch-capture de-ablation test: manifest byte zero as a lamp selector, then
; capture and return the validated payload plus one coherent 36-byte switch
; snapshot. The 8085-side acknowledgement/retry loop remains bypassed.
        CALL MANIFEST_LAMP_COMMAND
        CALL MANIFEST_CONTROL_COMMANDS
        CALL MANIFEST_DISPLAY_COMMANDS
        CALL MANIFEST_SOUND_COMMANDS
        JMP CAPTURE_HOST_RESPONSE

CAPTURE_HOST_RESPONSE:
; Capture one coherent input snapshot for this transaction. Retransmissions
; reuse these bytes rather than changing the response underneath its sequence.
; Atomically consume the Port-0 and Port-1 events accumulated by their ISRs.
        DI
        CALL SCAN_ROLLOVERS
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
; aperture mode. The former reserved byte now carries rising closure edges for
; the eight rollovers, preserving the established 36-byte switch trailer.
        IN #04
        STA LOCAL_SWITCH_4
        LDA ROLLOVER_HIT_LATCH
        STA LOCAL_SWITCH_5
        XRA A
        STA ROLLOVER_HIT_LATCH
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
; disconnected client. Open the same bounded idle window used by POLL_HOST
; before each stable sequence probe.
        EI
        MVI A,#10
RESPONSE_INTERRUPT_WINDOW:
        DCR A
        JNZ RESPONSE_INTERRUPT_WINDOW
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
        JNZ CABINET_SWITCH_ACTIVE
        CALL ADVANCE_FLIPPER_PWM
        JMP CABINET_SWITCH_DONE
CABINET_SWITCH_ACTIVE:
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
; Acknowledge the selected encoder source before spending time on PWM.
        CALL ADVANCE_FLIPPER_PWM
; The physical flipper contacts are fanned into Port 0 bits 4/5 for their
; latency-sensitive coil action. Fire a bounded local impulse before doing
; ordinary event bookkeeping for the host.
        CALL FIRE_FLIPPER_COIL
; Port-0 source bit 1 announces a playfield-DMA update. Capture rollover
; closure edges immediately, rather than waiting for the next host frame.
        MOV A,B
        CPI #01
        JNZ CABINET_ROLLOVER_SCAN_DONE
        CALL SCAN_ROLLOVERS
CABINET_ROLLOVER_SCAN_DONE:
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

; Port-0 bit 4 is the right flipper (coil 12, port 6 bit 4); bit 5 is the left
; flipper (coil 13, port 6 bit 5). Start with ten timer ticks at full power.
; ADVANCE_FLIPPER_PWM subsequently renews a held contact at $09, where the
; timer's $10 bit is clear and the interrupt-driven 50% hold carrier applies.
FIRE_FLIPPER_COIL:
        LDA REFLEX_ENABLED
        ORA A
        RZ
        MOV A,B
        CPI #04
        RC
        CPI #06
        RNC
        PUSH B
        SUI #04
        MOV E,A
        MVI D,#00
        LXI H,FLIPPER_COIL_TIMERS
        DAD D
        MOV A,M
        ORA A
        JNZ FLIPPER_COIL_DONE
        MVI M,#19
        CALL WRITE_LOCAL_COILS
FLIPPER_COIL_DONE:
        POP B
        RET

; The two interrupt lines alternate at about 454 edges per second. Toggle both
; flipper bits on every accepted edge for the 227 Hz, 50% carrier proven by
; ppm_hold_pwm on the physical machine. Timer bit $10 preserves full pull-in.
; After pull-in, Port 4 supplies held levels: $20 right and $40 left.
ADVANCE_FLIPPER_PWM:
; With no active flipper, leave the carrier and Port 6 untouched. This is the
; overwhelmingly common path and keeps switch interrupts close to stock cost.
        LXI H,FLIPPER_COIL_TIMERS
        MOV A,M
        INX H
        ORA M
        RZ

        LXI H,FLIPPER_PWM_MASK
        MOV A,M
        XRI #30
        MOV M,A

        LXI H,FLIPPER_COIL_TIMERS
        MOV A,M
        ORA A
        JZ CHECK_LEFT_FLIPPER_HOLD
        ANI #10
        JNZ CHECK_LEFT_FLIPPER_HOLD
        IN #04
        ANI #20
        JZ RELEASE_RIGHT_FLIPPER
        MVI M,#09
        JMP CHECK_LEFT_FLIPPER_HOLD
RELEASE_RIGHT_FLIPPER:
        MVI M,#00

CHECK_LEFT_FLIPPER_HOLD:
        INX H
        MOV A,M
        ORA A
        JZ WRITE_FLIPPER_PWM
        ANI #10
        JNZ WRITE_FLIPPER_PWM
        IN #04
        ANI #40
        JZ RELEASE_LEFT_FLIPPER
        MVI M,#09
        JMP WRITE_FLIPPER_PWM
RELEASE_LEFT_FLIPPER:
        MVI M,#00

WRITE_FLIPPER_PWM:
        CALL WRITE_LOCAL_COIL_PORT6
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
        JNZ REFLEX_SWITCH_ACTIVE
        CALL ADVANCE_FLIPPER_PWM
        JMP REFLEX_SWITCH_DONE
REFLEX_SWITCH_ACTIVE:
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
; Acknowledge the selected encoder source before spending time on PWM.
        CALL ADVANCE_FLIPPER_PWM
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
        LXI H,FLIPPER_COIL_TIMERS
        MVI B,#02
DECREMENT_FLIPPER_COIL_TIMER:
        MOV A,M
        ORA A
        JZ NEXT_FLIPPER_COIL_TIMER
        DCR M
NEXT_FLIPPER_COIL_TIMER:
        INX H
        DCR B
        JNZ DECREMENT_FLIPPER_COIL_TIMER
        LDA LAUNCHER_COIL_TIMER
        ORA A
        JZ LOCAL_COIL_TIMERS_READY
        DCR A
        STA LAUNCHER_COIL_TIMER
LOCAL_COIL_TIMERS_READY:
        CALL WRITE_LOCAL_COILS
        RET

; Carrier-edge fast path for Port 6, which contains two reflex mechanisms and
; both flippers. Preserve B: the mailbox caller keeps its pending sequence in B.
WRITE_LOCAL_COIL_PORT6:
        PUSH B
        MVI B,#00
        RIM
        ANI #01
        JNZ OUTPUT_LOCAL_COIL_PORT6

        LXI H,REFLEX_COIL_TIMERS
        MOV A,M
        ORA A
        JZ FAST_REFLEX_COIL_3
        MVI A,#08
        ORA B
        MOV B,A
FAST_REFLEX_COIL_3:
        LXI H,REFLEX_COIL_TIMERS+#03
        MOV A,M
        ORA A
        JZ FAST_RIGHT_FLIPPER
        MVI A,#04
        ORA B
        MOV B,A

FAST_RIGHT_FLIPPER:
        LXI H,FLIPPER_COIL_TIMERS
        MOV A,M
        ORA A
        JZ FAST_LEFT_FLIPPER
        ANI #10
        JNZ FAST_RIGHT_FLIPPER_ON
        LDA FLIPPER_PWM_MASK
        ANI #10
        JZ FAST_LEFT_FLIPPER
FAST_RIGHT_FLIPPER_ON:
        MVI A,#10
        ORA B
        MOV B,A

FAST_LEFT_FLIPPER:
        LXI H,FLIPPER_COIL_TIMERS+#01
        MOV A,M
        ORA A
        JZ OUTPUT_LOCAL_COIL_PORT6
        ANI #10
        JNZ FAST_LEFT_FLIPPER_ON
        LDA FLIPPER_PWM_MASK
        ANI #20
        JZ OUTPUT_LOCAL_COIL_PORT6
FAST_LEFT_FLIPPER_ON:
        MVI A,#20
        ORA B
        MOV B,A

OUTPUT_LOCAL_COIL_PORT6:
        MOV A,B
        CMA
        OUT #06
        POP B
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
        JZ READ_FLIPPER_COILS
        MVI A,#02
        ORA B
        MOV B,A
READ_FLIPPER_COILS:
        LXI H,FLIPPER_COIL_TIMERS
        MOV A,M
        ORA A
        JZ LEFT_FLIPPER_COIL
        ANI #10
        JNZ RIGHT_FLIPPER_COIL_ON
        LDA FLIPPER_PWM_MASK
        ANI #10
        JZ LEFT_FLIPPER_COIL
RIGHT_FLIPPER_COIL_ON:
        MVI A,#10
        ORA C
        MOV C,A
LEFT_FLIPPER_COIL:
        INX H
        MOV A,M
        ORA A
        JZ READ_LAUNCHER_COIL
        ANI #10
        JNZ LEFT_FLIPPER_COIL_ON
        LDA FLIPPER_PWM_MASK
        ANI #20
        JZ READ_LAUNCHER_COIL
LEFT_FLIPPER_COIL_ON:
        MVI A,#20
        ORA C
        MOV C,A
READ_LAUNCHER_COIL:
        LDA LAUNCHER_COIL_TIMER
        ORA A
        JZ LOCAL_COILS_READY
        MVI A,#20
        ORA E
        MOV E,A
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

; The signed 45-byte frame appends five logical lamp-mask bytes after sound.
; Preserve the legacy one-hot selector for diagnostic and soak-test clients.
        LDA LOCAL_LENGTH
        CPI DISPLAY_LAMP_BITMAP_COMMAND_LENGTH
        JNZ LEGACY_ONE_HOT_LAMP
        LDA LOCAL_PAYLOAD+#01
        CPI #4d
        JNZ LEGACY_ONE_HOT_LAMP
        LDA LOCAL_PAYLOAD+#02
        CPI #50
        JNZ LEGACY_ONE_HOT_LAMP
        LXI H,LAMP_BITMAP_PAYLOAD
        LXI D,LOCAL_LAMP_BYTES
        MVI B,#05
COPY_LAMP_BITMAP:
        MOV A,M
        STAX D
        INX H
        INX D
        DCR B
        JNZ COPY_LAMP_BITMAP
        JMP OUTPUT_LOCAL_LAMPS

LEGACY_ONE_HOT_LAMP:
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

; Mechanism commands use a signed payload so a generic echo
; test cannot accidentally energize coils:
;   byte 0 lamp, bytes 1-2 "MP", byte 3 reflex-enable bit,
;   byte 4 cup bits 0-5, byte 5 launcher bit 0.
; The current basic form is eight bytes. The display form inserts a raw copy of
; the 32-byte motherboard display window before the final pitch/duration pair.
; Accept the older six- and 38-byte forms during this protocol transition.
; Cup and launcher requests are rising-edge, non-renewing bounded pulses.
MANIFEST_CONTROL_COMMANDS:
        PUSH B
        PUSH D
        PUSH H

        LDA LOCAL_LENGTH
        CPI LEGACY_CONTROL_LENGTH
        JZ VALIDATE_CONTROL_SIGNATURE
        CPI CONTROL_LENGTH
        JZ VALIDATE_CONTROL_SIGNATURE
        CPI LEGACY_DISPLAY_COMMAND_LENGTH
        JZ VALIDATE_CONTROL_SIGNATURE
        CPI DISPLAY_COMMAND_LENGTH
        JZ VALIDATE_CONTROL_SIGNATURE
        CPI DISPLAY_LAMP_BITMAP_COMMAND_LENGTH
        JNZ NO_CONTROL_COMMAND
VALIDATE_CONTROL_SIGNATURE:
        LDA LOCAL_PAYLOAD+#01
        CPI #4d
        JNZ NO_CONTROL_COMMAND
        LDA LOCAL_PAYLOAD+#02
        CPI #50
        JNZ NO_CONTROL_COMMAND
        LDA REFLEX_ENABLED
        STA REFLEX_PRECOMMAND
        LDA LOCAL_PAYLOAD+#03
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
        STA FLIPPER_COIL_TIMERS
        STA FLIPPER_COIL_TIMERS+#01
        CALL WRITE_LOCAL_COILS

CHECK_CUP_COMMAND:
        JMP HAVE_CUP_COMMAND
NO_CONTROL_COMMAND:
        XRA A
        STA PREVIOUS_CUP_COMMAND
        STA PREVIOUS_LAUNCH_COMMAND
        JMP CONTROL_COMMAND_DONE

HAVE_CUP_COMMAND:
        LDA LOCAL_PAYLOAD+#04
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

        LDA LOCAL_PAYLOAD+#05
        ANI #01
        MOV C,A
        LDA PREVIOUS_LAUNCH_COMMAND
        MOV B,A
        MOV A,C
        STA PREVIOUS_LAUNCH_COMMAND
        MOV A,B
        CMA
        ANA C
        JZ CONTROL_COILS_READY
        LDA LAUNCHER_COIL_TIMER
        ORA A
        JNZ CONTROL_COILS_READY
        MVI A,#09
        STA LAUNCHER_COIL_TIMER
CONTROL_COILS_READY:
        CALL WRITE_LOCAL_COILS

CONTROL_COMMAND_DONE:
        POP H
        POP D
        POP B
        RET

; Copy the raw display payload directly into the motherboard's contiguous
; $23c0-$23df scan window. Most nibbles are 7448 hexadecimal digits. Bytes at
; offsets $0c, $16, and $1e also carry the ten score-panel LEDs; retaining the
; literal layout here lets the host-side mapper be refined experimentally.
MANIFEST_DISPLAY_COMMANDS:
        PUSH B
        PUSH D
        PUSH H

        LDA LOCAL_LENGTH
        CPI LEGACY_DISPLAY_COMMAND_LENGTH
        JZ VALIDATE_DISPLAY_SIGNATURE
        CPI DISPLAY_COMMAND_LENGTH
        JZ VALIDATE_DISPLAY_SIGNATURE
        CPI DISPLAY_LAMP_BITMAP_COMMAND_LENGTH
        JNZ DISPLAY_COMMAND_DONE
VALIDATE_DISPLAY_SIGNATURE:
        LDA LOCAL_PAYLOAD+#01
        CPI #4d
        JNZ DISPLAY_COMMAND_DONE
        LDA LOCAL_PAYLOAD+#02
        CPI #50
        JNZ DISPLAY_COMMAND_DONE

        LXI H,DISPLAY_PAYLOAD
        LXI D,#23c0
        MVI B,DISPLAY_BYTE_COUNT
COPY_DISPLAY_WINDOW:
        MOV A,M
        STAX D
        INX H
        INX D
        DCR B
        JNZ COPY_DISPLAY_WINDOW

DISPLAY_COMMAND_DONE:
        POP H
        POP D
        POP B
        RET

; The final two bytes of a current command are logical pitch and duration. The
; original board ports are active-low. Never complement a logical zero duration
; into raw $ff: zero is our explicit silence request and raw $fe is the stock
; ROM's safe sound-off value.
MANIFEST_SOUND_COMMANDS:
        PUSH B
        PUSH D
        PUSH H

        LDA LOCAL_LENGTH
        CPI CONTROL_LENGTH
        JZ SHORT_SOUND_COMMAND
        CPI DISPLAY_COMMAND_LENGTH
        JZ FULL_SOUND_COMMAND
        CPI DISPLAY_LAMP_BITMAP_COMMAND_LENGTH
        JNZ SOUND_COMMAND_DONE
FULL_SOUND_COMMAND:
        LXI H,DISPLAY_SOUND_PAYLOAD
        JMP VALIDATE_SOUND_SIGNATURE
SHORT_SOUND_COMMAND:
        LXI H,SHORT_SOUND_PAYLOAD
VALIDATE_SOUND_SIGNATURE:
        LDA LOCAL_PAYLOAD+#01
        CPI #4d
        JNZ SOUND_COMMAND_DONE
        LDA LOCAL_PAYLOAD+#02
        CPI #50
        JNZ SOUND_COMMAND_DONE

        MVI A,#ff
        OUT #09
        MOV A,M
        CMA
        OUT #0a
        INX H
        MOV A,M
        ORA A
        JNZ MANIFEST_SOUND_DURATION
        MVI A,#fe
        OUT #09
        JMP SOUND_COMMAND_DONE
MANIFEST_SOUND_DURATION:
        CMA
        OUT #09

SOUND_COMMAND_DONE:
        POP H
        POP D
        POP B
        RET

; Each raw DMA byte's $10 bit is high when its inductive contact is open.
; Sample only the eight 500-point rollover contacts and retain 0->1 closure
; edges until CAPTURE_HOST_RESPONSE consumes the latch. Low-nibble measurement
; jitter cannot manufacture a hit. Preserve BC: C owns the mailbox sequence.
SCAN_ROLLOVERS:
        PUSH B
        MVI B,#00
        LDA #23f3              ; contact 20, rollover NW
        ANI #10
        JNZ ROLLOVER_0_OPEN
        MOV A,B
        ORI #01
        MOV B,A
ROLLOVER_0_OPEN:
        LDA #23e9              ; contact 10, rollover W
        ANI #10
        JNZ ROLLOVER_1_OPEN
        MOV A,B
        ORI #02
        MOV B,A
ROLLOVER_1_OPEN:
        LDA #23ea              ; contact 11, rollover N
        ANI #10
        JNZ ROLLOVER_2_OPEN
        MOV A,B
        ORI #04
        MOV B,A
ROLLOVER_2_OPEN:
        LDA #23ec              ; contact 13, rollover SE
        ANI #10
        JNZ ROLLOVER_3_OPEN
        MOV A,B
        ORI #08
        MOV B,A
ROLLOVER_3_OPEN:
        LDA #23ed              ; contact 14, rollover NE
        ANI #10
        JNZ ROLLOVER_4_OPEN
        MOV A,B
        ORI #10
        MOV B,A
ROLLOVER_4_OPEN:
        LDA #23eb              ; contact 12, rollover E
        ANI #10
        JNZ ROLLOVER_5_OPEN
        MOV A,B
        ORI #20
        MOV B,A
ROLLOVER_5_OPEN:
        LDA #23f0              ; contact 17, rollover SW
        ANI #10
        JNZ ROLLOVER_6_OPEN
        MOV A,B
        ORI #40
        MOV B,A
ROLLOVER_6_OPEN:
        LDA #23f1              ; contact 18, rollover S
        ANI #10
        JNZ ROLLOVER_7_OPEN
        MOV A,B
        ORI #80
        MOV B,A
ROLLOVER_7_OPEN:
        LDA ROLLOVER_PREVIOUS
        CMA
        ANA B
        MOV C,A
        MOV A,B
        STA ROLLOVER_PREVIOUS
        LDA ROLLOVER_HIT_LATCH
        ORA C
        STA ROLLOVER_HIT_LATCH
        POP B
        RET

        ORG #2000
