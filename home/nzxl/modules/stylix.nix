{ pkgs, inputs, config, ... }: {
  imports = [ inputs.stylix.homeManagerModules.stylix ];

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/horizon-dark.yaml";

    targets = {
      hyprlock.enable = false;
      waybar.enable = false;
      vscode.enable = false;
      tmux.enable = true;
      wofi.enable = false;

      gtk.extraCss = ''
        window.background,
        window.maximized,
        window.dialog,
        window.message,
        window.csd {
          border-radius: 0;
        }

        messagedialog.background,
        messagedialog.maximized,
        messagedialog.dialog,
        messagedialog.message,
        messagedialog.csd {
          border-radius: 0;
          border-bottom-left-radius: 0;
          border-bottom-right-radius: 0;
        }
      '';
    };

    cursor = {
      name = "DMZ-Black";
      size = 24;
      package = pkgs.vanilla-dmz;
    };

    fonts = {
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };
      monospace = {
        name = "JetBrains Mono";
        package = pkgs.jetbrains-mono;
      };
      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };
      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };

      sizes = {
        terminal = 13;
        applications = 11;
      };
    };

    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    image = ../../../wallpaper-2.jpg;
  };
}