# Pico 5x 2716 EPROM Emulator

Raspberry Pi Pico (RP2040) firmware that emulates five 2716 EPROMs sharing
one address bus, one data bus, and five independent active-low chip
selects. ROM images are updated by dragging five 2KB `.bin` files onto the
Pico, which appears as a small USB drive.

**Status:** this was hand-written and reviewed carefully against the
Pico SDK / TinyUSB APIs, but it has **not been compiled in this environment**
(no internet access here to fetch the SDK). Treat the first build as a
debugging session, not a "should just work" — see the checklist at the
bottom.

## How it works (short version)

- **Core1** runs a tight, RAM-resident polling loop (`src/core1_emulator.c`)
  that reads the address+chip-select GPIOs, looks up the right byte out of
  RAM, and drives the data bus — every cycle, unconditionally. This is what
  meets the 2716's ~450ns access time.
- **Core0** runs TinyUSB in mass-storage mode (`src/msc_disk.c`), backed by
  a minimal hand-built FAT12 filesystem. Writes to a ROM file get staged in
  RAM, then committed to flash (and pushed live to core1's buffers) after a
  short idle period or when the OS sends a SYNCHRONIZE CACHE command.
- **`/TARGET_RESET`** (`src/reset_control.c`) is asserted the instant a USB
  write starts, and released only after the flash commit finishes — so the
  target CPU never sees a stale/mid-update bus during reprogramming.

See the four module headers in `src/` for the details of each piece; the
code is deliberately kept in small, single-purpose files.

## Pin map (Raspberry Pi Pico)

| Signal | GPIO |
|---|---|
| A0–A10 | GP0–GP10 |
| D0–D7 | GP11–GP18 |
| /CE0 | GP19 |
| /CE1 | GP20 |
| /CE2 | GP21 |
| /CE3 | GP22 |
| /CE4 | GP26 |
| /BUS_DRIVEN (active low, asserted while data bus is driven) | GP27 |
| /TARGET_RESET | GP28 |
| Heartbeat LED | GP25 (onboard) |

`pins.h` is the single source of truth for this — change it there if you
need to move pins.

## Hardware notes — `/TARGET_RESET`

GP28 is driven **open-drain**: asserting pulls it low, releasing floats it
(input/high-Z) rather than driving it high. This matches how the rest of
your shared wired-OR reset net presumably already behaves (a pull-up
somewhere on that net, plus possibly other devices that can also pull it
low), so the Pico only ever adds a low pull to the net and never fights
another device trying to hold it low or a pull-up trying to bring it high.

Because of this, there's no fail-safe pull-down needed on this net for the
Pico's sake: before `main()` runs (including during the whole window where
the Pico's own firmware is being reflashed via BOOTSEL), GP28 is
high-impedance, which under this scheme is identical to "released" — there's
no discontinuity where an undriven Pico pin could assert an opinion it
doesn't intend to. Whatever already sequences your reset net's power-on
behavior continues to do so uninterrupted; the Pico is just one more
contributor that can pull it low when it needs extra time.

This assumes an active-low, open-collector-style reset input, which is
standard for this kind of shared net. If your target's reset is active-high
or genuinely needs to be driven high by something, this approach doesn't
apply directly — worth double-checking your reset circuit's actual topology
first.

## Flash layout

Five 4KB flash sectors plus one metadata sector are reserved in the top 64KB of the Pico's 2MB
flash (`src/flash_layout.h`), one per chip, even though each image is only
2KB. The metadata remembers whether `coin_5.bin` exists; deleting it selects
the experimental aperture mode and remains effective after a reboot.

## USB drive limitations (important)

The FAT12 filesystem is a fixed, hand-built layout, not a general-purpose
one — it trades flexibility for being small and simple to reason about.
Concretely:

- The drive presents exactly five files: `ROM0.BIN` … `ROM4.BIN`, one per
  chip select, always 2048 bytes.
- **Keep replacement files exactly 2048 bytes.** Each ROM is tracked by
  *name*, not by a fixed cluster: `msc_disk.c` follows wherever a file's
  directory entry currently points, including through the
  create-new/delete-old/rename sequence Windows and other OSes commonly use
  for a same-name replace. A small pool of genuinely free scratch clusters
  (16KB) gives the OS room to do that safely; anything the OS writes there
  gets buffered and adopted the moment the corresponding directory entry
  points at it, then the layout is snapped back to canonical so the volume
  stays predictable for the next write. Changing a file's *size* still
  isn't supported and will likely get silently ignored (the fixed 2048-byte
  cluster size is baked into the emulator's image buffers).
- After copying files, either use "Eject"/"Safely Remove" or just wait
  about a second before power-cycling the target — that's the window for
  the flash commit to happen and for `/TARGET_RESET` to release.
- The general filesystem view is **not persisted**. ROM images and the
  presence/absence of `coin_5.bin` are persisted; every boot regenerates a
  clean boot sector/FAT/root directory from that state.

The CDC ACM control port accepts `status` followed by a newline and replies
with either `mode rom5` or `mode aperture`. It also accepts `bootsel` to enter
the Pico USB bootloader. In aperture mode, `rx` drains up to 16 bytes received
from the experimental address-strobe channel. The 8085 sends one byte by
reading `$2900 + byte` between `$2a00`/`$2a01` frame markers; the data bus never
reverses direction. `state` reports the current host transaction and Pico
acknowledgement counters for diagnosing a stalled exchange.
Every framed response carries CRC-8/ATM (polynomial `$07`). The Pico does not
acknowledge a damaged frame, causing the 8085 to retransmit it automatically;
host transactions carry the same CRC immediately after their payload, which
the 8085 checks before accepting their sequence. `stats` reports detected
return-channel CRC failures and receive-ring drops.

For the round-trip test, `tx HEXBYTES` publishes up to 64 payload bytes at
`$2803`, writes the length at `$2802`, and advances the sequence at `$2800`
last. A valid framed 8085 response acknowledges that sequence. `rx` returns
the response bytes as `sequence, length, echoed payload, port 0, port 1,
port 4`; for example, the three final bytes after the echo are the switch-port
snapshot captured by the test ROM.

## Notes on the core1 loop's two glitch fixes

Real-hardware testing (comparing what was written against what an EPROM
programmer read back) turned up two distinct sources of bad bytes, both
fixed in `core1_emulator.c`:

- The data bus used to be updated via clear-all-8-bits-then-set-the-right-
  ones, which briefly drove `0x00` on every single loop pass, not just on
  real data changes. Fixed by tracking the currently-latched value and
  updating it with a single atomic `gpio_togl` of only the bits that
  actually change.
- The loop runs fast enough to occasionally catch a genuinely transient
  address value while the driving system's address lines are still
  settling/ringing mid-transition -- something a real (much slower) 2716
  can't do. Fixed with a cheap 2-sample debounce: the raw address+CE
  reading has to repeat before it's trusted.

The debounce adds roughly one extra loop iteration (a few ns) of latency in
the worst case, which is negligible against the ~450ns budget, but it's
worth re-running the logic-analyzer timing check from earlier now that this
changed, rather than assuming the margin is still what it was.



1. Install the **Raspberry Pi Pico** extension from the VS Code Marketplace
   (publisher: Raspberry Pi). On Windows it needs no separate toolchain
   install — the extension downloads and manages the compiler, CMake,
   Ninja, and Pico SDK itself the first time you use it.
2. In VS Code: `File > Open Folder…` and select this project folder.
3. The Pico extension should detect `CMakeLists.txt` and offer to configure
   the project — pick the **Pico** board (not Pico W / Pico 2) and the SDK
   version it suggests (any recent 1.5.x/2.x release is fine).
4. Use the extension's own **Compile** button (bottom status bar, or the
   Raspberry Pi Pico sidebar) rather than the generic CMake Tools build
   button — the README for the extension notes CMake Tools should be used
   for configuration only, with the Pico extension's own buttons for
   compiling/flashing/running.
