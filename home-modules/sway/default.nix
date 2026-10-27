{ lib, pkgs, ... }:
let
  lock = "${pkgs.swaylock}/bin/swaylock -i ~/Pictures/wallpapers/lockscreen.png";
  # Toggle a screen recording: select a region and start, press again to stop
  # (SIGINT lets wf-recorder finalize the file).
  record = pkgs.writeShellScript "record-toggle" ''
    if ${pkgs.procps}/bin/pgrep -x wf-recorder >/dev/null; then
      ${pkgs.procps}/bin/pkill -INT -x wf-recorder
    else
      mkdir -p ~/Videos
      exec ${pkgs.wf-recorder}/bin/wf-recorder -g "$(${pkgs.slurp}/bin/slurp)" \
        -f ~/Videos/recording-$(date +%F-%H%M%S).mp4
    fi
  '';
in
{
  home.packages = with pkgs; [
    swaylock
    grim # screenshot grabber
    slurp # region selector for grim
    wf-recorder # screen recorder
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
      before-sleep = lock;
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
      # Monitor-specific output modes live in hosts/<host>/home.nix.
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
      ];
      bars = [ ];
      window = {
        titlebar = false;
        hideEdgeBorders = "smart";
      };
      defaultWorkspace = "workspace number 1";
      keybindings = lib.mkOptionDefault {
        "Mod4+l" = "exec ${lock}";
        "Mod4+p" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";
        "Mod4+Shift+p" = "exec ${record}";

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
        # Gruvbox, matching rofi/gruvbox.rasi and waybar/style.css.
        # border | background | text | indicator | child_border
        focused = "#282828d9 #282828d9 #EBDBB2 #282828d9 #282828d9";
        unfocused = "#282828d9 #282828d9 #928374 #282828d9 #282828d9";
        focused_inactive = "#282828d9 #282828d9 #928374 #282828d9 #282828d9";
        urgent = "#FB4934   #FB4934   #282828 #FB4934   #FB4934";
      in
      ''
        client.focused            ${focused}
        client.focused_inactive   ${focused_inactive}
        client.unfocused          ${unfocused}
        client.urgent             ${urgent}
      '';
  };
}
