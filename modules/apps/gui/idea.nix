{
  flake.homeModules.kybe =
    { lib, pkgs, ... }:
    let
      jdks = with pkgs; [
        jdk21.home
        jdk25.home
      ];

      idea = pkgs.symlinkJoin {
        inherit (pkgs.intellij-idea) pname version;
        paths = [ pkgs.intellij-idea ];
        nativeBuildInputs = [ pkgs.makeWrapper ];

        postBuild = /* bash */ ''
          wrapProgram $out/bin/${pkgs.intellij-idea.meta.mainProgram} \
            --prefix PATH : ${lib.makeBinPath jdks}
        '';
      };
    in
    {
      home.packages = [ idea ];
    };
}
