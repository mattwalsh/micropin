#include "pico/stdlib.h"
#include "hardware/gpio.h"
#include "tusb.h"

#include "pins.h"
#include "reset_control.h"
#include "core1_emulator.h"
#include "msc_disk.h"
#include "usb_control.h"

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
    const uint8_t ce_pins[NUM_CHIPS] = { PIN_CE0, PIN_CE1, PIN_CE2, PIN_CE3, PIN_CE4 };
    for (int i = 0; i < NUM_CHIPS; i++) {
        gpio_init(ce_pins[i]);
        gpio_set_dir(ce_pins[i], GPIO_IN);
        gpio_pull_up(ce_pins[i]);
    }

    // Bus-driven flag: push-pull output, idle high (active low = asserted).
    gpio_init(PIN_BUS_DRIVEN);
    gpio_set_dir(PIN_BUS_DRIVEN, GPIO_OUT);
    gpio_put(PIN_BUS_DRIVEN, 1);

    // Heartbeat LED.
    gpio_init(PIN_LED);
    gpio_set_dir(PIN_LED, GPIO_OUT);
    gpio_put(PIN_LED, 0);
}

int main(void)
{
    // ---- Boot ordering matters here; keep this sequence intact. ----

    // 1. Hold the target CPU in reset before anything else runs. From
    //    power-up until this line, PIN_TARGET_RESET was high-impedance,
    //    which is exactly why it needs an external pull-down (see README).
    reset_control_init();

    stdio_init_all();

    // 2. Configure the bus-facing GPIO (data bus starts tristated).
    init_bus_gpio();

    // 3. Build the fake FAT12 system area and load all five images from
    //    flash into RAM *before* core1 starts touching those buffers.
    msc_disk_init();
    core1_emulator_set_rom5_present(msc_disk_rom5_present());

    // 4. Start the timing-critical emulation loop on core1.
    core1_emulator_launch();

    // 5. Bring up USB MSC now that the emulator is already live and
    //    correct -- USB is only needed for reprogramming, never for basic
    //    operation.
    tud_init(0); // RP2040 has a single USB controller: port 0

    // 6. Only now release the target from reset.
    reset_control_notify_flush_complete(); // reuses the "release" path

    uint32_t last_blink_ms = 0;
    bool led_state = false;

    while (true) {
        tud_task();
        usb_control_task();
        msc_disk_task();
        reset_control_task();

        uint32_t now_ms = to_ms_since_boot(get_absolute_time());
        if (now_ms - last_blink_ms > 500) {
            last_blink_ms = now_ms;
            led_state = !led_state;
            gpio_put(PIN_LED, led_state);
        }
    }
}
