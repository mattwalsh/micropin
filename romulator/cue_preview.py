#!/usr/bin/env python3
"""Preview one configured MIDI/light cue outside the game loop."""

from __future__ import annotations

import argparse
from contextlib import nullcontext
from dataclasses import replace
from pathlib import Path
import threading
import time

from aperture_stress import SerialLines, find_device
from led_controller import GameLedRenderer, LedTransport, StripGeometry
from micropin_game import DEFAULT_CONFIG_PATH, load_game_config, safe_cleanup, synchronize_aperture
from midi_ay import load_midi_song_config
from sound_aperture_test import play_midi_song


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("cue", help="configured cue name, e.g. high_score")
    parser.add_argument("device", nargs="?", help="aperture CDC device")
    parser.add_argument("--led-device", required=True, help="LED CDC device")
    parser.add_argument("--led-count", type=int, default=160)
    parser.add_argument("--timeout", type=float, default=5.0)
    parser.add_argument("--config", type=Path, default=DEFAULT_CONFIG_PATH)
    args = parser.parse_args()

    config = load_game_config(args.config)
    cue = config.cue(args.cue)
    if cue.midi is None:
        parser.error(f"cues.{args.cue} is not a MIDI cue")
    if cue.light_effect is None:
        parser.error(f"cues.{args.cue} has no light_effect")
    song = replace(
        load_midi_song_config(args.config, cue.midi),
        loop=False,
        start_measure=cue.start_measure,
    )
    geometry = StripGeometry(args.led_count)
    stop = threading.Event()

    def show_effect(leds: LedTransport) -> None:
        renderer = GameLedRenderer(geometry)
        started = time.monotonic()
        while not stop.is_set():
            leds.show(renderer.effect_frame(cue.light_effect, now=time.monotonic() - started))
            time.sleep(1 / 30)

    device = find_device(args.device)
    with LedTransport(args.led_device, led_count=geometry.count) as leds, SerialLines(device, args.timeout) as serial:
        synchronize_aperture(serial)
        thread = threading.Thread(target=show_effect, args=(leds,), daemon=True)
        thread.start()
        try:
            print(f"previewing {args.cue}: {cue.midi}, measures {cue.start_measure}-{cue.end_measure}")
            play_midi_song(
                serial, song, loop=False, start_measure=cue.start_measure,
                end_measure=cue.end_measure,
            )
        finally:
            stop.set()
            thread.join(timeout=1)
            leds.show(bytes(geometry.count * 3))
            safe_cleanup(serial)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
