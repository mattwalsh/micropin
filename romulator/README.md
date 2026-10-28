# Micropin ROMulator

This is the one permanent ROMulator configuration for the Micropin board.
It emulates ROM pages from a Pico, offers the 8085 mailbox used by the host
game software, and drives the WS2812 LED strip.

## Build and flash

From the repository root:

```sh
make
./romulator-reload --device /dev/cu.usbmodemEPROM5_00011
```

The resulting UF2 is `romulator/build/pico_eprom_emulator.uf2`. There are no
separate standard or LED firmware builds.

## Address map

The Pico reads three U31 decoder inputs wired to CPU A11, A12, and A13. Each
page is 2 KB.

| CPU range | Page | Normal ROM mode | Aperture mode |
| --- | ---: | --- | --- |
| `$0000-$07FF` | 0 | `COIN_1.BIN` | `COIN_1.BIN` |
| `$0800-$0FFF` | 1 | `COIN_2.BIN` | `COIN_2.BIN` |
| `$1000-$17FF` | 2 | `COIN_3.BIN` | mailbox aperture |
| `$1800-$1FFF` | 3 | `COIN_4.BIN` | `COIN_4.BIN` |
| `$2000-$27FF` | 4 | motherboard RAM | motherboard RAM |
| `$2800-$2FFF` | 5 | `COIN_5.BIN` | `COIN_5.BIN` |
| `$3000-$37FF` | 6 | `COIN_6.BIN` | `COIN_6.BIN` |
| `$3800-$3FFF` | 7 | `COIN_7.BIN` | `COIN_7.BIN` |

The aperture is permanently located at `$1000-$17FF`; it never occupies ROM 5.
GP26 is permanently available for the WS2812 data signal.

## Runtime modes

The chosen mode is stored in Pico flash and survives power loss.

```sh
./romulator-mode aperture --device /dev/cu.usbmodemEPROM5_00011
./romulator-mode rom --device /dev/cu.usbmodemEPROM5_00011
```

Changing mode briefly resets the 8085 so it begins execution with a matching
ROM image set. `aperture` is the normal choice for the host-controlled game;
it reserves page 2 for the mailbox. `rom` is for conventional images that use
page 2 as normal program ROM.

## ROM images

The USB drive is named `EPROMEMU` and exposes `COIN_1.BIN` through
`COIN_7.BIN`. Every image is exactly 2 KB. Copying images only changes their
contents; it never changes the selected runtime mode.

The normal aperture image set is in `../aperture_roundtrip`:

```sh
cp -X aperture_roundtrip/coin_{1,2,3,4}.bin /Volumes/EPROMEMU/
./romulator-eject --device /dev/cu.usbmodemEPROM5_00011
```

`aperture_roundtrip.asm` deliberately leaves page 2 free and defines its
mailbox sequence byte at `$1000`.

## LEDs and control USB

The control CDC device accepts firmware maintenance commands such as `reset`,
`bootsel`, and `setmode`. The second CDC device carries raw WS2812 frames.
GP26 is the LED data output; power the strip from its own fused 5 V supply and
tie its ground to Pico ground.
