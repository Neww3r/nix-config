{ ... }:
{
  services.polybar.enable = true;
  services.polybar.extraConfig = builtins.readFile ./config;
}
