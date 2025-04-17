{ pkgs, ... }: {
  imports = [
    #./hardware-configuration.nix
    ./packages.nix
  ];
  networking.hostName = "shin";
}