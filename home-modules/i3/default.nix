{ pkgs, ... }:
{
  services.picom.enable = true;
  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "${pkgs.rofi}/bin/rofi -show";
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
        {
          command = "systemctl --user restart polybar";
          always = true;
          notification = false;
        }
      ];
      bars = [ ];
      window = {
        titlebar = false;
        hideEdgeBorders = "smart";
      };
      defaultWorkspace = "workspace number 1";
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
        bindsym Mod4+l exec --no-startup-id i3lock -i ~/Pictures/wallpapers/lockscreen.png
        bindsym Ctrl+Shift+p exec --no-startup-id maim | xclip -selection clipboard -t image/png
        client.focused            ${focused}
        client.focused_inactive   ${focused_inactive}
        client.unfocused          ${unfocused} 
        client.urgent             ${urgent} 
      '';
  };
}
