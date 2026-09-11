#include "reset_control.h"

#include "pico/stdlib.h"
#include "pins.h"

// If no USB write activity has arrived for this long, assume the host is
// done (it forgot/declined to send SYNCHRONIZE CACHE) and release reset.
#define RELEASE_TIMEOUT_US   (500 * 1000)

static volatile bool s_reset_asserted = false;
static volatile absolute_time_t s_last_write_time;
static volatile uint32_t s_reset_assertions;
static volatile uint32_t s_reset_falling_edges;

static void reset_gpio_irq(uint gpio, uint32_t events)
{
    if (gpio == PIN_TARGET_RESET && (events & GPIO_IRQ_EDGE_FALL)) {
        s_reset_falling_edges++;
    }
}

static inline void drive_reset(bool asserted)
{
    if (asserted) {
        // Output latch was already set to 0 once in reset_control_init()
        // and never changed -- asserting is just "enable the output driver."
        gpio_set_dir(PIN_TARGET_RESET, GPIO_OUT);
        if (!s_reset_asserted) s_reset_assertions++;
    } else {
        // Releasing = input/high-Z with the Pico's weak pull-up enabled.
        // The Romulator schematic connects GP28 directly to CPU_RESET and
        // shows no board-local pull resistor, so do not leave this net floating.
        gpio_set_dir(PIN_TARGET_RESET, GPIO_IN);
    }
    s_reset_asserted = asserted;
}

void reset_control_init(void)
{
    // Before this line runs, PIN_TARGET_RESET is high-impedance -- which,
    // with this open-drain scheme, is IDENTICAL to "released." There's no
    // discontinuity to guard against here (unlike a push-pull driver would
    // have): whatever the shared reset net's own pull-up and other devices
    // are doing continues uninterrupted until we actively choose to pull
    // this net low ourselves.
    gpio_init(PIN_TARGET_RESET);
    gpio_set_pulls(PIN_TARGET_RESET, true, false);  // weak inactive-high bias; still open-drain safe
    gpio_put(PIN_TARGET_RESET, 0);                   // output latch fixed at 0; direction is what toggles
    gpio_set_irq_enabled_with_callback(
        PIN_TARGET_RESET, GPIO_IRQ_EDGE_FALL, true, reset_gpio_irq);
    drive_reset(true);                               // assert immediately, first thing in main()
    s_last_write_time = get_absolute_time();
}

void reset_control_notify_write(void)
{
    if (!s_reset_asserted) {
        drive_reset(true);
    }
    s_last_write_time = get_absolute_time();
}

void reset_control_release(void)
{
    if (s_reset_asserted) {
        drive_reset(false);
    }
}

void reset_control_pulse(void)
{
    drive_reset(true);
    sleep_ms(10);
    drive_reset(false);
}

void reset_control_task(void)
{
    if (s_reset_asserted &&
        absolute_time_diff_us(s_last_write_time, get_absolute_time()) > RELEASE_TIMEOUT_US) {
        drive_reset(false);
    }
}

bool reset_control_is_asserted(void)
{
    return s_reset_asserted;
}

uint32_t reset_control_assertions(void)
{
    return s_reset_assertions;
}

uint32_t reset_control_falling_edges(void)
{
    return s_reset_falling_edges;
}
