{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.tetro-tui = pkgs.rustPlatform.buildRustPackage (finalAttrs: {
        pname = "tetro-tui";
        version = "3.6.1";

        strictDeps = true;
        __structuredAttrs = true;

        src = pkgs.fetchFromGitHub {
          owner = "Strophox";
          repo = "tetro-tui";
          tag = "v${finalAttrs.version}";
          hash = "sha256-i/d+i6E0ClMAAjC6zB9Lt26LYEcjvR01MCzGne2EXNQ=";
        };

        cargoHash = "sha256-LTHokF9T7nRvvzfQWSL9igTHmvV+w40Pm4z/i0y7goA=";

        meta.mainProgram = "tetro-tui";
      });
    };
}
