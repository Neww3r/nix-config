{ pkgs, ... }:
{
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  # X11 monitor profile switcher; i3 runs `autorandr --change` at startup.
  environment.systemPackages = [ pkgs.autorandr ];

  services.xserver = {
    enable = true;

    desktopManager.xterm.enable = false;

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3lock
      ];
    };
    # Configure keymap in X11
    xkb.layout = "us";
    xkb.options = "caps:escape";
  };
}
