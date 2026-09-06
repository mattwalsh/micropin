#ifndef PINS_H
#define PINS_H

// -----------------------------------------------------------------------
// GPIO pin map — Raspberry Pi Pico (RP2040), five 2716-compatible sockets
// sharing one address bus, one data bus, and five independent chip selects.
//
// GP23, GP24, GP29 are deliberately left alone (SMPS mode select, VBUS
// sense, and VSYS/3 ADC input on the official Pico board).
// -----------------------------------------------------------------------

// Address bus: A0..A10, contiguous GP0..GP10 (11 lines -> 2KB address space)
#define PIN_ADDR_BASE       0
#define ADDR_BIT_COUNT      11
#define ADDR_MASK           ((1u << ADDR_BIT_COUNT) - 1u)          // bits 0..10

// Data bus: D0..D7, contiguous GP11..GP18 (bidirectional, tristated by default)
#define PIN_DATA_BASE       11
#define DATA_BIT_COUNT      8
#define DATA_MASK           (((1u << DATA_BIT_COUNT) - 1u) << PIN_DATA_BASE)

// Chip selects, active low. CE0..CE3 are contiguous; CE4 is off on its own
// pin because GP23 is not freely usable on the Pico board.
#define PIN_CE0             19
#define PIN_CE1             20
#define PIN_CE2             21
#define PIN_CE3             22
#define PIN_CE4             26
#define NUM_CHIPS            5

// Active-low "data bus is being driven" indicator, for use with an external
// level shifter's direction-control pin instead of (or in addition to) the
// RP2040's own GPIO tri-state.
#define PIN_BUS_DRIVEN       27

// Target-CPU reset control. Driven push-pull by the RP2040; see
// reset_control.h for the fail-safe external pull-down this pin relies on.
#define PIN_TARGET_RESET     28

// Onboard LED, used as a heartbeat / USB-activity indicator.
#define PIN_LED              25

#endif // PINS_H
