{
  perSystem =
    {
      lib,
      pkgs,
      basenix,
      ...
    }:
    let
      manifestContent = basenix.substitute (builtins.readFile ./manifest.json);
      manifestHash = builtins.substring 0 7 (builtins.hashString "sha256" manifestContent);

      xpiFileName = "theme-${manifestHash}.xpi";
    in
    {
      packages.firefox-theme = pkgs.stdenv.mkDerivation (finalAttrs: {
        pname = "firefox-theme";
        version = "1.0-${manifestHash}";

        __structuredAttrs = true;
        strictDeps = true;

        src = builtins.toFile "manifest.json" manifestContent;

        unpackPhase = ":";

        buildPhase = ''
          runHook preBuild

          mkdir -p build
          cp $src build/manifest.json

          mkdir $out
          ${lib.getExe pkgs.zip} -j $out/${xpiFileName} build/manifest.json

          runHook postBuild
        '';

        passthru = {
          file = "${finalAttrs.finalPackage}/" + xpiFileName;
          fileName = xpiFileName;
          addonId =
            (builtins.fromJSON (builtins.readFile ./manifest.json)).browser_specific_settings.gecko.id;
        };
      });
    };
}
