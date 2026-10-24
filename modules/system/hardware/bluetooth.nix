let
  headPhones = "2C:BE:EE:4A:5B:32";
in
{
  flake = {
    homeModules.kybe.home.shellAliases.ears = "bluetoothctl connect ${headPhones}";
    nixosModules.system.hardware.bluetooth.enable = true;
  };
}
