{ config, ... }:

{
  # Enable OpenGL
  hardware.graphics.enable = true;

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Only works on modern Nvidia GPUs (Turing or newer); the GTX 1650 is
    # Turing, and PRIME offload mode (required) is enabled below.
    powerManagement.finegrained = true;

    # The NVIDIA open kernel module is still alpha-quality on Turing, so the
    # proprietary module remains the recommended setting.
    open = false;

    # Enable the `nvidia-settings` menu.
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.nvidia.prime = {
    # Render on the AMD iGPU by default; apps opt into the dGPU with the
    # PRIME offload env vars (or the `nvidia-offload <cmd>` wrapper).
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };

    # Bus ID values for this machine, from `sudo lshw -c display`.
    nvidiaBusId = "PCI:1:0:0";
    amdgpuBusId = "PCI:5:0:0";
  };
}
