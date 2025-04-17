{ pkgs, pkgs-stable, ... }: {
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    openrazer-daemon
    polychromatic
  ];
}