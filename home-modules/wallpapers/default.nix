{ ... }:
{
  # Both sessions reference these paths: feh/i3lock (X11) and
  # swaybg/swaylock (Wayland).
  home.file = {
    "Pictures/wallpapers/wallpaper.png".source = ./wallpaper.png;
    "Pictures/wallpapers/lockscreen.png".source = ./lockscreen.png;
  };
}
