{ config, pkgs, inputs, ... }:

{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = "./launcher.rasi";
  };

  home.file = {
    ".config/rofi/gruvbox.rasi".source = ./gruvbox.rasi;
    ".config/rofi/fonts.rasi".source = ./fonts.rasi;
    ".config/rofi/launcher.rasi".source = ./launcher.rasi;
  };
}
