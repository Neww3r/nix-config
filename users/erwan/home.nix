{ pkgs, ... }:
{
  imports = [
    ../../home-modules/vim
    # X11 session
    ../../home-modules/i3
    ../../home-modules/polybar
    # Wayland session
    ../../home-modules/sway
    ../../home-modules/waybar
    # Shared
    ../../home-modules/alacritty
    ../../home-modules/bash
    ../../home-modules/rofi
    ../../home-modules/gtk
    ../../home-modules/vscode
  ];

  home.username = "erwan";
  home.homeDirectory = "/home/erwan";
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
    wget
    tree
    unzip
    pavucontrol

    # Communication
    discord

  ];
}
