{ config, pkgs, ... }:
{
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
