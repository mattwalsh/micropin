#include "msc_disk.h"

#include <string.h>
#include "pico/stdlib.h"
#include "hardware/flash.h"
#include "hardware/sync.h"
#include "tusb.h"
#include "pins.h"
#include "flash_layout.h"
#include "core1_emulator.h"
#include "reset_control.h"

// A real, small FAT12 block device. Hosts may update FATs, directory entries,
// and data in any order, so all 128KB stays in RAM exactly as the host wrote
// it. Only the five named ROM files are persisted to flash.
#define SECTOR_SIZE 512u
#define SECTORS_PER_CLUSTER 4u
#define RESERVED_SECTORS 1u
#define NUM_FATS 2u
#define FAT_SECTORS 1u
#define ROOT_DIR_SECTORS 1u
#define ROOT_DIR_ENTRIES 16u
#define DATA_START_SECTOR (RESERVED_SECTORS + NUM_FATS * FAT_SECTORS + ROOT_DIR_SECTORS)
#define TOTAL_SECTORS 256u
#define DATA_SECTORS (TOTAL_SECTORS - DATA_START_SECTOR)
#define TOTAL_CLUSTERS (DATA_SECTORS / SECTORS_PER_CLUSTER)
#define FAT_BOOT_SECTOR_LBA 0u
#define FAT1_LBA 1u
#define FAT2_LBA 2u
#define ROOT_DIR_LBA 3u
#define FIRST_HOME_CLUSTER 2u
#define LAST_DATA_CLUSTER (FIRST_HOME_CLUSTER + TOTAL_CLUSTERS - 1u)
#define COMMIT_IDLE_US (150 * 1000)

#define MODE_METADATA_VERSION 1u
#define MODE_FLAG_ROM5_PRESENT 0x01u

static const uint8_t s_metadata_magic[8] = { 'M', 'P', 'R', 'O', 'M', 'M', 'O', 'D' };

static uint8_t s_disk[TOTAL_SECTORS][SECTOR_SIZE];
static uint8_t s_staging[NUM_CHIPS][IMAGE_SIZE_BYTES];
static uint8_t s_metadata_page[FLASH_PAGE_SIZE] __attribute__((aligned(4)));
static volatile bool s_dirty[NUM_CHIPS];
static absolute_time_t s_last_write_time;
static bool s_write_pending;
static bool s_ejected;
static bool s_rom5_present;

static const char s_file_names[NUM_CHIPS][8] = {
    "COIN_1  ", "COIN_2  ", "COIN_3  ", "COIN_4  ", "COIN_5  "
};

static void put16(uint8_t *p, uint16_t v) { p[0] = v & 0xffu; p[1] = v >> 8; }
static void put32(uint8_t *p, uint32_t v) { p[0] = v & 0xffu; p[1] = v >> 8; p[2] = v >> 16; p[3] = v >> 24; }
static uint16_t get16(const uint8_t *p) { return (uint16_t)(p[0] | ((uint16_t)p[1] << 8)); }
static uint32_t get32(const uint8_t *p) { return (uint32_t)p[0] | ((uint32_t)p[1] << 8) | ((uint32_t)p[2] << 16) | ((uint32_t)p[3] << 24); }

static void load_mode_metadata(void)
{
    const uint8_t *metadata = (const uint8_t *)(XIP_BASE + FLASH_METADATA_OFFSET);
    if (memcmp(metadata, s_metadata_magic, sizeof s_metadata_magic) == 0 &&
        metadata[8] == MODE_METADATA_VERSION &&
        metadata[10] == (uint8_t)~metadata[9]) {
        s_rom5_present = (metadata[9] & MODE_FLAG_ROM5_PRESENT) != 0;
    } else {
        // Firmware predating mode metadata always exposed five ROMs.  Preserve
        // that behavior on the first boot after upgrading.
        s_rom5_present = true;
    }
}

