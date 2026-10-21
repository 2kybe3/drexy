{
  flake.nixosModules.system = { pkgs, ... }: {
    hardware.bluetooth.enable = true;
  };
}
