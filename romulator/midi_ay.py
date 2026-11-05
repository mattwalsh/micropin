"""Small dependency-free Standard MIDI File reader for the AY background player.

The ROMulator host deliberately does not need a heavyweight MIDI stack.  This
module reads the common type-0/type-1, ticks-per-quarter-note flavour of SMF,
keeps note-on/off timing and tempo changes, and leaves synthesis to the caller.
"""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
import math
import struct
import tomllib

from micropin_protocol import AyRegisterImage


DEFAULT_TEMPO_US_PER_QUARTER = 500_000


class MidiFormatError(ValueError):
    """The input is not a supported Standard MIDI File."""


@dataclass(frozen=True)
class MidiNote:
    note: int
    velocity: int
    start_seconds: float
    end_seconds: float


@dataclass(frozen=True)
class MidiTrack:
    index: int
    name: str
    notes: tuple[MidiNote, ...]

    @property
    def duration_seconds(self) -> float:
        return max((note.end_seconds for note in self.notes), default=0.0)


@dataclass(frozen=True)
class MidiVoiceConfig:
    track: str
    channel: int
    # One physical AY channel, or a pool for polyphonic notes from this track.
    # ``channel`` remains the first member for backwards-compatible callers.
    channels: tuple[int, ...]
    volume: int
    a4_period: int
    use_envelope: bool = False
    use_tone: bool = True
    use_noise: bool = False
    priority: int = 0


@dataclass(frozen=True)
class MidiSongConfig:
    """One named, host-side MIDI playback choice from ``micropin_game.toml``."""

    name: str
    path: Path
    voices: tuple[MidiVoiceConfig, ...]
    loop: bool = False
    envelope_period: int | None = None
    envelope_shape: int = 0
    noise_period: int | None = None
    # One-based MIDI measure to use as the playback origin.
    start_measure: int = 1
    # Inclusive one-based measure at which playback stops or loops.  None
    # means through the MIDI file's natural end.
    end_measure: int | None = None


@dataclass(frozen=True)
class MidiVoiceState:
    """The currently desired state of one scheduled MIDI source."""

    active: bool
    period: int | None
    generation: int


@dataclass(frozen=True)
class MidiFile:
    ticks_per_quarter: int
    tracks: tuple[MidiTrack, ...]
    beats_per_measure: float = 4.0
    tempos: tuple[tuple[int, int], ...] = ((0, DEFAULT_TEMPO_US_PER_QUARTER),)

    def select_track(self, selector: str) -> MidiTrack:
        """Find a track by its displayed name or zero-based numeric index."""
        try:
            index = int(selector, 10)
        except ValueError:
            index = None
        if index is not None:
            if 0 <= index < len(self.tracks):
                return self.tracks[index]
        else:
            wanted = selector.casefold()
            for track in self.tracks:
                if track.name.casefold() == wanted:
                    return track
        choices = ", ".join(
            f'{track.index}: {track.name or "(unnamed)"}' for track in self.tracks
        )
        raise ValueError(f"MIDI track {selector!r} was not found; choices: {choices}")

    def seconds_at_measure(self, measure: int) -> float:
        """Return the start time of a one-based measure in this MIDI file."""
        if measure < 1:
            raise ValueError("MIDI measure must be one or greater")
        tick = round((measure - 1) * self.beats_per_measure * self.ticks_per_quarter)
        return _seconds_at_tick(tick, self.ticks_per_quarter, self.tempos)


@dataclass(frozen=True)
class _RawNote:
    note: int
    velocity: int
    start_tick: int
    end_tick: int


def _read_vlq(data: bytes, position: int) -> tuple[int, int]:
    value = 0
    for _ in range(4):
        if position >= len(data):
            raise MidiFormatError("truncated variable-length MIDI value")
        byte = data[position]
        position += 1
        value = (value << 7) | (byte & 0x7f)
        if not byte & 0x80:
            return value, position
    raise MidiFormatError("MIDI variable-length value exceeds four bytes")


