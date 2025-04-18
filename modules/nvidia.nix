{ config, pkgs, lib, primaryUser, ... }: {
    options.hardware.nvidia.enable = lib.mkEnableOption "Enable Nvidia drivers";

    config = lib.mkIf config.hardware.nvidia.enable {
        services.xserver.videoDrivers = [ "nvidia"];

        hardware.nvidia.modesetting.enable = true;
        hardware.nvidia.powerManagement.enable = true;
        hardware.opengl = {
          enable = true;
          driSupport = true;
          driSupport32Bit = true;
        };

        users.users.${primaryUser}.extraGroups = [ "video" ];

        environment.sessionVariables = {
          GBM_BACKEND = "nvidia-drm";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          NIXOS_OZONE_WL = "1";
        };
    };
}