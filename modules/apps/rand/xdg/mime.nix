{
  flake.homeModules.kybe =
    {
      pkgs,
      config,
      ...
    }:
    {
      xdg.mimeApps = {
        enable = true;
        defaultApplicationPackages = with pkgs; [
          config.programs.librewolf.package
          config.programs.zathura.package
          config.programs.vesktop.package
          config.programs.imv.package

          kdePackages.dolphin
        ];
      };
    };
}
