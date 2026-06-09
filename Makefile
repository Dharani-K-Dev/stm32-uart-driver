# Makefile for STM32H743 bare-metal UART driver project
# Author: Dharani K

# ===== Toolchain =====
CC      = arm-none-eabi-gcc
LD      = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy
OBJDUMP = arm-none-eabi-objdump

# ===== Flags =====
CFLAGS  = -mcpu=cortex-m7 -mthumb -nostdlib -ffreestanding -O0 -g -Iinclude -Wall
LDFLAGS = -T linker.ld

# ===== Files =====
BUILD       = build
TARGET      = $(BUILD)/firmware.elf

C_SOURCES   = src/main.c src/uart_driver.c
ASM_SOURCES = src/startup.s

C_OBJECTS   = $(C_SOURCES:src/%.c=$(BUILD)/%.o)
ASM_OBJECTS = $(ASM_SOURCES:src/%.s=$(BUILD)/%.o)
OBJECTS     = $(ASM_OBJECTS) $(C_OBJECTS)

# ===== Default target =====
all: $(TARGET)

$(TARGET): $(OBJECTS) | $(BUILD)
	$(LD) $(LDFLAGS) $(OBJECTS) -o $@
	@echo "BUILD OK -> $@"

# Pattern rule: any build/X.o is built from src/X.c
$(BUILD)/%.o: src/%.c | $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

# Pattern rule: any build/X.o is built from src/X.s
$(BUILD)/%.o: src/%.s | $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

# Make sure build directory exists
$(BUILD):
	mkdir -p $(BUILD)

# ===== Convenience targets =====
clean:
	rm -rf $(BUILD)

run: $(TARGET)
	~/renode_portable/renode renode/run.resc

.PHONY: all clean run
