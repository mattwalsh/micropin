; Host/Pico/8085 round-trip proof using no writable data-bus path.
;
; Host transaction at the Pico-served aperture:
;   $2800 sequence (published last)
;   $2801 Pico acknowledgement of the last complete response frame
;   $2802 payload length, capped here at 32
;   $2803... payload
;   immediately following payload: CRC-8 over sequence, length, and payload
;
; Response frame uses address strobes:
;   read $2a00 to start
;   transmit sequence, length, echoed payload, port 0, port 1, port 4, and
;   CRC-8 as one read from $2900+byte
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
MAX_PAYLOAD EQU #20
STACK_TOP EQU #23c0

        ORG #0000
        JMP START

; 8085 TRAP is non-maskable. The original game treats it as a reinitialization
; path, so do the same explicitly; framing and acknowledgement recover any
; response that it interrupted.
        ORG #0024
        JMP START

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
READ_INITIAL_ACK:
        LDA CPU_ACK
        MOV B,A
        LDA CPU_ACK
        CMP B
        JNZ READ_INITIAL_ACK
        MOV C,A

POLL_HOST:
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
        LXI H,HOST_PAYLOAD
        LDA LOCAL_LENGTH
        MOV E,A
        MVI D,#00
        DAD D
        MOV A,M
        LXI H,LOCAL_CRC
        CMP M
        JNZ POLL_HOST

        CALL MANIFEST_LAMP_COMMAND
; Capture one coherent input snapshot for this transaction. Retransmissions
; reuse these bytes rather than changing the response underneath its sequence.
        IN #00
        STA LOCAL_SWITCH_0
        IN #01
        STA LOCAL_SWITCH_1
        IN #04
        STA LOCAL_SWITCH_4
        LDA LOCAL_PENDING_SEQUENCE
        MOV C,A

TRANSMIT_RESPONSE:
        LDA #2a00
        MVI D,#00
        MOV A,C
        CALL SEND_BYTE
        LDA LOCAL_LENGTH
        ADI #03
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
