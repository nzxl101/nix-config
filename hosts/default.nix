{ pkgs, pkgs-stable, ... }: {
    imports = [
        ../modules
    ];
    i18n.defaultLocale = "en_US.UTF-8";
    environment.systemPackages = with pkgs; [
        home-manager
        git
        bashtop
        curl
        neovim
        nix-output-monitor
    ];
    system.stateVersion = "24.11";
}