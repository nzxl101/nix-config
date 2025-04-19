{ config, pkgs, lib, primaryUser, ... }: {
    options.hardware.nvidia.enable = lib.mkEnableOption "Enable Nvidia drivers";

    config = lib.mkIf config.hardware.nvidia.enable {
        services.xserver.videoDrivers = [ "nvidia" ];

        hardware.nvidia = {
          open = true;
          modesetting.enable = true;
          powerManagement.enable = true;
          powerManagement.finegrained = true;
          nvidiaSettings = true;
          package = config.boot.kernelPackages.nvidiaPackages.stable;
        };
        hardware.graphics.enable = true;

        users.users.${primaryUser}.extraGroups = [ "video" ];

        environment.sessionVariables = {
          GBM_BACKEND = "nvidia-drm";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          NIXOS_OZONE_WL = "1";
        };
    };
}