5. First flash: hold **BOOTSEL** on the Pico, plug it into your Windows PC,
   it will enumerate as a `RPI-RP2` drive; use the extension's **Run**
   button, or manually copy the built `.uf2` from `build/` onto that drive.
   Subsequent updates can use the same BOOTSEL step, or `picotool` if you
   set up a debug probe.

## First-build checklist (things to double check against your installed SDK)

- ~~`PICO_FLASH_ASSUME_CORE1_SAFE` / `sio_hw` field names / `BOARD_TUD_RHPORT` /
  `SCSI_CMD_SYNCHRONIZE_CACHE_10`~~ — already fixed against a real build on
  SDK 2.3.0: the atomic GPIO registers are `sio_hw->gpio_set`/`gpio_clr`
  (not `gpio_out_set`/`gpio_out_clr`), `tud_init(0)` is used directly
  instead of the undefined `BOARD_TUD_RHPORT`, and the SYNCHRONIZE CACHE
  SCSI opcode is used as the literal `0x35` instead of a symbolic name.
  `PICO_FLASH_ASSUME_CORE1_SAFE` compiled fine as-is.

Once it compiles, the two things most worth bench-testing first are (1) the
core1 loop's actual response time on a scope, and (2) that Windows Explorer
successfully round-trips a same-size file overwrite without needing extra
FAT edge cases handled.
