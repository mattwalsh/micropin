#include "core1_emulator.h"

#include "pico/multicore.h"
#include "pico/platform.h"
#include "hardware/structs/sio.h"
#include "hardware/gpio.h"

uint8_t emu_rom_image[NUM_CHIPS][2][IMAGE_SIZE_BYTES];
volatile uint8_t emu_active_buffer[NUM_CHIPS];
volatile bool emu_rom5_present = true;

#define STROBE_RING_SIZE 256u
#define STROBE_HIGH_BASE 0x0c0u
#define STROBE_LOW_BASE  0x0d0u
#define STROBE_FRAME_START 0x0e0u
#define STROBE_FRAME_END   0x0e1u
#define STROBE_NIBBLE_MASK 0x0fu
#define APERTURE_INPUT_SIZE 0x0c0u
#define APERTURE_CPU_ACK_OFFSET 1u
#define APERTURE_LENGTH_OFFSET 2u
#define APERTURE_PAYLOAD_OFFSET 3u
#define APERTURE_MAX_PAYLOAD (APERTURE_INPUT_SIZE - APERTURE_PAYLOAD_OFFSET - 1u)
#define STROBE_FRAME_MAX (APERTURE_MAX_PAYLOAD + 3u)

static volatile uint8_t s_strobe_ring[STROBE_RING_SIZE];
static volatile uint8_t s_strobe_head;
static volatile uint8_t s_strobe_tail;
static volatile uint32_t s_strobe_drops;
static volatile uint32_t s_strobe_crc_errors;
static volatile uint32_t s_strobe_frames;
static volatile uint32_t s_strobe_malformed;
static volatile uint32_t s_strobe_stale;
static volatile uint8_t s_strobe_last_sequence;
static volatile uint8_t s_strobe_last_length;
static volatile uint8_t s_strobe_last_calculated_crc;
static volatile uint8_t s_strobe_last_received_crc;
static volatile uint8_t s_aperture_input[APERTURE_INPUT_SIZE];
static volatile uint8_t s_cpu_ack;

static inline void __not_in_flash_func(strobe_push)(uint8_t value)
{
    uint8_t next = (uint8_t)(s_strobe_head + 1u);
    if (next == s_strobe_tail) {
        s_strobe_drops++;
        return;
    }
    s_strobe_ring[s_strobe_head] = value;
    __compiler_memory_barrier();
    s_strobe_head = next;
}

static inline size_t __not_in_flash_func(strobe_ring_free)(void)
{
    return (uint8_t)(s_strobe_tail - s_strobe_head - 1u);
}

