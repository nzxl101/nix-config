{ inputs, config, userName, ... }: {
  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  programs.hyprpanel = {
    enable = true;

    # Auto-reload config
    systemd.enable = true;

    # Hyprland integration
    hyprland.enable = true;

    # Overwrite the default config file.
    overwrite.enable = true;

    # Settings
    settings = {
      scalingPriority = "hyprpanel";
      wallpaper.image = "${config.stylix.image}";

      # Theme
      theme.bar.outer_spacing = "0px";
      theme.matugen = true;
      theme.bar.transparent = true;
      theme.font = {
        name = "JetBrains Mono";
        size = "12px";
      };

      # Ignore special workspace
      bar.workspaces.ignored = "-99";

      # Bar
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = false;
      bar.workspaces.show_numbered = true;

      # Clock
      bar.clock.format = "%d/%m/%Y %H:%M:%S";
      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather = {
          enabled = true;
          location = "Marburg";
          unit = "metric";
          key = "/home/${userName}/weatherAPI.json";
        };
      };

      # Dashboard
      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = true;
      menus.dashboard.shortcuts.enabled = false;
      menus.dashboard.powermenu.avatar.image = "${config.stylix.image}";

      # Layout
      layout = {
        "bar.layouts" = {
          "0" = {
            left = [ "dashboard" "workspaces" ];
            middle = [ "clock" ];
            right = [ "systray" "volume" "network" "battery" "notifications" "power" ];
          };
        };
      };
    };
  };
}