{ config, lib, primaryUser, ... }: {
  programs.vscode = {
    enable = true;
  };

  home.file."${config.home.homeDirectory}/.config/Code/User/settings.json".source = lib.mkForce (
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/home/${primaryUser}/modules/vscode/settings.json"
  );
}