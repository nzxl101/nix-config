{ lib, config, pkgs, ... }:
let
  diskName = "/dev/disk/by-id/nvme-KIOXIA-EXCERIA_G2_SSD_Y3RB704BK77S";
in
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = diskName;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            swap = {
              size = "8G";
              content = {
                type = "swap";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "/rootfs" = {
                    mountpoint = "/";
                  };
                  "/home" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/home";
                  };
                  "/nix" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/nix";
                  };
                  "/var/log" = {
                    mountpoint = "/var/log";
                  };
                };
              };
              mountpoint = "/partition-root";
            };
          };
        };
      };
    };
  };
}