static void persist_mode_metadata(void)
{
    memset(s_metadata_page, 0xff, sizeof s_metadata_page);
    memcpy(s_metadata_page, s_metadata_magic, sizeof s_metadata_magic);
    s_metadata_page[8] = MODE_METADATA_VERSION;
    s_metadata_page[9] = s_rom5_present ? MODE_FLAG_ROM5_PRESENT : 0;
    s_metadata_page[10] = (uint8_t)~s_metadata_page[9];

    uint32_t ints = save_and_disable_interrupts();
    flash_range_erase(FLASH_METADATA_OFFSET, FLASH_SECTOR_SIZE);
    flash_range_program(FLASH_METADATA_OFFSET, s_metadata_page, sizeof s_metadata_page);
    restore_interrupts(ints);
}

static void fat12_set_entry(uint8_t *fat, unsigned cluster, uint16_t value)
{
    unsigned idx = cluster * 3u / 2u;
    if (cluster & 1u) { fat[idx] = (fat[idx] & 0x0fu) | ((value << 4) & 0xf0u); fat[idx + 1u] = value >> 4; }
    else { fat[idx] = value & 0xffu; fat[idx + 1u] = (fat[idx + 1u] & 0xf0u) | ((value >> 8) & 0x0fu); }
}

static uint16_t fat12_get_entry(const uint8_t *fat, unsigned cluster)
{
    unsigned idx = cluster * 3u / 2u;
    if (cluster & 1u) return (uint16_t)((fat[idx] >> 4) | ((uint16_t)fat[idx + 1u] << 4));
    return (uint16_t)(fat[idx] | ((uint16_t)(fat[idx + 1u] & 0x0fu) << 8));
}

static void build_disk(void)
{
    memset(s_disk, 0, sizeof s_disk);
    uint8_t *boot = s_disk[FAT_BOOT_SECTOR_LBA];
    boot[0] = 0xeb; boot[1] = 0x3c; boot[2] = 0x90; memcpy(&boot[3], "PICOEPRM", 8);
    put16(&boot[0x0b], SECTOR_SIZE); boot[0x0d] = SECTORS_PER_CLUSTER; put16(&boot[0x0e], RESERVED_SECTORS);
    boot[0x10] = NUM_FATS; put16(&boot[0x11], ROOT_DIR_ENTRIES); put16(&boot[0x13], TOTAL_SECTORS);
    boot[0x15] = 0xf8; put16(&boot[0x16], FAT_SECTORS); put16(&boot[0x18], 1); put16(&boot[0x1a], 1);
    boot[0x24] = 0x80; boot[0x26] = 0x29; put32(&boot[0x27], 0x50494330);
    memcpy(&boot[0x2b], "EPROMEMU   ", 11); memcpy(&boot[0x36], "FAT12   ", 8); boot[0x1fe] = 0x55; boot[0x1ff] = 0xaa;

    for (unsigned fat_num = FAT1_LBA; fat_num <= FAT2_LBA; fat_num++) {
        uint8_t *fat = s_disk[fat_num];
        fat12_set_entry(fat, 0, 0xff8); fat12_set_entry(fat, 1, 0xfff);
        for (unsigned chip = 0; chip < NUM_CHIPS; chip++) {
            if (chip != 4u || s_rom5_present) fat12_set_entry(fat, FIRST_HOME_CLUSTER + chip, 0xfff);
        }
    }

    uint8_t *dir = s_disk[ROOT_DIR_LBA];
    memcpy(dir, "EPROMEMU   ", 11); dir[11] = 0x08;
    for (unsigned chip = 0; chip < NUM_CHIPS; chip++) {
        if (chip == 4u && !s_rom5_present) continue;
        uint8_t *e = &dir[(chip + 1u) * 32u];
        memcpy(e, s_file_names[chip], 8); memcpy(e + 8, "BIN", 3); e[11] = 0x20;
        // FAT's NT-reserved case bits make Finder display the 8.3 name as
        // coin_N.bin while retaining the canonical uppercase on disk.
        e[12] = 0x18;
        put16(e + 0x1a, FIRST_HOME_CLUSTER + chip); put32(e + 0x1c, IMAGE_SIZE_BYTES);
    }
}

