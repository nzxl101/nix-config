{ pkgs, primaryUser, stateVersion, hostname, ... }: {
  imports = [
    #./hardware-configuration.nix
    ./packages.nix
  ];
  networking.hostName = hostname;
  system.stateVersion = stateVersion;
}