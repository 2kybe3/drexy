{
  flake.homeModules.kybe =
    {
      pkgs,
      kylib,
      ...
    }:
    {
      services.dunst = {
        enable = true;
        settings =
          with kylib.colors;
          let
            urgency_low_normal = {
              background = main;
              foreground = text;
              timeout = 10;
            };
          in
          {
            global = {
              monitor = 0;
              width = "(100, 300)";
              height = "(50, 300)";

              offset = "(0, 0)";

              # dunstify -h int:value:12
              frame_width = 1;
              frame_color = outline;

              alignment = "center";

              browser = "xdg-open";
            };

            urgency_low = urgency_low_normal;
            urgency_normal = urgency_low_normal;

            urgency_critical = urgency_low_normal // {
              timeout = 0;
              frame_color = red;
            };
          };
      };
    };
}
