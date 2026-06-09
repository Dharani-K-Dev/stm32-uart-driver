/*
 * linker.ld — Minimal linker script for STM32H743ZI
 *
 * Memory map for STM32H743:
 *   FLASH: 2 MB starting at 0x08000000
 *   RAM (DTCM): 128 KB starting at 0x20000000
 *
 * Author: Dharani K
 */

ENTRY(Reset_Handler)

MEMORY
{
    FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 2048K
    RAM   (rw) : ORIGIN = 0x20000000, LENGTH = 128K
}

SECTIONS
{
    .vectors : {
        KEEP(*(.vectors))
    } > FLASH

    .text : {
        *(.text*)
    } > FLASH

    .rodata : {
        *(.rodata*)
    } > FLASH

    .data : {
        *(.data*)
    } > RAM

    .bss : {
        *(.bss*)
    } > RAM
}

_stack_top = ORIGIN(RAM) + LENGTH(RAM);
