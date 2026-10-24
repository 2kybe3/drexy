{
  flake.homeModules.kybe.programs.thunderbird = {
    enable = true;
    settings."general.useragent.override" = "Hello there :-)";
  };
}
