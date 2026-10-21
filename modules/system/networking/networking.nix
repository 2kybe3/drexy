{secrets,...}:{
  flake.nixosModules.networking =
    {
      pkgs,
      config,
      ...
    }:
    let
      interface-name = "wlp0s26u1u4";
    in
    {
      sops.secrets.wifi = {
        sopsFile = "${secrets}/system/wifi/wifi.env.bin";
        format = "binary";
      };

      networking.networkmanager = {
        enable = true;
        dns = "systemd-resolved";
        ensureProfiles = {
          environmentFiles = [ config.sops.secrets.wifi.path ];
          profiles = {
            "home" = {
              connection = {
                id = "MagentaWLAN-QWZ1";
                inherit interface-name;
                type = "wifi";
                uuid = "bba60051-a524-493e-9089-3f3d7a88c5bc";
              };
              ipv4 = {
                method = "auto";
              };
              ipv6 = {
                addr-gen-mode = "default";
                method = "auto";
              };
              wifi = {
                mode = "infrastructure";
                ssid = "MagentaWLAN-QWZ1";
              };
              wifi-security = {
                auth-alg = "open";
                key-mgmt = "wpa-psk";
                psk = "$HOME_KEY";
              };
            };
            "kybe" = {
              connection = {
                id = "kybe";
                inherit interface-name;
                type = "wifi";
                uuid = "2e3b1f20-0c7d-4594-9234-a9427e3b8274";
              };
              ipv4 = {
                method = "auto";
              };
              ipv6 = {
                addr-gen-mode = "default";
                method = "auto";
              };
              wifi = {
                mode = "infrastructure";
                ssid = "kybe";
              };
              wifi-security = {
                key-mgmt = "sae";
                psk = "$KYBE_KEY";
              };
            };
          };
        };
      };
    };
}
