###############################################################################
# Makefile for the project Xmega_Bootloader
###############################################################################

## General Flags
PROJECT = Xmega_Bootloader

###############################################################################
# User modification section
###############################################################################
#  Choose one of the following MCUs:
#    If you have a different MCU, you will have to define these values:
#         Name in makefile                   Name in ioxxxx.h
#         ---------------------------        -----------------------------
#         BOOT_SECTION_START_IN_BYTES        BOOT_SECTION_START
#         BOOT_PAGE_SIZE                     BOOT_SECTION_PAGE_SIZE
#         APP_PAGE_SIZE                      APP_SECTION_PAGE_SIZE
#
#    You can find these files in the include path for your compiler. Examples:
#    1) Winavr:  C:\WinAVR-20100110\avr\include\avr\ioxxxx.h
#    2) Atmel 3.4.2: C:\Program Files (x86)\Atmel\Atmel Toolchain\AVR8 GCC\
#       Native\3.4.2.1002\avr8-gnu-toolchain\avr\include\avr\ioxxxx.h

#  MCU = atxmega8e5
#  MCU = atxmega16a4
#  MCU = atxmega16a4u
#  MCU = atxmega16c4
#  MCU = atxmega16d4
#  MCU = atxmega16e5
#  MCU = atxmega32a4
#  MCU = atxmega32a4u
#  MCU = atxmega32c3
#  MCU = atxmega32c4
#  MCU = atxmega32d3
#  MCU = atxmega32d4
#  MCU = atxmega32e5
#  MCU = atxmega64a1
#  MCU = atxmega64a1u
#  MCU = atxmega64a3
#  MCU = atxmega64a3u
#  MCU = atxmega64a4u
#  MCU = atxmega64b1
#  MCU = atxmega64b3
#  MCU = atxmega64c3
#  MCU = atxmega64d3
#  MCU = atxmega64d4
#  MCU = atxmega128a1
#  MCU = atxmega128a1u
#  MCU = atxmega128a3
MCU = atxmega128a3u
#  MCU = atxmega128a4u
#  MCU = atxmega128b1
#  MCU = atxmega128b3
#  MCU = atxmega128c3
#  MCU = atxmega128d3
#  MCU = atxmega128d4
#  MCU = atxmega192a3
#  MCU = atxmega192a3u
#  MCU = atxmega192c3
#  MCU = atxmega192d3
#  MCU = atxmega256a3
#  MCU = atxmega256a3b
#  MCU = atxmega256a3bu
#  MCU = atxmega256a3u
#  MCU = atxmega256c3
#  MCU = atxmega256d3
#  MCU = atxmega384c3
#  MCU = atxmega384d3
  
# Choose one of the following interfaces:
# INTERFACE = UART
  INTERFACE = W5500_TCP_RAW

# Specify which SPI to use. For example, E for the PORTE SPI (SPIE).
# Applicable if BOOTLOADER_INTERFACE = W5500_TCP_RAW.
  SPI = E

# Specify a pin for SPI SS (Slave Select). The notation is PORT,PIN. For
# example, if you wanted to use PIN 4 on PORTE, you would set
# the option as E,4.
# Applicable if BOOTLOADER_INTERFACE = W5500_TCP_RAW.
  SPI_SS_PIN = E,4

# Specify a pin for the W5500 interrupt. The notation is PORT,PIN. For example,
# if you wanted to use PIN 2 on PORTD, you would set the option as D,2.
# Applicable if BOOTLOADER_INTERFACE == W5500_TCP_RAW.
  W5500_INT_PIN = D,2

# Specify location (memory type) and offset of ethernet MAC address -
# flash, on-chip EEPROM or external EEPROM (24C02 compatible) via I2C (TWI).
# For I2C, offset = ((7 bit I2C slave address) << 9) + (sub address);
# for example: 0xA0FA for the Microchip 24AA02E48.
# Applicable if BOOTLOADER_INTERFACE = W5500_TCP_RAW.
# MAC_ADDRESS_LOCATION = FLASH
# MAC_ADDRESS_LOCATION = EEPROM
  MAC_ADDRESS_LOCATION = I2C
  MAC_ADDRESS_OFFSET = 0xA0FA

# Specify location (memory type) and offset of static IPv4 address info -
# flash, on-chip EEPROM or external EEPROM (24C02 compatible) via I2C (TWI).
# For I2C, offset = ((7 bit I2C slave address) << 9) + (sub address);
# Applicable if BOOTLOADER_INTERFACE = W5500_TCP_RAW.
# IP_INFO_LOCATION = FLASH
# IP_INFO_LOCATION = EEPROM
  IP_INFO_LOCATION = I2C
  IP_INFO_OFFSET = 0xA000

