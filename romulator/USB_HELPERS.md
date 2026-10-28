# USB helpers on macOS and Linux

Run these from the repository root. Stop `run-game` before maintenance: the
helpers and game must not share the CDC serial interface concurrently.

```sh
./romulator-reset
./romulator-mode rom
./romulator-mode aperture
./romulator-mount
./romulator-eject
./romulator-reload                       # romulator/build/pico_eprom_emulator.uf2
./romulator-reload /path/to/prebuilt.uf2  # no compilation performed
python3 romulator/usb_helpers.py info     # read-only discovery
```

Every helper accepts `--device /dev/...` to override automatic discovery.
`mount` and firmware reloads accept `--timeout 30` for slow USB enumeration.

macOS uses `/dev/cu.usbmodemEPROM5*` and `/Volumes/<label>`. Linux prefers
`/dev/serial/by-id/*EPROM*if00*`, falling back to `/dev/ttyACM*`. Storage is
discovered by label using `lsblk`; unmounted Linux volumes are mounted using
`udisksctl` (provided by `udisks2`). Multiple matching devices are rejected.
If Linux denies mounting, mount the indicated block device administratively
first, then rerun the helper. The scripts do not silently elevate privileges.

`romulator-mount` prints the actual ROM storage path. Copy ROMs there using
`cp -X` on macOS or ordinary `cp` on Linux. Then run `romulator-eject`, which
flushes/unmounts the filesystem before sending the firmware eject command.

Firmware reload validates the source file before entering BOOTSEL, waits for
`RPI-RP2`, and copies the already-built UF2. Build firmware on the Mac; the Pi
does not need the Pico compiler toolchain.

`romulator-mode` selects and persists the ROMulator personality in Pico flash.
`rom` exposes the regular image at `$2800-$2fff`; `aperture` reserves that
page for the mailbox. Switching mode automatically resets the target CPU, so
use ROM images assembled for the selected personality.
