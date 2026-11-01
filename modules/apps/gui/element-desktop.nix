{
  flake.homeModules.kybe =
    {
      hostName,
      ...
    }:
    {
      programs.element-desktop = {
        enable = true;
        settings = {
          default_server_config = {
            "m.homeserver" = {
              base_url = "https://matrix.kybe.xyz";
            };
            "org.matrix.msc3575.proxy" = {
              url = "https://matrix.kybe.xyz";
            };
          };
          features = {
            feature_latex_maths = true;
            feature_pinning = true;
            feature_jump_to_date = true;
            feature_dm_verification = true;
          };
          default_theme = "dark";
          default_device_display_name = hostName;
        };
      };
    };
}