static int find_rom_dir_slot(unsigned chip)
{
    uint8_t *dir = s_disk[ROOT_DIR_LBA];
    for (unsigned i = 0; i < ROOT_DIR_ENTRIES; i++) {
        uint8_t *e = &dir[i * 32u];
        if (e[0] == 0x00) break;
        if (e[0] == 0xe5 || (e[11] & 0x08)) continue;
        if (memcmp(e, s_file_names[chip], 8) == 0 && memcmp(e + 8, "BIN", 3) == 0) return (int)i;
    }
    return -1;
}

static bool load_rom_from_disk(unsigned chip, uint8_t image[IMAGE_SIZE_BYTES])
{
    int slot = find_rom_dir_slot(chip);
    if (slot < 0) return false;
    uint8_t *entry = &s_disk[ROOT_DIR_LBA][slot * 32u];
    if (get32(entry + 0x1c) != IMAGE_SIZE_BYTES) return false;

    uint16_t cluster = get16(entry + 0x1a);
    uint32_t copied = 0;
    for (unsigned hops = 0; copied < IMAGE_SIZE_BYTES && hops < TOTAL_CLUSTERS; hops++) {
        if (cluster < FIRST_HOME_CLUSTER || cluster > LAST_DATA_CLUSTER) return false;
        uint32_t first_sector = DATA_START_SECTOR + (uint32_t)(cluster - FIRST_HOME_CLUSTER) * SECTORS_PER_CLUSTER;
        for (unsigned sector = 0; sector < SECTORS_PER_CLUSTER && copied < IMAGE_SIZE_BYTES; sector++) {
            uint32_t count = IMAGE_SIZE_BYTES - copied;
            if (count > SECTOR_SIZE) count = SECTOR_SIZE;
            memcpy(image + copied, s_disk[first_sector + sector], count);
            copied += count;
        }
        if (copied == IMAGE_SIZE_BYTES) return true;
        uint16_t next = fat12_get_entry(s_disk[FAT1_LBA], cluster);
        if (next >= 0xff8) return false;
        cluster = next;
    }
    return false;
}

static void load_all_images_from_flash(void)
{
    for (unsigned chip = 0; chip < NUM_CHIPS; chip++) {
        const uint8_t *flash_ptr = (const uint8_t *)(XIP_BASE + flash_offset_for_chip(chip));
        memcpy(emu_rom_image[chip][0], flash_ptr, IMAGE_SIZE_BYTES);
        memcpy(s_staging[chip], flash_ptr, IMAGE_SIZE_BYTES);
        emu_active_buffer[chip] = 0;
        memcpy(&s_disk[DATA_START_SECTOR + chip * SECTORS_PER_CLUSTER][0], flash_ptr, IMAGE_SIZE_BYTES);
    }
}

static void commit_all_dirty(void)
{
    uint8_t image[IMAGE_SIZE_BYTES];
    for (unsigned chip = 0; chip < NUM_CHIPS; chip++) {
        if (load_rom_from_disk(chip, image) && memcmp(image, s_staging[chip], IMAGE_SIZE_BYTES) != 0) {
            memcpy(s_staging[chip], image, IMAGE_SIZE_BYTES); s_dirty[chip] = true;
        }
    }
    bool any = false;
    for (unsigned chip = 0; chip < NUM_CHIPS; chip++) if (s_dirty[chip]) {
        uint32_t ints = save_and_disable_interrupts();
        flash_range_erase(flash_offset_for_chip(chip), IMAGE_SECTOR_SIZE);
        flash_range_program(flash_offset_for_chip(chip), s_staging[chip], IMAGE_SIZE_BYTES);
        restore_interrupts(ints);
        unsigned staging_buf = emu_active_buffer[chip] ^ 1u;
        memcpy(emu_rom_image[chip][staging_buf], s_staging[chip], IMAGE_SIZE_BYTES);
        core1_emulator_publish(chip, staging_buf);
        s_dirty[chip] = false; any = true;
    }

    int rom5_slot = find_rom_dir_slot(4u);
    bool rom5_present_now = false;
    if (rom5_slot >= 0) {
        uint8_t *entry = &s_disk[ROOT_DIR_LBA][(unsigned)rom5_slot * 32u];
        rom5_present_now = get32(entry + 0x1c) == IMAGE_SIZE_BYTES;
    }
    if (rom5_present_now != s_rom5_present) {
        s_rom5_present = rom5_present_now;
        persist_mode_metadata();
        core1_emulator_set_rom5_present(s_rom5_present);
        any = true;
    }
    if (any) reset_control_release();
}

