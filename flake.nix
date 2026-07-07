{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    # Fresh branch used only to keep a few fast-moving packages up to date.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      asus-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # overlays
          ({ config, pkgs, ... }: {
            nixpkgs.overlays = [
              inputs.alacritty-theme.overlays.default
              # Track these fast-moving packages from nixpkgs-unstable instead
              # of the pinned stable branch. `nix flake update` pulls newest.
              (final: prev:
                let
                  unstable = import inputs.nixpkgs-unstable {
                    system = prev.stdenv.hostPlatform.system;
                    config.allowUnfree = true;
                  };
                in
                {
                  inherit (unstable) google-chrome claude-code;
                })
            ];
          })
          ./hosts/asus-laptop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.erwan = import ./users/erwan/home.nix;
          }
        ];
      };
    };
  };
}
