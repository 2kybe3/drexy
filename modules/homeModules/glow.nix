{
  flake.homeModules.glow =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      cfg = config.programs.glow;
      format = pkgs.formats.yaml_1_2 { };
    in
    {
      options.programs.glow = {
        enable = lib.mkEnableOption "glow";

        package = lib.mkPackageOption pkgs "glow" { nullable = true; };

        settings = lib.mkOption {
          type = lib.types.submodule { freeformType = format.type; };
          default = { };
          example = {
            all = true;
          };
          description = ''
            Glow configuration.
            See <https://github.com/charmbracelet/glow#the-config-file> for options.
          '';
        };
      };

      config = lib.mkIf cfg.enable {
        home.packages = lib.mkIf (cfg.package != null) [ cfg.package ];

        xdg.configFile."glow/glow.yml" = lib.mkIf (cfg.settings != { }) {
          source = format.generate "glow-config.yaml" cfg.settings;
        };
      };
    };
}
