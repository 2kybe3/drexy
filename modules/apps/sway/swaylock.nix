{
  flake.nixosModules.system.security.pam.services.swaylock = { };

  flake.homeModules.kybe.programs.swaylock = {
    enable = true;
    settings = {
      ignore-empty-password = true;
      show-failed-attempts = true;
      line-uses-ring = true;
      daemonize = true;
    };
  };
}
