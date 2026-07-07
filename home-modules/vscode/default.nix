{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      # Add extensions here, e.g.:
      # ms-python.python
      # jnoortheen.nix-ide
    ];
  };
}
