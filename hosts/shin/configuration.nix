{ pkgs, primaryUser, stateVersion, hostname, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
  ];
  networking.hostName = hostname;
  system.stateVersion = stateVersion;

  hardware.openrazer.enable = true;
  users.users.${primaryUser} = { extraGroups = [ "openrazer" ]; };
  services.tlp.enable = true;

  hardware.nvidia.enable = true;
  hardware.nvidia.prime = {
    sync.enable = true;
    amdGpuBusId = "PCI:04:00:0";
    nvidiaBusId = "PCI:01:00:0";
    offload.enable = true;
  };
}