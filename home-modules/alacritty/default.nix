{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [
        pkgs.alacritty-theme.gruvbox_material_medium_dark
      ];
      font.size = 21;
      window.opacity = 0.85;
    };
  };
}
