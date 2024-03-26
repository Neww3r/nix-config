{ pkgs, lib, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        pkgs.alacritty-theme.gruvbox_material_medium_dark
      ];

      window = {
        opacity = lib.mkForce 0.85;
      };
    };
  };
}
