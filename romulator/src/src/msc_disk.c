#include "msc_disk.h"

#include <string.h>
#include <stdio.h>

#include "pico/stdlib.h"
#include "hardware/flash.h"
#include "hardware/sync.h"
#include "tusb.h"

#include "pins.h"
#include "flash_layout.h"
#include "core1_emulator.h"
#include "reset_control.h"

// -----------------------------------------------------------------------
// Disk geometry. One FAT cluster == one 2716 image (2048B) for the five
// fixed "home" clusters. A handful of additional clusters are left
// genuinely free as scratch space, because it turns out Windows (and
// probably other OSes) doesn't reliably overwrite a same-name file
// in-place on removable media -- it stages the new content on a freshly
// allocated cluster, deletes the old directory entry, and renames the new
// one into place. So rather than fighting that, this file tracks each ROM
// by NAME and reads whatever cluster its directory entry currently points
// to, wherever that ends up.
// -----------------------------------------------------------------------
#define SECTOR_SIZE             512u
#define SECTORS_PER_CLUSTER     4u              // 4 * 512 = 2048B = IMAGE_SIZE_BYTES
#define RESERVED_SECTORS        1u              // boot sector
#define NUM_FATS                2u
#define FAT_SECTORS              1u              // plenty for <340 clusters
#define ROOT_DIR_SECTORS         1u              // 16 entries * 32B = 512B
#define ROOT_DIR_ENTRIES        16u

#define DATA_START_SECTOR      (RESERVED_SECTORS + NUM_FATS * FAT_SECTORS + ROOT_DIR_SECTORS) // = 4
#define SYSTEM_AREA_SECTORS    DATA_START_SECTOR
#define TOTAL_SECTORS            256u             // 128KB volume
#define DATA_SECTORS             (TOTAL_SECTORS - SYSTEM_AREA_SECTORS)
#define TOTAL_CLUSTERS            (DATA_SECTORS / SECTORS_PER_CLUSTER) // 63

#define FAT_BOOT_SECTOR_LBA      0u
#define FAT1_LBA                 (FAT_BOOT_SECTOR_LBA + RESERVED_SECTORS)
#define FAT2_LBA                 (FAT1_LBA + FAT_SECTORS)
#define ROOT_DIR_LBA              (FAT2_LBA + FAT_SECTORS)

// Five "home" clusters (2..6), one per chip -- what a freshly-booted,
// never-touched-by-Windows volume uses. SCRATCH_CLUSTERS more are left
// genuinely free for the OS's own temp-copy dance; everything past that is
// claimed by a hidden placeholder file so the volume still can't sprawl
// across its whole ~128KB for an unrelated relocation.
#define FIRST_HOME_CLUSTER       2u
#define SCRATCH_CLUSTERS          8u              // 16KB of legitimate free space
#define FIRST_SCRATCH_CLUSTER    (FIRST_HOME_CLUSTER + NUM_CHIPS)
#define FIRST_PLACEHOLDER_CLUSTER (FIRST_SCRATCH_CLUSTER + SCRATCH_CLUSTERS)

static uint8_t s_system_area[SYSTEM_AREA_SECTORS][SECTOR_SIZE];

// Per-chip write staging: whatever's currently believed to be that chip's
// live content, resolved by resolve_relocated_files() below. Committed to
// flash (and published to core1) after a short idle period or a
// SYNCHRONIZE CACHE command.
static uint8_t  s_staging[NUM_CHIPS][IMAGE_SIZE_BYTES];
static volatile bool s_dirty[NUM_CHIPS];
static absolute_time_t s_last_write_time;

// Generic scratch cache: buffers whatever gets written to any cluster in
// the free scratch range, keyed by cluster number, so that once a
// directory entry gets repointed there we have the data to adopt.
typedef struct {
    uint16_t cluster;  // 0 == slot unused
    uint8_t  data[IMAGE_SIZE_BYTES];
} scratch_slot_t;
static scratch_slot_t s_scratch[SCRATCH_CLUSTERS];

#define COMMIT_IDLE_US   (150 * 1000) // flush after 150ms of no further writes

