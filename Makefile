LINKARGS = "-mthumb -mcpu=cortex-m3 -Tefm32gg.ld --specs=nosys.specs -lgcc -lc -lnosys -lm -Wl,--start-group -lnosys -lgcc -lc -lm -Wl,--start-group"

OBJCOPY = arm-none-eabi-objcopy

OUT=$(shell cat Cargo.toml | sed -n 's/^name *= *"\(.*\)" *$/\1/p' | head -1)

DEBUG_DIR=target/thumbv7m-none-eabi/debug

all: debug

debug: $(DEBUG_DIR)/$(OUT) $(DEBUG_DIR)/$(OUT).hex $(DEBUG_DIR)/$(OUT).bin $(DEBUG_DIR)/$(OUT).axf

$(DEBUG_DIR)/$(OUT): src/main.rs
	cargo linkargs $(LINKARGS) --target thumbv7m-none-eabi --verbose

%.hex: %
	$(OBJCOPY) -O ihex $< $@

%.bin: %
	$(OBJCOPY) -O binary $< $@

%.axf: %
	$(OBJCOPY) $< $@
