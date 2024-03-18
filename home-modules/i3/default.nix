{ ... }:
{
  services.picom.enable = true;

  xsession.windowManager.i3 = {
    enable = true;
    extraConfig = builtins.readFile ./config;
  };
}