# Specify TCP port number to listen on.
  TCP_PORT = 65000

# Specify which TWI to use. For example, C for the PORTC TWI (TWIC).
# Applicable if BOOTLOADER_INTERFACE = W5500_TCP_RAW and
# MAC_ADDRESS_LOCATION = I2C.
  TWI = TWIC

# Choose a baud rate for the UART.
#    If you need a baud rate that is not listed in this makefile, you must add
#    new configuration statements in config.macros.h. Remember, Xmegas start-up
#    with a 2MHz clock.
# Applicable if BOOTLOADER_INTERFACE == UART.
# BAUD_RATE = 9600
# BAUD_RATE = 38400
# BAUD_RATE = 57600
  BAUD_RATE = 115200
  
# Specify a pin to check for entry into the bootloader. The notation is
# PORT,PIN. For example, if you wanted to use PIN 3 on PORTC, you would set
# the option as C,3. Then specifiy the logic value required to enable the
# bootloader code (1 = enable the bootloader if the pin is VCC, 0 = enable 
# the bootloader if the pin is GND).
  BOOTLOADER_PIN    = B,2
  BOOTLOADER_PIN_ON = 0
  
# Specify a pin to control an LED. The notation is PORT,PIN. For example, if
# you wanted to use PIN 6 on PORTA, you would set the option as A,6. Then
# specifiy the logic value required to enable the LED (1 = output VCC to turn
# on the LED, 0 = output GND to turn on the LED).
  LED_PIN = D,2
  LED_ON  = 0

# Specify which UART to use with PORT,NUM notation. For example, UART1 on
# PORTD would be D,1.
# Applicable if BOOTLOADER_INTERFACE == UART.
  UART = C,0

###############################################################################
# End user modification section
###############################################################################
  
## Set configuration options based on MCU model  
ifeq ($(MCU), atxmega8e5)
    BOOT_SECTION_START_IN_BYTES = 0x2000
    BOOT_PAGE_SIZE = 128
    APP_PAGE_SIZE = 128
endif
ifeq ($(MCU), atxmega16a4)
    BOOT_SECTION_START_IN_BYTES = 0x4000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega16a4u)
    BOOT_SECTION_START_IN_BYTES = 0x4000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega16c4)
    BOOT_SECTION_START_IN_BYTES = 0x4000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega16d4)
    BOOT_SECTION_START_IN_BYTES = 0x4000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega16e5)
    BOOT_SECTION_START_IN_BYTES = 0x4000
    BOOT_PAGE_SIZE = 128
    APP_PAGE_SIZE = 128
endif
ifeq ($(MCU), atxmega32a4)
    BOOT_SECTION_START_IN_BYTES = 0x8000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega32a4u)
    BOOT_SECTION_START_IN_BYTES = 0x8000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega32c3)
    BOOT_SECTION_START_IN_BYTES = 0x8000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega32c4)
    BOOT_SECTION_START_IN_BYTES = 0x8000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega32d3)
    BOOT_SECTION_START_IN_BYTES = 0x8000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega32d4)
    BOOT_SECTION_START_IN_BYTES = 0x8000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega32e5)
    BOOT_SECTION_START_IN_BYTES = 0x8000
    BOOT_PAGE_SIZE = 128
    APP_PAGE_SIZE = 128
endif
ifeq ($(MCU), atxmega64a1)
    BOOT_SECTION_START_IN_BYTES = 0x10000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega64a1u)
    BOOT_SECTION_START_IN_BYTES = 0x10000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega64a3)
    BOOT_SECTION_START_IN_BYTES = 0x10000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega64a3u)
    BOOT_SECTION_START_IN_BYTES = 0x10000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega64a4u)
    BOOT_SECTION_START_IN_BYTES = 0x10000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega64b1)
    BOOT_SECTION_START_IN_BYTES = 0x10000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega64b3)
    BOOT_SECTION_START_IN_BYTES = 0x10000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega64c3)
    BOOT_SECTION_START_IN_BYTES = 0x10000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega64d3)
    BOOT_SECTION_START_IN_BYTES = 0x10000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega64d4)
    BOOT_SECTION_START_IN_BYTES = 0x10000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega128a1)
    BOOT_SECTION_START_IN_BYTES = 0x20000
    BOOT_PAGE_SIZE = 512
    APP_PAGE_SIZE = 512
endif
ifeq ($(MCU), atxmega128a1u)
    BOOT_SECTION_START_IN_BYTES = 0x20000
    BOOT_PAGE_SIZE = 512
    APP_PAGE_SIZE = 512
