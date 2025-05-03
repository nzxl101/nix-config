{ pkgs, inputs, config, ... }: {
  imports = [ inputs.stylix.homeManagerModules.stylix ];

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    targets = {
      hyprland.enable = false;
      hyprlock.enable = false;
      waybar.enable = false;
      vscode.enable = false;
      wofi.enable = false;
      gtk.extraCss = ''
        window.background,
        window.maximized,
        window.dialog,
        window.message,
        window.csd,
        #input,
        #entry,
        #entry:selected,
        #outer-box {
          border-radius: 0;
        }

        #entry:selected {
          outline: none;
        }

        messagedialog.background,
        messagedialog.maximized,
        messagedialog.dialog,
        messagedialog.message,
        messagedialog.csd {
          border-radius: 0;
        }

        .control-center,
        .notification-window,
        .notification {
          border-radius: 0;
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

    image = ../../../wallpaper.png;
  };
}