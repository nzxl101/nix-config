{ pkgs, ... }: {
  programs.chromium = with pkgs; {
    enable = true;
    package = brave;
    extensions = [];
    commandLineArgs = [];
  };
}