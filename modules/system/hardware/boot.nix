{
  flake.nixosModules.system = { pkgs, ... }: {
    boot = {
      kernelPackages = pkgs.linuxKernel.packages.linux_testing;

      loader.systemd-boot = {
        enable = true;
        memtest86.enable = true;
      };
    };
  };
}
