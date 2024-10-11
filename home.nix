{ pkgs, ... }:

{
  imports = [ 
    ./tmux.nix
    ./git.nix
  ];
  home.stateVersion = "23.05";
  home.packages = [];

  home.file = {
    ".config/wezterm/wezterm.lua".source = ./config/wezterm/wezterm.lua;
    ".config/nvim".source = ./config/nvim;
    ".config/aerospace".source = ./config/aerospace;
    ".zshrc".source = ./config/zsh/zshrc;
  };

  # If needed: source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = {};
  programs.home-manager.enable = true;
}
