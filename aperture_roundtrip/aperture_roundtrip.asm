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
;   read $28e0 to start
;   transmit sequence, length, payload, and CRC-8 as $28cH/$28dL reads
;   read $28e1 to finish and acknowledge the host sequence

HOST_SEQUENCE EQU #2800
CPU_ACK EQU #2801
HOST_LENGTH EQU #2802
HOST_PAYLOAD EQU #2803

LOCAL_LENGTH EQU #2202
LOCAL_PAYLOAD EQU #2203
LOCAL_PENDING_SEQUENCE EQU #2223
LOCAL_CRC EQU #2224
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

FINISH_RESPONSE:
        MOV A,D
        CALL SEND_RAW_BYTE
        LDA #28e1

; The host cannot publish another sequence until the Pico has accepted this
; response. Thus an advanced HOST_SEQUENCE proves acknowledgement without a
; timing-sensitive CPU_ACK read. While it remains unchanged, retransmit; the
; Pico deduplicates already accepted frames.
WAIT_FOR_NEXT_OR_RETRY:
        LDA HOST_SEQUENCE
        MOV B,A
        LDA HOST_SEQUENCE
        CMP B
        JNZ WAIT_FOR_NEXT_OR_RETRY
        CMP C
        JNZ RECEIVE_HOST_TRANSACTION
        JMP TRANSMIT_RESPONSE

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

        ORG #2000
