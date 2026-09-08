#ifndef USB_CONTROL_H
#define USB_CONTROL_H

// Services the USB CDC ACM control port. "status" reports whether ROM 5 or
// aperture mode is selected. "tx HEX" publishes a host transaction and
// "rx" drains up to 16 address-strobe bytes. "state" reports the host and
// 8085 acknowledgement sequences; "stats" reports CRC failures and drops.
// "bootsel" reboots into the RP2040 bootloader.
void usb_control_task(void);

#endif // USB_CONTROL_H
