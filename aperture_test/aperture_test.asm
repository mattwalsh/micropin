; Minimal real-hardware proof for the no-R/WR aperture return channel.
; In aperture mode, the Pico observes reads in two reserved address ranges:
;   $28c0-$28cf = high nibble
;   $28d0-$28df = low nibble
; This program repeatedly transmits one framed diagnostic packet:
; sequence 1, length 4, ASCII "MPX1" (01 04 4d 50 58 31).

        ORG #0000
        JMP START

        ORG #0040
START:
        DI
        LXI SP, #23c0

TRANSMIT_FOREVER:
        LDA #28e0
        LDA #28c0
        LDA #28d1
        LDA #28c0
        LDA #28d4
        LDA #28c4
        LDA #28dd
        LDA #28c5
        LDA #28d0
        LDA #28c5
        LDA #28d8
        LDA #28c3
        LDA #28d1
        LDA #28e1

; Keep the producer slow enough that a human issuing `rx` cannot immediately
; overflow the Pico's first experimental receive ring.
        MVI B, #ff
DELAY_OUTER:
        MVI C, #ff
DELAY_INNER:
        DCR C
        JNZ DELAY_INNER
        DCR B
        JNZ DELAY_OUTER
        JMP TRANSMIT_FOREVER

        ORG #2000
