{ lib, hostName, pkgs, machineType, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Cachix
    cachix

    # Utils
    microfetch

  ] ++ lib.optionals (machineType == "desktop" || machineType == "laptop")[
    # File Explorer
    kdePackages.dolphin

    # OBS
    obs-studio

    # Utils (screenshots, brightness control etc.)
    brightnessctl
    cliphist
    git-credential-manager
    grimblast
    hyprpicker
    hyprswitch
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