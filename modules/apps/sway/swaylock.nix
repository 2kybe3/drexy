{
  flake.nixosModules.system.security.pam.services.swaylock = { };

  flake.homeModules.kybe =
    {
      basenix,
      ...
    }:
    {
      programs.swaylock = {
        enable = true;
        settings = {
          key-hl-color = basenix.stripHash basenix.colors.base02;
          ring-color = basenix.stripHash basenix.colors.base00;
          ignore-empty-password = true;
          show-failed-attempts = true;
          line-uses-ring = true;
          daemonize = true;
          color = "000000";
        };
      };
    };
}
