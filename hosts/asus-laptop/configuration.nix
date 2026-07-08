{ pkgs, user, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./nvidia.nix
      ../../sys-modules/desktop
      ../../sys-modules/power
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
    shell = pkgs.zsh;
  };
  # Login shell; needed system-side so zsh lands in /etc/shells and gets the
  # Nix environment. Per-user config lives in home-modules/zsh.
  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
    git
    openvpn
  ];

  virtualisation.docker.enable = true;

  # Run prebuilt dynamically-linked binaries (uv-managed Pythons, manylinux
  # wheels, downloaded tools) without patching them.
  programs.nix-ld.enable = true;

  system.stateVersion = "24.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Keep the store from slowly filling the disk: weekly GC of generations
  # older than a month, and hard-link identical store files.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.settings.auto-optimise-store = true;
}
