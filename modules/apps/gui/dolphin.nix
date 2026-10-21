{
  flake.homeModules.kybe =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        kdePackages.dolphin
        kdePackages.qtsvg
      ];
    };
}
