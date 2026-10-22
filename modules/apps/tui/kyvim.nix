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
          inherit pkgs;
          theme = {
            name = "kybe";
            theme = basenix.vimTheme "kybe";
          };
        }).wrapped;
    in
    {
      home = {
        packages = [ kyvim ];
        sessionVariables.EDITOR = "${lib.getExe kyvim}";
      };
    };
}
