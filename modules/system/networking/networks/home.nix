{
  flake.nixosModules.networking.networking.networkmanager.ensureProfiles.profiles."home" = {
    connection = {
      id = "MagentaWLAN-QWZ1";
      interface-name = "wlp0s26u1u4";
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
}
