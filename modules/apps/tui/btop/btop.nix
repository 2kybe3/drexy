{
  flake.homeModules.kybe =
    {
      lib,
      pkgs,
      kylib,
      ...
    }:
    {
      xdg.configFile."btop/themes/kybe.theme".text = kylib.colors.lib.substitute (
        builtins.readFile ./kybe.theme
      );

      programs.btop = {
        enable = true;
        package = pkgs.btop-cuda;
        settings = {
          vim_keys = true;
          update_ms = 200;
          color_theme = "kybe";
          theme_background = false;
        };
      };
    };
}
