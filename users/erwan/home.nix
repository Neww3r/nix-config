{ pkgs, ... }:
let
  importModules = modules: (map (path: ../../home-modules/${path}) modules);
in
{
  imports = importModules [
    "vim"
    "i3"
    "alacritty"
    "bash"
    "polybar"
    "rofi"
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
    pavucontrol

    # Communication
    discord

    # Terminal
    alacritty
    xterm

    # VPN
    openvpn
    openresolv

    # IDE & code editor
    vscode
    jetbrains.pycharm-professional
    jetbrains.idea-ultimate
    jetbrains.webstorm

    # Python Programming
    python312
    python312Packages.pip
    python312Packages.virtualenv
    python312Packages.autopep8

    # C Programming
    gcc
    gdb
    gnumake
    bear
    valgrind
    meson
    ninja

    # Rust Programming
    rustc
    cargo

    # Java Programming
    jdk
    javacc
  ];
}
