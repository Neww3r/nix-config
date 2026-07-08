{ ... }:
{
  programs.bash = {
    enable = true;
    bashrcExtra = (builtins.readFile ./bashrc);
  };

  home.sessionPath = [ "$HOME/.local/bin" ];
}
