let
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell {
  LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
  shellHook = ''
    . ~/.virtualenvs/masi-py3/bin/activate
    python -m jupyter notebook
  '';
}
