{ inputs, ... }:
{
  nixpkgs.overlays = [
    # Track these fast-moving packages from nixpkgs-unstable instead of the
    # pinned stable branch. `nix flake update` pulls newest.
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
}
