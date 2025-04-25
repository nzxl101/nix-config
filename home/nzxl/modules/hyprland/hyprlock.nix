{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 10;
        hide_cursor = true;
        no_fade_in = false;
      };

      label = {
        text = "$TIME";
        font_size = 96;
        font_family = "JetBrains Mono";
        color = "rgba(cdd6f4ff)";
        position = "0, 600";
        halign = "center";
        walign = "center";

        shadow_passes = 1;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          font_color = "rgba(cdd6f4ff)";
          inner_color = "rgba(1e1e2eff)";
          outer_color = "rgba(313244ff)";
          outline_thickness = 5;
          placeholder_text = "...";
          shadow_passes = 1;
        }
      ];
    };
  };
}