# nix-config

Flake-based NixOS + [Home Manager](https://github.com/nix-community/home-manager) configuration, running a Wayland-only Sway session.

## Layout

```
flake.nix            Inputs (nixpkgs 26.05, unstable, home-manager) and host definitions
hosts/<host>/        Host-specific config: boot, networking, users, hardware
sys-modules/         System-level (NixOS) modules
  desktop/           SDDM, PipeWire, Bluetooth, fonts, media-key tools
  power/             TLP power management
  sway/              Sway system side: wlroots portal, swaylock PAM
home-modules/        Home Manager modules, one directory per program
  sway/ waybar/ alacritty/ zsh/ bash/ rofi/ gtk/ vim/ vscode/ wallpapers/
overlays/            Packages tracked from nixpkgs-unstable
users/<user>/        Home Manager entry point: module imports and user packages
```

The username is defined once in `flake.nix` and passed to both NixOS and Home
Manager modules via `specialArgs` / `extraSpecialArgs`.

## Usage

Rebuild the system (from the repo root):

```sh
sudo nixos-rebuild switch --flake .#<host>
```

Update all inputs, then rebuild:

```sh
nix flake update
sudo nixos-rebuild switch --flake .#<host>
```

Garbage collection is automatic (weekly, generations older than 30 days) and
the store is deduplicated with `auto-optimise-store`.

## Notes

- **Unstable overlay.** A few fast-moving packages come from
  `nixpkgs-unstable` via `overlays/`; everything else is pinned to the stable
  release.
- **Dev shells live elsewhere.** No per-language shells here — each project
  carries its own flake with a `devShell`.
