{
  self,
  inputs,
  ...
}:
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake.homeModules.kybe = { lib, pkgs, ... }: {
    imports = [
      self.homeModules.glow
    ];

    home.stateVersion = "26.11";
  };

  flake.nixosModules.system =
    {
      pkgs,
      config,
      ...
    }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        extraSpecialArgs.hostName = config.networking.hostName;

        users.kybe = self.homeModules.kybe;
      };
    };
}
