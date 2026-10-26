{
  flake.nixosModules.networking = {
    networking.networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };

    services.resolved = {
      enable = true;
      settings.Resolve = {
        Domains = [ "~." ];
        DNSOverTLS = "true";
        DNSSEC = "false";
      };
    };

    networking = {
      nftables.enable = true;
      firewall.enable = true;
      nameservers = [
        # quad9 "unsecure"
        "9.9.9.10"
        "149.112.112.10"
        "2620:fe::10"
        "2620:fe::fe:10"

        # cloudflare
        "1.1.1.1"
        "1.0.0.1"
        "2606:4700:4700::1111"
        "2606:4700:4700::1001"

        # google
        "8.8.8.8"
        "8.8.4.4"
        "2001:4860:4860::8888"
        "2001:4860:4860::8844"
      ];
    };
  };
}
