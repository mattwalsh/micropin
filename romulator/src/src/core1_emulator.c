#include "core1_emulator.h"

#include "pico/multicore.h"
#include "pico/platform.h"
#include "hardware/structs/sio.h"
#include "hardware/structs/bus_ctrl.h"
#include "hardware/gpio.h"

_Static_assert(PIN_PAGE_A12 == PIN_PAGE_A11 + 1 && PIN_PAGE_A13 == PIN_PAGE_A11 + 2,
               "page-select pins must be contiguous");
_Static_assert(PIN_ADDR_BASE == 0, "address bus must start at GP0");

uint8_t emu_rom_image[NUM_CHIPS][2][IMAGE_SIZE_BYTES];
volatile uint8_t emu_active_buffer[NUM_CHIPS];
volatile bool emu_aperture_enabled = false;

#define STROBE_RING_SIZE 256u
#define STROBE_EVENT_START 0x100u
#define STROBE_EVENT_END   0x101u
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
#define STROBE_LAST_OFFSET 0x0e1u
#define PAGE_COUNT 8u

// The normal aperture uses the fifth decoded window ($2800). The compact
// aperture-roundtrip program fits in ROM1, so the LED build instead uses the
// unused third window ($1000), freeing CE4/GP26 for WS2812 output.
#ifdef APERTURE_ON_CE2
#define APERTURE_CHIP_INDEX 2
#else
#define APERTURE_CHIP_INDEX 4
#endif
// U31 page number (A13:A11) that carries the aperture. Page 4 is motherboard
// RAM and is skipped when numbering ROM slots, so chips >= 4 sit one page up.
#define APERTURE_PAGE (APERTURE_CHIP_INDEX < 4 ? APERTURE_CHIP_INDEX : APERTURE_CHIP_INDEX + 1)

// One entry per U31 page. The hot loop does exactly one table lookup per bus
// sample and then one bounds check:
//   addr <  limit -> drive base[addr]
//   addr >= limit -> release D0..D7 (page 4 has limit 0; the aperture page has
//                    limit 0xC0 so $28C0.. address-strobe reads float the bus)
// Core0 retargets an entry with single 32-bit stores; core1 never has to look
// at any mode flag, active-buffer index or mailbox bank.
typedef struct {
    const uint8_t *base;
    uint32_t limit;
} page_entry_t;

static volatile uint8_t s_strobe_ring[STROBE_RING_SIZE];
static volatile uint8_t s_strobe_head;
static volatile uint8_t s_strobe_tail;
// Raw, filtered strobe offsets ($0C0..$0E1) captured by core1. Core0 pairs
// nibbles and assembles frames, so core1 does no protocol work at all.
static volatile uint16_t s_strobe_event_ring[STROBE_RING_SIZE];
static volatile uint8_t s_strobe_event_head;
static volatile uint8_t s_strobe_event_tail;
static volatile uint32_t s_strobe_drops;
static volatile uint32_t s_strobe_event_drops;
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
// Core0 constructs a complete transaction in the inactive bank, then flips the
// aperture page's table entry to it with one 32-bit store. Core1 therefore
// never serves a mailbox while it is being rewritten in place. Both banks and
// the page table live in scratch X together with the hot loop, so core0's USB
// traffic can never stall core1's fetch, table lookup or mailbox data read.
// Offset 1 of each bank mirrors the CPU's acknowledge byte.
static volatile uint8_t __scratch_x("aperture_mailbox")
    s_mailbox[2][APERTURE_INPUT_SIZE];
static volatile page_entry_t __scratch_x("core1_page_table") s_pages[PAGE_COUNT];
static volatile uint8_t s_aperture_active_bank;
static volatile uint8_t s_cpu_ack;
static uint8_t s_strobe_frame[STROBE_FRAME_MAX];
static size_t s_strobe_frame_length;
static bool s_strobe_frame_active;
static uint8_t s_nibble_high;
static bool s_nibble_valid;

static inline void strobe_push(uint8_t value)
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

static inline size_t strobe_ring_free(void)
{
    return (uint8_t)(s_strobe_tail - s_strobe_head - 1u);
}

static inline uint8_t crc8_update(uint8_t crc, uint8_t value)
{
    crc ^= value;
    for (unsigned bit = 0; bit < 8u; bit++) {
        crc = (uint8_t)((crc << 1) ^ ((crc & 0x80u) ? 0x07u : 0u));
    }
    return crc;
}

// Core1 records only raw strobe offsets. It never pairs nibbles, assembles a
// frame or calculates a CRC while the 8085 is waiting for its next ROM fetch.
static inline void __not_in_flash_func(strobe_event_push)(uint16_t offset)
{
    uint8_t head = s_strobe_event_head;
    uint8_t next = (uint8_t)(head + 1u);
    if (next == s_strobe_event_tail) {
        s_strobe_event_drops++;
        return;
    }
    s_strobe_event_ring[head] = offset;
    __compiler_memory_barrier();
    s_strobe_event_head = next;
}

