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

// True when the persisted directory state contains a valid 2KB coin_5.bin.
// False selects the experimental $2800-$2fff aperture address space.
bool msc_disk_rom5_present(void);

#endif // MSC_DISK_H
