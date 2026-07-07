{ pkgs, ... }:

let
  user = "erwan";
in
{
  imports =
    [
      ./hardware-configuration.nix
      ./nvidia.nix
      ../../sys-modules/desktop
      # Both sessions coexist; comment one out to drop it entirely.
      ../../sys-modules/i3
      ../../sys-modules/sway
    ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
  };

  networking.hostName = "asus-laptop";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  users.users.${user} = {
    isNormalUser = true;
    description = "Le R";
    extraGroups = [ "docker" "networkmanager" "wheel" "video" "audio" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
    google-chrome
    git
    autorandr
    alsa-utils
    openvpn
    brightnessctl
    playerctl
    wireplumber
  ];

  # Let users in the "video" group control screen backlight (media keys).
  services.udev.packages = [ pkgs.brightnessctl ];

  virtualisation.docker.enable = true;

  system.stateVersion = "24.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
