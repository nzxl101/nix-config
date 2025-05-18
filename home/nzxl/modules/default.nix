{ lib, ... }: {
  imports = [
    ./git.nix
    ./zsh.nix
    ./tmux.nix
    ./yazi.nix
    ./starship
    ./btop.nix
  ] ++ lib.optionals (machineType == "desktop" || machineType == "laptop") [
    ./chromium.nix
    ./ghostty.nix
    ./hyprland
    ./wofi.nix
    ./vscode
    ./easyeffects
    ./waybar
    ./swaync.nix
    ./stylix.nix
    ./network-manager-applet.nix
    ./env.nix
  ];
}
