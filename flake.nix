{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    # Fresh branch used only to keep a few fast-moving packages up to date.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
    let
      # Single source of truth for the username; passed to both the NixOS
      # modules (specialArgs) and the home-manager modules (extraSpecialArgs).
      user = "erwan";
    in
    {
      nixosConfigurations = {
        asus-laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs user; };
          modules = [
            ./overlays
            ./hosts/asus-laptop/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { inherit user; };
              home-manager.users.${user}.imports = [
                ./users/erwan/home.nix
                # Host-specific home settings (monitor modes, ...).
                ./hosts/asus-laptop/home.nix
              ];
            }
          ];
        };
      };
    };
}
