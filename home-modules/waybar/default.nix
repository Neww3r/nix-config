{ pkgs, ... }:
{
  # Tray applets: clicking their icons drops a menu down from the bar
  # (wifi picker, bluetooth devices) instead of opening a full window.
  # Both are systemd user services tied to the graphical session.
  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;

  # Workspaces + window title on the left; wifi, bluetooth, volume, disk,
  # battery, clock on the right.
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 32;

        modules-left = [ "sway/workspaces" "sway/window" ];
        modules-right = [ "network" "bluetooth" "pulseaudio" "disk" "battery" "tray" "clock" ];

        "sway/window" = {
          max-length = 60;
        };

        # Icons are Nerd Font glyphs (nerd-fonts.jetbrains-mono).
        network = {
          interval = 5;
          format-wifi = "{icon} {essid}";
          format-ethernet = "󰈀 {ifname} {ipaddr}";
          format-disconnected = "󰤮 disconnected";
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          tooltip-format-wifi = "{essid} ({signalStrength}%) {ipaddr}";
        };

        bluetooth = {
          format = "󰂯";
          format-off = "󰂲";
          format-disabled = "󰂲";
          format-connected = "󰂱 {device_alias}";
          tooltip-format = "{controller_alias} {status}";
          tooltip-format-connected = "{device_alias} {device_address}";
          # Radio starts powered off (powerOnBoot = false); right-click toggles it.
          on-click-right = "${pkgs.bluez}/bin/bluetoothctl show | grep -q 'Powered: yes' && ${pkgs.bluez}/bin/bluetoothctl power off || ${pkgs.bluez}/bin/bluetoothctl power on";
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
