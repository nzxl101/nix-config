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
        "XDG_SCREENSHOTS_DIR,$HOME/Pictures/Screenshots"
      ];

      monitor = ",2560x1440@165,auto,1.2";

      "$mainMod" = "SUPER";
      "$terminal" = "ghostty";
      "$browser" = "brave";
      "$fileBrowser" = "$terminal -e sh -c 'yazi'";
      "$launcher" = "tofi-drun --drun-launch=true"

      bind = [
        # Kill active window
        "$mainMod SHIFT, Q, killactive"

        # Launch file browser
        "$mainMod SHIFT, E, exec, $fileBrowser"
        # Launch terminal
        "$mainMod SHIFT, RETURN, exec, $terminal"
        # Launch browser
        "$mainMod SHIFT, F, exec, $browser"
        # Launcher
        "$mainMod SHIFT, D, exec, $launcher"

        # Toggle floating
        "$mainMod SHIFT, SPACE, togglefloating"
        # Toggle split
        "$mainMod SHIFT, S, togglesplit"
        # Pin
        "$mainMod SHIFT, P, pin"

        # Move focused window
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"

        # Resize window
        "$mainMod CTRL, left, resizeactive, -60 0"
        "$mainMod CTRL, right, resizeactive, 60 0"
        "$mainMod CTRL, up, resizeactive, 0 -60"
        "$mainMod CTRL, down, resizeactive, 0 60"

        # Switch workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"

        # Move window to workspace
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"

        # Screenshot (Full screen)
        ", Print, exec, grimblast --notify --cursor copysave screen"
        # Screenshot (Select region)
        ", SHIFT Print, exec, grimblast --notify --cursor copysave area"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"

        # TODO: OpenRazer
        # ", XF86KbdBrightnessDown, exec, your-kbd-brightness-tool down"
        # ", XF86KbdBrightnessUp, exec, your-kbd-brightness-tool up"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
    };
  };
}