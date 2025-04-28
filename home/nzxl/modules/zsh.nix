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
        "pull" = "(cd ${configDir} && git pull --rebase)";
        "rebuild-home" = "home-manager switch --flake ${configDir}#${currentUser}@$(hostname)";
        "rebuild-system" = "sudo nixos-rebuild switch --flake ${configDir}#$(hostname)";
        "update" = "nix flake update ${configDir} && sudo nixos-rebuild switch --flake ${configDir}#$(hostname)";
        "cleanup" = "nix-collect-garbage -d";

        "ll" = "ls -l";
        ".." = "cd ..";
      };

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    initExtra = ''
      bindkey "^[[1;5D" backward-word
      bindkey "^[[1;5C" forward-word

      # Tmux session
      if [ -z "$TMUX" ] && [ -n "$DISPLAY" ]; then
        tmux attach-session -t default || tmux new-session -s default
      fi

      # Wayland session
      if uwsm check may-start > /dev/null; then
        exec systemd-cat -t uwsm_start uwsm start default
      fi
    '';
  };
}
