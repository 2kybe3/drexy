{
  flake.homeModules.kybe.xdg = {
    enable = true;
    userDirs.enable = true;

    autostart = {
      enable = true;
      readOnly = true;
    };
  };
}
