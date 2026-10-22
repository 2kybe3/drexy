{
  flake.homeModules.kybe =
    {
      pkgs,
      basenix,
      ...
    }:
    {
      services.dunst = {
        enable = true;
        settings =
          with basenix.colors;
          let
            urgency_low_normal = {
              background = base00;
              foreground = base05;
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
              frame_color = base01;

              alignment = "center";

              browser = "xdg-open";
            };

            urgency_low = urgency_low_normal;
            urgency_normal = urgency_low_normal;

            urgency_critical = urgency_low_normal // {
              timeout = 0;
              frame_color = base08;
            };
          };
      };
    };
}
