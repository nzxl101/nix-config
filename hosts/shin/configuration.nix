{ pkgs, stateVersion, hostname, user, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
  ];
  networking.hostName = hostname;
  system.stateVersion = stateVersion;

  # Boot Params
  boot.kernelParams = [
    "amd_pstate=guided"
    "usbcore.autosuspend=-1"
  ];

  # Firmware
  hardware.enableRedistributableFirmware = true;

  # Sunshine
  services.rdp.enable = true;

  # RGB Controller
  hardware.openrazer.enable = true;
  hardware.openrazer.devicesOffOnScreensaver = false;

  # Groups
  users.users.${user} = { extraGroups = [ "openrazer" "plugdev" "corectrl" ]; };

  # Power Management
  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      KBD_BACKLIGHT_TIMEOUT_AC = 0;
      KBD_BACKLIGHT_TIMEOUT_BAT = 0;
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;
    };
  };
  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "schedutil";
  powerManagement.powertop.enable = true;
  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;
  services.auto-cpufreq.enable = false;

  # Hybrid Graphics
  hardware.nvidia.enable = true;
  hardware.nvidia.dynamicBoost.enable = true;
  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    amdgpuBusId = "PCI:04:00:0";
    nvidiaBusId = "PCI:01:00:0";
  };

  # AMDGPU
  programs.corectrl = {
    enable = true;
    gpuOverclock = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };
  };
}