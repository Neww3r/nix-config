{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    swaylock
    grim # screenshot grabber
    slurp # region selector for grim
    wl-clipboard # xclip equivalent (wl-copy / wl-paste)
  ];

  # Power off the outputs after 10 minutes idle (a display left on is a
  # constant multi-watt draw), and lock before the system suspends.
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 600;
        command = "${pkgs.sway}/bin/swaymsg 'output * power off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * power on'";
      }
    ];
    events = {
      before-sleep = "${pkgs.swaylock}/bin/swaylock -i ~/Pictures/wallpapers/lockscreen.png";
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    # Use the system-level sway from programs.sway, which carries the
    # --unsupported-gpu flag and session variables.
    package = null;
    checkConfig = false;
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "${pkgs.rofi}/bin/rofi -show";
      output = {
        "HDMI-A-1" = {
          mode = "1920x1080@144Hz";
        };
      };
      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_options = "caps:escape";
        };
        "type:touchpad" = {
          tap = "enabled";
        };
      };
      startup = [
        {
          command = "${pkgs.swaybg}/bin/swaybg -m fill -i ~/Pictures/wallpapers/wallpaper.png";
        }
        {
          command = "${pkgs.waybar}/bin/waybar";
        }
      ];
      bars = [ ];
      window = {
        titlebar = false;
        hideEdgeBorders = "smart";
      };
      defaultWorkspace = "workspace number 1";
      keybindings = lib.mkOptionDefault {
        "Mod4+l" = "exec ${pkgs.swaylock}/bin/swaylock -i ~/Pictures/wallpapers/lockscreen.png";
        "Mod4+p" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";

        # Audio (PipeWire via wireplumber)
        "XF86AudioRaiseVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute" = "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

        # Media playback
        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

        # Backlight brightness
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
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
        client.focused            ${focused}
        client.focused_inactive   ${focused_inactive}
        client.unfocused          ${unfocused}
        client.urgent             ${urgent}
      '';
  };
}
