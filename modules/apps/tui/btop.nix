{
  flake.homeModules.kybe =
    {
      lib,
      pkgs,
      ...
    }:
    {
      programs.btop = {
        enable = true;
        package = pkgs.btop-cuda;
        settings = {
          vim_keys = true;
          update_ms = 200;
          theme_background = false;
        };
      };
    };
}
