{ pkgs, stateVersion, hostname, user, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
  ];
  networking.hostName = hostname;
  system.stateVersion = stateVersion;

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  security.pam.services = {
    login = {
      enableKwallet = true;
    };
    hyprlock = {};
  };

  # Sunshine
  services.rdp.enable = true;

  # RGB Controller
  hardware.openrazer.enable = true;

  # Battery Tweaks
  hardware.battery-tweaks.enable = true;

  # Disable Nvidia dGPU
  hardware.dgpu.disable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = true;

  # Extra Groups
  users.users.${user} = { extraGroups = [ "openrazer" "plugdev" "corectrl" ]; };
}
