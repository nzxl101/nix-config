{ pkgs, pkgs-stable, ... }: {
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [ ];

  # CORECTRL
  programs.corectrl = {
    enable = true;
    gpuOverclock = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };
  };
}