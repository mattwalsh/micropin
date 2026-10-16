#include "pico/stdlib.h"
#include "hardware/gpio.h"
#include "tusb.h"

#include "pins.h"
#include "reset_control.h"
#include "core1_emulator.h"
#include "msc_disk.h"
#include "usb_control.h"
#include "ws2812_frame.h"

static void init_bus_gpio(void)
{
    // Address bus: inputs, no pulls (driven by the target system).
    for (int i = 0; i < ADDR_BIT_COUNT; i++) {
        gpio_init(PIN_ADDR_BASE + i);
        gpio_set_dir(PIN_ADDR_BASE + i, GPIO_IN);
    }

    // Data bus: start tristated (input, no pulls -- the external level
    // shifter/pull resistors on your board own the idle state).
    for (int i = 0; i < DATA_BIT_COUNT; i++) {
        gpio_init(PIN_DATA_BASE + i);
        gpio_set_dir(PIN_DATA_BASE + i, GPIO_IN);
    }

    // Chip selects: inputs with weak pull-ups, so an unconnected/undriven
    // CE line defaults to "not selected" rather than floating.
    const uint8_t ce_pins[] = { PIN_CE0, PIN_CE1, PIN_CE2, PIN_CE3,
#ifndef WS2812_ON_CE4
        PIN_CE4,
#endif
    };
    for (unsigned i = 0; i < sizeof ce_pins / sizeof ce_pins[0]; i++) {
        gpio_init(ce_pins[i]);
        gpio_set_dir(ce_pins[i], GPIO_IN);
        gpio_pull_up(ce_pins[i]);
    }

    // Bus-driven flag: push-pull output, idle high (active low = asserted).
    gpio_init(PIN_BUS_DRIVEN);
    gpio_set_dir(PIN_BUS_DRIVEN, GPIO_OUT);
    gpio_put(PIN_BUS_DRIVEN, 1);

}

int main(void)
{
    // ---- Boot ordering matters here; keep this sequence intact. ----

    // 1. Hold the target CPU in reset before anything else runs. From
    //    power-up until this line, PIN_TARGET_RESET was high-impedance;
    //    reset_control_init() also establishes its inactive weak pull-up.
    reset_control_init();

    stdio_init_all();

    // 2. Configure the bus-facing GPIO (data bus starts tristated).
    init_bus_gpio();

    // 3. Build the fake FAT12 system area and load all five images from
    //    flash into RAM *before* core1 starts touching those buffers.
    msc_disk_init();
#ifdef APERTURE_ONLY
    // The dedicated diagnostic firmware has no USB mass-storage interface
    // and never changes modes at runtime. ROMs 1-4 still come from the same
    // persisted flash slots, while CE4 is unconditionally the aperture.
    core1_emulator_set_ce4_mode(false, true);
#else
    core1_emulator_set_ce4_mode(msc_disk_rom5_present(), msc_disk_aperture_enabled());
#endif

    // 4. Start the timing-critical emulation loop on core1.
    core1_emulator_launch();

    // This optional build dedicates exposed GP26 (formerly ROM5 /CE) to the
    // LED data stream. PIO clocks it independently of the ROM loop.
#ifdef WS2812_ON_CE4
    ws2812_frame_init(PIN_WS2812_DATA);
#endif

    // 5. Bring up USB MSC now that the emulator is already live and
    //    correct -- USB is only needed for reprogramming, never for basic
    //    operation.
    tud_init(0); // RP2040 has a single USB controller: port 0

    // 6. Only now release the target from reset.
    reset_control_notify_flush_complete(); // reuses the "release" path

    while (true) {
        tud_task();
        core1_emulator_task();
        usb_control_task();
#ifdef WS2812_ON_CE4
        ws2812_frame_task();
#endif
#ifndef APERTURE_ONLY
        msc_disk_task();
#endif
        reset_control_task();

    }
}
