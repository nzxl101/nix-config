{ config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases =
      let
        configDir = "~/nix-config";
        currentUser = config.home.username;
      in {
        "rebuild" = "sudo nixos-rebuild switch --flake ${configDir}#$(hostname)";
        "update" = "nix flake update ${configDir} && sudo nixos-rebuild switch --flake ${configDir}#$(hostname)";
        "gc" = "nix-collect-garbage -d";
        "hs" = "home-manager switch --flake ${configDir}#${currentUser}";

        "ll" = "ls -l";
      };

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    initExtra = ''
      # Tmux session
      if [ -z "$TMUX" ] && [ -n "$DISPLAY" ]; then
        tmux attach-session -t default || tmux new-session -s default
      fi

      # Wayland session
      if uwsm check may-start > /dev/null && uwsm select; then
        exec systemd-cat -t uwsm_start uwsm start default
      fi
    '';
  };
}