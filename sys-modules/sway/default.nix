{ ... }:
{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    # The proprietary NVIDIA driver is not officially supported by wlroots;
    # sway refuses to start on it without this flag.
    extraOptions = [ "--unsupported-gpu" ];
    extraSessionCommands = ''
      # Make Electron/Chromium apps (chrome, discord, vscode) run natively
      # on Wayland instead of through XWayland.
      export NIXOS_OZONE_WL=1
    '';
  };

  # Screen sharing / screenshots through xdg-desktop-portal on wlroots.
  xdg.portal.wlr.enable = true;

  # swaylock needs a PAM service to verify the password.
  security.pam.services.swaylock = { };
}
