{
  flake.nixosModules.system.security.pam.services.swaylock = { };

  flake.homeModules.kybe =
    {
      kylib,
      ...
    }:
    {
      programs.swaylock = {
        enable = true;
        settings = {
          key-hl-color = kylib.colors.lib.stripHash kylib.colors.selected;
          ring-color = kylib.colors.lib.stripHash kylib.colors.main;
          ignore-empty-password = true;
          show-failed-attempts = true;
          line-uses-ring = true;
          daemonize = true;
          color = "000000";
        };
      };
    };
}
