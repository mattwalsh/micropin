cmake_minimum_required(VERSION 3.13)

# Pull in the Pico SDK (must run before project())
include(pico_sdk_import.cmake)

project(pico_eprom_emulator C CXX ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

# Target board: plain Raspberry Pi Pico (RP2040)
set(PICO_BOARD pico CACHE STRING "Board type")

pico_sdk_init()

add_executable(pico_eprom_emulator
    src/main.c
    src/core1_emulator.c
    src/reset_control.c
    src/msc_disk.c
    src/usb_control.c
    src/usb_descriptors.c
)

target_include_directories(pico_eprom_emulator PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}
    ${CMAKE_CURRENT_LIST_DIR}/src
)

# Core1's emulation loop lives entirely in RAM and never reads flash, so we
# can tell the SDK's flash helpers that core1 does not need to be locked out
# during flash_range_erase/flash_range_program. This avoids the SDK trying to
# IPC-pause core1 (and therefore avoids any chance of it stalling mid-cycle)
# every time we commit a new ROM image to flash.
target_compile_definitions(pico_eprom_emulator PRIVATE
    PICO_FLASH_ASSUME_CORE1_SAFE=1
)

target_link_libraries(pico_eprom_emulator PRIVATE
    pico_stdlib
    pico_multicore
    pico_bootrom
    pico_unique_id
    hardware_flash
    hardware_sync
    hardware_gpio
    tinyusb_device
)

# Give the emulator a couple of ms of stack headroom on core1 for safety
pico_set_program_name(pico_eprom_emulator "pico_eprom_emulator")
pico_set_program_version(pico_eprom_emulator "0.1.0")

# We don't need a USB CDC/UART console competing with our own USB MSC device,
# so route stdio to UART only (handy for a debug probe / serial adapter).
pico_enable_stdio_uart(pico_eprom_emulator 1)
pico_enable_stdio_usb(pico_eprom_emulator 0)

pico_add_extra_outputs(pico_eprom_emulator)
