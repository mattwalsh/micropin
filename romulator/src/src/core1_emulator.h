#ifndef CORE1_EMULATOR_H
#define CORE1_EMULATOR_H

#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>
#include "pins.h"
#include "flash_layout.h"

// Double-buffered RAM image per chip: core0 stages a freshly-flashed image
// into the *inactive* buffer, then flips emu_active_buffer[chip] once the
// copy is complete. Core1 only ever reads emu_active_buffer[chip] to decide
// which buffer to serve from, so a chip's data bus output is never a mix of
// old and new bytes.
extern uint8_t emu_rom_image[NUM_CHIPS][2][IMAGE_SIZE_BYTES];
extern volatile uint8_t emu_active_buffer[NUM_CHIPS];
extern volatile bool emu_rom5_present;
extern volatile bool emu_aperture_enabled;

// Called once from core0 at boot, after emu_rom_image[*][0] has been loaded
// from flash, and before core1 is launched.
void core1_emulator_launch(void);

// Core0 calls this after committing a new image for `chip` into
// emu_rom_image[chip][staging_buffer] to make it live.
void core1_emulator_publish(unsigned chip, unsigned staging_buffer);

// Configure CE4 independently: a fifth ROM drives it in ROM mode, an explicit
// aperture marker enables the mailbox, and otherwise it remains tristated.
void core1_emulator_set_ce4_mode(bool rom5_present, bool aperture_enabled);

// Drain bytes received through the aperture-mode address-strobe channel.
// The 8085 transmits a byte by reading $2900+byte between $2a00/$2a01 frame
// markers; no reverse data-bus path is required.
size_t core1_emulator_read_strobes(uint8_t *destination, size_t capacity);
uint32_t core1_emulator_strobe_drops(void);
uint32_t core1_emulator_strobe_crc_errors(void);
void core1_emulator_cpu_start_counts(uint32_t *reset_count, uint32_t *trap_count);

// Publish one host transaction into $2800-$28bf. Payload and length are
// written first and the sequence byte at $2800 is changed last. Returns false
// while the previous sequence has not yet been acknowledged by the 8085.
bool core1_emulator_publish_aperture(const uint8_t *payload, size_t length, uint8_t *sequence);
void core1_emulator_aperture_sequences(uint8_t *host_sequence, uint8_t *cpu_ack);
void core1_emulator_strobe_diagnostics(
    uint32_t *frames, uint32_t *malformed, uint32_t *stale,
    uint8_t *sequence, uint8_t *length,
    uint8_t *calculated_crc, uint8_t *received_crc);

#endif // CORE1_EMULATOR_H
