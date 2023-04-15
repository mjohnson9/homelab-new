@echo -off

if exist .\EFI\DRIVERS\NvmExpressDXE.efi then
  goto DRIVERS
endif

if exist fs0:\EFI\DRIVERS\NvmExpressDXE.efi then
 fs0:
 goto DRIVERS
endif

if exist fs1:\EFI\DRIVERS\NvmExpressDXE.efi then
 fs1:
 goto DRIVERS
endif

if exist fs2:\EFI\DRIVERS\NvmExpressDXE.efi then
 fs2:
 goto DRIVERS
endif

if exist fs3:\EFI\DRIVERS\NvmExpressDXE.efi then
 fs3:
 goto DRIVERS
endif

if exist fs4:\EFI\DRIVERS\NvmExpressDXE.efi then
 fs4:
 goto DRIVERS
endif

if exist fs5:\EFI\DRIVERS\NvmExpressDXE.efi then
 fs5:
 goto DRIVERS
endif

if exist fs6:\EFI\DRIVERS\NvmExpressDXE.efi then
 fs6:
 goto DRIVERS
endif

if exist fs7:\EFI\DRIVERS\NvmExpressDXE.efi then
 fs7:
 goto DRIVERS
endif

echo "Unable to find iPXE"
exit 1

:DRIVERS
load EFI\DRIVERS\NvmExpressDxe.efi
connect -r
map -u

:PXE
EFI\DRIVERS\ipxe.efi

:LOCALFIND
if exist fs0:\EFI\BOOT\BOOTx64.efi and not exist fs0:\EFI\DRIVERS\ipxe.efi then
 fs0:
 goto LOCAL
endif

if exist fs1:\EFI\BOOT\BOOTx64.efi and not exist fs1:\EFI\DRIVERS\ipxe.efi then
 fs1:
 goto LOCAL
endif

if exist fs2:\EFI\BOOT\BOOTx64.efi and not exist fs2:\EFI\DRIVERS\ipxe.efi then
 fs2:
 goto LOCAL
endif

if exist fs3:\EFI\BOOT\BOOTx64.efi and not exist fs3:\EFI\DRIVERS\ipxe.efi then
 fs3:
 goto LOCAL
endif

if exist fs4:\EFI\BOOT\BOOTx64.efi and not exist fs4:\EFI\DRIVERS\ipxe.efi then
 fs4:
 goto LOCAL
endif

if exist fs5:\EFI\BOOT\BOOTx64.efi and not exist fs5:\EFI\DRIVERS\ipxe.efi then
 fs5:
 goto LOCAL
endif

if exist fs6:\EFI\BOOT\BOOTx64.efi and not exist fs6:\EFI\DRIVERS\ipxe.efi then
 fs6:
 goto LOCAL
endif

if exist fs7:\EFI\BOOT\BOOTx64.efi and not exist fs7:\EFI\DRIVERS\ipxe.efi then
 fs7:
 goto LOCAL
endif

echo "Unable to find local disk"
exit 1

:LOCAL
EFI\BOOT\BOOTx64.efi

:END
exit
