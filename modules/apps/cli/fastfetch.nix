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
              "1" = base0C;
              "3" = base0C;
              "5" = base0C;

              "2" = base0D;
              "4" = base0D;
              "6" = base0D;
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
