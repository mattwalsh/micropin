#ifndef MSC_DISK_H
#define MSC_DISK_H

#include <stdbool.h>

typedef enum {
    MSC_DISK_MODE_ROM = 0,
    MSC_DISK_MODE_APERTURE = 1,
} msc_disk_mode_t;

// Builds the (RAM-only, regenerated-every-boot) FAT12 system area and loads
// all chip images from flash into emu_rom_image[*][0]. Call this before
// core1_emulator_launch() and before tud_init().
void msc_disk_init(void);

// Call once per main-loop iteration on core0 (alongside tud_task()). Handles
// the debounced flash-commit of any chip whose data was written over USB
// but hasn't been synced yet.
void msc_disk_task(void);

// Explicit, persisted personality.  It is intentionally independent of the
// set of ROM images stored on the USB volume.
msc_disk_mode_t msc_disk_mode(void);
void msc_disk_set_mode(msc_disk_mode_t mode);

// Hide or restore the virtual mass-storage medium without disturbing CDC or
// the running ROM emulator. Ejection persists until an explicit mount or a
// Pico reboot.
void msc_disk_set_ejected(bool ejected);
bool msc_disk_is_ejected(void);

#endif // MSC_DISK_H
