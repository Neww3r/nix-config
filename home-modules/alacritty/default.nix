{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [
        pkgs.alacritty-theme.gruvbox_material_medium_dark
      ];

      window = {
        opacity = 0.85;
      };
    };
  };
}
