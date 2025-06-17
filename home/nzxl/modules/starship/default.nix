{ pkgs, hostName, ... }: {
  programs.starship = with pkgs; {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;

      format = "[╭](fg:current_line)$os$directory$git_branch$fill$cmd_duration$shell$time$username$line_break$character";

      palettes.simple = {
        foreground = "#F8F8F2";
        background = "#282A36";
        current_line = "#44475A";
        primary = "#1E1F29";
        box = "#44475A";
        red = "#FF5555";
        pink = "#FF79C6";
        green = "#50FA7B";
        orange = "#FFB86C";
        blue = "#6272A4";
        purple = "#BD93F9";
        yellow = "#F1FA8C";
      };

      palette = "simple";

      os = {
        format = "(fg:current_line)[](fg:red)[ $symbol ${hostName} ](fg:primary bg:red)[](fg:red)";
        disabled = false;
        symbols = {
          NixOS = "";
          Linux = "";
          Macos = "";
          Windows = "win";
          Unknown = "";
        };
      };

      directory = {
        format = "[─](fg:current_line)[](fg:pink)[ path ](fg:primary bg:pink)[](fg:pink bg:box)[ $read_only$truncation_symbol$path ](fg:foreground bg:box)[](fg:box)";
        home_symbol = "~/";
        truncation_length = 2;
        read_only_style = "";
      };

      git_branch = {
        format = "[─](fg:current_line)[](fg:green)[$symbol](fg:primary bg:green)[](fg:green bg:box)[ $branch](fg:foreground bg:box)[](fg:box)";
        symbol = "  ";
      };

      fill = {
        symbol = "─";
        style = "fg:current_line";
      };

      cmd_duration = {
        min_time = 500;
        format = "[─](fg:current_line)[](fg:orange)[  ](fg:primary bg:orange)[](fg:orange bg:box)[ $duration ](fg:foreground bg:box)[](fg:box)";
      };

      shell = {
        format = "[─](fg:current_line)[](fg:blue)[   ](fg:primary bg:blue)[](fg:blue bg:box)[ $indicator](fg:foreground bg:box)[](fg:box)";
        unknown_indicator = "shell";
        powershell_indicator = "powershell";
        fish_indicator = "fish";
        disabled = false;
      };

      time = {
        format = "[─](fg:current_line)[](fg:purple)[ 󰦖 ](fg:primary bg:purple)[](fg:purple bg:box)[ $time](fg:foreground bg:box)[](fg:box)";
        time_format = "%H:%M";
        disabled = false;
      };

      username = {
        format = "[─](fg:current_line)[](fg:yellow)[  ](fg:primary bg:yellow)[](fg:yellow bg:box)[ $user](fg:foreground bg:box)[](fg:box) ";
        show_always = true;
      };

      character = {
        format = ''
          [╰─$symbol](fg:current_line) '';
        success_symbol = "[>](fg:bold white)";
        error_symbol = "[×](fg:bold red)";
      };
    };
  };
}