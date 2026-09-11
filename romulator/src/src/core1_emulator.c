#include "core1_emulator.h"

#include "pico/multicore.h"
#include "pico/platform.h"
#include "hardware/structs/sio.h"
#include "hardware/gpio.h"

uint8_t emu_rom_image[NUM_CHIPS][2][IMAGE_SIZE_BYTES];
volatile uint8_t emu_active_buffer[NUM_CHIPS];
volatile bool emu_rom5_present = true;
volatile bool emu_aperture_enabled = false;

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
#define APERTURE_MAX_PAYLOAD (APERTURE_INPUT_SIZE - APERTURE_PAYLOAD_OFFSET - 2u)
#define STROBE_FRAME_MAX (APERTURE_MAX_PAYLOAD + 3u)
#define CE4_BUFFER_APERTURE 0xfeu
#define CE4_BUFFER_DISABLED 0xffu

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
// Retained in the diagnostic reply for compatibility. The nibble transport
// deliberately has no out-of-band reset/TRAP marker addresses.
static volatile uint32_t s_cpu_reset_count;
static volatile uint32_t s_cpu_trap_count;
// Core0 constructs a complete transaction in the inactive bank, then flips
// this single-byte selector. Core1 therefore never serves a mailbox while it
// is being rewritten in place.
// Keep the shared mailbox out of the striped main SRAM banks used by the ROM
// images. Core0 writes only the inactive bank; core1 reads only the active
// bank, and the selector flip publishes a complete transaction atomically.
static volatile uint8_t __scratch_y("aperture_mailbox")
    s_aperture_input[2][APERTURE_INPUT_SIZE];
