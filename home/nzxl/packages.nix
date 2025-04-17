{ pkgs, pkgs-stable, ... }: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [];
}