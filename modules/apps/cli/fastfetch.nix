{
  flake.homeModules.kybe =
    {
      basenix,
      ...
    }:
    {
      programs.fastfetch = {
        enable = true;
        settings = {
          logo = {
            source = "nixos";
            color = with basenix.colors; {
              "1" = base00;
              "3" = base00;
              "5" = base00;

              "2" = base01;
              "4" = base01;
              "6" = base01;
            };
          };
          display.separator = " -> ";
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
