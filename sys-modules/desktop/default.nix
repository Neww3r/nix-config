{ pkgs, ... }:
{
  # SDDM can launch both X11 and Wayland sessions (lightdm is X11-only).
  # Every enabled session (sway, i3) shows up in the greeter's session
  # picker, so switching between them never requires a rebuild.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Session picked when none was chosen before. Set back to "none+i3" to make
  # X11/i3 the default again.
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
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  services.blueman.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    font-awesome
  ];

  # File explorer
  programs.thunar.enable = true;
}
