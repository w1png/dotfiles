{ ... }:
{ 
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    shortcut = "space";
    baseIndex = 1;
    keyMode = "vi";
    extraConfig = "
      set-option -ga terminal-overrides \",xterm-256color:Tc\"
      set-option -g detach-on-destroy off
      set-option -g renumber-windows on
      set-option -g status-position top

      bind -n c-t new-window
      bind N command-prompt -p \"New Session:\" \"new-session -A -s '%%'\"
      bind M attach-session -c \"#{pane_current_path}\"
      set -g mouse on 
    ";
  }; 
}
