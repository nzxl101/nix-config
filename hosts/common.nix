{ pkgs, pkgs-stable, ... }: {
    imports = [
        ../modules
    ];
    i18n.defaultLocale = "en_US.UTF-8";
    environment.systemPackages = with pkgs; [
        home-manager
        curl
        git
        nix-output-monitor
        powertop
    ];
    fonts.packages = with pkgs; [
        dejavu_fonts
        jetbrains-mono
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        font-awesome
        fira
        fira-code
        fira-code-symbols
        liberation_ttf
        libertine
        source-serif-pro
        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
    ];
    services.dbus.enable = true;
}