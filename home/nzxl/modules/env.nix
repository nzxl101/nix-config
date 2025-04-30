{ config, lib, ... }: {
  home.sessionVariables = rec {
    TERMINAL = "ghostty";
    EDITOR = "code";
    XDG_BIN_HOME = "${config.home.homeDirectory}/.local/bin";
    MESA_SHADER_CACHE_DIR = "${config.home.homeDirectory}/.cache/mesa_shader_cache";
    MESA_SHADER_CACHE_MAX_SIZE = "1G";
    MESA_SHADER_CACHE_DISABLE = "0";
  };
}