def _parse_track(
    data: bytes,
) -> tuple[str, list[_RawNote], list[tuple[int, int]], list[tuple[int, int, int]]]:
    position = 0
    tick = 0
    running_status: int | None = None
    name = ""
    tempos: list[tuple[int, int]] = []
    time_signatures: list[tuple[int, int, int]] = []
    notes: list[_RawNote] = []
    active: dict[tuple[int, int], list[tuple[int, int]]] = {}

    while position < len(data):
        delta, position = _read_vlq(data, position)
        tick += delta
        if position >= len(data):
            raise MidiFormatError("truncated MIDI event")
        status_or_data = data[position]
        position += 1
        first_data: int | None = None
        if status_or_data < 0x80:
            if running_status is None:
                raise MidiFormatError("MIDI data byte without running status")
            status = running_status
            first_data = status_or_data
        else:
            status = status_or_data
            if 0x80 <= status <= 0xef:
                running_status = status

        if status == 0xff:
            if position >= len(data):
                raise MidiFormatError("truncated MIDI meta event")
            meta_type = data[position]
            position += 1
            length, position = _read_vlq(data, position)
            end = position + length
            if end > len(data):
                raise MidiFormatError("truncated MIDI meta-event payload")
            payload = data[position:end]
            position = end
            if meta_type == 0x03:
                name = payload.decode("latin-1", errors="replace")
            elif meta_type == 0x51:
                if len(payload) != 3:
                    raise MidiFormatError("MIDI tempo event must contain three bytes")
                tempos.append((tick, int.from_bytes(payload, "big")))
            elif meta_type == 0x58 and len(payload) >= 2:
                time_signatures.append((tick, payload[0], payload[1]))
            continue
        if status in (0xf0, 0xf7):
            length, position = _read_vlq(data, position)
            position += length
            if position > len(data):
                raise MidiFormatError("truncated MIDI sysex payload")
            continue
        if not 0x80 <= status <= 0xef:
            raise MidiFormatError(f"unsupported MIDI system status 0x{status:02x}")

        message_type = status & 0xf0
        channel = status & 0x0f
        if first_data is None:
            if position >= len(data):
                raise MidiFormatError("truncated MIDI channel event")
            first_data = data[position]
            position += 1
        if message_type in (0xc0, 0xd0):
            continue
        if position >= len(data):
            raise MidiFormatError("truncated MIDI channel event")
        second_data = data[position]
        position += 1
        key = (channel, first_data)
        if message_type == 0x90 and second_data:
            active.setdefault(key, []).append((tick, second_data))
        elif message_type == 0x80 or (message_type == 0x90 and not second_data):
            starts = active.get(key)
            if starts:
                start_tick, velocity = starts.pop(0)
                notes.append(_RawNote(first_data, velocity, start_tick, tick))

    # A few hand-authored MIDI files omit final note-off events.  End those
    # notes at the end of their track rather than silently discarding them.
    for (_channel, note), starts in active.items():
        for start_tick, velocity in starts:
            notes.append(_RawNote(note, velocity, start_tick, tick))
    return name, notes, tempos, time_signatures


def _seconds_at_tick(
    tick: int, ticks_per_quarter: int, tempos: tuple[tuple[int, int], ...]
) -> float:
    elapsed = 0.0
    previous_tick = 0
    tempo = DEFAULT_TEMPO_US_PER_QUARTER
    for tempo_tick, new_tempo in tempos:
        if tempo_tick >= tick:
            break
        elapsed += (tempo_tick - previous_tick) * tempo / ticks_per_quarter / 1_000_000
        previous_tick = tempo_tick
        tempo = new_tempo
    return elapsed + (tick - previous_tick) * tempo / ticks_per_quarter / 1_000_000


