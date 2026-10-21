{
  perSystem =
    {
      lib,
      pkgs,
      kylib,
      ...
    }:
    {
      packages.firefox-theme = pkgs.stdenv.mkDerivation {
        pname = "firefox-theme";
        version = "1.0";

        __structuredAttrs = true;
        strictDeps = true;

        src = builtins.toFile "manifest.json" (
          kylib.colors.lib.substitute (builtins.readFile ./manifest.json)
        );

        unpackPhase = ":";

        buildPhase = ''
          runHook preBuild
          mkdir $out
          ${lib.getExe pkgs.zip} $out/theme.xpi $src
          runHook postBuild
        '';
      };
    };
}
