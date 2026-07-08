{ ... }:
{
  # Tray applets: their icons show wifi/bluetooth status and clicking them
  # drops a menu down from the bar (wifi picker, bluetooth devices).
  # Both are systemd user services tied to the graphical session.
  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;

  # Workspaces + window title on the left; network name, volume, disk,
  # battery, tray (wifi/bluetooth applets), clock on the right.
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 32;

        modules-left = [ "sway/workspaces" "sway/window" ];
        modules-right = [ "network" "pulseaudio" "disk" "battery" "tray" "clock" ];

        "sway/window" = {
          max-length = 60;
        };

        # Icons are Nerd Font glyphs (nerd-fonts.jetbrains-mono).
        # Read-only indicator; the menu lives in the nm-applet tray icon.
        network = {
          interval = 5;
          format-wifi = "{icon} {essid}";
          format-ethernet = "󰈀 {ifname} {ipaddr}";
          format-disconnected = "󰤮 disconnected";
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          tooltip-format-wifi = "{essid} ({signalStrength}%) {ipaddr}";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 muted";
          format-icons = {
            headphone = "󰋋";
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
        };

        disk = {
          interval = 25;
          path = "/";
          format = "󰋊 {percentage_used}%";
        };

        # Battery and adapter are auto-detected; no need to name BAT0/AC0.
        battery = {
          states = {
            warning = 30;
            critical = 5;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-icons = [ "󰁺" "󰁻" "󰁽" "󰁿" "󰂁" "󰁹" ];
        };

        tray = {
          spacing = 8;
        };

        clock = {
          format = "󰥔 {:%H:%M}";
          tooltip-format = "{:%Y-%m-%d %H:%M:%S}";
        };
      }
    ];
    style = builtins.readFile ./style.css;
  };
}
