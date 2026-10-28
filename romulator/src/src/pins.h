#ifndef PINS_H
#define PINS_H

// -----------------------------------------------------------------------
// GPIO pin map — Raspberry Pi Pico (RP2040). The ROMulator sees the shared
// A0..A10 and D0..D7 buses plus three U31 decoder inputs, rather than one
// physical /CE signal per ROM socket.
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

// These three header wires formerly carried active-low CE0..CE2. They now
// carry U31's three positive-logic page bits: CPU A11, A12, and A13.
// Together they select one 2 KiB page in the $0000-$3fff decode region.
#define PIN_CE0             19
#define PIN_CE1             20
#define PIN_CE2             21
#define PIN_PAGE_A11        PIN_CE0
#define PIN_PAGE_A12        PIN_CE1
#define PIN_PAGE_A13        PIN_CE2

// GP22 and GP26 are no longer ROM-select inputs in U31-page mode. GP26
// remains the optional WS2812 output pin in the aperture+LED build.
#define PIN_CE3             22
#define PIN_CE4             26
#define NUM_CHIPS            7

// Active-low "data bus is being driven" indicator, for use with an external
// level shifter's direction-control pin instead of (or in addition to) the
// RP2040's own GPIO tri-state.
#define PIN_BUS_DRIVEN       27

// Active-low target-CPU reset control. See reset_control.h for the open-drain
// drive and weak inactive pull-up policy.
#define PIN_TARGET_RESET     28

// GP25 drives only the onboard LED; it is not present on the Pico headers.
// The LED firmware instead uses the exposed ROM5 /CE4 line (GP26, physical
// header pin 31) and therefore deliberately gives up socket 5 in that build.
#define PIN_LED              25
#define PIN_WS2812_DATA      PIN_CE4

#endif // PINS_H
