{ type, lib, ... }: {
  boot.consoleLogLevel = 3;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "udev.log_priority=3"
    "rd.systemd.show_status=auto"
  ] ++ lib.optionals (type == "laptop") [
    "amd_pstate=guided"
    "usbcore.autosuspend=-1"
  ];
  boot.plymouth.enable = true;
}