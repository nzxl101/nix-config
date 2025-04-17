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

  # TODO: Nvidia Optimus/AMD iGPU Switch
}