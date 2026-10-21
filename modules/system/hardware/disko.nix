{ self, inputs, ... }:
{
  imports = [
    inputs.disko.flakeModules.default
  ];

  flake.nixosModules.system = { pkgs, ... }: {
    imports = [
      inputs.disko.nixosModules.default
    ];

    disko.devices = self.diskoConfigurations.drexy.disko.devices;
    fileSystems = {
      "/persistent".neededForBoot = true;
      "/nix".neededForBoot = true;
    };
  };

  perSystem = { pkgs, inputs', ... }: {
    devShells.bootstrap = pkgs.mkShell {
      packages = [
        inputs'.disko.packages.default
      ];
    };
  };

  flake.diskoConfigurations.drexy = {
    disko.devices.disk.main = {
      type = "disk";
      device = "/dev/disk/by-id/ata-Crucial_CT525MX300SSD1_1642144EAB93";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "1G";
            type = "EF00";
            priority = 1;
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              settings.allowDiscards = true;
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "@" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "@persistent" = {
                    mountpoint = "/persistent";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "@swap" = {
                    mountpoint = "/.swapvol";
                    swap.swapfile.size = "10G";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