// 8-byte, space-padded FAT short names (NOT null-terminated C-string
// length -- must be exactly 8 bytes for a correct 8.3 directory entry).
static const char s_file_names[NUM_CHIPS][8] = {
    "ROM0    ", "ROM1    ", "ROM2    ", "ROM3    ", "ROM4    "
};

// ------------------------- FAT12 image construction --------------------

static void put16(uint8_t *p, uint16_t v) { p[0] = v & 0xFF; p[1] = (v >> 8) & 0xFF; }
static void put32(uint8_t *p, uint32_t v) { p[0]=v&0xFF; p[1]=(v>>8)&0xFF; p[2]=(v>>16)&0xFF; p[3]=(v>>24)&0xFF; }
static uint16_t get16(const uint8_t *p) { return (uint16_t)(p[0] | (p[1] << 8)); }

static void build_boot_sector(uint8_t *s)
{
    memset(s, 0, SECTOR_SIZE);
    s[0] = 0xEB; s[1] = 0x3C; s[2] = 0x90;               // jmp + nop
    memcpy(&s[3], "PICOEPRM", 8);                         // OEM name
    put16(&s[0x0B], SECTOR_SIZE);
    s[0x0D] = SECTORS_PER_CLUSTER;
    put16(&s[0x0E], RESERVED_SECTORS);
    s[0x10] = NUM_FATS;
    put16(&s[0x11], ROOT_DIR_ENTRIES);
    put16(&s[0x13], TOTAL_SECTORS);
    s[0x15] = 0xF8;                                        // media descriptor: fixed disk
    put16(&s[0x16], FAT_SECTORS);
    put16(&s[0x18], 1);                                    // sectors per track (dummy)
    put16(&s[0x1A], 1);                                    // heads (dummy)
    put32(&s[0x1C], 0);                                    // hidden sectors
    put32(&s[0x20], 0);                                    // total sectors 32 (unused, 16-bit field used above)
    s[0x24] = 0x80;                                        // drive number
    s[0x26] = 0x29;                                        // extended boot signature
    put32(&s[0x27], 0x50494330);                            // volume serial "PIC0"
    memcpy(&s[0x2B], "EPROMEMU   ", 11);                    // volume label
    memcpy(&s[0x36], "FAT12   ", 8);                        // fs type string
    s[0x1FE] = 0x55; s[0x1FF] = 0xAA;                        // boot signature
}

static void fat12_set_entry(uint8_t *fat, unsigned cluster, uint16_t value)
{
    unsigned idx = (cluster * 3) / 2;
    if (cluster & 1) {
        fat[idx]     = (fat[idx] & 0x0F) | ((value << 4) & 0xF0);
        fat[idx + 1] = (value >> 4) & 0xFF;
    } else {
        fat[idx]     = value & 0xFF;
        fat[idx + 1] = (fat[idx + 1] & 0xF0) | ((value >> 8) & 0x0F);
    }
}

// Sets a FAT entry in BOTH on-disk FAT copies at once -- used when we
// reclaim a relocated cluster back to canonical after resolving a write.
static void fat_set_entry_both(unsigned cluster, uint16_t value)
{
    fat12_set_entry(s_system_area[FAT1_LBA], cluster, value);
    fat12_set_entry(s_system_area[FAT2_LBA], cluster, value);
}

static void build_fat(uint8_t *fat)
{
    memset(fat, 0, SECTOR_SIZE);
    fat12_set_entry(fat, 0, 0xFF8);   // media descriptor copy
    fat12_set_entry(fat, 1, 0xFFF);   // reserved

    for (unsigned chip = 0; chip < NUM_CHIPS; chip++) {
        fat12_set_entry(fat, FIRST_HOME_CLUSTER + chip, 0xFFF); // 1-cluster file, EOC
    }
    // Scratch clusters stay 0x000 == genuinely free, for the OS's own use.

    // Placeholder file claims everything past the scratch region so the
    // volume can't sprawl further than that -- caps how much bookkeeping
    // our scratch cache and resolver ever need to deal with.
    for (unsigned c = FIRST_PLACEHOLDER_CLUSTER; c < TOTAL_CLUSTERS + 1; c++) {
        uint16_t next = (c == TOTAL_CLUSTERS) ? 0xFFF : (uint16_t)(c + 1);
        fat12_set_entry(fat, c, next);
    }
}

