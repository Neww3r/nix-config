{ config, pkgs, inputs, ... }:

{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = "./launcher.rasi";
    plugins = [
      pkgs.rofi-emoji
      pkgs.rofi-calc
      pkgs.rofi-power-menu
    ];
  };
}
