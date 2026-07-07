let
  pkgs = import <nixpkgs> { config.allowUnfree = true; };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    cudaPackages.cudatoolkit
  ];
  CUDA_PATH = pkgs.cudaPackages.cudatoolkit;
}
