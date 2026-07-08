{ ... }:
{
  # Host-specific home-manager settings; imported next to users/*/home.nix
  # in flake.nix. The shared home-modules stay machine-agnostic.

  # External monitor; without an explicit mode sway falls back to 60Hz.
  wayland.windowManager.sway.config.output."HDMI-A-1".mode = "1920x1080@144Hz";
}
