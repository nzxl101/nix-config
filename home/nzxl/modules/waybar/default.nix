{ config, lib, primaryUser, hostName, ... }: {
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 25;
        modules-left = ["custom/logo" "hyprland/workspaces"];
        modules-right = if hostName == "shin"
                        then ["custom/weather" "pulseaudio" "battery" "clock" "tray" "custom/notification" "custom/power"]
                        else ["custom/weather" "pulseaudio" "clock" "tray" "custom/notification" "custom/power"];

        "custom/logo" = {
          format = "";
        };

        "custom/power" = {
          format = "⏻";
          on-click = "wofi-power-menu";
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          show-special = true;
          special-visible-only = true;
          all-outputs = false;
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
          };

          persistent-workspaces = {
            "*" = 5;
          };
        };

        "custom/weather" = {
          format = " {} ";
          exec = "curl -s 'wttr.in/Marburg?format=%c%t'";
          interval = 300;
          class = "weather";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "";
          format-icons = {
            "headphones" = "";
            "handsfree" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" ""];
          };
          on-click = "pavucontrol";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 1;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-icons = ["" "" "" "" ""];
          on-click = {};
        };

        "clock" = {
          format = "{:%d.%m.%Y%H:%M}";
          on-click = {};
        };

        "tray" = {
          icon-size = 14;
          spacing = 1;
        };

        "custom/notification" = {
          tooltip = false;
          format = "{icon} {}";
          "format-icons" = {
            notification = "󱅫";
            none = "";
            "dnd-notification" = " ";
            "dnd-none" = "󰂛";
            "inhibited-notification" = " ";
            "inhibited-none" = "";
            "dnd-inhibited-notification" = " ";
            "dnd-inhibited-none" = " ";
          };
          "return-type" = "json";
          "exec-if" = "which swaync-client";
          exec = "swaync-client -swb";
          "on-click" = "sleep 0.1 && swaync-client -t -sw";
          "on-click-right" = "sleep 0.1 && swaync-client -d -sw";
          escape = true;
        };
      };
    };
  };
}