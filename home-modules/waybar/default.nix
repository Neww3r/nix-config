{ ... }:
{
  # Wayland bar, mirrors the polybar layout: workspaces + window title on the
  # left; wifi, volume, disk, battery, clock on the right.
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 32;

        modules-left = [ "sway/workspaces" "sway/window" ];
        modules-right = [ "network" "pulseaudio" "disk" "battery" "clock" ];

        "sway/window" = {
          max-length = 60;
        };

        network = {
          interval = 5;
          format-wifi = "  {essid}";
          format-ethernet = "{ifname} {ipaddr}";
          format-disconnected = "{ifname} disconnected";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " muted";
          format-icons = {
            default = [ "🔈" "🔊" ];
          };
        };

        disk = {
          interval = 25;
          path = "/";
          format = " {percentage_used}%";
        };

        battery = {
          bat = "BAT0";
          adapter = "AC0";
          states = {
            warning = 30;
            critical = 5;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-icons = [ "" "" "" "" "" ];
        };

        clock = {
          format = "{:%H:%M}";
          tooltip-format = "{:%Y-%m-%d %H:%M:%S}";
        };
      }
    ];
    style = builtins.readFile ./style.css;
  };
}