endif
ifeq ($(MCU), atxmega128a3)
    BOOT_SECTION_START_IN_BYTES = 0x20000
    BOOT_PAGE_SIZE = 512
    APP_PAGE_SIZE = 512
endif
ifeq ($(MCU), atxmega128a3u)
    BOOT_SECTION_START_IN_BYTES = 0x20000
    BOOT_PAGE_SIZE = 512
    APP_PAGE_SIZE = 512
endif
ifeq ($(MCU), atxmega128a4u)
    BOOT_SECTION_START_IN_BYTES = 0x20000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega128b1)
    BOOT_SECTION_START_IN_BYTES = 0x20000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega128b3)
    BOOT_SECTION_START_IN_BYTES = 0x20000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega128c3)
    BOOT_SECTION_START_IN_BYTES = 0x20000
    BOOT_PAGE_SIZE = 512
    APP_PAGE_SIZE = 512
endif
ifeq ($(MCU), atxmega128d3)
    BOOT_SECTION_START_IN_BYTES = 0x20000
    BOOT_PAGE_SIZE = 512
    APP_PAGE_SIZE = 512
endif
ifeq ($(MCU), atxmega128d4)
    BOOT_SECTION_START_IN_BYTES = 0x20000
    BOOT_PAGE_SIZE = 256
    APP_PAGE_SIZE = 256
endif
ifeq ($(MCU), atxmega192a3)
    BOOT_SECTION_START_IN_BYTES = 0x30000
    BOOT_PAGE_SIZE = 512
    APP_PAGE_SIZE = 512
endif
ifeq ($(MCU), atxmega192a3u)
    BOOT_SECTION_START_IN_BYTES = 0x30000
    BOOT_PAGE_SIZE = 512
    APP_PAGE_SIZE = 512
endif
ifeq ($(MCU), atxmega192c3)
    BOOT_SECTION_START_IN_BYTES = 0x30000
    BOOT_PAGE_SIZE = 512
    APP_PAGE_SIZE = 512
endif
ifeq ($(MCU), atxmega192d3)
    BOOT_SECTION_START_IN_BYTES = 0x30000
    BOOT_PAGE_SIZE = 512
    APP_PAGE_SIZE = 512
endif
ifeq ($(MCU), atxmega256a3)
    BOOT_SECTION_START_IN_BYTES = 0x40000
    BOOT_PAGE_SIZE = 512
    APP_PAGE_SIZE = 512
endif
ifeq ($(MCU), atxmega256a3b)
    BOOT_SECTION_START_IN_BYTES = 0x40000
    BOOT_PAGE_SIZE = 512
    APP_PAGE_SIZE = 512
endif
ifeq ($(MCU), atxmega256a3bu)
    BOOT_SECTION_START_IN_BYTES = 0x40000
    BOOT_PAGE_SIZE = 512
    APP_PAGE_SIZE = 512
endif
ifeq ($(MCU), atxmega256a3u)
    BOOT_SECTION_START_IN_BYTES = 0x40000
    BOOT_PAGE_SIZE = 512
    APP_PAGE_SIZE = 512
endif
ifeq ($(MCU), atxmega256c3)
    BOOT_SECTION_START_IN_BYTES = 0x40000
    BOOT_PAGE_SIZE = 512
    APP_PAGE_SIZE = 512
endif
ifeq ($(MCU), atxmega256d3)
    BOOT_SECTION_START_IN_BYTES = 0x40000
    BOOT_PAGE_SIZE = 512
    APP_PAGE_SIZE = 512
endif
ifeq ($(MCU), atxmega384c3)
    BOOT_SECTION_START_IN_BYTES = 0x60000
    BOOT_PAGE_SIZE = 512
    APP_PAGE_SIZE = 512
endif
ifeq ($(MCU), atxmega384d3)
    BOOT_SECTION_START_IN_BYTES = 0x60000
    BOOT_PAGE_SIZE = 512
    APP_PAGE_SIZE = 512
endif

TARGET = $(PROJECT).elf
TARGET_BASE = $(PROJECT)

CC = avr-gcc
CPP = avr-g++

