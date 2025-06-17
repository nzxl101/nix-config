{ config, ... }: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 0;
        hide_cursor = true;
        no_fade_in = false;
      };

      label = {
        text = "$TIME";
        font_size = 96;
        font_family = "JetBrains Mono";
        color = "rgba(bbbdc4ff)";
        # position = "0, 1280";
        halign = "center";
        walign = "center";

        shadow_passes = 1;
      };

      background = [
        {
          path = "${config.stylix.image}";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "300, 50";
          position = "0, -120";
          monitor = "";
          dots_center = true;
          font_color = "rgba(bbbdc4ff)";
          inner_color = "rgba(22232dff)";
          outer_color = "rgba(bb4a65ff)";
          outline_thickness = 5;
          placeholder_text = "Enter Password..";
          shadow_passes = 1;
          font_family = "JetBrains Mono";
        }
      ];
    };
  };
}