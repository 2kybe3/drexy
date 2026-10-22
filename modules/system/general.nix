{
  flake.nixosModules.system = { lib, pkgs, ... }: {
    time.timeZone = "Europe/Berlin";
    security.polkit.enable = true;

    services = {
      dbus.enable = true;
      gnome.gnome-keyring.enable = true;
      getty.helpLine = lib.mkForce "";
    };

    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_TIME = "de_DE.UTF-8";
      };
    };

    environment.shellAliases = {
      ls = null;
      ll = null;
      l = null;
    };

    programs = {
      dconf.enable = true;
      steam.enable = true;
      nix-ld.enable = true;
      command-not-found.enable = false;
    };
  };
}
