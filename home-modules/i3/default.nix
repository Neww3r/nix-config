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
          command = "${pkgs.feh}/bin/feh --bg-fill ~/Pictures/wallpapers/wallpaper.png";
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
    extraConfig =
      let
        # border | background | text | indicator | child_border
        focused = "#282828d9 #282828d9 #FFFFFF #282828d9 #282828d9";
        unfocused = "#282828a9 #282828a9 #FFFFFF #282828a9 #282828a9";
        urgent = "#FF0000   #FF0000   #FF0000 #FF0000   #FF0000";
      in
      ''
        client.focused            ${focused}
        client.unfocused          ${unfocused} 
        client.urgent             ${urgent} 
      '';
  };
}
