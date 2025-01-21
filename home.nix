{ pkgs, ... }:

{
  imports = [ 
    ./tmux.nix
    ./git.nix
  ];
  home.stateVersion = "24.11";
  home.packages = [];

  home.file = {
    ".config/wezterm/wezterm.lua".source = ./config/wezterm/wezterm.lua;
    ".config/nvim".source = ./config/nvim;
    ".zshrc".source = ./config/zsh/zshrc;
  };

  home.sessionVariables = {};
  programs.home-manager.enable = true;
}