static void write_dir_entry(uint8_t *e, const char name8[8], const char ext3[3],
                             uint8_t attr, uint16_t cluster, uint32_t size)
{
    memcpy(e, name8, 8);
    memcpy(e + 8, ext3, 3);
    e[11] = attr;
    put16(&e[0x1A], cluster);
    put32(&e[0x1C], size);
}

static void build_root_dir(uint8_t *dir)
{
    memset(dir, 0, SECTOR_SIZE);

    // Volume label entry uses its 11 bytes as one combined field, not a
    // separate name+ext -- handled directly rather than via write_dir_entry.
    memcpy(&dir[0], "EPROMEMU   ", 11);
    dir[11] = 0x08; // ATTR_VOLUME_ID

    for (unsigned chip = 0; chip < NUM_CHIPS; chip++) {
        write_dir_entry(&dir[(chip + 1) * 32], s_file_names[chip], "BIN", 0x20,
                         (uint16_t)(FIRST_HOME_CLUSTER + chip), IMAGE_SIZE_BYTES);
    }

    uint32_t placeholder_clusters = TOTAL_CLUSTERS - (NUM_CHIPS + SCRATCH_CLUSTERS);
    write_dir_entry(&dir[(NUM_CHIPS + 1) * 32], "SPACE   ", "SYS", 0x06,
                     (uint16_t)FIRST_PLACEHOLDER_CLUSTER,
                     placeholder_clusters * SECTORS_PER_CLUSTER * SECTOR_SIZE);
}

static void rebuild_system_area(void)
{
    build_boot_sector(s_system_area[FAT_BOOT_SECTOR_LBA]);
    build_fat(s_system_area[FAT1_LBA]);
    build_fat(s_system_area[FAT2_LBA]);
    build_root_dir(s_system_area[ROOT_DIR_LBA]);
}

// ------------------------- directory lookups -----------------------------

// Scans the root directory for a live (non-deleted, non-volume-label) entry
// whose 8-byte name matches, wherever it currently sits in the table.
// Returns the directory slot index (0..ROOT_DIR_ENTRIES-1), or -1.
static int find_dir_slot(const char name8[8])
{
    uint8_t *dir = s_system_area[ROOT_DIR_LBA];
    for (unsigned i = 0; i < ROOT_DIR_ENTRIES; i++) {
        uint8_t *e = &dir[i * 32];
        if (e[0] == 0x00) break;         // never-used entry -> nothing further to scan
        if (e[0] == 0xE5) continue;      // deleted
        if (e[11] & 0x08) continue;      // volume label / LFN entries
        if (memcmp(e, name8, 8) == 0) return (int) i;
    }
    return -1;
}

static uint16_t dir_slot_get_cluster(int slot) { return get16(&s_system_area[ROOT_DIR_LBA][slot * 32 + 0x1A]); }
static void dir_slot_set_cluster(int slot, uint16_t cluster) { put16(&s_system_area[ROOT_DIR_LBA][slot * 32 + 0x1A], cluster); }

static scratch_slot_t *find_scratch_slot(uint16_t cluster)
{
    for (unsigned i = 0; i < SCRATCH_CLUSTERS; i++) {
        if (s_scratch[i].cluster == cluster) return &s_scratch[i];
    }
    return NULL;
}

static scratch_slot_t *alloc_scratch_slot(uint16_t cluster)
{
    scratch_slot_t *existing = find_scratch_slot(cluster);
    if (existing) return existing;

    for (unsigned i = 0; i < SCRATCH_CLUSTERS; i++) {
        if (s_scratch[i].cluster == 0) {
            s_scratch[i].cluster = cluster;
            return &s_scratch[i];
        }
    }
    // No free slot: evict the first one. In practice a handful of slots
    // comfortably covers however many files Explorer stages at once.
    s_scratch[0].cluster = cluster;
    return &s_scratch[0];
}