static inline uint8_t __not_in_flash_func(crc8_update)(uint8_t crc, uint8_t value)
{
    crc ^= value;
    for (unsigned bit = 0; bit < 8u; bit++) {
        crc = (uint8_t)((crc << 1) ^ ((crc & 0x80u) ? 0x07u : 0u));
    }
    return crc;
}

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
    uint32_t previous_strobe_addr = 0xffffffffu;
    uint8_t strobe_high_nibble = 0;
    bool strobe_high_valid = false;
    uint8_t strobe_frame[STROBE_FRAME_MAX];
    size_t strobe_frame_length = 0;
    bool strobe_frame_active = false;

    const uint32_t ce_mask = (1u << PIN_CE0) | (1u << PIN_CE1) |
        (1u << PIN_CE2) | (1u << PIN_CE3) | (1u << PIN_CE4);
    const uint32_t sampled_bus_mask = ADDR_MASK | ce_mask;

    while (true) {
        uint32_t gpio_in = sio_hw->gpio_in;
        uint32_t bus_sample = gpio_in & sampled_bus_mask;

        if (bus_sample != prev_sample) {
            prev_sample = bus_sample;
            continue; // not yet confirmed stable -- leave the bus exactly as it was
        }

        int chip = -1;
        if (!(gpio_in & (1u << PIN_CE0)))      chip = 0;
        else if (!(gpio_in & (1u << PIN_CE1)))  chip = 1;
        else if (!(gpio_in & (1u << PIN_CE2)))  chip = 2;
        else if (!(gpio_in & (1u << PIN_CE3)))  chip = 3;
        else if (!(gpio_in & (1u << PIN_CE4)))  chip = 4;

        const uint32_t addr = gpio_in & ADDR_MASK;
        const bool aperture_cycle = chip == 4 && !emu_rom5_present;
        const bool aperture_strobe = aperture_cycle && addr >= APERTURE_INPUT_SIZE;

        // Service the target's data bus first. This is the timing-critical
        // path: on an aperture read the 8085 was otherwise sampling the $28
        // operand byte from its preceding LDA before we reached the GPIO
        // update. Protocol parsing can safely happen after D0..D7 are valid.
        if (chip >= 0 && !aperture_strobe) {
            uint8_t data;
            if (aperture_cycle) {
                if (addr == APERTURE_CPU_ACK_OFFSET) data = s_cpu_ack;
                else data = s_aperture_input[addr];
            } else {
                uint8_t buf = emu_active_buffer[chip];
                data = emu_rom_image[chip][buf][addr];
            }

            uint32_t data_bits = ((uint32_t)data) << PIN_DATA_BASE;
            uint32_t diff = (data_bits ^ current_data_bits) & DATA_MASK;
            if (diff) {
                sio_hw->gpio_togl = diff;
                current_data_bits = data_bits;
            }
            sio_hw->gpio_oe_set = DATA_MASK;
            sio_hw->gpio_clr = (1u << PIN_BUS_DRIVEN);
        } else {
            // Strobe reads encode their data on the address bus, so D0..D7
            // must be released just like a cycle with no selected ROM.
            sio_hw->gpio_oe_clr = DATA_MASK;
            sio_hw->gpio_set = (1u << PIN_BUS_DRIVEN);
        }

        if (aperture_cycle) {
            if (!aperture_strobe) {
                previous_strobe_addr = 0xffffffffu;
            } else if (addr != previous_strobe_addr) {
                previous_strobe_addr = addr;
                if (addr == STROBE_FRAME_START) {
                    strobe_frame_active = true;
                    strobe_frame_length = 0;
                    strobe_high_valid = false;
                } else if (addr == STROBE_FRAME_END) {
                    if (strobe_frame_active) s_strobe_frames++;
                    if (strobe_frame_active && strobe_frame_length >= 3u &&
                        strobe_frame_length == (size_t)strobe_frame[1] + 3u) {
                        size_t delivered_length = strobe_frame_length - 1u;
                        uint8_t crc = 0;
                        for (size_t i = 0; i < delivered_length; i++) crc = crc8_update(crc, strobe_frame[i]);
                        s_strobe_last_sequence = strobe_frame[0];
                        s_strobe_last_length = strobe_frame[1];
                        s_strobe_last_calculated_crc = crc;
                        s_strobe_last_received_crc = strobe_frame[delivered_length];
                        if (crc != strobe_frame[delivered_length]) {
                            s_strobe_crc_errors++;
                        } else if (strobe_frame[0] == s_cpu_ack) {
                            // A retry of an already accepted transaction is
                            // acknowledged but never delivered twice.
                        } else if (strobe_frame[0] != s_aperture_input[0]) {
                            // Only the currently pending host sequence is a
                            // legal response. A stale but internally valid
                            // frame must never rewind the acknowledgement.
                            s_strobe_stale++;
                        } else if (strobe_ring_free() >= delivered_length) {
                            for (size_t i = 0; i < delivered_length; i++) strobe_push(strobe_frame[i]);
                            __compiler_memory_barrier();
                            s_cpu_ack = strobe_frame[0];
                        } else {
                            s_strobe_drops += (uint32_t)delivered_length;
                        }
                    } else if (strobe_frame_active) {
                        s_strobe_malformed++;
                    }
                    strobe_frame_active = false;
                    strobe_high_valid = false;
                } else if ((addr & ~STROBE_NIBBLE_MASK) == STROBE_HIGH_BASE) {
                    strobe_high_nibble = (uint8_t)(addr & STROBE_NIBBLE_MASK);
                    strobe_high_valid = true;
                } else if ((addr & ~STROBE_NIBBLE_MASK) == STROBE_LOW_BASE && strobe_high_valid) {
                    uint8_t value = (uint8_t)((strobe_high_nibble << 4) | (addr & STROBE_NIBBLE_MASK));
                    if (strobe_frame_active) {
                        if (strobe_frame_length < sizeof strobe_frame) strobe_frame[strobe_frame_length++] = value;
                        else strobe_frame_active = false;
                    }
                    strobe_high_valid = false;
                }
            }
        } else {
            previous_strobe_addr = 0xffffffffu;
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

void core1_emulator_set_rom5_present(bool present)
{
    emu_rom5_present = present;
}

size_t core1_emulator_read_strobes(uint8_t *destination, size_t capacity)
{
    size_t count = 0;
    while (count < capacity && s_strobe_tail != s_strobe_head) {
        destination[count++] = s_strobe_ring[s_strobe_tail];
        __compiler_memory_barrier();
        s_strobe_tail = (uint8_t)(s_strobe_tail + 1u);
    }
    return count;
}

uint32_t core1_emulator_strobe_drops(void)
{
    return s_strobe_drops;
}

uint32_t core1_emulator_strobe_crc_errors(void)
{
    return s_strobe_crc_errors;
}

bool core1_emulator_publish_aperture(const uint8_t *payload, size_t length, uint8_t *sequence)
{
    if (emu_rom5_present || length > APERTURE_MAX_PAYLOAD ||
        s_aperture_input[0] != s_cpu_ack) return false;

    uint8_t next = (uint8_t)(s_aperture_input[0] + 1u);
    uint8_t crc = crc8_update(0, next);
    crc = crc8_update(crc, (uint8_t)length);
    for (size_t i = 0; i < length; i++) {
        s_aperture_input[APERTURE_PAYLOAD_OFFSET + i] = payload[i];
        crc = crc8_update(crc, payload[i]);
    }
    s_aperture_input[APERTURE_PAYLOAD_OFFSET + length] = crc;
    s_aperture_input[APERTURE_LENGTH_OFFSET] = (uint8_t)length;
    __compiler_memory_barrier();
    s_aperture_input[0] = next;
    if (sequence) *sequence = next;
    return true;
}

void core1_emulator_aperture_sequences(uint8_t *host_sequence, uint8_t *cpu_ack)
{
    if (host_sequence) *host_sequence = s_aperture_input[0];
    if (cpu_ack) *cpu_ack = s_cpu_ack;
}

void core1_emulator_strobe_diagnostics(
    uint32_t *frames, uint32_t *malformed, uint32_t *stale,
    uint8_t *sequence, uint8_t *length,
    uint8_t *calculated_crc, uint8_t *received_crc)
{
    if (frames) *frames = s_strobe_frames;
    if (malformed) *malformed = s_strobe_malformed;
    if (stale) *stale = s_strobe_stale;
    if (sequence) *sequence = s_strobe_last_sequence;
    if (length) *length = s_strobe_last_length;
    if (calculated_crc) *calculated_crc = s_strobe_last_calculated_crc;
    if (received_crc) *received_crc = s_strobe_last_received_crc;
}
