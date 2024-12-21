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
        {
          command = "${pkgs.autorandr}/bin/autorandr --change";
          always = true;
          notification = false;
        }
      ];
      bars = [ ];
      gaps = {
        outer = 4;
        inner = 10;
      };
    };
    extraConfig =
      let
        # border | background | text | indicator | child_border
        focused = "#282828d9 #282828d9 #FFFFFF #282828d9 #282828d9";
        unfocused = "#282828d9 #282828d9 #AAAAAA #282828d9 #282828d9";
        focused_inactive = "#282828d9 #282828d9 #AAAAAA #282828d9 #282828d9";
        urgent = "#FF0000   #FF0000   #FF0000 #FF0000   #FF0000";
      in
      ''
        bindsym Ctrl+Shift+p exec --no-startup-id maim | xclip -selection clipboard -t image/png
        client.focused            ${focused}
        client.focused_inactive   ${focused_inactive}
        client.unfocused          ${unfocused} 
        client.urgent             ${urgent} 
      '';
  };
}
