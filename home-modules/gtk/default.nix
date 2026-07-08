{ config, pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };
    # Apply the same theme to GTK4 apps (silences the 26.05 default-change warning).
    gtk4.theme = config.gtk.theme;
  };
}
