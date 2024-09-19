{ config, pkgs, ... }:
let
  importModules = modules: (map (path: ../../home-modules/${path}) modules);
in
{
  imports = importModules [
    "vim"
    "i3"
    "alacritty"
    "bash"
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "erwan";
  home.homeDirectory = "/home/erwan";
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [

    # Files
    cinnamon.pix
    feh
    vlc
    libreoffice

    # Tools
    wget
    xsel
    tree
    unzip
    nodejs
    maim
    xclip
    transmission_4-gtk
    pavucontrol

    # Communication
    discord
    zoom-us

    # Terminal
    alacritty
    xterm

    # VPN
    openvpn
    openresolv

    # Python Programming
    python312
    python312Packages.pip
    python312Packages.virtualenv
    jetbrains.pycharm-professional
    python312Packages.autopep8

    # C Programming
    gcc
    gdb
    gnumake
    valgrind
    criterion

    # Rust Programming
    rustc
    cargo

    # Java Programming
    jdk
    javacc
  ];
}
