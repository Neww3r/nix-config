let
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell {
  buildInputs = with pkgs;[
    portaudio
  ];
  LD_LIBRARY_PATH =
    "${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.lib.makeLibraryPath [ pkgs.portaudio ]}";
  shellHook = ''
    . ~/.virtualenvs/masi-py3/bin/activate
    python -m jupyter notebook
  '';
}
