{ self, inputs, ... }:
{
  imports = [
    inputs.disko.flakeModules.default
  ];

  flake.nixosModules.system = { lib, inputs', ... }: {
    imports = [
      inputs.disko.nixosModules.default
    ];

    fileSystems."/persistent".neededForBoot = true;
    disko.devices = lib.recursiveUpdate self.diskoConfigurations.drexy.disko.devices self.diskoConfigurations.drexy-secondary.disko.devices;
    environment.systemPackages = [ inputs'.disko.packages.default ];
  };

  perSystem = { pkgs, inputs', ... }: {
    devShells.bootstrap = pkgs.mkShell {
      packages = [
        inputs'.disko.packages.default
      ];
    };
  };

  flake.diskoConfigurations = {
    drexy.disko.devices.disk.drexy = {
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
              content =
                let
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                in
                {
                  type = "btrfs";
                  extraArgs = [ "-f" ];

                  mountpoint = "/roots";
                  inherit mountOptions;

                  subvolumes = {
                    "@" = {
                      mountpoint = "/";
                      inherit mountOptions;
                    };
                    "@home" = {
                      mountpoint = "/home";
                      inherit mountOptions;
                    };
                    "@nix" = {
                      mountpoint = "/nix";
                      inherit mountOptions;
                    };
                    "@persistent" = {
                      mountpoint = "/persistent";
                      inherit mountOptions;
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
    drexy-secondary.disko.devices.disk.drexy-secondary = {
      type = "disk";
      device = "/dev/disk/by-id/usb-Micron_CT1000X9SSD9_2517EA9013D4-0:0";
      content = {
        type = "gpt";
        partitions.luks = {
          size = "100%";
          content = {
            type = "luks";
            name = "secondary-crypted";
            settings.allowDiscards = true;
            content = {
              type = "btrfs";
              mountpoint = "/mnt/secondary";
              mountOptions = [
                "compress=zstd"
                "noatime"
                "nofail"
              ];
            };
          };
        };
      };
    };
  };
}
