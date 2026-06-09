/*
 * uart_driver.h — Public API for the bare-metal USART3 driver.
 *
 * Author: Dharani K
 */

#ifndef UART_DRIVER_H
#define UART_DRIVER_H

#include <stdint.h>

/**
 * Initialise USART3 at the given baud rate, 8N1.
 * @param baud_rate  e.g. 115200
 */
void uart_init(uint32_t baud_rate);

/**
 * Send a single character over USART3 (blocking).
 */
void uart_send_char(char ch);

/**
 * Send a null-terminated string over USART3 (blocking).
 */
void uart_send_string(const char *str);

/**
 * Receive a single character from USART3 (blocking).
 */
char uart_receive_char(void);

#endif /* UART_DRIVER_H */
