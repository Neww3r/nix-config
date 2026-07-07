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
  };
}
