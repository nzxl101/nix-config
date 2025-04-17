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
                type = "filesystem";
                format = "btrfs";
                mountpoint = "/";
                subvolumes = {
                  "/home" = {
                    mountpoint = "/home";
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "/var/log" = {
                    mountpoint = "/var/log";
                  };
                };
                mountOptions = [ "compress=zstd" "noatime" ];
              };
            };
          };
        };
      };
    };
  };
}