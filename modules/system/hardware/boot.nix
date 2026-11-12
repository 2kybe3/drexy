{
  flake.nixosModules.system = { pkgs, ... }: {
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;

      loader.systemd-boot = {
        enable = true;
        memtest86.enable = true;
      };
    };
  };
}