// Everything the loop touches (code, page table, mailbox banks, stack) is in
// scratch X, a private 4 KiB SRAM bank, so neither flash erases nor core0's
// USB DMA can ever stall it.
//
// Every bus sample takes the same short path:
//   1. read GP0..GP21 once
//   2. page = A13:A11 -> table entry {base, limit}
//   3. addr < limit ? drive base[addr] (ROM *or* mailbox, identical code)
//                   : release D0..D7
// The data update is one gpio_togl of only the bits that change, issued while
// OE is still in its previous state, so a driven bus never passes through a
// wrong intermediate value. Strobe capture lives only on the release path.
static void __scratch_x("core1_bus_loop") core1_main(void)
{
    sio_hw->gpio_oe_clr = DATA_MASK;
    sio_hw->gpio_set = (1u << PIN_BUS_DRIVEN);

    uint32_t current_data_bits = 0;   // what the data-pin output latches hold
    uint32_t candidate = 0xffffffffu; // strobe offset seen on the last release sample
    uint32_t stable = 0;              // 0 = none, 1 = seen once, 2 = already emitted
    const volatile page_entry_t *const aperture_entry = &s_pages[APERTURE_PAGE];

    while (true) {
        const uint32_t gpio_in = sio_hw->gpio_in;
        const volatile page_entry_t *entry = (const volatile page_entry_t *)
            ((uintptr_t)s_pages + ((gpio_in >> (PIN_PAGE_A11 - 3u)) & ((PAGE_COUNT - 1u) << 3u)));
        const uint32_t addr = gpio_in & ADDR_MASK;

        if (addr < entry->limit) {
            const uint32_t data_bits =
                (uint32_t)((const volatile uint8_t *)entry->base)[addr] << PIN_DATA_BASE;
            sio_hw->gpio_togl = data_bits ^ current_data_bits;
            current_data_bits = data_bits;
            sio_hw->gpio_oe_set = DATA_MASK;
            sio_hw->gpio_clr = (1u << PIN_BUS_DRIVEN);
            stable = 0;
            continue;
        }

        // No driven byte for this sample: page 4 (motherboard RAM) or an
        // address-strobe read, whose data is the address itself.
        sio_hw->gpio_oe_clr = DATA_MASK;
        sio_hw->gpio_set = (1u << PIN_BUS_DRIVEN);

        if (entry != aperture_entry) {
            stable = 0;
        } else if (addr != candidate || stable == 0u) {
            candidate = addr;
            stable = 1u;
        } else if (stable == 1u) {
            // The same strobe offset in two consecutive samples: a real read
            // cycle, not an address-bus transient. Emitted once per visit.
            stable = 2u;
            if (addr - STROBE_HIGH_BASE <= STROBE_LAST_OFFSET - STROBE_HIGH_BASE) {
                strobe_event_push((uint16_t)addr);
            }
        }
    }
}

// Point one ROM slot's page-table entry at the right thing: the mailbox bank
// when it is the aperture slot in aperture mode, otherwise its active ROM
// buffer. limit is zeroed around a base/limit change of kind so core1 can never
// pair a mailbox base with a ROM-sized limit (it releases the bus instead).
static void table_update(unsigned chip)
{
    const unsigned page = chip < 4u ? chip : chip + 1u;
    const bool mailbox = emu_aperture_enabled && chip == APERTURE_CHIP_INDEX;
    const uint8_t *base = mailbox ? (const uint8_t *)s_mailbox[s_aperture_active_bank]
                                  : emu_rom_image[chip][emu_active_buffer[chip] & 1u];
    const uint32_t limit = mailbox ? APERTURE_INPUT_SIZE : IMAGE_SIZE_BYTES;
    if (s_pages[page].limit != limit) {
        s_pages[page].limit = 0;
        __compiler_memory_barrier();
    }
    s_pages[page].base = base;
    __compiler_memory_barrier();
    s_pages[page].limit = limit;
}

void core1_emulator_launch(void)
{
    // Page 4 is never driven.
    s_pages[4].base = emu_rom_image[0][0];
    s_pages[4].limit = 0;
    for (unsigned chip = 0; chip < NUM_CHIPS; chip++) table_update(chip);
    // Core1 wins any main-SRAM arbitration against core0 and the USB DMA.
    bus_ctrl_hw->priority = BUSCTRL_BUS_PRIORITY_PROC1_BITS;
    multicore_launch_core1(core1_main);
}

