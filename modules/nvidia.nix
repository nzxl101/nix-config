{ config, lib, user, type, hostname, ... }: {
    options.hardware.nvidia.enable = lib.mkEnableOption "Enable Nvidia drivers";

    config = lib.mkIf config.hardware.nvidia.enable {
        services.xserver.videoDrivers = [ "nvidia" ];

        hardware.nvidia = {
          open = true;
          modesetting.enable = true;
          powerManagement.enable = true;
          powerManagement.finegrained = true;
          nvidiaSettings = true;
          dynamicBoost.enable = true;
          package = config.boot.kernelPackages.nvidiaPackages.production;
          prime = lib.mkMerge [
            (lib.mkIf (type == "laptop") {
              offload = {
                enable = true;
                enableOffloadCmd = true;
              };
              reverseSync.enable = true;
            })
            (lib.mkIf (hostname == "shin") {
              amdgpuBusId = "PCI:4:0:0";
              nvidiaBusId = "PCI:1:0:0";
            })
          ];
        };
        hardware.graphics.enable = true;
        hardware.graphics.enable32Bit = true;

        users.users.${user}.extraGroups = [ "video" ];
    };
}
