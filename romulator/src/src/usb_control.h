#ifndef USB_CONTROL_H
#define USB_CONTROL_H

// Services the USB CDC ACM control port. Sending "bootsel" followed by a
// newline reboots the RP2040 into its built-in RPI-RP2 USB bootloader.
void usb_control_task(void);

#endif // USB_CONTROL_H
