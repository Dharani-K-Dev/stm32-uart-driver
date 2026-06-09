/*
 * stm32h7_regs.h — STM32H743ZI register definitions
 *
 * Only the registers used by this project are defined.
 * All addresses verified against RM0433 (STM32H7 reference manual).
 *
 * Author: Dharani K
 */

#ifndef STM32H7_REGS_H
#define STM32H7_REGS_H

#include <stdint.h>

/* ===== RCC (Reset and Clock Control) ===== */
#define RCC_BASE                (0x58024400UL)
#define RCC_APB1LENR            (*(volatile uint32_t *)(RCC_BASE + 0x0E8))

#define RCC_APB1LENR_USART3EN   (1U << 18)

/* ===== USART3 ===== */
#define USART3_BASE             (0x40004800UL)
#define USART3_CR1              (*(volatile uint32_t *)(USART3_BASE + 0x00))
#define USART3_BRR              (*(volatile uint32_t *)(USART3_BASE + 0x0C))
#define USART3_ISR              (*(volatile uint32_t *)(USART3_BASE + 0x1C))
#define USART3_RDR              (*(volatile uint32_t *)(USART3_BASE + 0x24))
#define USART3_TDR              (*(volatile uint32_t *)(USART3_BASE + 0x28))

#define USART_CR1_UE            (1U << 0)
#define USART_CR1_RE            (1U << 2)
#define USART_CR1_TE            (1U << 3)

#define USART_ISR_RXNE          (1U << 5)
#define USART_ISR_TXE           (1U << 7)

#endif /* STM32H7_REGS_H */
