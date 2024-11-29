with import <nixpkgs> { };
stdenv.mkDerivation {
  name = "c-dev-environment";
  buildInputs = [
    pkg-config
    SDL2
    SDL2_image
    SDL2_ttf
    openssl
    curl
    criterion
  ];
}