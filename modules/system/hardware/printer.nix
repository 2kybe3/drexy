{
  flake.nixosModules.system =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      services = {
        printing = {
          enable = true;
          browsing = true;
        };

        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
      };
    };
}
