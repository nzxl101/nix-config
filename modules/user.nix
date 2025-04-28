{ pkgs, userName, ... }: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users.${userName} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "input" ];
    };
  };

  services.getty.autologinUser = userName;
}