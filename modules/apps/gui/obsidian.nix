{
  flake.homeModules.kybe =
    {
      pkgs,
      ...
    }:
    {
      programs.obsidian = {
        enable = true;
        cli.enable = true;
        vaults."abi" = {
          enable = true;
          target = ".syncthing/obsidian/abi";
        };
        vaults."main" = {
          enable = true;
          target = ".syncthing/obsidian/main";
        };
      };
    };
}
