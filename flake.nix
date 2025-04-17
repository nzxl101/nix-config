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
    specialArgs = {
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
      inherit inputs system;
    };
    primaryUser = "nzxl";
  in
  {
    nixosConfigurations = {
      # == Razer Blade 14 (2021) == #
      "shin" = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts
          ./hosts/shin
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${primaryUser} = import ./home/${primaryUser};
          }
        ];
      };
      # == Adding my desktop later.. == #
    };
  };
}