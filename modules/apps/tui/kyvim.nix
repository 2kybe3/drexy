{
  flake.homeModules.kybe =
    {
      lib,
      inputs',
      ...
    }:
    let
      kyvim = inputs'.kyvim.packages.default;
    in
    {
      home = {
        packages = [ kyvim ];
        sessionVariables.EDITOR = "${lib.getExe kyvim}";
      };
    };
}
