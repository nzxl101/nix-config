{ pkgs, primaryUser, ... }: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users.${primaryUser} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "input" ];
    };
  };

  services.getty.autologinUser = primaryUser;
}