{ pkgs, ... }:
{ 
  programs.git = {
    enable = true;
    userEmail = "wonepng@gmail.com";
    userName = "w1png";
    aliases = {
      undo = "reset --soft HEAD~1";
    };
    extraConfig = {
      credential = {
        helper = "store";
      };
    };
  }; 
}
