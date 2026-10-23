# https://github.com/tinted-theming/base24/blob/main/styling.md
{ inputs, ... }:
let
  # https://github.com/tinted-theming/schemes/tree/spec-0.11/base24

  # theme = "dracula";
  themeFile = "${inputs.black-metal}/black-metal-dark-funeral.yaml";

  theme = null;
  # themeFile = null;
in
{
  perSystem = { pkgs, ... }: {
    _module.args.basenix = inputs.basenix.lib.mkLib { inherit theme themeFile pkgs; };
  };

  flake.nixosModules.system = { pkgs, ... }: {
    _module.args.basenix = inputs.basenix.lib.mkLib { inherit theme themeFile pkgs; };
  };

  flake.homeModules.kybe =
    { pkgs, inputs', ... }:
    {
      _module.args.basenix = inputs.basenix.lib.mkLib { inherit theme themeFile pkgs; };
      home.packages = [ inputs'.basenix.packages.default ];
    };
}
