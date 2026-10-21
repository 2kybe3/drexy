{
  flake.homeModules.kybe =
    {
      pkgs,
      config,
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
          default_theme = "dark";
          default_device_display_name = hostName;
        };
      };
    };
}
