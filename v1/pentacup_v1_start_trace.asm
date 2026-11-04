; Pentacup / Micropin Rev. 1 Start-button trace
; ===============================================
;
; CPU: Motorola 6800
; Numbers in MAME's debugger are hexadecimal by default.
;
; There are two layers here:
;   1. Native 6800 code detects and translates a switch edge.
;   2. A native interpreter executes serialized game-rule bytecode.
;
; $66a1 is therefore a BYTECODE address.  The 6800 program counter never
; becomes $66a1, so an execution breakpoint at $66a1 will not fire.


; ---------------------------------------------------------------------------
; Native input scanner: port $4000 changed
; ---------------------------------------------------------------------------

70de: b6 40 00     LDAA  $4000       ; raw switch input containing Start bit $10
70e1: 94 40        ANDA  $40         ; apply current input-enable mask
70e3: 98 2e        EORA  $2e         ; XOR previous snapshot: A = changed bits
70e5: 26 30        BNE   $7117       ; at least one bit changed

; The scanner repeats the same operation for the remaining input ports here.
; If no input changed, it returns through $6f0d.

7117: 36           PSHA              ; preserve changed-bit mask
7118: 84 24        ANDA  #$24         ; special handling for two ball inputs
711a: 27 03        BEQ   $711f
711c: bd 72 50     JSR   $7250
711f: 32           PULA              ; A = changed bits again
7120: c6 00        LDAB  #$00         ; logical base number for port $4000
7122: 20 12        BRA   $7136

; Entry points $7124/$7128/$712c/$7130/$7134 select the corresponding
; logical base for changes found on the other input ports.

7136: 37           PSHB
7137: 36           PSHA
7138: fe 6d e1     LDX   [$6de1]      ; bit-mask lookup table -> $6de3
713b: 48           ASLA              ; locate the changed bit
713c: 25 03        BCS   $7141
713e: 08           INX
713f: 20 fa        BRA   $713b
7141: 32           PULA
7142: a4 00        ANDA  0,X          ; isolate selected switch state
7144: 97 6b        STAA  $6b
7146: c6 fc        LDAB  #$fc
7148: cb 04        ADDB  #$04         ; convert bit position to table offset
714a: 48           ASLA
714b: 24 fb        BCC   $7148
714d: 32           PULA
714e: 1b           ABA               ; add input-port logical base

; Concrete trace for Start, where the changed-bit mask was $10 and the input
; port's logical base in B was $00:
;
;   [$6de1] = $6de3                 bit-mask table pointer
;   X at $7141 = $6de6              selected mask-table entry
;   [$6de6] = $10
;   $7142 computes $10 AND [$6de6], not "A AND X"
;   $6b = $10                       selected switch state/mask
;
; The $7148-$714b loop adds four for each bit position.  For bit $10 it
; finishes with B=$0c.  $714d deliberately pulls the saved input-port base
; ($00) into A, and ABA forms descriptor offset $0c.
;
;   [$6db6] = $7d8d                 switch-descriptor table base
;   $7d8d + $0c = $7d99
;   descriptor at $7d99 = 40 08 01 01
;
; The descriptor's low nibble selects hardware group zero.  Its group record
; at $6db8 contains pointers $002e (previous input snapshot) and $4000 (raw
; input).  Descriptor bytes 2 and 3 are both event $01, so this switch maps to
; event $01 on either descriptor-selected path.
;
; $714f-$71b2 use those tables to distinguish edge/state behavior.  On the
; admitted Start edge, the important final handoff is:

71b3: 97 6c        STAA  $6c         ; internal switch-event number
71b5: 7e 6f 17     JMP   $6f17       ; finish interrupt/event admission


; ---------------------------------------------------------------------------
; Native event dequeue and serialized-handler lookup
; ---------------------------------------------------------------------------

7309: de 6e        LDX   $6e          ; read pointer for circular event queue
730b: a6 00        LDAA  0,X          ; A = queued internal event number
730d: 08           INX
730e: bc 72 bb     CPX   $72bb        ; wrap at end of queue
7311: 26 03        BNE   $7316
7313: fe 72 bd     LDX   $72bd         ; queue start
7316: df 6e        STX   $6e
7318: 7a 00 6d     DEC   $6d          ; queued-event count
731b: 48           ASLA               ; convert event number to table offset
731c: 24 01        BCC   $731f
731e: 4c           INCA
731f: 48           ASLA
7320: bb 6d 9d     ADDA  $6d9d        ; event-table base, low byte
7323: 97 a3        STAA  $a3
7325: 86 00        LDAA  #$00
7327: b9 6d 9c     ADCA  $6d9c        ; event-table base, high byte
732a: 97 a2        STAA  $a2
732c: de a2        LDX   $a2
732e: ee 00        LDX   0,X          ; X = serialized handler pointer
7330: df a2        STX   $a2           ; bytecode PC; Start gives X=$66a1
7332: 86 80        LDAA  #$80
7334: 9a e4        ORAA  $e4           ; mark interpreter active
7336: 97 e4        STAA  $e4
7338: 86 08        LDAA  #$08
733a: 94 e4        ANDA  $e4
733c: 26 9f        BNE   $72dd        ; dispatch first bytecode opcode


