{
  flake.homeModules.kybe =
    {
      pkgs,
      ...
    }:
    {
      xdg = {
        enable = true;
        userDirs.enable = true;

        mimeApps = {
          enable = true;
          associations.added = {
            "application/pdf" = "librewolf.desktop";
          };
          defaultApplicationPackages = with pkgs; [
            kdePackages.dolphin
            librewolf
            vesktop # x-scheme-handler/discord
            imv
          ];
        };

        autostart = {
          enable = true;
          readOnly = true;
        };
      };
    };
}
