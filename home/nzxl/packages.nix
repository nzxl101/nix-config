{ lib, hostName, pkgs, pkgs-stable, ... }: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # OBS
    obs-studio

    # Cachix
    cachix

    # Utils (screenshots, brightness control etc.)
    brightnessctl
    cliphist
    git-credential-manager
    grimblast
    hyprpicker
    hyprswitch
    microfetch
    pavucontrol
    playerctl
    wl-clipboard
    wofi-emoji
    wofi-power-menu

    # Libs
    glib
    libnotify
    libsForQt5.xwaylandvideobridge
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland

  ] ++ lib.optionals (hostName == "shin") [
    # Razer controller
    polychromatic
  ];
}