def load_midi(path: Path) -> MidiFile:
    """Load a PPQN type-0 or type-1 SMF without requiring :mod:`mido`."""
    source = Path(path)
    data = source.read_bytes()
    if len(data) < 14 or data[:4] != b"MThd":
        raise MidiFormatError(f"{source}: missing MIDI MThd header")
    header_length = struct.unpack(">I", data[4:8])[0]
    if header_length < 6 or len(data) < 8 + header_length:
        raise MidiFormatError(f"{source}: malformed MIDI header")
    midi_format, track_count, division = struct.unpack(">HHH", data[8:14])
    if midi_format not in (0, 1):
        raise MidiFormatError(f"{source}: MIDI format {midi_format} is not supported")
    if division & 0x8000:
        raise MidiFormatError(f"{source}: SMPTE-timed MIDI is not supported")
    if division == 0:
        raise MidiFormatError(f"{source}: zero ticks-per-quarter")

    position = 8 + header_length
    parsed_tracks: list[tuple[str, list[_RawNote]]] = []
    all_tempos: list[tuple[int, int]] = []
    all_time_signatures: list[tuple[int, int, int]] = []
    for _ in range(track_count):
        if position + 8 > len(data) or data[position:position + 4] != b"MTrk":
            raise MidiFormatError(f"{source}: missing MTrk chunk")
        length = struct.unpack(">I", data[position + 4:position + 8])[0]
        position += 8
        end = position + length
        if end > len(data):
            raise MidiFormatError(f"{source}: truncated MTrk chunk")
        name, notes, tempos, time_signatures = _parse_track(data[position:end])
        position = end
        parsed_tracks.append((name, notes))
        all_tempos.extend(tempos)
        all_time_signatures.extend(time_signatures)

    # For duplicate tempo events at a tick, later track order wins.  (The
    # supplied song has one tempo event, but this keeps the behaviour defined.)
    tempo_by_tick: dict[int, int] = {0: DEFAULT_TEMPO_US_PER_QUARTER}
    for tempo_tick, tempo in all_tempos:
        tempo_by_tick[tempo_tick] = tempo
    tempos = tuple(sorted(tempo_by_tick.items()))
    tracks = tuple(
        MidiTrack(
            index=index,
            name=name,
            notes=tuple(
                MidiNote(
                    note=note.note,
                    velocity=note.velocity,
                    start_seconds=_seconds_at_tick(note.start_tick, division, tempos),
                    end_seconds=_seconds_at_tick(note.end_tick, division, tempos),
                )
                for note in sorted(raw_notes, key=lambda item: (item.start_tick, item.end_tick))
            ),
        )
        for index, (name, raw_notes) in enumerate(parsed_tracks)
    )
    numerator, denominator_power = next(
        ((numerator, denominator_power)
         for tick, numerator, denominator_power in all_time_signatures if tick == 0),
        (4, 2),
    )
    return MidiFile(
        division,
        tracks,
        beats_per_measure=numerator * 4 / (1 << denominator_power),
        tempos=tempos,
    )


def midi_note_to_ay_period(note: int, *, a4_period: int = 142) -> int:
    """Convert a MIDI note number to an AY 12-bit tone period.

    ``a4_period=142`` is the nominal 1 MHz AY clock calibration.  The result
    is intentionally exposed because the real board may invite a later
    one-number tuning adjustment after comparing it by ear with the game.
    """
    if not 0 <= note <= 127:
        raise ValueError("MIDI note must be 0-127")
    if not 1 <= a4_period <= 0x0fff:
        raise ValueError("AY A4 period must fit in 12 bits and be nonzero")
    period = round(a4_period * math.pow(2, (69 - note) / 12))
    return min(0x0fff, max(1, period))


