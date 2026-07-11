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
    Reset_Handler:
    
    ldr r0, =_sidata      
    ldr r1, =_sdata       
    ldr r2, =_edata       
copy_loop:
    cmp r1, r2            
    bcs copy_done         
    ldr r3, [r0], #4      
    str r3, [r1], #4      
    b copy_loop
copy_done:
   
    ldr r1, =_sbss
    ldr r2, =_ebss
    movs r3, #0          
zero_loop:
    cmp r1, r2
    bcs zero_done
    str r3, [r1], #4      
    b zero_loop
zero_done:
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
