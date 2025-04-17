{
  description = "NixOS configuration";

  # Dependencies (HM, Disko, ...)
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
    nixos-hardware.url = "github:NixOS/nixos-hardware/master"; # Mostly needed for Razer hardware quirks
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, disko, nixos-hardware, ... }@inputs:
  let
    system = "x86_64-linux";
    homeStateVersion = "24.11";
    primaryUser = "nzxl";
    hosts = [
      { hostname = "shin"; stateVersion = "24.11"; }
    ];

    makeSystem = { hostname, stateVersion }: nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
        inherit inputs system stateVersion hostname primaryUser;
      };
      modules = [
        ./hosts
        ./hosts/${hostname}
      ];
    };
  in
  {
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs // {
        "${host.hostname}" = makeSystem {
          inherit (host) hostname stateVersion;
        };
      }) {} hosts;

    homeConfigurations.${primaryUser} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {
        inherit inputs homeStateVersion primaryUser;
      };
      modules = [
        ./home/${primaryUser}/home.nix
      ];
    };
  };
}