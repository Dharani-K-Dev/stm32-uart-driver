/*
 * main.c — Application code with UART echo loop.
 *
 * Sends a banner, then echoes back any character typed in the
 * Renode UART analyzer window.
 *
 * Author: Dharani K
 */

#include "uart_driver.h"

volatile int magic = 0xABCD;   /* .data test */
volatile int ghost;            /* .bss test */

int main(void)
{
    uart_init(115200U);

    uart_send_string("\r\n");
    uart_send_string("STM32H743 Bare-Metal UART Driver\r\n");
    uart_send_string("--------------------------------\r\n");
    uart_send_string("Type characters and they will be echoed.\r\n");
    uart_send_string("> ");

    /* Echo loop: read a character, write it back. */
    while (1) {
        char ch = uart_receive_char();
        uart_send_char(ch);

        /* Convert lone CR to CRLF so terminals show new lines properly. */
        if (ch == '\r') {
            uart_send_char('\n');
            uart_send_string("> ");
        }
    }

    return 0;
}
