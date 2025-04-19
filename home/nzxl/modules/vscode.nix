let
  profile = "default";
in
{
  programs.vscode = {
    enable = true;
    profiles.${default}.userSettings = {
      "sync.enable" = true;
    };
  };
}