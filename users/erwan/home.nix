{ config, pkgs, ... }:
let
  importModules = modules: (map (path: ../../home-modules/${path}) modules);
in
{
  imports = importModules [
    "vim"
    # X11 session
    "i3"
    "polybar"
    # Wayland session
    "sway"
    "waybar"
    # Shared
    "alacritty"
    "bash"
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
    vlc

    # Tools
    claude-code
    wget
    tree
    unzip
    xclip
    pavucontrol

    # Communication
    discord

  ];

  # VS Code with declarative config
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      # Add extensions here, e.g.:
      # ms-python.python
      # jnoortheen.nix-ide
    ];
  };

  # GTK theming
  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-mauve-standard";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = [ "mauve" ];
      };
    };
    # Apply the same theme to GTK4 apps (silences the 26.05 default-change warning).
    gtk4.theme = config.gtk.theme;
  };
}
