{ pkgs, stateVersion, hostname, user, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
  ];
  networking.hostName = hostname;
  system.stateVersion = stateVersion;

  # Sunshine
  services.rdp.enable = true;

  # RGB Controller
  hardware.openrazer.enable = true;

  # Battery Tweaks
  hardware.battery-tweaks.enable = true;

  # Disable Nvidia dGPU
  hardware.dgpu.disable = true;

  # Extra Groups
  users.users.${user} = { extraGroups = [ "openrazer" "plugdev" "corectrl" ]; };
}
