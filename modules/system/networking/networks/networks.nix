{ secrets, ... }: {
  flake.nixosModules.networking =
    {
      config,
      ...
    }:
    {
      sops.secrets.wifi = {
        sopsFile = "${secrets}/system/wifi/wifi.env.bin";
        format = "binary";
      };

      networking.networkmanager.ensureProfiles.environmentFiles = [ config.sops.secrets.wifi.path ];
    };
}
