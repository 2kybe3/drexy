{ inputs, ... }: {
  flake.homeModules.kybe =
    {
      lib,
      pkgs,
      basenix,
      ...
    }:
    let
      kyvim =
        (inputs.kyvim.lib.mkPackage {
          inherit pkgs basenix;
        }).config.build.package;
    in
    {
      home = {
        packages = [ kyvim ];
        shellAliases.n = "${lib.getExe kyvim}";
        sessionVariables.EDITOR = "${lib.getExe kyvim}";
      };
    };
}
