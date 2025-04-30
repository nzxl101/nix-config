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
  boot.initrd.kernelModules = [ "amdgpu" ];

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
  # hardware.nvidia.enable = true;
  # hardware.nvidia.prime = {
  #   offload = {
  #     enable = true;
  #     enableOffloadCmd = true;
  #   };
  #   amdgpuBusId = "PCI:4:0:0";
  #   nvidiaBusId = "PCI:1:0:0";
  # };

  # Disable dGPU (I can't figure out how to setup Hybrid)
  boot.extraModprobeConfig = ''
    blacklist nouveau
    options nouveau modeset=0
  '';
  services.udev.extraRules = ''
    # Remove NVIDIA USB xHCI Host Controller devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"

    # Remove NVIDIA USB Type-C UCSI devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"

    # Remove NVIDIA Audio devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"

    # Remove NVIDIA VGA/3D controller devices
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
  '';
  boot.blacklistedKernelModules = [ "nouveau" "nvidia" ];

  # AMDGPU
  programs.corectrl = {
    enable = true;
    gpuOverclock = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };
  };
}
