{ config, pkgs, inputs, ... }:

{
  programs.rofi = {
    enable = true;
    theme = "slate";
    plugins = [
      pkgs.rofi-emoji
      pkgs.rofi-calc
      pkgs.rofi-power-menu
    ];

    extraConfig = {
      modi = "drun,filebrowser,window";
      show-icons = true;
      sort = true;
      matching = "fuzzy";
    };
  };
}
