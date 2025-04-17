{ pkgs, ... }: {
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ./packages.nix
  ];
  networking.hostName = "shin";
}