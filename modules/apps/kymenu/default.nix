{
  flake.homeModules.kybe =
    {
      inputs',
      ...
    }:
    {
      home.packages = [
        inputs'.kymenu.packages.default
      ]
      ++ builtins.attrValues inputs'.kymenu-extras.packages;
    };
}
