#include "core1_emulator.h"

#include "pico/multicore.h"
#include "pico/platform.h"
#include "hardware/structs/sio.h"
#include "hardware/gpio.h"

uint8_t emu_rom_image[NUM_CHIPS][2][IMAGE_SIZE_BYTES];
volatile uint8_t emu_active_buffer[NUM_CHIPS];

// Precomputed per-chip CE bit position within sio_hw->gpio_in, in priority
// order. If more than one CE is asserted at once (shouldn't happen on real
// hardware, but wiring glitches happen), the lowest-numbered chip wins.
static const uint8_t ce_pin[NUM_CHIPS] = { PIN_CE0, PIN_CE1, PIN_CE2, PIN_CE3, PIN_CE4 };

// -----------------------------------------------------------------------
// This entire function (and everything it calls) is forced into RAM with
// __not_in_flash_func. That guarantees core1 never fetches an instruction
// from flash, so a core0 flash_range_erase()/flash_range_program() call
// (which briefly makes flash entirely unreadable) can never stall or crash
// this loop. It's also why this loop is safe to leave running, unpaused,
// for the entire duration of a USB write session — target CPU bus
// correctness during that window is handled separately by holding
// /TARGET_RESET, not by stopping this loop.
// -----------------------------------------------------------------------
static void __not_in_flash_func(core1_main)(void)
{
    // Data bus starts tristated, bus-driven flag starts deasserted (idle high).
    sio_hw->gpio_oe_clr = DATA_MASK;
    sio_hw->gpio_set = (1u << PIN_BUS_DRIVEN);

    // Tracks exactly what's currently latched on the data pins, so we can
    // update them with a single atomic toggle of only the bits that need
    // to change -- never an intermediate "all zero" state, unlike a
    // clear-then-set sequence.
    uint32_t current_data_bits = 0;

    // Simple 2-sample debounce on the address+CE bus: a raw async loop
    // this fast can catch a genuinely transient value while the driving
    // system's address lines are still settling/ringing mid-transition --
    // something a real (much slower) 2716 physically can't do. Requiring
    // the same raw reading twice in a row filters that out at negligible
    // cost against the 450ns budget.
    uint32_t prev_sample = 0xFFFFFFFFu; // sentinel, guaranteed to mismatch first pass

    while (true) {
        uint32_t gpio_in = sio_hw->gpio_in;

        if (gpio_in != prev_sample) {
            prev_sample = gpio_in;
            continue; // not yet confirmed stable -- leave the bus exactly as it was
        }

        int chip = -1;
        if (!(gpio_in & (1u << PIN_CE0)))      chip = 0;
        else if (!(gpio_in & (1u << PIN_CE1)))  chip = 1;
        else if (!(gpio_in & (1u << PIN_CE2)))  chip = 2;
        else if (!(gpio_in & (1u << PIN_CE3)))  chip = 3;
        else if (!(gpio_in & (1u << PIN_CE4)))  chip = 4;

        if (chip >= 0) {
            uint32_t addr = gpio_in & ADDR_MASK;
            uint8_t buf = emu_active_buffer[chip];
            uint8_t data = emu_rom_image[chip][buf][addr];

            uint32_t data_bits = ((uint32_t)data) << PIN_DATA_BASE;
            uint32_t diff = (data_bits ^ current_data_bits) & DATA_MASK;
            if (diff) {
                sio_hw->gpio_togl = diff; // atomic: touches only the bits that actually change
                current_data_bits = data_bits;
            }
            sio_hw->gpio_oe_set  = DATA_MASK;
            sio_hw->gpio_clr = (1u << PIN_BUS_DRIVEN);     // assert, active low
        } else {
            sio_hw->gpio_oe_clr = DATA_MASK;               // tristate
            sio_hw->gpio_set = (1u << PIN_BUS_DRIVEN);     // deassert, idle high
        }
    }
}

void core1_emulator_launch(void)
{
    multicore_launch_core1(core1_main);
}

void core1_emulator_publish(unsigned chip, unsigned staging_buffer)
{
    // A plain store is all that's needed here: emu_active_buffer[chip] is a
    // single byte, the write is naturally atomic on Cortex-M0+, and core1
    // only ever reads it (never read-modify-writes it), so there's no
    // race to guard against beyond "don't flip it until the staging buffer
    // is fully written" (guaranteed by call-site ordering in msc_disk.c).
    emu_active_buffer[chip] = (uint8_t)staging_buffer;
}
