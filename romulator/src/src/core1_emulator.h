#ifndef CORE1_EMULATOR_H
#define CORE1_EMULATOR_H

#include <stdint.h>
#include <stdbool.h>
#include "pins.h"
#include "flash_layout.h"

// Double-buffered RAM image per chip: core0 stages a freshly-flashed image
// into the *inactive* buffer, then flips emu_active_buffer[chip] once the
// copy is complete. Core1 only ever reads emu_active_buffer[chip] to decide
// which buffer to serve from, so a chip's data bus output is never a mix of
// old and new bytes.
extern uint8_t emu_rom_image[NUM_CHIPS][2][IMAGE_SIZE_BYTES];
extern volatile uint8_t emu_active_buffer[NUM_CHIPS];

// Called once from core0 at boot, after emu_rom_image[*][0] has been loaded
// from flash, and before core1 is launched.
void core1_emulator_launch(void);

// Core0 calls this after committing a new image for `chip` into
// emu_rom_image[chip][staging_buffer] to make it live.
void core1_emulator_publish(unsigned chip, unsigned staging_buffer);

#endif // CORE1_EMULATOR_H
