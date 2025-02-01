with import <nixpkgs> { };
stdenv.mkDerivation {
  name = "c-dev-environment";
  buildInputs = [
    pkg-config
    clang
    SDL2
    SDL2_image
    SDL2_ttf
    openssl
    curl
    criterion
  ];
  hardeningDisable = [ "fortify" ]; # Disable `_FORTIFY_SOURCE`
}