class MidiAySequencer:
    """Turn one MIDI track into scheduled writes for one AY voice."""

    def __init__(
        self,
        track: MidiTrack,
        *,
        channel: int,
        volume: int,
        loop: bool,
        a4_period: int,
        started_at: float,
        use_envelope: bool = False,
        envelope_shape: int = 0,
        window_start_seconds: float = 0.0,
        window_end_seconds: float | None = None,
    ) -> None:
        if channel not in range(3):
            raise ValueError("MIDI AY channel must be 0, 1, or 2")
        if not 1 <= volume <= 0x0f:
            raise ValueError("MIDI AY volume must be 1-15")
        if not 0 <= envelope_shape <= 0x0f:
            raise ValueError("AY envelope shape must be 0-15")
        if not track.notes or track.duration_seconds <= 0:
            raise ValueError(f"MIDI track {track.name!r} has no positive duration")
        self.channel = channel
        self.volume = volume
        self.use_envelope = use_envelope
        self.envelope_shape = envelope_shape
        self.loop = loop
        self.a4_period = a4_period
        self.started_at = started_at
        if window_start_seconds < 0:
            raise ValueError("MIDI playback window start must not be negative")
        if window_end_seconds is None:
            window_end_seconds = track.duration_seconds
        if window_end_seconds <= window_start_seconds:
            raise ValueError("MIDI playback window must have positive duration")
        self.duration = window_end_seconds - window_start_seconds
        self.window_start_seconds = window_start_seconds
        self.window_end_seconds = window_end_seconds
        # At one tick, note-off must win before note-on: no stale old pitch.
        # Rebase events into the configured window.  A note that began before
        # the window remains audible at its beginning; a note that extends
        # beyond it receives an artificial note-off at its end.  Therefore a
        # looping excerpt restarts cleanly at its own start/end, rather than
        # falling through to the complete MIDI file.
        events: list[tuple[float, bool, int]] = []
        for note in track.notes:
            if note.end_seconds <= window_start_seconds or note.start_seconds >= window_end_seconds:
                continue
            events.append((
                max(0.0, note.start_seconds - window_start_seconds),
                True,
                note.note,
            ))
            events.append((
                min(self.duration, note.end_seconds - window_start_seconds),
                False,
                note.note,
            ))
        self.events = tuple(sorted(
            events,
            key=lambda event: (event[0], event[1]),
        ))
        self.next_event = 0
        self.active_notes: list[int] = []
        self._silent = False
        self._generation = 0

    @property
    def finished(self) -> bool:
        return not self.loop and self.next_event == len(self.events) and not self.active_notes

    @property
    def voice_state(self) -> MidiVoiceState:
        if not self.active_notes:
            return MidiVoiceState(False, None, self._generation)
        return MidiVoiceState(
            True,
            self.active_periods[0],
            self._generation,
        )

    @property
    def active_periods(self) -> tuple[int, ...]:
        """Active notes, highest pitch first, expressed as AY periods.

        The AY only has three tone generators.  A caller assigning a MIDI
        track to a two-channel pool gets the top two simultaneous notes rather
        than whichever note happened to arrive most recently.
        """
        return tuple(
            midi_note_to_ay_period(note, a4_period=self.a4_period)
            for note in sorted(self.active_notes, reverse=True)
        )

    def _apply_event(self, note_on: bool, note: int) -> None:
        if note_on:
            self.active_notes.append(note)
            return
        for index in range(len(self.active_notes) - 1, -1, -1):
            if self.active_notes[index] == note:
                del self.active_notes[index]
                return

    def _write_voice(self, registers: AyRegisterImage) -> None:
        if self.active_notes:
            registers.set_tone_period(
                self.channel,
                midi_note_to_ay_period(self.active_notes[-1], a4_period=self.a4_period),
            )
            # Bit 4 selects the AY's one shared envelope generator.  The
            # fixed 0-15 level is deliberately not combined with it.
            registers.set_volume(self.channel, 0x10 if self.use_envelope else self.volume)
            self._silent = False
        elif not self._silent:
            registers.set_volume(self.channel, 0)
            self._silent = True

    def advance_timeline(self, *, now: float) -> tuple[bool, bool]:
        """Advance timing only; return ``(changed, saw_note_on)``.

        A channel arbiter can use this to multiplex multiple MIDI sources onto
        one physical AY channel without letting them race to write registers.
        """
        elapsed = max(0.0, now - self.started_at)
        changed = False
        while self.loop and elapsed >= self.duration:
            self.started_at += self.duration
            elapsed -= self.duration
            self.next_event = 0
            self.active_notes.clear()
            self._silent = False
            changed = True
        note_on_seen = False
        while self.next_event < len(self.events):
            event_time, note_on, note = self.events[self.next_event]
            if event_time > elapsed:
                break
            self._apply_event(note_on, note)
            note_on_seen |= note_on
            self.next_event += 1
            changed = True
        if changed:
            self._generation += 1
        return changed, note_on_seen

    def advance(self, registers: AyRegisterImage, *, now: float) -> None:
        changed, note_on_seen = self.advance_timeline(now=now)
        if changed:
            self._write_voice(registers)
            if self.use_envelope and note_on_seen and self.active_notes:
                # R13 is the shared envelope's start/restart strobe.  Its
                # period/shape are song-level configuration, but every note
                # onset on an envelope voice needs a fresh attack.
                registers.trigger_envelope(self.envelope_shape)