## Compile options common for all C compilation units.
CFLAGS += -mmcu=$(MCU) -Wall -gdwarf-2 -std=gnu99 -DF_CPU=2000000UL -Os -funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums -DBOOT_PAGE_SIZE=$(BOOT_PAGE_SIZE) -DAPP_PAGE_SIZE=$(APP_PAGE_SIZE) -DMCU=$(MCU) -DBAUD_RATE=$(BAUD_RATE) -DMY_UART=$(UART) -DENTER_BOOTLOADER_PIN=$(BOOTLOADER_PIN) -DLED_PIN=$(LED_PIN) -DLED_ON=$(LED_ON) -DBOOTLOADER_PIN_EN=$(BOOTLOADER_PIN_ON) -DINTERFACE=$(INTERFACE) -DMY_SPI=$(SPI) -DSPI_SS_PIN=$(SPI_SS_PIN) -DW5500_INT_PIN=$(W5500_INT_PIN) -DMAC_ADDRESS_LOCATION=$(MAC_ADDRESS_LOCATION) -DMAC_ADDRESS_OFFSET=$(MAC_ADDRESS_OFFSET) -DIP_INFO_LOCATION=$(IP_INFO_LOCATION)-DIP_INFO_OFFSET=$(IP_INFO_OFFSET) -DTCP_PORT=$(TCP_PORT) -DMY_TWI=$(TWI)
CFLAGS += -MD -MP -MT $(*F).o

## Assembly specific flags
ASMFLAGS += $(CFLAGS)
ASMFLAGS += -x assembler-with-cpp -Wa,-gdwarf2

## Linker flags
LDFLAGS = -mmcu=$(MCU)
LDFLAGS += -Wl,-Map=$(PROJECT).map
LDFLAGS += -Wl,-section-start=.text=$(BOOT_SECTION_START_IN_BYTES)

## Intel Hex file production flags
HEX_FLASH_FLAGS = -R .eeprom -R .fuse -R .lock -R .signature
HEX_EEPROM_FLAGS = -j .eeprom
HEX_EEPROM_FLAGS += --set-section-flags=.eeprom="alloc,load"
HEX_EEPROM_FLAGS += --change-section-lma .eeprom=0 --no-change-warnings

## Objects that must be built in order to link
OBJECTS = $(PROJECT).o serial.o sp_driver.o CCP_Write.o i2c_master.o spi_master.o w5500.o eeprom_driver.o

## Objects explicitly added by the user
LINKONLYOBJECTS =

## Build
all: $(TARGET) $(PROJECT).hex $(PROJECT).eep $(PROJECT).lss
# Uncomment if you want sizebefore and size after to execute
#all: sizebefore $(TARGET) $(PROJECT).hex $(PROJECT).eep sizeafter  $(PROJECT).lss
$(PROJECT).o: $(PROJECT).c
    $(CC) $(INCLUDES) $(CFLAGS) -c  $<

serial.o: serial.c
    $(CC) $(INCLUDES) $(CFLAGS) -c  $<

sp_driver.o: sp_driver.s
    $(CC) $(INCLUDES) $(ASMFLAGS) -c  $<

CCP_Write.o: CCP_Write.s
    $(CC) $(INCLUDES) $(ASMFLAGS) -c  $<

i2c_master.o: i2c_master.c
    $(CC) $(INCLUDES) $(CFLAGS) -c  $<

spi_master.o: spi_master.c
    $(CC) $(INCLUDES) $(CFLAGS) -c  $<

w5500.o: w5500.c
    $(CC) $(INCLUDES) $(CFLAGS) -c  $<

eeprom_driver.o: eeprom_driver.c
    $(CC) $(INCLUDES) $(CFLAGS) -c  $<

##Link
$(TARGET): $(OBJECTS)
    $(CC)  $(LDFLAGS) $(OBJECTS) $(LINKONLYOBJECTS) $(LIBDIRS) $(LIBS) -o $(TARGET)

%.hex: $(TARGET)
    avr-objcopy -O ihex $(HEX_FLASH_FLAGS)  $< $@

%.eep: $(TARGET)
    avr-objcopy $(HEX_EEPROM_FLAGS) -O ihex $< $@ || exit 0

%.lss: $(TARGET)
    avr-objdump -h -S $< > $@

## Clean target
.PHONY: clean
clean:
    -rm -rf $(OBJECTS) $(PROJECT).elf $(PROJECT).hex $(PROJECT).eep $(PROJECT).lss $(PROJECT).map $(PROJECT).d

## Other dependencies


# Display size of file.
FORMAT = ihex
SIZE = avr-size
MSG_SIZE_BEFORE = Size before:
MSG_SIZE_AFTER = Size after:

HEXSIZE = $(SIZE) --target=$(FORMAT) $(TARGET_BASE).hex
ELFSIZE = $(SIZE) -A $(TARGET_BASE).elf

sizebefore:
    @if test -f $(TARGET); then echo; echo $(MSG_SIZE_BEFORE); $(ELFSIZE); \
    echo; fi

sizeafter:
    @if test -f $(TARGET); then echo; echo $(MSG_SIZE_AFTER); $(ELFSIZE); \
    echo; fi
