/*
 * startup.s — STM32H743 minimal startup file
 *
 * Sets up the vector table, defines the reset handler,
 * and jumps to main(). Written by hand for learning purposes.
 *
 * Author: Dharani K
 */

    .syntax unified
    .cpu cortex-m7
    .thumb
.section .vectors, "a"
    .global vector_table
vector_table:
    .word _stack_top              /* 0: Initial stack pointer */
    .word Reset_Handler           /* 1: Reset handler */
    .word Default_Handler         /* 2: NMI */
    .word Default_Handler         /* 3: Hard Fault */
    /* (We stop here — only 4 entries for now. Real STM32H7 has 240+) */
.section .text
    .global Reset_Handler
    .thumb_func
Reset_Handler:
    /* For now, our reset handler does nothing fancy.
     * It just calls main() directly.
     * Later we'll add: copy .data, zero .bss, then call main.
     */
    bl main

    /* If main ever returns, just loop forever — there's no OS to return to. */
hang:
    b hang
.global Default_Handler
    .thumb_func
Default_Handler:
    /* Catches NMI, Hard Fault, and any unhandled interrupt.
     * For now: just hang in a loop. In production, you'd log the
     * fault details and reset the chip.
     */
    b Default_Handler

    .end
