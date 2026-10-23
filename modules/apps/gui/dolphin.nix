{
  flake.homeModules.kybe =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs.kdePackages; [
        dolphin
        # support for svg icons
        qtsvg
        # network shares
        kio
        kio-fuse
        kio-extras
      ];
    };
}
