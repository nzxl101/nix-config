{ config, lib, ... }: {
  options.hardware.battery-tweaks.enable = lib.mkEnableOption "Enable Battery tweaks";

  config = lib.mkIf config.hardware.battery-tweaks.enable {
    services.tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        KBD_BACKLIGHT_TIMEOUT_AC = 0;
        KBD_BACKLIGHT_TIMEOUT_BAT = 0;
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;
      };
    };
    powerManagement.enable = true;
    powerManagement.cpuFreqGovernor = "schedutil";
    powerManagement.powertop.enable = true;
    services.power-profiles-daemon.enable = false;
    services.thermald.enable = true;
    services.auto-cpufreq.enable = false;
  };
}