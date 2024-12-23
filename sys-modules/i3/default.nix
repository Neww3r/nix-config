{ pkgs, ... }:
{
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  services.displayManager.defaultSession = "none+i3";

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

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
