{ config, pkgs, ... }:
let
  importModules = modules: (map (path: ../../home-modules/${path}) modules);
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "erwan";
  home.homeDirectory = "/home/erwan";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [

    # Files
    xfce.thunar
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

    # Communication
    discord
    zoom-us

    # Terminal
    alacritty
    xterm

    #Fonts
    powerline-fonts

    # NixOS autocompletion
    nil
    nixpkgs-fmt

    # VPN
    openvpn
    openresolv

    # Python Programming
    python311
    python311Packages.pip
    python311Packages.virtualenv
    python311Packages.autopep8

    # C Programming
    gcc
    gdb
    gnumake
    valgrind
    clang-tools_16
    criterion

    # Rust Programming
    rustc
    cargo
    rust-analyzer

    # Java Programming
    eclipses.eclipse-java
    jetbrains.idea-ultimate
    javacc
  ];
}
