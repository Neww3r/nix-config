{ pkgs, user, ... }:
{
  imports = [
    ../../home-modules/vim
    ../../home-modules/sway
    ../../home-modules/waybar
    ../../home-modules/alacritty
    ../../home-modules/bash
    ../../home-modules/rofi
    ../../home-modules/gtk
    ../../home-modules/vscode
    ../../home-modules/wallpapers
  ];

  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [

    # Media
    vlc

    # Web
    google-chrome

    # Tools
    claude-code
    uv
    wget
    tree
    unzip
    pavucontrol

    # Communication
    discord

  ];
}