def load_midi_song_config(config_path: Path, name: str) -> MidiSongConfig:
    """Load one named MIDI choice without burdening game-rule configuration."""
    config_path = Path(config_path)
    with config_path.open("rb") as config_file:
        data = tomllib.load(config_file)
    songs = data.get("midi_songs", {})
    music = data.get("music", {})
    audio = data.get("audio", {})
    if not isinstance(music, dict) or not isinstance(audio, dict):
        raise ValueError("music and audio must be tables")
    default_volume = int(audio.get("midi_volume", music.get("midi_volume", 2)))
    if not 1 <= default_volume <= 0x0f:
        raise ValueError("audio.midi_volume must be 1-15")
    source = songs.get(name) if isinstance(songs, dict) else None
    if not isinstance(source, dict):
        available = ", ".join(sorted(songs)) if isinstance(songs, dict) else ""
        raise ValueError(f"unknown MIDI song {name!r}; available: {available}")
    try:
        filename = Path(str(source["file"]))
    except KeyError as error:
        raise ValueError(f"midi_songs.{name}.file is required") from error
    path = filename if filename.is_absolute() else config_path.parent / filename
    loop = bool(source.get("loop", False))
    envelope_period = source.get("envelope_period")
    if envelope_period is not None:
        envelope_period = int(envelope_period)
        if not 1 <= envelope_period <= 0xffff:
            raise ValueError(f"midi_songs.{name}.envelope_period must be 1-65535")
    envelope_shape = int(source.get("envelope_shape", 0))
    if not 0 <= envelope_shape <= 0x0f:
        raise ValueError(f"midi_songs.{name}.envelope_shape must be 0-15")
    noise_period = source.get("noise_period")
    if noise_period is not None:
        noise_period = int(noise_period)
        if not 0 <= noise_period <= 0x1f:
            raise ValueError(f"midi_songs.{name}.noise_period must be 0-31")
    start_measure = int(source.get("start_measure", 1))
    end_raw = source.get("end_measure")
    end_measure = None if end_raw is None else int(end_raw)
    if start_measure < 1 or (end_measure is not None and end_measure < start_measure):
        raise ValueError(
            f"midi_songs.{name} requires start_measure >= 1 and end_measure >= start_measure"
        )
    voice_sources = source.get("voices")
    if voice_sources is None:  # Read the original single-voice form too.
        voice_sources = (source,)
    if not isinstance(voice_sources, list | tuple) or not voice_sources:
        raise ValueError(f"midi_songs.{name}.voices must be a nonempty list")
    voices: list[MidiVoiceConfig] = []
    for index, voice in enumerate(voice_sources):
        if not isinstance(voice, dict):
            raise ValueError(f"midi_songs.{name}.voices[{index}] must be a table")
        track = str(voice.get("track", "Synth Pluck (Classic)"))
        raw_channels = voice.get("channels")
        if raw_channels is None:
            channels = (int(voice.get("channel", 1)),)
        elif isinstance(raw_channels, list | tuple) and raw_channels:
            channels = tuple(int(channel) for channel in raw_channels)
        else:
            raise ValueError(
                f"midi_songs.{name}.voices[{index}].channels must be a nonempty list"
            )
        channel = channels[0]
        # A voice may still override this deliberately, but ordinary MIDI
        # arrangements inherit the global music setting.
        volume = int(voice.get("volume", default_volume))
        a4_period = int(voice.get("a4_period", 142))
        use_envelope = bool(voice.get("use_envelope", False))
        use_tone = bool(voice.get("use_tone", True))
        use_noise = bool(voice.get("use_noise", False))
        priority = int(voice.get("priority", index))
        if any(channel not in (0, 1, 2) for channel in channels):
            raise ValueError(
                f"midi_songs.{name}.voices[{index}].channels must contain only 0, 1, or 2"
            )
        if len(channels) != len(set(channels)):
            raise ValueError(f"midi_songs.{name}.voices[{index}].channels must be distinct")
        if not 1 <= volume <= 0x0f:
            raise ValueError(f"midi_songs.{name}.voices[{index}].volume must be 1-15")
        if not use_tone and not use_noise:
            raise ValueError(
                f"midi_songs.{name}.voices[{index}] must enable tone or noise"
            )
        if priority < 0:
            raise ValueError(f"midi_songs.{name}.voices[{index}].priority must be nonnegative")
        voices.append(MidiVoiceConfig(
            track=track, channel=channel, channels=channels, volume=volume,
            a4_period=a4_period, use_envelope=use_envelope,
            use_tone=use_tone, use_noise=use_noise, priority=priority,
        ))
    for channel in range(3):
        priorities = [
            voice.priority for voice in voices if channel in voice.channels
        ]
        if len(priorities) != len(set(priorities)):
            raise ValueError(
                f"midi_songs.{name}.voices on AY channel {channel} must have distinct priorities"
            )
    return MidiSongConfig(
        name, path, tuple(voices), loop, envelope_period, envelope_shape,
        noise_period, start_measure, end_measure,
    )