// For each chip, checks whether its directory entry has been repointed at
// a cluster other than its home cluster (i.e. Windows relocated it during
// a replace). If we've buffered data for that cluster in the scratch
// cache, adopts it as the chip's new content, then snaps the directory
// entry and FAT back to the canonical layout so future reads/writes don't
// need to keep tracking the relocation.
static void resolve_relocated_files(void)
{
    for (unsigned chip = 0; chip < NUM_CHIPS; chip++) {
        int slot = find_dir_slot(s_file_names[chip]);
        if (slot < 0) continue; // entry momentarily deleted mid-replace; catch it next pass

        uint16_t cluster = dir_slot_get_cluster(slot);
        uint16_t home = (uint16_t)(FIRST_HOME_CLUSTER + chip);
        if (cluster == home) continue; // already canonical

        scratch_slot_t *s = find_scratch_slot(cluster);
        if (!s) continue; // dir entry moved but data hasn't arrived yet -- wait for it

        memcpy(s_staging[chip], s->data, IMAGE_SIZE_BYTES);
        s_dirty[chip] = true;

        // Snap back to canonical so the volume's layout stays predictable.
        dir_slot_set_cluster(slot, home);
        fat_set_entry_both(cluster, 0x000); // free the relocated cluster
        fat_set_entry_both(home, 0xFFF);    // ensure home cluster is EOC

        s->cluster = 0; // release scratch slot
    }
}

// ------------------------- flash <-> RAM image loading -------------------

static void load_all_images_from_flash(void)
{
    for (unsigned chip = 0; chip < NUM_CHIPS; chip++) {
        const uint8_t *flash_ptr = (const uint8_t *)(XIP_BASE + flash_offset_for_chip(chip));
        memcpy(emu_rom_image[chip][0], flash_ptr, IMAGE_SIZE_BYTES);
        memcpy(s_staging[chip], flash_ptr, IMAGE_SIZE_BYTES);
        emu_active_buffer[chip] = 0;
    }
}

static void commit_chip_to_flash(unsigned chip)
{
    uint32_t offset = flash_offset_for_chip(chip);

    uint32_t ints = save_and_disable_interrupts();
    flash_range_erase(offset, IMAGE_SECTOR_SIZE);
    flash_range_program(offset, s_staging[chip], IMAGE_SIZE_BYTES);
    restore_interrupts(ints);

    unsigned live = emu_active_buffer[chip];
    unsigned staging_buf = live ^ 1u;
    memcpy(emu_rom_image[chip][staging_buf], s_staging[chip], IMAGE_SIZE_BYTES);
    core1_emulator_publish(chip, staging_buf);

    s_dirty[chip] = false;
}

static void commit_all_dirty(void)
{
    resolve_relocated_files();

    bool any = false;
    for (unsigned chip = 0; chip < NUM_CHIPS; chip++) {
        if (s_dirty[chip]) {
            commit_chip_to_flash(chip);
            any = true;
        }
    }
    if (any) {
        reset_control_release();
    }
}

void msc_disk_init(void)
{
    rebuild_system_area();
    load_all_images_from_flash();
    for (unsigned i = 0; i < NUM_CHIPS; i++) s_dirty[i] = false;
    for (unsigned i = 0; i < SCRATCH_CLUSTERS; i++) s_scratch[i].cluster = 0;
    s_last_write_time = get_absolute_time();
}

void msc_disk_task(void)
{
    resolve_relocated_files();

    bool any_dirty = false;
    for (unsigned i = 0; i < NUM_CHIPS; i++) any_dirty |= s_dirty[i];

    if (any_dirty &&
        absolute_time_diff_us(s_last_write_time, get_absolute_time()) > COMMIT_IDLE_US) {
        commit_all_dirty();
    }
}

// ------------------------------- TinyUSB callbacks -----------------------

void tud_msc_inquiry_cb(uint8_t lun, uint8_t vendor_id[8], uint8_t product_id[16], uint8_t product_rev[4])
{
    (void) lun;
    memcpy(vendor_id,   "PICOEMU ", 8);
    memcpy(product_id,  "EPROM5 EMULATOR ", 16);
    memcpy(product_rev, "1.0 ", 4);
}

bool tud_msc_test_unit_ready_cb(uint8_t lun)
{
    (void) lun;
    return true;
}

void tud_msc_capacity_cb(uint8_t lun, uint32_t *block_count, uint16_t *block_size)
{
    (void) lun;
    *block_count = TOTAL_SECTORS;
    *block_size  = SECTOR_SIZE;
}

