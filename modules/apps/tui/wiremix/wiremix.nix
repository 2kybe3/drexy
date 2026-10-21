{
  perSystem =
    {
      pkgs,
      config,
      inputs',
      ...
    }:
    {
      packages.wiremix = pkgs.wiremix.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          ./style.patch
        ];
      });
    };

  flake.homeModules.kybe =
    {
      pkgs,
      self',
      kylib,
      ...
    }:
    {
      programs.wiremix = {
        enable = true;
        package = self'.packages.wiremix;
        settings = {
          fps = 75.0;
          themes.default = with kylib.colors; {
            dropdown_selected.fg = selected;
            list_more.fg = main;
            meter_active.fg = bright;
            meter_center_active.fg = bright;
            meter_overload.fg = red;
            selector.fg = selected;
            tab_marker.fg = selected;
            tab_selected.fg = selected;
            volume_filled.fg = bright;
          };
        };
      };
    };
}
