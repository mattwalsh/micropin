#include "usb_control.h"

#include <string.h>

#include "pico/bootrom.h"
#include "tusb.h"

#include "reset_control.h"

#define COMMAND_MAX_LEN  15u

static char s_command[COMMAND_MAX_LEN + 1u];
static unsigned s_command_len;

static void process_command(void)
{
    s_command[s_command_len] = '\0';

    if (strcmp(s_command, "bootsel") == 0) {
        // The boot ROM owns USB from here. Assert target reset immediately so
        // an accidental update cannot leave the pinball CPU using a ROM image
        // while the RP2040 is changing USB personalities.
        reset_control_notify_write();
        reset_usb_boot(0, 0);
    }

    s_command_len = 0;
}

void usb_control_task(void)
{
    while (tud_cdc_available()) {
        char ch;
        if (tud_cdc_read(&ch, 1) != 1) break;

        if (ch == '\r' || ch == '\n') {
            if (s_command_len) process_command();
        } else if (s_command_len < COMMAND_MAX_LEN) {
            s_command[s_command_len++] = ch;
        } else {
            // Discard an overlong command until its line terminator.
            s_command_len = 0;
        }
    }
}
