{ pkgs, inputs, system, ... }: {
    # Nix Settings
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings.auto-optimise-store = true;
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
    };
    nixpkgs.config.allowUnfree = true;

    # Import Modules
    imports = [
        ../modules
    ];

    # Network
    networking.networkmanager.enable = true;

    # Timezone
    time.timeZone = "Europe/Berlin";

    # Firmware
    hardware.enableRedistributableFirmware = true;

    # Locale
    i18n.defaultLocale = "en_US.UTF-8";

    # Env
    environment.localBinInPath = true;
    environment.systemPackages = with pkgs; [
        home-manager
        curl
        git
        nix-output-monitor
        powertop
        inputs.agenix.packages."${system}".default
    ];

    # Fonts
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

    # Dbus
    services.dbus.enable = true;

    # SSH
    services.sshd.enable = true;
}