{ lib, hostName, pkgs, pkgs-stable, ... }: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # Utils (screenshots, brightness control etc.)
    grimblast
    playerctl
    brightnessctl
    pavucontrol
    git-credential-manager

    # Libs
    libsForQt5.xwaylandvideobridge
    libnotify
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland

  ] ++ lib.optionals (hostName == "shin") [
    # Razer controller
    polychromatic
  ];
}