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

      monitor = ",2560x1440@165,auto,1.2";

      "$mainMod" = "SUPER";
      "$terminal" = "ghostty";
      "$browser" = "brave";

      bind = [
        # Launch terminal
        "$mainMod, RETURN, exec, $terminal"

        # Launch browser
        "$mainMod, F, exec, $browser"

        # Move focused window
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"
      ];
    };
  };
}