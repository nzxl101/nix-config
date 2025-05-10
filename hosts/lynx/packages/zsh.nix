{ config, user, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases =
      let
        configDir = "~/nix-config";
        currentUser = user;
      in {
        "pull" = "(cd ${configDir} && git pull --rebase)";
        "rebuild" = "sudo nixos-rebuild switch --flake ${configDir}#$(hostname)";
        "update" = "nix flake update ${configDir} && sudo nixos-rebuild switch --flake ${configDir}#$(hostname)";
        "cleanup" = "nix-collect-garbage -d";

        "ll" = "ls -l";
        ".." = "cd ..";
      };

    # history.size = 10000;
    # history.path = "${config.xdg.dataHome}/zsh/history";

    # initExtra = ''
    #   bindkey "^[[1;5D" backward-word
    #   bindkey "^[[1;5C" forward-word
    # '';
  };
}
