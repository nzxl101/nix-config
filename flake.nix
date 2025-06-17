{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, agenix, ... }@inputs:
  let
    system = "x86_64-linux";
    homeStateVersion = "24.11";

    hosts = [
      { hostname = "shin"; stateVersion = "24.11"; user = "nzxl"; type = "laptop"; }
      { hostname = "lynx"; stateVersion = "24.11"; user = "nzxl"; type = "server"; }
      #{ hostname = "rin"; stateVersion = "24.11"; user = "nzxl"; type = "desktop"; }
    ];

    makeSystem = { hostname, stateVersion, user, type }: nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit inputs system stateVersion hostname user type;
      };
      modules = [
        ./cachix.nix
        ./hosts/common.nix
        ./hosts/${hostname}/configuration.nix
        agenix.nixosModules.default
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