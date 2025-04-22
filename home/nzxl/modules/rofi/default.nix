{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    theme = "~/nix-config/home/nzxl/modules/rofi/theme.rasi";
  };
}