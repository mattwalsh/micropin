#include "usb_control.h"

#include <stdio.h>
#include <string.h>

#include "pico/bootrom.h"
#include "tusb.h"

#include "reset_control.h"
#include "msc_disk.h"
#include "core1_emulator.h"

#define COMMAND_MAX_LEN  139u

static char s_command[COMMAND_MAX_LEN + 1u];
static unsigned s_command_len;

static int hex_nibble(char ch)
{
    if (ch >= '0' && ch <= '9') return ch - '0';
    if (ch >= 'a' && ch <= 'f') return ch - 'a' + 10;
    if (ch >= 'A' && ch <= 'F') return ch - 'A' + 10;
    return -1;
}

static void reply(const char *text)
{
    tud_cdc_write_str(text);
    tud_cdc_write_flush();
}

static void reply_strobes(void)
{
    static const char hex[] = "0123456789abcdef";
    uint8_t received[16];
    char response[4u + sizeof received * 2u + 2u];
    size_t count = core1_emulator_read_strobes(received, sizeof received);
    size_t position = 0;
    response[position++] = 'r';
    response[position++] = 'x';
    response[position++] = ' ';
    for (size_t i = 0; i < count; i++) {
        response[position++] = hex[received[i] >> 4];
        response[position++] = hex[received[i] & 0x0f];
    }
    response[position++] = '\r';
    response[position++] = '\n';
    tud_cdc_write(response, (uint32_t)position);
    tud_cdc_write_flush();
}

static void publish_test_transaction(const char *hex_payload)
{
    uint8_t payload[64];
    size_t digits = strlen(hex_payload);
    if ((digits & 1u) != 0 || digits > sizeof payload * 2u) {
        reply("error bad-payload\r\n");
        return;
    }
    size_t length = digits / 2u;
    for (size_t i = 0; i < length; i++) {
        int high = hex_nibble(hex_payload[i * 2u]);
        int low = hex_nibble(hex_payload[i * 2u + 1u]);
        if (high < 0 || low < 0) {
            reply("error bad-payload\r\n");
            return;
        }
        payload[i] = (uint8_t)((high << 4) | low);
    }

    uint8_t sequence;
    if (!core1_emulator_publish_aperture(payload, length, &sequence)) {
        reply("error busy-or-rom5\r\n");
        return;
    }
    char response[] = "tx 00\r\n";
    static const char hex[] = "0123456789abcdef";
    response[3] = hex[sequence >> 4];
    response[4] = hex[sequence & 0x0f];
    reply(response);
}

static void reply_aperture_state(void)
{
    uint8_t host_sequence;
    uint8_t cpu_ack;
    core1_emulator_aperture_sequences(&host_sequence, &cpu_ack);
    static const char hex[] = "0123456789abcdef";
    char response[] = "state host=00 ack=00\r\n";
    response[11] = hex[host_sequence >> 4];
    response[12] = hex[host_sequence & 0x0f];
    response[18] = hex[cpu_ack >> 4];
    response[19] = hex[cpu_ack & 0x0f];
    reply(response);
}

static void reply_strobe_stats(void)
{
    char response[48];
    snprintf(response, sizeof response, "stats crc=%lu drops=%lu\r\n",
        (unsigned long)core1_emulator_strobe_crc_errors(),
        (unsigned long)core1_emulator_strobe_drops());
    reply(response);
}

static void reply_cpu_start_count(void)
{
    uint32_t reset_count, trap_count;
    core1_emulator_cpu_start_counts(&reset_count, &trap_count);
    char response[64];
    snprintf(response, sizeof response,
        "bootcount r=%08lx t=%08lx p=%08lx e=%08lx\r\n",
        (unsigned long)reset_count, (unsigned long)trap_count,
        (unsigned long)reset_control_assertions(),
        (unsigned long)reset_control_falling_edges());
    reply(response);
}

static void reply_strobe_diagnostics(void)
{
    uint32_t frames, malformed, stale;
    uint8_t sequence, length, calculated_crc, received_crc;
    core1_emulator_strobe_diagnostics(
        &frames, &malformed, &stale, &sequence, &length,
        &calculated_crc, &received_crc);
    // Keep this within one full-speed CDC packet. reply() is deliberately
    // non-blocking and TinyUSB may accept only the first 64 bytes otherwise.
    char response[64];
    snprintf(response, sizeof response,
        "diag f=%08lx m=%08lx s=%08lx q=%02x l=%02x c=%02x g=%02x\r\n",
        (unsigned long)frames, (unsigned long)malformed, (unsigned long)stale,
        sequence, length, calculated_crc, received_crc);
    reply(response);
}

static void process_command(void)
{
    s_command[s_command_len] = '\0';

    if (strcmp(s_command, "bootsel") == 0) {
        // The boot ROM owns USB from here. Assert target reset immediately so
        // an accidental update cannot leave the pinball CPU using a ROM image
        // while the RP2040 is changing USB personalities.
        reset_control_notify_write();
        reset_usb_boot(0, 0);
    } else if (strcmp(s_command, "reset") == 0) {
        reset_control_pulse();
        reply("reset ok\r\n");
#ifndef APERTURE_ONLY
    } else if (strcmp(s_command, "eject") == 0) {
        msc_disk_set_ejected(true);
        reply("eject ok\r\n");
    } else if (strcmp(s_command, "mount") == 0) {
        msc_disk_set_ejected(false);
        reply("mount ok\r\n");
    } else if (strcmp(s_command, "status") == 0) {
        if (msc_disk_rom5_present()) reply("mode rom5\r\n");
        else if (msc_disk_aperture_enabled()) reply("mode aperture\r\n");
        else reply("mode four-rom\r\n");
#else
    } else if (strcmp(s_command, "status") == 0) {
        reply("mode aperture-only\r\n");
#endif
    } else if (strcmp(s_command, "rx") == 0) {
        reply_strobes();
    } else if (strncmp(s_command, "tx ", 3) == 0) {
        publish_test_transaction(s_command + 3);
    } else if (strcmp(s_command, "state") == 0) {
        reply_aperture_state();
    } else if (strcmp(s_command, "stats") == 0) {
        reply_strobe_stats();
    } else if (strcmp(s_command, "bootcount") == 0) {
        reply_cpu_start_count();
    } else if (strcmp(s_command, "diag") == 0) {
        reply_strobe_diagnostics();
    } else {
        reply("error unknown-command\r\n");
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
