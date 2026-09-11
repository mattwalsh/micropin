#ifndef MSC_DISK_H
#define MSC_DISK_H

#include <stdbool.h>

// Builds the (RAM-only, regenerated-every-boot) FAT12 system area and loads
// all five chip images from flash into emu_rom_image[*][0]. Call this before
// core1_emulator_launch() and before tud_init().
void msc_disk_init(void);

// Call once per main-loop iteration on core0 (alongside tud_task()). Handles
// the debounced flash-commit of any chip whose data was written over USB
// but hasn't been synced yet.
void msc_disk_task(void);

// Persisted CE4 configuration. Aperture mode is deliberately independent of
// ROM count so an ordinary four-ROM game leaves the empty socket tristated.
bool msc_disk_rom5_present(void);
bool msc_disk_aperture_enabled(void);

// Hide or restore the virtual mass-storage medium without disturbing CDC or
// the running ROM emulator. Ejection persists until an explicit mount or a
// Pico reboot.
void msc_disk_set_ejected(bool ejected);
bool msc_disk_is_ejected(void);

#endif // MSC_DISK_H
