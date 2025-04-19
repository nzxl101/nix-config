{ pkgs, ... }: {
  programs.chromium = with pkgs; {
    enable = true;
    package = brave;
    extensions = [];
    commandLineArgs = [
      "--ozone-platform-hint=auto"
      "--enable-features=TouchpadOverscrollHistoryNavigation"
    ];
  };
}