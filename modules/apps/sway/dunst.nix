{
  flake.homeModules.kybe =
    {
      pkgs,
      ...
    }:
    {
      services.dunst = {
        enable = true;
        settings = {
          global = {
            monitor = 0;
            width = "(100, 300)";
            height = "(50, 300)";

            offset = "(0, 0)";

            # dunstify -h int:value:12
            frame_width = 1;
            alignment = "center";

            browser = "xdg-open";
          };

          urgency_critical.timeout = 0;
        };
      };
    };
}
