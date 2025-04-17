{ pkgs, pkgs-stable, primaryUser, ... }: {
    imports = [
        ../modules
    ];
    i18n.defaultLocale = "en_US.UTF-8";
    environment.systemPackages = with pkgs; [
        home-manager
        btop
        curl
        nix-output-monitor
    ];
}