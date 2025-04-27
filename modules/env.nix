{
  environment.sessionVariables = rec {
    TERMINAL = "ghostty";
    EDITOR = "code";
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
      "$HOME/nix-config/scripts"
    ];
    MESA_SHADER_CACHE_DIR = "$HOME/.cache/mesa_shader_cache";
    MESA_SHADER_CACHE_MAX_SIZE = "1G";
    MESA_SHADER_CACHE_DISABLE = "0";
  };
}