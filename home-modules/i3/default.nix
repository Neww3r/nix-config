{ pkgs, ... }:
{
  services.picom.enable = true;
  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      startup = [
        {
          command = "${pkgs.feh}/bin/feh --bg-scale
          ~/Pictures/wallpapers/wallpaper.png";
          always = true;
          notification = false;
        }
        {
          command = "${pkgs.picom}/bin/picom";
          always = true;
          notification = false;
        }
      ];
      bars = [
        {
          statusCommand = "${pkgs.i3status}/bin/i3status";
          position = "top";
        }
      ];
    };
  };
}
