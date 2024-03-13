{ pkgs, ... }:
{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      defaultSession = "none+i3";
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
      ];
    };
    # Configure keymap in X11
    xkb.layout = "us";
    xkb.options = "caps:escape";
  };


  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Mount, trash, and other functionalities
  services.gvfs.enable = true;
  # Thumbnail support for images
  services.tumbler.enable = true;
}
