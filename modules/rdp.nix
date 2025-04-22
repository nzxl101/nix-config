{ config, lib, ... }: {
  options.services.rdp.enable = lib.mkEnableOption "Enable RDP via Sunshine";

  config = lib.mkIf config.services.rdp.enable {
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
  };
}