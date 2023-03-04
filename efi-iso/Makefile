.PHONY: all
all: build/efi-utils.iso
	@echo --all--

clean:
	rm -rfv esp build

esp:
	mkdir esp

esp/EFI: | esp
	mkdir esp/EFI

esp/EFI/drivers: | esp/EFI
	mkdir esp/EFI/drivers

esp/EFI/drivers/NvmExpressDxe.efi : NvmExpressDxe.efi | esp/EFI/drivers
	cp -af "$<" "$@"

esp/EFI/shell : | esp/EFI
	mkdir esp/EFI/shell

esp/EFI/shell/shellx64.EFI: shellx64.efi | esp/EFI/shell
	cp -af "$<" "$@"

esp/EFI/shell/shellia32.EFI: shellia32.efi | esp/EFI/shell
	cp -af "$<" "$@"

esp/EFI/shell/startup.nsh: startup.nsh | esp
	cp -af "$<" "$@"

build:
	mkdir build

build/efi-utils.esp.img: esp/EFI/shell/shellx64.EFI esp/EFI/shell/shellia32.EFI esp/EFI/shell/startup.nsh esp/EFI/drivers/NvmExpressDxe.efi | build esp
	@rm -f "$@"
	fallocate --posix --length "2MiB" "$@"
	mformat -i "$@" ::

	mcopy -Q -s -p -m -i "$@" esp/EFI ::EFI

build/efi-utils.iso: build/efi-utils.esp.img | build
	@rm -f "$@"
	xorriso -indev "$<" \
		-outdev "$@" \
		-boot_image any replay \
		-append_partition 2 0xef "$<" \
		-map_l ./ /EFI/shell/ shellx64.efi shellia32.efi startup.nsh -- \
		-map_l ./ /EFI/drivers/ NvmExpressDxe.efi
