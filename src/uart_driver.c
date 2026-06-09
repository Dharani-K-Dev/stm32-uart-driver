/*
 * uart_driver.c — Bare-metal USART3 driver implementation.
 *
 * Polling-based TX and RX. No interrupts, no DMA.
 *
 * Author: Dharani K
 */

#include "uart_driver.h"
#include "stm32h7_regs.h"

/* Renode's stm32h743 platform clocks USART3 at 64 MHz. */
#define USART3_KERNEL_CLOCK_HZ  (64000000UL)

void uart_init(uint32_t baud_rate)
{
    /* Step 1: Enable peripheral clock for USART3.
     * Without this, every USART3 register access is a no-op. */
    RCC_APB1LENR |= RCC_APB1LENR_USART3EN;

    /* Step 2: Set the baud rate. BRR = clock / baud_rate. */
    USART3_BRR = USART3_KERNEL_CLOCK_HZ / baud_rate;

    /* Step 3: Enable transmitter, receiver, and the USART itself. */
    USART3_CR1 = USART_CR1_TE | USART_CR1_RE | USART_CR1_UE;
}

void uart_send_char(char ch)
{
    /* Wait until TDR is empty before writing. */
    while ((USART3_ISR & USART_ISR_TXE) == 0U) {
        /* spin */
    }
    USART3_TDR = (uint32_t)ch;
}

void uart_send_string(const char *str)
{
    if (str == (const char *)0) {
        return;
    }
    while (*str != '\0') {
        uart_send_char(*str);
        str++;
    }
}

char uart_receive_char(void)
{
    /* Wait until a byte is available in RDR. */
    while ((USART3_ISR & USART_ISR_RXNE) == 0U) {
        /* spin */
    }
    return (char)(USART3_RDR & 0xFFU);
}
