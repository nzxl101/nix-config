{ lib, type, ... }: {
  programs.hyprland = lib.mkIf (type != "server") {
    enable = true;
    withUWSM = true;
  };
}