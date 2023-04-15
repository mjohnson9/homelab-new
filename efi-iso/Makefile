file_list = EFI/DRIVERS/NvmExpressDxe.efi EFI/BOOT/BOOTX64.efi EFI/BOOT/BOOTIA32.efi EFI/BOOT/startup.nsh EFI/DRIVERS/ipxe.efi

.SECONDEXPANSION:
.PHONY: all clean distclean test

all: build/efi-utils.iso ;

$(file_list) : $$(@F)
	@mkdir -p "$(@D)"
	cp -af "$<" "$@"

build/efi-utils.esp.img(%): % ;

build/efi-utils.esp.img: build/efi-utils.esp.img($(file_list))
	@mkdir -p "$(@D)"
	@if [ ! -s "$@" ]; then \
		fallocate --posix --length "4MiB" "$@" ; \
		mformat -i "$@" :: ; \
	fi

	mcopy -D overwrite -Q -s -p -m -i "$@" EFI ::EFI

build/efi-utils.iso(%): % ;

build/efi-utils.iso: build/efi-utils.iso(build/efi-utils.esp.img) $(file_list)
	@mkdir -p "$(@D)"
	@rm -f "$@"
	xorriso -indev build/efi-utils.esp.img \
		-outdev "$@" \
		-boot_image any replay \
		-append_partition 2 0xef build/efi-utils.esp.img \
		-map_l ./ / $(file_list)

test:
	@echo "This project does not have tests."

clean:
	rm -fv $(file_list) \
		build/efi-utils.esp.img build/efi-utils.iso

distclean:
	rm -rfv EFI build