; ---------------------------------------------------------------------------
; Native bytecode opcode dispatcher
; ---------------------------------------------------------------------------

72dd: de a2        LDX   $a2          ; X = current bytecode PC
72df: a6 00        LDAA  0,X          ; A = bytecode opcode
72e1: 48           ASLA              ; two bytes per native handler pointer
72e2: 5f           CLRB
72e3: bb 74 7d     ADDA  $747d        ; opcode-handler table low byte
72e6: f9 74 7c     ADCB  $747c        ; opcode-handler table high byte
72e9: d7 dc        STAB  $dc
72eb: 97 dd        STAA  $dd
72ed: de dc        LDX   $dc
72ef: ee 00        LDX   0,X          ; native opcode-handler address
72f1: df dc        STX   $dc
72f3: 96 dd        LDAA  $dd           ; synthesize handler return address
72f5: 36           PSHA
72f6: 96 dc        LDAA  $dc
72f8: 36           PSHA
72f9: de a2        LDX   $a2
72fb: a6 01        LDAA  1,X          ; first serialized operand
72fd: 39           RTS                ; actually enters selected handler


; ---------------------------------------------------------------------------
; Serialized Start policy at $66a1
; ---------------------------------------------------------------------------
;
; These are interpreter operations, not 6800 mnemonics.  Names below come
; from tracing the native handlers selected by the table at $747e.

66a1: 09 d1
       CLEAR_FLAG $d1

66a3: 0c 07 0d 74 77 70 06 0f 04 66 dd
       IF_ANY_FLAG_SET {$0d,$74,$77,$70,$06,$0f,$04}, GOTO $66dd
       ; Tilt/interlock or internal blocking state -> reject Start.

66ae: 0b 71 66 dd
       IF_FLAG_CLEAR $71, GOTO $66dd
       ; Active-low Tilt 3/interlock is not kosher -> reject Start.

66b2: 0a 6e 66 c6
       IF_FLAG_SET $6e, GOTO $66c6
       ; Route according to game-over/current-game state.

66b6: 14 02 66 c6
       PLAYER_OR_GAME_STATE_TEST $02, GOTO $66c6
       ; Branch behavior known; object semantics not fully named yet.

66ba: 19 08 20 00 00 66 de 66 c6
       NUMERIC_OR_GAME_STATE_COMPARE ..., GOTO $66de OR $66c6
       ; Two-result branch; exact operands not fully named yet.

66c3: 29 66 de
       PLAYER_OR_GAME_STATE_TEST ..., GOTO $66de

66c6: 0b 03 66 cf
       IF_FLAG_CLEAR $03, GOTO $66cf

66ca: 14 05 66 cf
       PLAYER_OR_GAME_STATE_TEST $05, GOTO $66cf

66ce: 00
       END                         ; reject this route

66cf: 08 0e
       SET_FLAG $0e

66d1: 1a 09 67 00
       IF_NUMERIC_OBJECT_NONZERO CREDITS, GOTO $6700
       ; This is the decisive "should I start?" credit test.

66d5: 05 35 0f
66d8: 09 25
66da: 03 09 0e
66dd: 00
       NO_CREDIT_RESPONSE
       END                         ; no game starts

66de: 09 05 22 3c 09 02 09 d3 09 76 25 0d
66ea: 15 08 50 00 00 16 01 12 02 12 03 12 04 12 05 12 06 12 07
66fd: 08 0f 00
       EXISTING_GAME_OR_ADD_PLAYER_PATH

6700: 03 34 09 0e 0a 6e 67 38 ...
       NEW_GAME_INITIALIZATION     ; accepted Start arrives here


; ---------------------------------------------------------------------------
; Internal flag decoding
; ---------------------------------------------------------------------------
;
; The bytecode values $04/$06/$0d/etc. are flag IDs, not RAM addresses.
; Native routine $7b54 maps flag ID n as follows:
;
;     RAM byte = $20 + (n >> 3)
;     bit mask = {$80,$40,$20,$10,$08,$04,$02,$01}[n & 7]
;
; Relevant Start gates:
;
;   ID $04 -> RAM $20 bit $08       internal blocking state
;   ID $06 -> RAM $20 bit $02       internal blocking state
;   ID $0d -> RAM $21 bit $04       internal blocking state
;   ID $0f -> RAM $21 bit $01       internal blocking state
;   ID $70 -> RAM $2e bit $01       Tilt 4
;   ID $71 -> RAM $2e bit $02       Tilt 3/interlock, must be set
;   ID $74 -> RAM $2e bit $08       Tilt 2
;   ID $77 -> RAM $2e bit $40       Tilt 1
;
; Passing raw tilt/interlock state:
;
;     ($4000 & $c9) == $40
