{
  flake.nixosModules.system =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      nixpkgs.config.allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "nvidia-x11"
          "obsidian"
        ];
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware = {
        graphics = {
          enable = true;
          enable32Bit = true;
        };
        nvidia = {
          open = false;
          nvidiaSettings = true;
          modesetting.enable = true;
          powerManagement.enable = false;
          powerManagement.finegrained = false;
          package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
        };
      };
    };
}
