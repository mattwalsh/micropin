"""Calibrated playfield lamp coordinates and a simple wipe effect.

Coordinates use the same 3300x3980-ish playfield space as the MAME layout.
Only lamps with a calibrated playfield position are included; unassigned
driver outputs are intentionally absent.
"""

from __future__ import annotations

from collections.abc import Iterable


# Centers of the calibrated lamp spots in micropin2dev.lay.  The dictionary
# key is the logical MAME/host lamp number, not the layout element sequence.
PLAYFIELD_LAMP_COORDINATES: dict[int, tuple[float, float]] = {
    9: (1912, 257),
    10: (2039, 2073),
    7: (2039, 2139),
    15: (2246, 2196),
    14: (2039, 2200),
    2: (839, 252),
    19: (1159, 252),
    8: (1478, 252),
    21: (839, 571),
    11: (1480, 572),
    16: (839, 894),
    17: (1164, 894),
    12: (1480, 894),
    6: (1264, 2985),
    36: (548, 1910),
    24: (770, 1785),
    25: (989, 1662),
    26: (1212, 1543),
    13: (1432, 1423),
    28: (796, 1305),
    35: (770, 1256),
    29: (712, 2074),
    37: (908, 1967),
    32: (1103, 1859),
    33: (1298, 1754),
    34: (1496, 1647),
    27: (741, 1204),
    18: (714, 1151),
}


def wavefront_lamps(
    position: float,
    *,
    thickness: float = 180.0,
    coordinates: dict[int, tuple[float, float]] = PLAYFIELD_LAMP_COORDINATES,
) -> set[int]:
    """Return lamps intersected by a left-to-right/down diagonal wavefront.

    ``position`` and ``thickness`` are in normalized diagonal coordinates
    (0.0 to 1.0 across the playfield), making the effect independent of the
    exact artwork resolution.  The wave travels from upper-left to
    lower-right using ``(x + y) / (max_x + max_y)``.
    """
    if not 0.0 <= position <= 1.0:
        raise ValueError("position must be between 0 and 1")
    if thickness < 0:
        raise ValueError("thickness must not be negative")
    if not coordinates:
        return set()
    max_diagonal = max(x + y for x, y in coordinates.values())
    min_diagonal = min(x + y for x, y in coordinates.values())
    span = max_diagonal - min_diagonal or 1.0
    return {
        lamp
        for lamp, (x, y) in coordinates.items()
        if abs(((x + y) - min_diagonal) / span - position) <= thickness / span
    }


def lamp_bitmap(lamps: Iterable[int], *, byte_count: int = 5) -> bytes:
    """Pack logical lamp numbers into the control protocol bitmap."""
    bitmap = bytearray(byte_count)
    for lamp in lamps:
        if 0 <= lamp < byte_count * 8:
            bitmap[lamp // 8] |= 1 << (lamp % 8)
    return bytes(bitmap)


if __name__ == "__main__":
    import json
    print(json.dumps(PLAYFIELD_LAMP_COORDINATES, indent=2, sort_keys=True))
