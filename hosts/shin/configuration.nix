{ pkgs, primaryUser, stateVersion, hostname, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
  ];
  networking.hostName = hostname;
  system.stateVersion = stateVersion;

  boot.kernelParams = [
    "amdgpu.dc=1"
    "amdgpu.runpm=0"
  ];

  hardware.openrazer.enable = true;
  users.users.${primaryUser} = { extraGroups = [ "openrazer" "plugdev" ]; };

  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };
  powerManagement.powertop.enable = true;
  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;

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
}