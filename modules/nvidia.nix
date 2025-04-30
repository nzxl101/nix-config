{ config, pkgs, lib, user, ... }: {
    options.hardware.nvidia.enable = lib.mkEnableOption "Enable Nvidia drivers";

    config = lib.mkIf config.hardware.nvidia.enable {
        services.xserver.videoDrivers = [ "nvidia" ];

        hardware.nvidia = {
          open = false;
          modesetting.enable = true;
          powerManagement.enable = true;
          powerManagement.finegrained = true;
          nvidiaSettings = true;
          dynamicBoost.enable = true;
          package = config.boot.kernelPackages.nvidiaPackages.production;
        };
        hardware.graphics.enable = true;
        hardware.graphics.enable32Bit = true;

        users.users.${user}.extraGroups = [ "video" ];
    };
}
