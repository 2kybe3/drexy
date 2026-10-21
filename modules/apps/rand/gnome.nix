{
  flake.homeModules.kybe =
    {
      pkgs,
      ...
    }:
    {
      # A lot of gnome apps need this
      home.packages = with pkgs; [
        adwaita-icon-theme
      ];
    };
}
