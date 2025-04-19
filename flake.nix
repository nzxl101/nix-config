{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, nixos-hardware, ... }@inputs:
  let
    system = "x86_64-linux";
    homeStateVersion = "24.11";
    primaryUser = "nzxl";
    hosts = [
      { hostname = "shin"; stateVersion = "24.11"; user = primaryUser; }
    ];

    makeSystem = { hostname, stateVersion, user }: nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
        inherit inputs system stateVersion hostname;
        primaryUser = user;
      };
      modules = [
        ./hosts/common.nix
        ./hosts/${hostname}/configuration.nix
      ] ++ nixpkgs.lib.optionals (hostname == "shin") [
        nixos-hardware.nixosModules.common-pc-laptop
      ];
    };
  in
  {
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs // {
        "${host.hostname}" = makeSystem {
          inherit (host) hostname stateVersion user;
        };
      }) {} hosts;

    homeConfigurations = builtins.listToAttrs (map (host: {
      name = "${host.user}@${host.hostname}";
      value = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit inputs homeStateVersion;
          hostName = host.hostname;
          primaryUser = host.user;
        };
        modules = [
          ./home/${host.user}/home.nix
        ];
      };
    }) hosts);
  };
}