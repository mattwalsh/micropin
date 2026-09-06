#ifndef FLASH_LAYOUT_H
#define FLASH_LAYOUT_H

#include "hardware/flash.h"
#include "pins.h" // NUM_CHIPS

// Each 2716 image is exactly 2KB (11 address lines).
#define IMAGE_SIZE_BYTES        2048u

// We give each image its own full flash sector (4KB) even though it only
// uses half of it — this keeps erase/program operations simple (one sector
// = one image, no shared-sector bookkeeping) at the cost of 20KB of flash,
// which is trivial against the Pico's 2MB.
#define IMAGE_SECTOR_SIZE       FLASH_SECTOR_SIZE   // 4096

// Reserve the top 64KB of flash for our five images, well clear of the
// program itself.
#define FLASH_TARGET_OFFSET     (PICO_FLASH_SIZE_BYTES - (64 * 1024))

static inline uint32_t flash_offset_for_chip(unsigned chip)
{
    return FLASH_TARGET_OFFSET + (chip * IMAGE_SECTOR_SIZE);
}

#endif // FLASH_LAYOUT_H
