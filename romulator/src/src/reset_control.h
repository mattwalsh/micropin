#ifndef RESET_CONTROL_H
#define RESET_CONTROL_H

#include <stdbool.h>
#include <stdint.h>

// Drives PIN_TARGET_RESET as an open-drain output: asserted = actively pulled
// low, released = input/high-Z with the Pico's weak pull-up, never actively
// driven high. This preserves wired-OR behavior while giving the direct GP28
// connection shown on the Romulator schematic a defined inactive level.
//
// Assumes an ACTIVE-LOW target reset input, which is standard for the 8085.

// Configure the pin and assert reset. Call this as the very first thing in
// main(), before any other initialization.
void reset_control_init(void);

// Assert reset for an explicit long-running operation such as entering the
// Pico BOOTSEL loader, and reset the safety-timeout clock.
void reset_control_notify_write(void);

// Release reset immediately. Used at the end of the Pico boot sequence once
// the emulator is live, and by explicit reset operations.
void reset_control_release(void);
#define reset_control_notify_flush_complete reset_control_release

// Deliberately reset the target CPU for a short, bounded interval. This is the
// only runtime reset path used by the CDC control interface; filesystem and ROM
// commits do not implicitly reset the target.
void reset_control_pulse(void);

// Call periodically from the core0 main loop (e.g. once per tud_task()
// iteration). Handles the inactivity-timeout release path for hosts that
// do not complete normally (for example, an aborted BOOTSEL transition).
void reset_control_task(void);

bool reset_control_is_asserted(void);
uint32_t reset_control_assertions(void);
uint32_t reset_control_falling_edges(void);

#endif // RESET_CONTROL_H
