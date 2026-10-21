{
  flake.homeModules.kybe = {
    programs.vesktop = {
      enable = true;
      settings.discordBranch = "ptb";
    };
  };
}
