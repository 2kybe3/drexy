{ lib, ... }:
let
  kylib = import ../../kylib/default.nix { inherit lib; };
in
{
  _module.args = { inherit kylib; };

  perSystem._module.args = { inherit kylib; };

  flake.nixosModules.system._module.args = {
    inherit kylib;
  };

  flake.homeModules.kybe._module.args = {
    inherit kylib;
  };
}
