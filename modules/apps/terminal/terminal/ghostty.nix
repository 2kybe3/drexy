{
  flake.homeModules.kybe =
    {
      lib,
      pkgs,
      kylib,
      ...
    }:
    {
      home.sessionVariables.TERMINAL = "${lib.getExe pkgs.ghostty}";

      programs.ghostty = {
        enable = true;
        settings = {
          font-size = 11;
          background-opacity = 0.0;
          app-notifications = [
            "no-clipboard-copy"
          ];
          confirm-close-surface = false;
          palette = [
            "4=${kylib.colors.bright}"
            "12=${kylib.colors.bright}"
          ];
        };
      };
    };
}
