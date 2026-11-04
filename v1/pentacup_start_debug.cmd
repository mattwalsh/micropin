// Stop when the $4000 input scanner sees the Start bit change.
bp 7117,(a&10)!=0

// Stop when event dispatch resolves the Start event to bytecode $66a1.
bp 7330,x==66a1

// Thereafter stop once per interpreted Start-policy opcode.
bp 72dd,(w@a2>=66a1)&&(w@a2<6740)

g
