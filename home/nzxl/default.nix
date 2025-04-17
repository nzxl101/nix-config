{ homeStateVersion, primaryUser, ... }: {
  imports = [
    ./modules
    ./packages.nix
  ];

  home = {
    username = primaryUser;
    homeDirectory = "/home/${primaryUser}";
    stateVersion = homeStateVersion;
  };
}