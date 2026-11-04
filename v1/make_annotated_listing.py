#!/usr/bin/env python3
"""Build a byte-accurate, address-correct listing of the Pentacup v1 ROM set.

The first part of the ROM is bytecode for a Micropin interpreter, not native
6800 instructions.  Consequently this deliberately emits bytes rather than
feeding the whole image to a 6800 disassembler and inventing bogus code.
"""

from __future__ import annotations

import hashlib
from pathlib import Path


HERE = Path(__file__).resolve().parent
ROM_DIR = HERE / "roms_orig"
OUTPUT = HERE / "pentacup_v1_serialized.lst"

ROMS = (
    ("ic2.bin", 0x6400),
    ("ic3.bin", 0x6800),
    ("ic4.bin", 0x6C00),
    ("ic5.bin", 0x7000),
    ("ic6.bin", 0x7400),
    ("ic7.bin", 0x7800),
    ("ic8.bin", 0x7C00),
)

NOTES = {
    0x6400: "serialized game program begins (Micropin bytecode, not 6800)",
    0x66A1: "START_EVENT: serialized Start-button policy entry",
    0x66A3: "reject if any blocking state/tilt flag is set",
    0x66AE: "reject unless active-low Tilt 3 / interlock flag is kosher",
    0x66B2: "route according to game-over/current-game state",
    0x66C6: "new-game versus add-player state checks",
    0x66CF: "mark Start request accepted far enough to test credits",
    0x66D1: "SHOULD_I_START: branch to $6700 when numeric field 9 (credits) != 0",
    0x66D5: "no-credit response path",
    0x66DD: "START_REJECTED: end serialized event",
    0x66DE: "existing-game/add-player path",
    0x6700: "START_ACCEPTED: initialize a new game",
    0x6D9C: "serialized-event dispatch table metadata",
    0x6DEB: "native 6800 NMI entry",
    0x6E18: "native 6800 RESET entry",
    0x6E48: "reset-time RAM-validity / forced-clear decision",
    0x6E5D: "cold/forced reset: clear all $0000-$01ff RAM",
    0x6EA5: "write RAM-valid signature $55,$aa at $e8,$e9",
    0x6EE5: "native 6800 IRQ entry",
    0x7096: "snapshot switch inputs into RAM shadows $2e-$33",
    0x70DE: "scan switch inputs for changes",
    0x7117: "changed switch found on $4000",
    0x7136: "identify changed bit and translate to internal event",
    0x72C7: "serialized-bytecode interpreter loop",
    0x72DD: "decode bytecode opcode through handler table at $747e",
    0x7309: "dequeue internal event",
    0x732C: "look up event's serialized handler",
    0x747C: "bytecode opcode-handler table base pointer",
    0x747E: "bytecode opcode-handler table",
    0x756E: "bytecode opcode $08: set flag",
    0x7576: "bytecode opcode $09: clear flag",
    0x757E: "bytecode opcode $0a: branch if flag set",
    0x7590: "bytecode opcode $0b: branch if flag clear",
    0x75A7: "bytecode opcode $0c: branch if any listed flag set",
    0x7723: "bytecode opcode $1a: branch if numeric object nonzero",
    0x7B54: "decode internal flag number to RAM byte and bit mask",
    0x7B77: "flag bit masks: 80 40 20 10 08 04 02 01",
    0x7CCD: "serialized event-handler pointer table",
    0x7CED: "Start event pointer -> $66a1",
    0x7FF8: "IRQ vector (mirrored at $fff8) -> $6ee5",
    0x7FFA: "SWI vector (mirrored at $fffa) -> $6f17",
    0x7FFC: "NMI vector (mirrored at $fffc) -> $6deb",
    0x7FFE: "RESET vector (mirrored at $fffe) -> $6e18",
}


def main() -> None:
    lines = [
        "; Pentacup / Micropin revision 1 serialized ROM listing",
        "; Generated from v1/roms_orig by v1/make_annotated_listing.py",
        ";",
        "; IMPORTANT: $6400-$6dea contains mostly serialized Micropin bytecode",
        "; and data.  It is not valid to disassemble that whole range as 6800.",
        "; Native 6800 firmware begins at $6deb and interprets the bytecode.",
        "; See pentacup_v1_annotated.md for decoded Start logic and native excerpts.",
        "",
    ]

    for name, base in ROMS:
        data = (ROM_DIR / name).read_bytes()
        if len(data) != 0x400:
            raise SystemExit(f"{name}: expected 1024 bytes, found {len(data)}")
        digest = hashlib.md5(data).hexdigest()
        lines.extend(
            (
                "; ------------------------------------------------------------------",
                f"; {name}: ${base:04x}-${base + 0x3ff:04x}  MD5 {digest}",
                f"        .org ${base:04x}",
            )
        )
        offset = 0
        note_addresses = sorted(
            address for address in NOTES if base <= address <= base + 0x3FF
        )
        while offset < len(data):
            address = base + offset
            if address in NOTES:
                lines.append("")
                lines.append(f"; >>> {NOTES[address]}")
            following_note = next(
                (candidate for candidate in note_addresses if candidate > address),
                base + len(data),
            )
            chunk_size = min(8, following_note - address, len(data) - offset)
            chunk = data[offset : offset + chunk_size]
            encoded = ", ".join(f"${value:02x}" for value in chunk)
            lines.append(f"L{address:04X}: .byte {encoded}")
            offset += chunk_size
        lines.append("")

    OUTPUT.write_text("\n".join(lines) + "\n")
    print(OUTPUT)


if __name__ == "__main__":
    main()