static volatile uint8_t s_aperture_active_bank;
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
// Scratch X is a private 4 KiB SRAM bank. Keeping the complete hot loop here
// prevents USB activity on core0 from stalling core1 instruction fetches in
// striped main SRAM while the 8085 is waiting for an EPROM byte.
static void __scratch_x("core1_bus_loop") core1_main(void)
{
    // Data bus starts tristated, bus-driven flag starts deasserted (idle high).
    sio_hw->gpio_oe_clr = DATA_MASK;
    sio_hw->gpio_set = (1u << PIN_BUS_DRIVEN);

    // Tracks exactly what's currently latched on the data pins, so we can
    // update them with a single atomic toggle of only the bits that need
    // to change -- never an intermediate "all zero" state, unlike a
    // clear-then-set sequence.
    uint32_t current_data_bits = 0;

    uint32_t previous_strobe_addr = 0xffffffffu;
    uint8_t strobe_high_nibble = 0;
    bool strobe_high_valid = false;
    uint8_t strobe_frame[STROBE_FRAME_MAX];
    size_t strobe_frame_length = 0;
    bool strobe_frame_active = false;

    while (true) {
        uint32_t gpio_in = sio_hw->gpio_in;

        int chip = -1;
        if (!(gpio_in & (1u << PIN_CE0)))      chip = 0;
        else if (!(gpio_in & (1u << PIN_CE1)))  chip = 1;
        else if (!(gpio_in & (1u << PIN_CE2)))  chip = 2;
        else if (!(gpio_in & (1u << PIN_CE3)))  chip = 3;
        else if (!(gpio_in & (1u << PIN_CE4)))  chip = 4;

        const uint32_t addr = gpio_in & ADDR_MASK;

        // Keep ordinary EPROM fetches on the original minimal path. The 8085
        // must see the byte within the 2716 access window; none of the aperture
        // framing work belongs ahead of that deadline. For CE4, the active-
        // buffer byte doubles as its mode so this path needs no second global
        // lookup: 0/1 select a ROM buffer, fe is aperture, and ff is disabled.
        uint8_t buf = CE4_BUFFER_DISABLED;
        if (chip >= 0) buf = emu_active_buffer[chip];
        if (chip >= 0 && (chip != 4 || buf < 2u)) {
            uint8_t data = emu_rom_image[chip][buf][addr];

            uint32_t data_bits = ((uint32_t)data) << PIN_DATA_BASE;
            uint32_t diff = (data_bits ^ current_data_bits) & DATA_MASK;
            if (diff) {
                sio_hw->gpio_togl = diff;
                current_data_bits = data_bits;
            }
            sio_hw->gpio_oe_set = DATA_MASK;
            sio_hw->gpio_clr = (1u << PIN_BUS_DRIVEN);
            // Do nonessential aperture bookkeeping only after the ROM byte is
            // safely present on the bus.
            if (chip != 4) previous_strobe_addr = 0xffffffffu;
            continue;
        }

        const bool aperture_cycle = chip == 4 && buf == CE4_BUFFER_APERTURE;
        const bool aperture_strobe = aperture_cycle && addr >= APERTURE_INPUT_SIZE;

        // Mailbox reads are also timing-critical. Parse address-strobe frames
        // only after the data bus has either been driven or explicitly freed.
        if (aperture_cycle && !aperture_strobe) {
            previous_strobe_addr = 0xffffffffu;
            uint8_t bank = s_aperture_active_bank;
            uint8_t data = addr == APERTURE_CPU_ACK_OFFSET ? s_cpu_ack : s_aperture_input[bank][addr];
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

        if (aperture_cycle && aperture_strobe && addr != previous_strobe_addr) {
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
                        s_strobe_last_sequence = strobe_frame[0];
                        s_strobe_last_length = strobe_frame[1];
                        s_strobe_last_received_crc = strobe_frame[delivered_length];
                        if (strobe_frame[0] == s_cpu_ack) {
                            // A retry of an already accepted transaction is
                            // acknowledged but never delivered twice. Its
                            // contents are irrelevant, so avoid spending the
                            // timing-critical bus core on another CRC pass.
                        } else {
                            uint8_t crc = 0;
                            for (size_t i = 0; i < delivered_length; i++) crc = crc8_update(crc, strobe_frame[i]);
                            s_strobe_last_calculated_crc = crc;
                            if (crc != strobe_frame[delivered_length]) {
                                s_strobe_crc_errors++;
                            } else if (strobe_frame[0] !=
                                s_aperture_input[s_aperture_active_bank][0]) {
                                // Only the currently pending host sequence is
                                // a legal response. A stale but internally
                                // valid frame must never rewind the ack.
                                s_strobe_stale++;
                            } else if (strobe_ring_free() >= delivered_length) {
                                for (size_t i = 0; i < delivered_length; i++) strobe_push(strobe_frame[i]);
                                __compiler_memory_barrier();
                                s_cpu_ack = strobe_frame[0];
                            } else {
                                s_strobe_drops += (uint32_t)delivered_length;
                            }
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
                    uint8_t value = (uint8_t)((strobe_high_nibble << 4) |
                        (addr & STROBE_NIBBLE_MASK));
                    if (strobe_frame_active) {
                        if (strobe_frame_length < sizeof strobe_frame) strobe_frame[strobe_frame_length++] = value;
                        else strobe_frame_active = false;
                    }
                    strobe_high_valid = false;
                }
        } else if (!aperture_cycle) {
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

void core1_emulator_set_ce4_mode(bool rom5_present, bool aperture_enabled)
{
    emu_rom5_present = rom5_present;
    emu_aperture_enabled = aperture_enabled && !rom5_present;
    if (!rom5_present) {
        emu_active_buffer[4] = emu_aperture_enabled ? CE4_BUFFER_APERTURE : CE4_BUFFER_DISABLED;
    } else if (emu_active_buffer[4] > 1u) {
        emu_active_buffer[4] = 0;
    }
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

void core1_emulator_cpu_start_counts(uint32_t *reset_count, uint32_t *trap_count)
{
    if (reset_count) *reset_count = s_cpu_reset_count;
    if (trap_count) *trap_count = s_cpu_trap_count;
}

bool core1_emulator_publish_aperture(const uint8_t *payload, size_t length, uint8_t *sequence)
{
    uint8_t active_bank = s_aperture_active_bank;
    if (!emu_aperture_enabled || length > APERTURE_MAX_PAYLOAD) return false;

    // One-way diagnostic mode permits replacing an unacknowledged mailbox.
    // The bank flip still makes each published transaction internally atomic.
    uint8_t next = (uint8_t)(s_aperture_input[active_bank][0] + 1u);
    uint8_t next_bank = active_bank ^ 1u;
    uint8_t crc = crc8_update(0, next);
    crc = crc8_update(crc, (uint8_t)length);
    for (size_t i = 0; i < length; i++) {
        s_aperture_input[next_bank][APERTURE_PAYLOAD_OFFSET + i] = payload[i];
        crc = crc8_update(crc, payload[i]);
    }
    s_aperture_input[next_bank][APERTURE_PAYLOAD_OFFSET + length] = crc;
    s_aperture_input[next_bank][APERTURE_PAYLOAD_OFFSET + length + 1u] = (uint8_t)~crc;
    s_aperture_input[next_bank][APERTURE_LENGTH_OFFSET] = (uint8_t)length;
    s_aperture_input[next_bank][0] = next;
    // Make the entire immutable transaction visible before atomically
    // selecting its bank for core1 and the target CPU.
    __mem_fence_release();
    s_aperture_active_bank = next_bank;
    if (sequence) *sequence = next;
    return true;
}

void core1_emulator_aperture_sequences(uint8_t *host_sequence, uint8_t *cpu_ack)
{
    uint8_t bank = s_aperture_active_bank;
    if (host_sequence) *host_sequence = s_aperture_input[bank][0];
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
