{ config, lib, pkgs, ... }:

let
  user = "erwan";
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "asus-laptop"; # Define your hostname.
  # Pick only one of the below networking options.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Seoul";


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  services = {
    xserver = {
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
    };
  };


  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  hardware = {
    pulseaudio = {
      enable = true;
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "Erwan";
    extraGroups = [ "audio" "networkmanager" "wheel" ];
    initialPassword = "password";
  };

  fonts.packages = with pkgs; [
    powerline-fonts
    terminus_font
  ];

  programs.thunar.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    firefox
    i3
    git
  ];

  system.stateVersion = "23.11"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

