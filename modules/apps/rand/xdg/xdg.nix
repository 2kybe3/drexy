{
  flake.homeModules.kybe =
    {
      pkgs,
      config,
      ...
    }:
    {
      xdg = {
        enable = true;
        userDirs.enable = true;

        mimeApps = {
          enable = true;
          defaultApplicationPackages = with pkgs; [
            config.programs.librewolf.package
            config.programs.zathura.package
            config.programs.vesktop.package
            config.programs.imv.package

            kdePackages.dolphin
          ];
        };

        autostart = {
          enable = true;
          readOnly = true;
        };
      };
    };
}
