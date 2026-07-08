{ ... }:
{
  # TLP applies power-saving defaults (USB autosuspend, PCIe ASPM, audio
  # codec PM, Wi-Fi powersave on battery, ...) and switches them between
  # AC and battery. Only non-default settings are listed below.
  services.tlp = {
    enable = true;
    settings = {
      # ACPI platform profiles this machine's firmware exposes:
      # quiet / balanced / performance.
      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "quiet";

      # CPU turbo boost is the single biggest power draw on this Zen+ CPU;
      # keep it for AC, drop it on battery.
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      # TLP disables PCIe runtime PM on AC by default, which would keep the
      # GTX 1650 powered even when idle; "auto" lets the NVIDIA fine-grained
      # power management turn it off on AC too.
      RUNTIME_PM_ON_AC = "auto";

      # Stop charging at 80% to slow battery wear (the firmware supports
      # charge_control_end_threshold). Uncomment to enable.
      # STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };
}