bool tud_msc_is_writable_cb(uint8_t lun)
{
    (void) lun;
    return true;
}

// Given an LBA within the data region, returns the 0-based cluster offset
// (cluster - FIRST_HOME_CLUSTER) and the sector-within-cluster.
static void lba_to_cluster(uint32_t lba, uint32_t *cluster_out, uint32_t *sector_in_cluster_out)
{
    uint32_t data_lba = lba - DATA_START_SECTOR;
    *cluster_out = FIRST_HOME_CLUSTER + (data_lba / SECTORS_PER_CLUSTER);
    *sector_in_cluster_out = data_lba % SECTORS_PER_CLUSTER;
}

int32_t tud_msc_read10_cb(uint8_t lun, uint32_t lba, uint32_t offset, void *buffer, uint32_t bufsize)
{
    (void) lun;
    uint8_t tmp[SECTOR_SIZE] = {0};

    if (lba < SYSTEM_AREA_SECTORS) {
        memcpy(tmp, s_system_area[lba], SECTOR_SIZE);
    } else {
        uint32_t cluster, sector_in_cluster;
        lba_to_cluster(lba, &cluster, &sector_in_cluster);

        if (cluster >= FIRST_HOME_CLUSTER && cluster < FIRST_HOME_CLUSTER + NUM_CHIPS) {
            unsigned chip = cluster - FIRST_HOME_CLUSTER;
            unsigned buf = emu_active_buffer[chip];
            memcpy(tmp, &emu_rom_image[chip][buf][sector_in_cluster * SECTOR_SIZE], SECTOR_SIZE);
        } else {
            scratch_slot_t *s = find_scratch_slot((uint16_t) cluster);
            if (s) {
                memcpy(tmp, &s->data[sector_in_cluster * SECTOR_SIZE], SECTOR_SIZE);
            }
            // else: placeholder / never-written scratch cluster -> zeros
        }
    }

    memcpy(buffer, tmp + offset, bufsize);
    return (int32_t) bufsize;
}

int32_t tud_msc_write10_cb(uint8_t lun, uint32_t lba, uint32_t offset, uint8_t *buffer, uint32_t bufsize)
{
    (void) lun;

    reset_control_notify_write();
    s_last_write_time = get_absolute_time();

    if (lba < SYSTEM_AREA_SECTORS) {
        if (offset + bufsize <= SECTOR_SIZE) {
            memcpy(s_system_area[lba] + offset, buffer, bufsize);
        }
    } else {
        uint32_t cluster, sector_in_cluster;
        lba_to_cluster(lba, &cluster, &sector_in_cluster);
        uint32_t byte_off = sector_in_cluster * SECTOR_SIZE + offset;

        if (cluster >= FIRST_HOME_CLUSTER && cluster < FIRST_HOME_CLUSTER + NUM_CHIPS) {
            unsigned chip = cluster - FIRST_HOME_CLUSTER;
            if (byte_off + bufsize <= IMAGE_SIZE_BYTES) {
                memcpy(&s_staging[chip][byte_off], buffer, bufsize);
                s_dirty[chip] = true;
            }
        } else if (cluster >= FIRST_SCRATCH_CLUSTER && cluster < FIRST_PLACEHOLDER_CLUSTER) {
            scratch_slot_t *s = alloc_scratch_slot((uint16_t) cluster);
            if (byte_off + bufsize <= IMAGE_SIZE_BYTES) {
                memcpy(&s->data[byte_off], buffer, bufsize);
            }
        }
        // else: write landed in the placeholder region -> accepted, discarded
    }

    return (int32_t) bufsize;
}

int32_t tud_msc_scsi_cb(uint8_t lun, uint8_t const scsi_cmd[16], void *buffer, uint16_t bufsize)
{
    (void) lun; (void) buffer; (void) bufsize;

    switch (scsi_cmd[0]) {
        case 0x35: // SCSI SYNCHRONIZE CACHE (10)
            commit_all_dirty();
            return 0;
        default:
            tud_msc_set_sense(lun, SCSI_SENSE_ILLEGAL_REQUEST, 0x20, 0x00);
            return -1;
    }
}
