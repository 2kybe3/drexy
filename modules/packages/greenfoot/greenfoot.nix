{
  perSystem =
    {
      pkgs,
      ...
    }:
    let
      openjdk = pkgs.openjdk21.override {
        enableJavaFX = true;
        openjfx_jdk = pkgs.openjfx21.override { withWebKit = true; };
      };
    in
    {
      packages.greenfoot = pkgs.stdenv.mkDerivation (finalAttrs: {
        pname = "greenfoot";
        version = "3.9.0";

        src = pkgs.fetchurl {
          url = "https://www.greenfoot.org/download/files/Greenfoot-linux-arm64-${
            builtins.replaceStrings [ "." ] [ "" ] finalAttrs.version
          }.deb";
          hash = "sha256-d5bkK+teTA4fxFb46ovbZE28l8WILGStv3Vg3nJZfv0=";
        };

        nativeBuildInputs = with pkgs; [
          dpkg
          wrapGAppsHook3
        ];

        buildInputs = with pkgs; [ glib ];

        installPhase = /* bash */ ''
          runHook preInstall

          mkdir -p $out
          cp -r usr/* $out

          rm -r $out/share/greenfoot/jdk
          rm -r $out/share/greenfoot/javafx-*.jar

          makeWrapper ${openjdk}/bin/java $out/bin/greenfoot \
            "''${gappsWrapperArgs[@]}" \
            --add-flags "--add-opens javafx.graphics/com.sun.glass.ui=ALL-UNNAMED \
                         --add-opens javafx.graphics/com.sun.javafx.scene.input=ALL-UNNAMED \
                         -cp $out/share/greenfoot/boot.jar bluej.Boot \
                         -greenfoot=true -bluej.compiler.showunchecked=false \
                         -greenfoot.scenarios=$out/share/doc/Greenfoot/scenarios \
                         -greenfoot.url.javadoc=file://$out/share/doc/Greenfoot/API"

          runHook postInstall
        '';

        meta.mainProgram = "greenfoot";
      });
    };
}
