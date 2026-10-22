# https://github.com/tinted-theming/base24/blob/main/styling.md
{ inputs, ... }:
let
  # https://github.com/tinted-theming/schemes/tree/spec-0.11/base24
  theme = "gruvbox-dark";
in
{
  perSystem = { pkgs, ... }: {
    _module.args.basenix = inputs.basenix.lib.mkLib { inherit theme pkgs; };
  };

  flake.nixosModules.system = { pkgs, ... }: {
    _module.args.basenix = inputs.basenix.lib.mkLib { inherit theme pkgs; };
  };

  flake.homeModules.kybe =
    { pkgs, ... }:
    let
      basenix = inputs.basenix.lib.mkLib { inherit theme pkgs; };
    in
    {
      _module.args.basenix = basenix;
      home.packages = [ basenix ];
    };
}
