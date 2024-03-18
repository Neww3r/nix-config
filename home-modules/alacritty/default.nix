{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        pkgs.alacritty-theme.gruvbox_material_medium_dark
      ];

      window = {
        opactity = 0.85;
      };
    };
  };
}
