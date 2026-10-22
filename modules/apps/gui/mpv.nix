{

  perSystem =
    {
      lib,
      pkgs,
      ...
    }:
    {
      packages.mpv = pkgs.mpv.override {
        scripts = with pkgs.mpvScripts; [
          uosc
          sponsorblock
        ];
      };
    };

  flake.homeModules.kybe =
    {
      pkgs,
      self',
      ...
    }:
    {
      programs.mpv = {
        enable = true;
        package = self'.packages.mpv;
        config.save-position-on-quit = "yes";
      };
    };
}
