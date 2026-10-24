{
  flake.homeModules.kybe.programs.obsidian = {
    enable = true;
    cli.enable = true;
    vaults = {
      "abi" = {
        enable = true;
        target = ".syncthing/obsidian/abi";
      };
      "main" = {
        enable = true;
        target = ".syncthing/obsidian/main";
      };
    };
  };
}
