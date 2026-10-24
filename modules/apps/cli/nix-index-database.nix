{ inputs, ... }: {
  flake.homeModules.kybe = {
    imports = [
      inputs.nix-index-database.homeModules.default
    ];

    programs = {
      command-not-found.enable = false;
      nix-index-database.comma.enable = true;
    };
  };
}
