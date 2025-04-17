{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "NIXOS_OZONE_WL,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland"
      ];

      monitor = ",2560x1440@165,auto,1.25";

      "$mainMod" = "SUPER";
      "$terminal" = "ghostty";

      bind = [
        # Launch terminal
        "$mainMod, RETURN, exec, $terminal"

        # Move focused window
        "$mainMod, left, movewindow, l"
        "$mainMod, right, movewindow, r"
        "$mainMod, up, movewindow, u"
        "$mainMod, down, movewindow, d"
      ];
    };
  };
}