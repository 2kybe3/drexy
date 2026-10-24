{
  flake.nixosModules.system.environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];

  flake.homeModules.kybe =
    {
      pkgs,
      ...
    }:
    {
      xdg.portal = {
        enable = true;

        config.common.default = [
          "wlr"
          "gtk"
          "gnome"
        ];

        extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
          xdg-desktop-portal-gtk
          xdg-desktop-portal-wlr
        ];

        xdgOpenUsePortal = true;
      };
    };
}
