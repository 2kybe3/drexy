{
  flake.homeModules.kybe =
    {
      lib,
      pkgs,
      ...
    }:
    let
      fonts = {
        monospace = {
          name = "FiraCode Nerd Font";
          pkg = pkgs.nerd-fonts.fira-code;
        };
        sansSerif = {
          name = "Inter";
          pkg = pkgs.inter;
        };
        serif = {
          name = "Noto Serif 4";
          pkg = pkgs.source-serif;
        };
        emoji = {
          name = "Noto Color Emoji";
          pkg = pkgs.noto-fonts-color-emoji;
        };
      };
    in
    {
      home.packages = (lib.mapAttrsToList (_: f: f.pkg) fonts) ++ [ pkgs.font-awesome_6 ];

      fonts.fontconfig = {
        enable = true;
        antialiasing = true;

        defaultFonts = lib.mapAttrs (_: f: [ f.name ]) fonts;
      };
    };
}
