{ ... }:
{
  services.polybar = {
    enable = true;
    extraConfig = builtins.readFile ./config;
    script = "polybar bar &";
  };
}