void core1_emulator_task(void)
{
    while (s_strobe_event_tail != s_strobe_event_head) {
        uint16_t offset = s_strobe_event_ring[s_strobe_event_tail];
        __compiler_memory_barrier();
        s_strobe_event_tail = (uint8_t)(s_strobe_event_tail + 1u);

        uint16_t event;
        if (offset == STROBE_FRAME_START) {
            s_nibble_valid = false;
            event = STROBE_EVENT_START;
        } else if (offset == STROBE_FRAME_END) {
            s_nibble_valid = false;
            event = STROBE_EVENT_END;
        } else if ((offset & ~STROBE_NIBBLE_MASK) == STROBE_HIGH_BASE) {
            s_nibble_high = (uint8_t)(offset & STROBE_NIBBLE_MASK);
            s_nibble_valid = true;
            continue;
        } else if ((offset & ~STROBE_NIBBLE_MASK) == STROBE_LOW_BASE && s_nibble_valid) {
            event = (uint8_t)((s_nibble_high << 4) | (offset & STROBE_NIBBLE_MASK));
            s_nibble_valid = false;
        } else {
            continue;
        }

        if (event == STROBE_EVENT_START) {
            s_strobe_frame_active = true;
            s_strobe_frame_length = 0;
            continue;
        }
        if (event != STROBE_EVENT_END) {
            if (s_strobe_frame_active) {
                if (s_strobe_frame_length < sizeof s_strobe_frame) {
                    s_strobe_frame[s_strobe_frame_length++] = (uint8_t)event;
                } else {
                    s_strobe_frame_active = false;
                }
            }
            continue;
        }

        if (!s_strobe_frame_active) continue;
        s_strobe_frames++;
        if (s_strobe_frame_length < 3u ||
            s_strobe_frame_length != (size_t)s_strobe_frame[1] + 3u) {
            s_strobe_malformed++;
            s_strobe_frame_active = false;
            continue;
        }

        size_t delivered_length = s_strobe_frame_length - 1u;
        s_strobe_last_sequence = s_strobe_frame[0];
        s_strobe_last_length = s_strobe_frame[1];
        s_strobe_last_received_crc = s_strobe_frame[delivered_length];
        if (s_strobe_frame[0] != s_cpu_ack) {
            uint8_t crc = 0;
            for (size_t i = 0; i < delivered_length; i++) {
                crc = crc8_update(crc, s_strobe_frame[i]);
            }
            s_strobe_last_calculated_crc = crc;
            if (crc != s_strobe_frame[delivered_length]) {
                s_strobe_crc_errors++;
            } else if (s_strobe_frame[0] !=
                s_mailbox[s_aperture_active_bank][0]) {
                s_strobe_stale++;
            } else if (strobe_ring_free() >= delivered_length) {
                for (size_t i = 0; i < delivered_length; i++) {
                    strobe_push(s_strobe_frame[i]);
                }
                __compiler_memory_barrier();
                s_cpu_ack = s_strobe_frame[0];
                s_mailbox[0][APERTURE_CPU_ACK_OFFSET] = s_cpu_ack;
                s_mailbox[1][APERTURE_CPU_ACK_OFFSET] = s_cpu_ack;
            } else {
                s_strobe_drops += (uint32_t)delivered_length;
            }
        }
        s_strobe_frame_active = false;
    }
}

void core1_emulator_publish(unsigned chip, unsigned staging_buffer)
{
    // emu_active_buffer[] now only ever holds a ROM buffer index (0/1). If this
    // slot is currently serving the aperture the new image is remembered, but
    // the mailbox stays in place until aperture mode is switched off.
    emu_active_buffer[chip] = (uint8_t)(staging_buffer & 1u);
    table_update(chip);
}

void core1_emulator_set_aperture_mode(bool aperture_enabled)
{
    emu_aperture_enabled = aperture_enabled;
    if (aperture_enabled) {
        // Clean mailbox: sequence 0, empty payload, ack mirrors the CPU's.
        for (unsigned bank = 0; bank < 2u; bank++) {
            for (unsigned i = 0; i < APERTURE_INPUT_SIZE; i++) s_mailbox[bank][i] = 0;
            s_mailbox[bank][APERTURE_CPU_ACK_OFFSET] = s_cpu_ack;
        }
    }
    table_update(APERTURE_CHIP_INDEX);
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
    return s_strobe_drops + s_strobe_event_drops;
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
    uint8_t next = (uint8_t)(s_mailbox[active_bank][0] + 1u);
    uint8_t next_bank = active_bank ^ 1u;
    uint8_t crc = crc8_update(0, next);
    crc = crc8_update(crc, (uint8_t)length);
    for (size_t i = 0; i < length; i++) {
        s_mailbox[next_bank][APERTURE_PAYLOAD_OFFSET + i] = payload[i];
        crc = crc8_update(crc, payload[i]);
    }
    s_mailbox[next_bank][APERTURE_PAYLOAD_OFFSET + length] = crc;
    s_mailbox[next_bank][APERTURE_PAYLOAD_OFFSET + length + 1u] = (uint8_t)~crc;
    s_mailbox[next_bank][APERTURE_LENGTH_OFFSET] = (uint8_t)length;
    s_mailbox[next_bank][0] = next;
    // Make the entire immutable transaction visible before atomically
    // selecting its bank for core1 and the target CPU.
    __mem_fence_release();
    s_aperture_active_bank = next_bank;
    s_pages[APERTURE_PAGE].base = (const uint8_t *)s_mailbox[next_bank];
    if (sequence) *sequence = next;
    return true;
}

void core1_emulator_aperture_sequences(uint8_t *host_sequence, uint8_t *cpu_ack)
{
    uint8_t bank = s_aperture_active_bank;
    if (host_sequence) *host_sequence = s_mailbox[bank][0];
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
