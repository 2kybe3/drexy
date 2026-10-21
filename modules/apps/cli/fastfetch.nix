{
  flake.homeModules.kybe =
    {
      kylib,
      ...
    }:
    {
      programs.fastfetch = {
        enable = true;
        settings = {
          logo = {
            source = "nixos";
            color = with kylib.colors; {
              "1" = main;
              "3" = main;
              "5" = main;

              "2" = bright;
              "4" = bright;
              "6" = bright;
            };
          };
          display = {
            color = kylib.colors.bright;
            separator = " -> ";
          };
          modules = [
            "kernel"
            "uptime"
            "wm"
            "os"
            "packages"

            "break"

            {
              type = "datetime";
              key = "Time";
              format = "{14}:{17}:{20}";
            }
            {
              type = "datetime";
              key = "Date";
              format = "{1}-{3}-{11}";
            }

            "break"

            "bluetooth"
            "media"

            "break"

            "board"
            "bios"
            "bootmgr"

            "break"

            "cpu"
            "memory"
            "disk"
          ];
        };
      };
    };
}
