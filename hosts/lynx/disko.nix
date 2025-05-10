{ lib, config, pkgs, ... }:
let
  diskName = "/dev/vda";
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
              priority = 1;
              name = "ESP";
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
                    mountpoint = "/home";
                  };
                  "/nix" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/nix";
                  };
                  "/var/log" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/var/log";
                  }
                };

                mountOptions = [ "compress=zstd" "noatime" ];
                mountpoint = "/partition-root";
              };
            };
          };
        };
      };
    };
  };
}