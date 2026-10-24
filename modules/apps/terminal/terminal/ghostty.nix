{
  flake.homeModules.kybe =
    {
      lib,
      config,
      basenix,
      ...
    }:
    {
      home.sessionVariables.TERMINAL = "${lib.getExe config.programs.ghostty.package}";

      programs.ghostty = {
        enable = true;
        settings = {
          font-size = 11;
          background-opacity = 0.9;
          app-notifications = [
            "no-clipboard-copy"
          ];
          confirm-close-surface = false;
          foreground = basenix.colors.base05;
          palette = with basenix.colors; [
            "0=${base00}"
            "1=${base08}"
            "2=${base0B}"
            "3=${base0A}"
            "4=${base0D}"
            "5=${base0E}"
            "6=${base0C}"
            "7=${base05}"
            "8=${base03}"
            "9=${base08}"
            "10=${base0B}"
            "11=${base0A}"
            "12=${base0D}"
            "13=${base0E}"
            "14=${base0C}"
            "15=${base07}"
            "16=${base10}"
            "17=${base11}"
            "18=${base12}"
            "19=${base13}"
            "20=${base14}"
            "21=${base15}"
            "22=${base16}"
            "23=${base17}"
          ];
        };
      };
    };
}
