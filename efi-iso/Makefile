file_list = EFI/drivers/NvmExpressDxe.efi EFI/shell/shellx64.efi EFI/shell/shellia32.efi EFI/shell/startup.nsh

.PHONY: all clean distclean test

all: build/efi-utils.iso ;

$(file_list) : $(@F)
	@mkdir -p "$(@D)"
	@cp -afv "$(@F)" "$(@D)"

build/efi-utils.esp.img(%): % ;

build/efi-utils.esp.img: build/efi-utils.esp.img($(file_list))
	@mkdir -p "$(@D)"
	@if [ ! -s "$@" ]; then \
		fallocate --posix --length "4MiB" "$@" ; \
		mformat -i "$@" :: ; \
	fi

	mcopy -D overwrite -Q -s -p -m -i "$@" EFI ::EFI

build/efi-utils.iso(%): % ;

build/efi-utils.iso: build/efi-utils.iso(build/efi-utils.esp.img)
	@mkdir -p "$(@D)"
	@rm -f "$@"
	xorriso -indev "$?" \
		-outdev "$@" \
		-boot_image any replay \
		-append_partition 2 0xef "$?" \
		-map_l ./ /EFI/shell/ shellx64.efi shellia32.efi startup.nsh -- \
		-map_l ./ /EFI/drivers/ NvmExpressDxe.efi

test:
	@echo "This project does not have tests."

clean:
	rm -fv $(file_list) \
		build/efi-utils.esp.img build/efi-utils.iso

distclean:
	rm -rfv EFI build
