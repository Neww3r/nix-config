{ pkgs, ... }:
{
  # picom is started from the i3 startup list below rather than as a systemd
  # user service: the service would also be pulled into the sway (Wayland)
  # session, where picom cannot run.
  # X11 clipboard tool (wl-clipboard is its counterpart in the sway module).
  home.packages = with pkgs; [ xclip ];

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
          command = "${pkgs.polybar}/bin/polybar jmetapedesbarres &";
          always = false;
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
        bindsym Mod4+l exec --no-startup-id ${pkgs.i3lock}/bin/i3lock -i ~/Pictures/wallpapers/lockscreen.png
        bindsym Mod4+p exec --no-startup-id ${pkgs.maim}/bin/maim -s | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png

        # Audio (PipeWire via wireplumber)
        bindsym XF86AudioRaiseVolume exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
        bindsym XF86AudioLowerVolume exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        bindsym XF86AudioMute exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        bindsym XF86AudioMicMute exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

        # Media playback
        bindsym XF86AudioPlay exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause
        bindsym XF86AudioNext exec --no-startup-id ${pkgs.playerctl}/bin/playerctl next
        bindsym XF86AudioPrev exec --no-startup-id ${pkgs.playerctl}/bin/playerctl previous

        # Backlight brightness
        bindsym XF86MonBrightnessUp exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl set 5%+
        bindsym XF86MonBrightnessDown exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl set 5%-
        client.focused            ${focused}
        client.focused_inactive   ${focused_inactive}
        client.unfocused          ${unfocused}
        client.urgent             ${urgent}
      '';
  };
}
