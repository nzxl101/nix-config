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
    # walker = {
    #   url = "github:abenz1267/walker";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, nixos-hardware, ... }@inputs:
  let
    system = "x86_64-linux";
    homeStateVersion = "24.11";

    hosts = [
      { hostname = "shin"; stateVersion = "24.11"; user = "nzxl"; type = "laptop"; }
    ];

    makeSystem = { hostname, stateVersion, user, type }: nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
        inherit inputs system stateVersion hostname user;
      };
      modules = [
        ./cachix.nix
        ./hosts/common.nix
        ./hosts/${hostname}/configuration.nix
      ] ++ nixpkgs.lib.optionals (type == "laptop") [
        nixos-hardware.nixosModules.common-pc-laptop-ssd
      ] ++ nixpkgs.lib.optionals (type == "desktop") [
        nixos-hardware.nixosModules.common-pc-ssd
      ];
    };
  in
  {
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs // {
        "${host.hostname}" = makeSystem {
          inherit (host) hostname stateVersion user type;
        };
      }) {} hosts;

    homeConfigurations = builtins.listToAttrs (map (host: {
      name = "${host.user}@${host.hostname}";
      value = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit inputs homeStateVersion;
          hostName = host.hostname;
          userName = host.user;
          machineType = host.type;
        };
        modules = [
          ./home/${host.user}/home.nix
        ];
      };
    }) hosts);
  };
}