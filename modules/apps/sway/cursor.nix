{
  flake.homeModules.kybe =
    {
      pkgs,
      ...
    }:
    {
      home.pointerCursor = {
        enable = true;
        package = pkgs.vanilla-dmz;

        name = "DMZ-Black";
        size = 12;

        sway.enable = true;
        gtk.enable = true;
      };
    };
}
