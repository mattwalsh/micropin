#!/usr/bin/env python3
"""Play named legacy or MIDI songs directly through the AY aperture command."""

import argparse
from pathlib import Path
import time

from aperture_stress import SerialLines, find_device
from micropin_game import (
    DEFAULT_CONFIG_PATH,
    load_game_config,
    safe_cleanup,
    synchronize_aperture,
)
from midi_ay import MidiAySequencer, load_midi, load_midi_song_config
from micropin_protocol import (
    DEFAULT_AY_PERIOD_CONSTANT,
    AyRegisterImage,
    build_ay_payload,
    legacy_pitch_to_ay_period,
)
from random_lamp_test import send_and_verify


def send_ay_frame(serial, ay):
    update = ay.pending_update()
    if update.mask:
        send_and_verify(serial, build_ay_payload(update))
        ay.acknowledge(update)


def play_ay_song(
    serial, song, ay, *, period_constant=DEFAULT_AY_PERIOD_CONSTANT,
    volume=1, envelope_period=None, envelope_shape=0, stop_at_end=True
):
    # Channel A tone only; channels B/C and every noise source remain disabled.
    ay.set_register(7, 0x3e)
    ay.set_volume(1, 0)
    ay.set_volume(2, 0)
    if envelope_period is not None:
        ay.set_envelope_period(envelope_period)
    for note in song:
        pitch = note.tone.pitch
        period = legacy_pitch_to_ay_period(pitch, period_constant)
        if period:
            ay.set_tone_period(0, int(period / 2))
            if envelope_period is None:
                ay.set_volume(0, volume)
                description = f'AY period=0x{period:03x}'
            else:
                # Select the shared envelope for channel A. Writing R13 is
                # itself the note-on trigger, even when its value is unchanged.
                ay.set_volume(0, 0x10)
                ay.trigger_envelope(envelope_shape)
                description = (
                    f'AY period=0x{period:03x} '
                    f'envelope=0x{envelope_period:04x}/0x{envelope_shape:x}'
                )
        else:
            ay.set_volume(0, 0)
            description = 'rest'
        print(
            f'legacy pitch={pitch:3d} (0x{pitch:02x}) -> {description} '
            f'interval={note.interval_seconds:.3f}s',
            flush=True,
        )
        send_ay_frame(serial, ay)
        time.sleep(note.interval_seconds)
    if stop_at_end:
        ay.set_volume(0, 0)
        send_ay_frame(serial, ay)


