{
  flake.homeModules.kybe =
    {
      lib,
      inputs,
      basenix,
      ...
    }:
    let
      lib = inputs.kyvim.lib.mkPackage {
        theme = {
          name = "kybe";
          theme = basenix.vimTheme;
        };
      };
      kyvim = lib.wrapped;
    in
    {
      home = {
        packages = [ kyvim ];
        sessionVariables.EDITOR = "${lib.getExe kyvim}";
      };
    };
}
