#!/usr/bin/env python3
"""Read a Micropin ROM variant's shared build/MAME configuration."""

import argparse
import sys
from pathlib import Path


MAME_TARGETS = {
    4: ("pencup2d", "micro"),
    5: ("pencup2c", "coin"),
}

# Named experiments can select a deliberately isolated MAME target even when
# they have an otherwise ordinary ROM count.  In particular, bridge needs the
# $3000-$31ff Pico-facing aperture, which is not present on pencup2c.
MAME_VARIANT_TARGETS = {
    "bridge": ("pencupx", "x"),
    "arb": ("pencupx", "x"),
    "arb_tester": ("pencuptst", "test"),
}


def fail(message: str) -> None:
    print(message, file=sys.stderr)
    raise SystemExit(1)


def read_text(path: Path, description: str) -> str:
    try:
        value = path.read_text().strip()
    except FileNotFoundError:
        fail(f"missing {description}: {path}")
    if not value:
        fail(f"empty {description}: {path}")
    return value


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("variant", help="ROM variant directory")
    args = parser.parse_args()

    variant = Path(args.variant)
    if not variant.is_dir():
        fail(f"no such game / directory {variant}")

    source_prefix = read_text(variant / "rom_prefix", "rom_prefix")
    count_path = variant / "rom_count"
    count_text = count_path.read_text().strip() if count_path.exists() else "4"
    try:
        rom_count = int(count_text, 10)
    except ValueError:
        fail(f"invalid rom_count in {count_path}: {count_text!r}")
    if rom_count < 1 or str(rom_count) != count_text:
        fail(f"invalid rom_count in {count_path}: {count_text!r}")

    target = MAME_VARIANT_TARGETS.get(variant.name, MAME_TARGETS.get(rom_count))
    if target is None:
        fail(f"no MAME deployment target exists yet for {rom_count} ROMs")
    mame_system, mame_prefix = target
    print(f"{rom_count}\t{mame_system}\t{mame_prefix}\t{source_prefix}")


if __name__ == "__main__":
    main()
