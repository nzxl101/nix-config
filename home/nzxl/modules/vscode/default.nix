{ lib, primaryUser, ... }: {
  programs.vscode = {
    enable = true;
  };

  home.file."~/.config/Code/User/settings.json".source = lib.mkForce (
    config.lib.file.mkOutOfStoreSymlink "~/nix-config/home/${primaryUser}/modules/vscode/settings.json"
  );
}