void msc_disk_init(void)
{
    load_mode_metadata(); build_disk(); load_all_images_from_flash();
    for (unsigned i = 0; i < NUM_CHIPS; i++) s_dirty[i] = false;
    s_last_write_time = get_absolute_time(); s_write_pending = false; s_ejected = false;
}

bool msc_disk_rom5_present(void)
{
    return s_rom5_present;
}

void msc_disk_task(void)
{
    if (s_write_pending && absolute_time_diff_us(s_last_write_time, get_absolute_time()) > COMMIT_IDLE_US) {
        commit_all_dirty(); s_write_pending = false; reset_control_release();
    }
}

void tud_msc_inquiry_cb(uint8_t lun, uint8_t vendor_id[8], uint8_t product_id[16], uint8_t product_rev[4])
{ (void)lun; memcpy(vendor_id, "PICOEMU ", 8); memcpy(product_id, "EPROM5 EMULATOR ", 16); memcpy(product_rev, "1.0 ", 4); }

bool tud_msc_test_unit_ready_cb(uint8_t lun)
{ return s_ejected ? tud_msc_set_sense(lun, SCSI_SENSE_NOT_READY, 0x3a, 0x00) : true; }

bool tud_msc_start_stop_cb(uint8_t lun, uint8_t power_condition, bool start, bool load_eject)
{
    (void)lun; (void)power_condition;
    if (load_eject && !start) { commit_all_dirty(); s_write_pending = false; reset_control_release(); s_ejected = true; }
    return true;
}

void tud_msc_capacity_cb(uint8_t lun, uint32_t *block_count, uint16_t *block_size)
{ (void)lun; *block_count = TOTAL_SECTORS; *block_size = SECTOR_SIZE; }
bool tud_msc_is_writable_cb(uint8_t lun) { (void)lun; return !s_ejected; }

int32_t tud_msc_read10_cb(uint8_t lun, uint32_t lba, uint32_t offset, void *buffer, uint32_t bufsize)
{
    (void)lun;
    if (lba >= TOTAL_SECTORS || offset > SECTOR_SIZE || bufsize > SECTOR_SIZE - offset) return -1;
    memcpy(buffer, s_disk[lba] + offset, bufsize); return (int32_t)bufsize;
}

int32_t tud_msc_write10_cb(uint8_t lun, uint32_t lba, uint32_t offset, uint8_t *buffer, uint32_t bufsize)
{
    (void)lun;
    if (s_ejected || lba >= TOTAL_SECTORS || offset > SECTOR_SIZE || bufsize > SECTOR_SIZE - offset) return -1;
    reset_control_notify_write(); memcpy(s_disk[lba] + offset, buffer, bufsize);
    s_last_write_time = get_absolute_time(); s_write_pending = true; return (int32_t)bufsize;
}

int32_t tud_msc_scsi_cb(uint8_t lun, uint8_t const scsi_cmd[16], void *buffer, uint16_t bufsize)
{
    (void)buffer; (void)bufsize;
    if (scsi_cmd[0] == 0x35) { commit_all_dirty(); s_write_pending = false; reset_control_release(); return 0; }
    tud_msc_set_sense(lun, SCSI_SENSE_ILLEGAL_REQUEST, 0x20, 0x00); return -1;
}
