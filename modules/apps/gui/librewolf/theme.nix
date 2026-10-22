{
  perSystem =
    {
      lib,
      pkgs,
      basenix,
      ...
    }:
    {
      packages.firefox-theme = pkgs.stdenv.mkDerivation {
        pname = "firefox-theme";
        version = "1.0";

        __structuredAttrs = true;
        strictDeps = true;

        src = builtins.toFile "manifest.json" (basenix.substitute (builtins.readFile ./manifest.json));

        unpackPhase = ":";

        buildPhase = ''
          runHook preBuild

          mkdir -p build
          cp $src build/manifest.json

          mkdir $out
          ${lib.getExe pkgs.zip} -j $out/theme.xpi build/manifest.json

          runHook postBuild
        '';
      };
    };
}
