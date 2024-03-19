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
        focused = "#00000000 #212155d9 #FFFFFF #00000000 #00000000";
        unfocused = "#00000000 #00000000 #FFFFFF #00000000 #00000000";
        urgent = "#FF0000   #FF0000   #FF0000 #FF0000   #FF0000";
      in
      ''
        client.focused            ${focused}
        client.unfocused          ${unfocused} 
        client.urgent             ${urgent} 
      '';
  };
}
