LINKARGS = "-mthumb -mcpu=cortex-m3 -Tefm32gg.ld --specs=nosys.specs -lgcc -lc -lnosys -lm"

OBJCOPY = arm-none-eabi-objcopy

OUT=$(shell cat Cargo.toml | sed -n 's/^name *= *"\(.*\)" *$/\1/p' | head -1)

DEBUG_DIR=target/thumbv7m-none-eabi/debug
DEBUG_OUT=$(DEBUG_DIR)/$(OUT)

RELEASE_DIR=target/thumbv7m-none-eabi/release
RELEASE_OUT=$(RELEASE_DIR)/$(OUT)

.PHONY: all debug release

all: debug

debug: $(DEBUG_OUT) $(DEBUG_OUT).hex $(DEBUG_OUT).bin $(DEBUG_OUT).axf

release: $(RELEASE_OUT) $(RELEASE_OUT).hex $(RELEASE_OUT).bin $(RELEASE_OUT).axf

$(DEBUG_OUT):
	cargo linkargs $(LINKARGS) --target thumbv7m-none-eabi --verbose

$(RELEASE_OUT):
	cargo linkargs $(LINKARGS) --target thumbv7m-none-eabi --verbose --release

%.hex: %
	$(OBJCOPY) -O ihex $< $@

%.bin: %
	$(OBJCOPY) -O binary $< $@

%.axf: %
	$(OBJCOPY) $< $@

clean:
	cargo clean
