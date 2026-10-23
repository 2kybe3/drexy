{
  flake.homeModules.kybe =
    {
      lib,
      pkgs,
      ...
    }:
    {
      fonts.fontconfig = {
        enable = true;
        antialiasing = true;
      };
    };
}