def play_midi_song(serial, song_config, *, loop: bool, start_measure: int, end_measure: int | None = None) -> None:
    midi = load_midi(song_config.path)
    start_seconds = midi.seconds_at_measure(start_measure)
    end_seconds = (
        midi.seconds_at_measure(end_measure + 1)
        if end_measure is not None
        else None
    )
    ay = AyRegisterImage()
    # Start fully muted. The priority arbiter below opens only the selected
    # tone/noise path on each physical AY channel.
    ay.set_register(7, 0x3f)
    for channel in range(3):
        ay.set_volume(channel, 0)
    if song_config.noise_period is not None:
        ay.set_register(6, song_config.noise_period)
    if song_config.envelope_period is not None:
        ay.set_envelope_period(song_config.envelope_period)
        # R13 is the global envelope start/restart register.  It is written
        # once per song; a voice merely elects to consume that shared shape.
        ay.trigger_envelope(song_config.envelope_shape)
    started_at = time.monotonic()
    sources = tuple(
        (voice, MidiAySequencer(
            midi.select_track(voice.track),
            channel=voice.channel,
            volume=voice.volume,
            loop=loop,
            a4_period=voice.a4_period,
            use_envelope=voice.use_envelope,
            envelope_shape=song_config.envelope_shape,
            started_at=started_at,
            window_start_seconds=start_seconds,
            window_end_seconds=end_seconds,
        ))
        for voice in song_config.voices
    )
    print(
        f"MIDI {song_config.name!r}: measures {start_measure}-"
        f"{end_measure if end_measure is not None else 'end'} "
        f"({start_seconds:.3f}s), "
        + "; ".join(
            f"track {midi.select_track(voice.track).index} "
            f"{voice.track!r} -> AY {'ABC'[voice.channel]} "
            f"{'envelope' if voice.use_envelope else f'vol {voice.volume}'} "
            f"({'tone' if voice.use_tone else ''}"
            f"{' + noise' if voice.use_tone and voice.use_noise else 'noise' if voice.use_noise else ''}; p{voice.priority})"
            for voice in song_config.voices
        ),
        flush=True,
    )
    last_selection = [None, None, None]
    last_mixer = 0x3f
    while not all(sequencer.finished for _voice, sequencer in sources):
        now = time.monotonic()
        for _voice, sequencer in sources:
            sequencer.advance_timeline(now=now)

        # (source index, voice-pool slot, AY period), highest notes first for
        # a track configured with channels = [ ... ].
        winners = [None, None, None]
        for source_index, (voice, sequencer) in enumerate(sources):
            for slot, period in enumerate(sequencer.active_periods[:len(voice.channels)]):
                channel = voice.channels[slot]
                current = winners[channel]
                if current is None or voice.priority < sources[current[0]][0].priority:
                    winners[channel] = (source_index, slot, period)

        mixer = 0x3f
        for channel, winner in enumerate(winners):
            if winner is None:
                continue
            source_index, _slot, _period = winner
            voice, _sequencer = sources[source_index]
            if voice.use_tone:
                mixer &= ~(1 << channel)
            if voice.use_noise:
                mixer &= ~(1 << (channel + 3))
        if mixer != last_mixer:
            ay.set_register(7, mixer)
            last_mixer = mixer

        for channel, winner in enumerate(winners):
            if winner is None:
                signature = None
            else:
                source_index, slot, period = winner
                voice, sequencer = sources[source_index]
                state = sequencer.voice_state
                signature = (source_index, state.generation, slot, period)
            if signature == last_selection[channel]:
                continue
            if winner is None:
                ay.set_volume(channel, 0)
            else:
                source_index, _slot, period = winner
                if voice.use_tone:
                    ay.set_tone_period(channel, period)
                ay.set_volume(channel, 0x10 if voice.use_envelope else voice.volume)
                if voice.use_envelope:
                    ay.trigger_envelope(song_config.envelope_shape)
            last_selection[channel] = signature
        send_ay_frame(serial, ay)
        time.sleep(0.003)
    for channel in range(3):
        ay.set_volume(channel, 0)
    send_ay_frame(serial, ay)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('device', nargs='?')
    selection = parser.add_mutually_exclusive_group()
    selection.add_argument(
        '--pitches', nargs='+', type=lambda value: int(value, 0),
        help='logical pitch byte(s), for example --pitches 0x78 0x94',
    )
    selection.add_argument(
        '--song',
        help='play one named legacy or MIDI song from micropin_game.toml, then exit',
    )
    parser.add_argument(
        '--loop',
        action='store_true',
        help='repeat --song continuously until Ctrl-C',
    )
    parser.add_argument(
        '--start-measure', type=int,
        help=(
            'override the one-based MIDI measure to begin at; otherwise use '
            'midi_songs.<name>.start_measure (default: 1)'
        ),
    )
    parser.add_argument(
        '--config',
        type=Path,
        default=DEFAULT_CONFIG_PATH,
        help=f'game configuration (default: {DEFAULT_CONFIG_PATH})',
    )
    parser.add_argument('--timeout', type=float, default=5.0)
    parser.add_argument(
        '--ay-period-constant',
        type=float,
        default=DEFAULT_AY_PERIOD_CONSTANT,
        help=(
            'divide this tuning constant by each legacy pitch '
            f'(default: {DEFAULT_AY_PERIOD_CONSTANT:g}, mapping 0x78 to 0x180)'
        ),
    )
    parser.add_argument(
        '--ay-volume',
        type=lambda value: int(value, 0),
        default=1,
        help='AY channel-A fixed volume, 0x01-0x0f (default: 1)',
    )
    parser.add_argument(
        '--ay-envelope-period',
        type=lambda value: int(value, 0),
        help=(
            'use the hardware envelope with this 16-bit period; '
            'try 0x0080 for a punchy one-shot decay'
        ),
    )
    parser.add_argument(
        '--ay-envelope-shape',
        type=lambda value: int(value, 0),
        default=0x00,
        help='envelope shape 0x0-0xf (default: 0x0, one-shot decay)',
    )
    args = parser.parse_args()
    if args.pitches is None and args.song is None:
        args.pitches = (0x49, 0x50)
    if args.loop and args.song is None:
        parser.error('--loop requires --song')
    if args.start_measure is not None and args.start_measure < 1:
        parser.error('--start-measure must be one or greater')
    if (
        (args.pitches is not None and not args.pitches)
        or any(not 0 <= pitch <= 255 for pitch in (args.pitches or ()))
        or args.ay_period_constant <= 0
        or not 1 <= args.ay_volume <= 0x0f
        or (
            args.ay_envelope_period is not None
            and not 1 <= args.ay_envelope_period <= 0xffff
        )
        or not 0 <= args.ay_envelope_shape <= 0x0f
    ):
        parser.error(
            'pitches and duration must be bytes, and seconds must be positive'
        )
    device = find_device(args.device)
    song = None
    midi_song = None
    if args.song is not None:
        songs = dict(load_game_config(args.config).song_library)
        if args.song in songs:
            song = songs[args.song]
        else:
            try:
                midi_song = load_midi_song_config(args.config, args.song)
            except ValueError as error:
                parser.error(
                    f'{error}; legacy songs: ' + ', '.join(sorted(songs))
                )
    print(f'device: {device}')
    print('Use aperture_roundtrip ROMs (not sound_tester); stop run-game first.')
    with SerialLines(device, args.timeout) as serial:
        mode = serial.command('status')
        print(f'ROMulator status: {mode}')
        synchronize_aperture(serial)
        ay = AyRegisterImage() if song is not None else None
        try:
            if midi_song is not None:
                play_midi_song(
                    serial, midi_song,
                    loop=args.loop or midi_song.loop,
                    start_measure=(
                        midi_song.start_measure
                        if args.start_measure is None
                        else args.start_measure
                    ),
                    end_measure=midi_song.end_measure,
                )
                return 0
            if song is not None:
                action = 'looping' if args.loop else 'playing'
                print(
                    f'{action} AY song {args.song!r} '
                    f'(period constant {args.ay_period_constant:g}, '
                    f'volume {args.ay_volume})',
                    flush=True,
                )
                while True:
                    play_ay_song(
                        serial,
                        song,
                        ay,
                        period_constant=args.ay_period_constant,
                        volume=args.ay_volume,
                        envelope_period=args.ay_envelope_period,
                        envelope_shape=args.ay_envelope_shape,
                        stop_at_end=not args.loop,
                    )
                    if not args.loop:
                        break
                return 0
            ay = AyRegisterImage()
            ay.set_register(7, 0x3e)
            ay.set_volume(1, 0)
            ay.set_volume(2, 0)
            for pitch in args.pitches:
                ay.set_tone_period(0, legacy_pitch_to_ay_period(pitch))
                ay.set_volume(0, args.ay_volume)
                print(f'legacy pitch={pitch:3d} -> AY tone A', flush=True)
                send_ay_frame(serial, ay)
                time.sleep(1.05)
            ay.set_volume(0, 0)
            send_ay_frame(serial, ay)
        except KeyboardInterrupt:
            pass
        finally:
            # This covers MIDI too: play_midi_song owns its own AY mirror, so
            # a local volume-only cleanup cannot reliably stop its note.
            safe_cleanup(serial)
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
