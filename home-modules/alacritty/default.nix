{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [
        pkgs.alacritty-theme.gruvbox_dark
      ];
      font.size = 10;
      window.opacity = 1.00;
    };
  };
}
