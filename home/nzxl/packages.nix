{ pkgs, pkgs-stable, ... }: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # Utils (screenshots, brightness control etc.)
    grimblast
    playerctl
    brightnessctl
    polychromatic
    pavucontrol
    git-credential-manager
  ];
}