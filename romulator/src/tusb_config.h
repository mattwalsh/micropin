#ifndef _TUSB_CONFIG_H_
#define _TUSB_CONFIG_H_

#ifdef __cplusplus
extern "C" {
#endif

#define CFG_TUSB_MCU               OPT_MCU_RP2040
#define CFG_TUSB_OS                OPT_OS_PICO
#define CFG_TUSB_RHPORT0_MODE      OPT_MODE_DEVICE

#ifndef CFG_TUSB_MEM_SECTION
#define CFG_TUSB_MEM_SECTION
#endif

#ifndef CFG_TUSB_MEM_ALIGN
#define CFG_TUSB_MEM_ALIGN          __attribute__((aligned(4)))
#endif

// The device exposes the ROM drive plus one small CDC ACM control port. The
// control port accepts the "bootsel" command to enter the RP2040 boot ROM,
// avoiding a physical press of the BOOTSEL button for later firmware updates.
#define CFG_TUD_ENDPOINT0_SIZE      64

#define CFG_TUD_CDC                 1
#ifdef APERTURE_ONLY
#define CFG_TUD_MSC                 0
#else
#define CFG_TUD_MSC                 1
#endif
#define CFG_TUD_HID                 0
#define CFG_TUD_MIDI                0
#define CFG_TUD_VENDOR              0

// MSC buffer: one 512-byte sector at a time is plenty for our tiny disk.
#define CFG_TUD_CDC_RX_BUFSIZE       64
#define CFG_TUD_CDC_TX_BUFSIZE       64
#define CFG_TUD_CDC_EP_BUFSIZE       64
#define CFG_TUD_MSC_EP_BUFSIZE      512

#ifdef __cplusplus
}
#endif

#endif
