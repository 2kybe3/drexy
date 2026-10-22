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
      basenix,
      ...
    }:
    {
      programs.wiremix = {
        enable = true;
        package = self'.packages.wiremix;
        settings = {
          fps = 75.0;
          themes.default = with basenix.colors; {
            meter_overload.fg = base08;

            dropdown_selected.fg = base05;
            list_more.fg = base05;
            meter_active.fg = base05;
            meter_center_active.fg = base05;
            selector.fg = base05;
            tab_marker.fg = base05;
            tab_selected.fg = base05;
            volume_filled.fg = base05;
          };
        };
      };
    };
}
