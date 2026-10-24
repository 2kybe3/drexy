{
  flake.nixosModules.system = { lib, ... }: {
    time.timeZone = "Europe/Berlin";

    security.polkit.enable = true;

    services = {
      gnome.gnome-keyring.enable = true;
      getty.helpLine = lib.mkForce "";
    };

    i18n =
      let
        us = "en_US.UTF-8";
        de = "de_DE.UTF-8";
      in
      {
        defaultLocale = us;
        extraLocaleSettings = {
          LC_ADDRESS = de;
          LC_COLLATE = de;
          LC_IDENTIFICATION = de;
          LC_MONETARY = de;
          LC_MEASUREMENT = de;
          LC_NUMERIC = de;
          LC_PAPER = de;
          LC_TELEPHONE = de;
          LC_TIME = de;
        };
      };

    programs = {
      dconf.enable = true;
      steam.enable = true;
      nix-ld.enable = true;
    };
  };
}
