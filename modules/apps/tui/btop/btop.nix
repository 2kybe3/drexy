{
  flake.homeModules.kybe =
    {
      lib,
      pkgs,
      basenix,
      ...
    }:
    {
      xdg.configFile."btop/themes/kybe.theme".text = basenix.substitute (builtins.readFile ./kybe.theme);

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
