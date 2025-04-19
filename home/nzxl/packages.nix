{ lib, hostName, pkgs, pkgs-stable, ... }: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # Utils (screenshots, brightness control etc.)
    grimblast
    playerctl
    brightnessctl
    pavucontrol
    git-credential-manager
  ] ++ lib.optionals (hostName == "shin") [
    # Razer controller
    polychromatic
  ];
}