{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set-option -g @plugin 'tmux-plugins/tmux-resurrect'
      set-option -g status-left ""
      set-option -g status-right ""
      set-option -g status-left-length 100
      set-option -g status-left "  "  # 2 spaces padding on the left
    '';
  };
}