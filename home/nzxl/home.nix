{ homeStateVersion, userName, ... }: {
  imports = [
    ./modules
    ./packages.nix
  ];

  home = {
    username = userName;
    homeDirectory = "/home/${userName}";
    stateVersion = homeStateVersion;
  };
}