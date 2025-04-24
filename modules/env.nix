{
  environment.sessionVariables = rec {
    TERMINAL = "ghostty";
    EDITOR = "code";
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
      "$HOME/nix-config/scripts"
    ];
  };
}