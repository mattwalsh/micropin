#include "pico/stdlib.h"
#include "hardware/gpio.h"
#include "hardware/clocks.h"
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

    // U31 page decode inputs: CPU A11, A12, A13. These are actively driven
    // by the target, so unlike the old /CE inputs they need no idle pull-up.
    const uint8_t page_pins[] = { PIN_PAGE_A11, PIN_PAGE_A12, PIN_PAGE_A13 };
    for (unsigned i = 0; i < sizeof page_pins / sizeof page_pins[0]; i++) {
        gpio_init(page_pins[i]);
        gpio_set_dir(page_pins[i], GPIO_IN);
        gpio_disable_pulls(page_pins[i]);
    }

    // Bus-driven flag: push-pull output, idle high (active low = asserted).
    gpio_init(PIN_BUS_DRIVEN);
    gpio_set_dir(PIN_BUS_DRIVEN, GPIO_OUT);
    gpio_put(PIN_BUS_DRIVEN, 1);

}

int main(void)
{
    // ---- Boot ordering matters here; keep this sequence intact. ----

#ifdef ROMULATOR_SYS_CLOCK_KHZ
    // This is deliberately a build-time diagnostic, not a runtime setting.
    // A faster core shortens the interval before core1 notices a new U31 page
    // value and serves its byte, making it useful for testing page-wire skew.
    set_sys_clock_khz(ROMULATOR_SYS_CLOCK_KHZ, true);
#endif

    // 1. Hold the target CPU in reset before anything else runs. From
    //    power-up until this line, PIN_TARGET_RESET was high-impedance;
    //    reset_control_init() also establishes its inactive weak pull-up.
    reset_control_init();

    stdio_init_all();

    // 2. Configure the bus-facing GPIO (data bus starts tristated).
    init_bus_gpio();

    // 3. Build the fake FAT12 system area and load all ROM images from
    //    flash into RAM *before* core1 starts touching those buffers.
    msc_disk_init();
#ifdef APERTURE_ONLY
    // The dedicated diagnostic firmware has no USB mass-storage interface
    // and never changes modes at runtime. ROMs 1-4 still come from the same
    // persisted flash slots, while the aperture is unconditionally enabled.
    core1_emulator_set_aperture_mode(true);
#else
    core1_emulator_set_aperture_mode(msc_disk_mode() == MSC_DISK_MODE_APERTURE);
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
