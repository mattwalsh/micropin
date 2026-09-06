#ifndef RESET_CONTROL_H
#define RESET_CONTROL_H

#include <stdbool.h>

// Drives PIN_TARGET_RESET as an open-drain output: asserted = actively pulled
// low, released = floated (input/high-Z), never driven high. This matches
// how every other device on a shared wired-OR reset net behaves, and avoids
// fighting whatever pull-up (and other open-drain devices) already exist on
// that net.
//
// Assumes an ACTIVE-LOW target reset input, which is standard for
// open-collector/wired-OR reset nets. If yours is active-high, this
// approach doesn't apply the same way -- let's revisit the circuit if so.

// Configure the pin and assert reset. Call this as the very first thing in
// main(), before any other init, so the target is held in reset for the
// shortest possible but still complete window.
void reset_control_init(void);

// Called from msc_disk.c whenever a WRITE10 (or a write to the emulated
// filesystem's system area) is received. Asserts reset if not already
// asserted, and resets the release-timeout clock.
void reset_control_notify_write(void);

// Releases reset immediately. Used both at the end of the boot sequence
// (once the emulator is confirmed live) and from msc_disk.c after a flash
// commit finishes / a SCSI SYNCHRONIZE CACHE (10) command arrives, rather
// than waiting for the inactivity timeout.
void reset_control_release(void);
#define reset_control_notify_flush_complete reset_control_release

// Call periodically from the core0 main loop (e.g. once per tud_task()
// iteration). Handles the inactivity-timeout release path for hosts that
// never send SYNCHRONIZE CACHE.
void reset_control_task(void);

bool reset_control_is_asserted(void);

#endif // RESET_CONTROL_H
