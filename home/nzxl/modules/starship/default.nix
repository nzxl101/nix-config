{ pkgs, ... }: {
  programs.starship = with pkgs; {
    enable = true;
    enableZshIntegration = true;
    settings = pkgs.lib.importTOML ./starship.toml;
  };
}