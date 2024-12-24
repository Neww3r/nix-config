{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
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
            nixpkgs.overlays = [ inputs.alacritty-theme.overlays.default ];
          })
          ./hosts/asus-laptop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.erwan = import ./users/erwan/home.nix;
          }
        ];
      };
    };
  };
}
