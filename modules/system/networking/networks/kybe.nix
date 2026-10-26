{
  flake.nixosModules.networking.networking.networkmanager.ensureProfiles.profiles."kybe" = {
    connection = {
      id = "kybe";
      interface-name = "wlp0s26u1u4";
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
}
