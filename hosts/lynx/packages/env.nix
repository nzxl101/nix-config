{ config, lib, ... }: {
  environment.sessionVariables = rec {
    EDITOR = "nvim";
    # XDG_BIN_HOME = "${config.home.homeDirectory}/.local/bin";
  };
}
