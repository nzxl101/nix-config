{ pkgs, stateVersion, hostname, user, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
  ];
  networking.hostName = hostname;
  system.stateVersion = stateVersion;

  # Enable Greetd
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.uwsm}/bin/uwsm start default > /dev/null 2>&1";
        user = user;
      };
    };
  };

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  security.pam.services = {
    hyprlock = {};
  };
  services.upower.enable = true;

  # Sunshine
  services.rdp.enable = true;

  # RGB Controller
  hardware.openrazer.enable = true;

  # Battery Tweaks
  hardware.battery-tweaks.enable = true;

  # Nvidia dGPU
  hardware.dgpu.disable = true;
  hardware.nvidia.enable = false;

  # AMD iGPU
  hardware.amdgpu = {
    overdrive = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };
  };
  programs.corectrl.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = true;

  # Extra Groups
  users.users.${user} = { extraGroups = [ "openrazer" "plugdev" "corectrl" ]; };

  # Steam
  programs.steam.enable = true;
}
