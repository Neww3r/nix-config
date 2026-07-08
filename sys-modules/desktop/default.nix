{ pkgs, ... }:
{
  # SDDM can launch both X11 and Wayland sessions; every enabled session
  # shows up in the greeter's picker, so adding one never requires more
  # than a rebuild.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Session picked when none was chosen before.
  services.displayManager.defaultSession = "sway";

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  services.blueman.enable = true;

  # Audio/media/backlight CLI tools; the WM keybindings call them by store
  # path, this only puts them on the interactive PATH.
  environment.systemPackages = with pkgs; [
    alsa-utils
    playerctl
    wireplumber
    brightnessctl
  ];

  # Let users in the "video" group control screen backlight (media keys).
  services.udev.packages = [ pkgs.brightnessctl ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    font-awesome
  ];

  # File explorer
  programs.thunar.enable = true;
}
