{ pkgs, ... }:
{
  # Bluetooth tray applet: its icon shows the status and clicking it drops
  # a menu down from the bar (devices, pairing, power). Runs as a systemd
  # user service tied to the graphical session. Network gets no applet —
  # the network module below opens a rofi menu instead, so the bar keeps a
  # single wifi icon.
  services.blueman-applet.enable = true;

  # Wifi picker for the network module's on-click, rendered by rofi in
  # dmenu mode (inherits the gruvbox launcher theme).
  xdg.configFile."networkmanager-dmenu/config.ini".text = ''
    [dmenu]
    dmenu_command = ${pkgs.rofi}/bin/rofi -dmenu -i
  '';

  # Workspaces + window title on the left; network name, volume, disk,
  # battery, tray (bluetooth applet), clock on the right.
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
        network = {
          interval = 5;
          format-wifi = "{icon} {essid}";
          format-ethernet = "󰈀 {ifname} {ipaddr}";
          format-disconnected = "󰤮 disconnected";
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          tooltip-format-wifi = "{essid} ({signalStrength}%) {ipaddr}";
          on-click = "${pkgs.networkmanager_dmenu}/bin/networkmanager_dmenu";
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
