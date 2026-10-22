{ secrets, ... }: {
  flake.nixosModules.system =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      sops.secrets = {
        "kybe.xyz@wg-key" = {
          sopsFile = "${secrets}/system/wireguard/kybe.xyz.yaml";
          key = "wg-key";
        };
        "kybe.xyz@wg-pk" = {
          sopsFile = "${secrets}/system/wireguard/kybe.xyz.yaml";
          key = "wg-pk";
        };
        "mullvad@wg-key" = {
          sopsFile = "${secrets}/system/wireguard/mullvad.yaml";
          key = "wg-key";
        };
      };

      systemd.services = {
        "kybe-wg-resolv" = {
          after = [
            "wireguard-kybe.xyz.target"
            "network.target"
            "wireguard-kybe.xyz.service"
          ];
          wants = [ "wireguard-kybe.xyz.service" ];
          bindsTo = [ "wireguard-kybe.xyz.service" ];
          wantedBy = [ "wireguard-kybe.xyz.service" ];

          serviceConfig = {
            Type = "oneshot";
            ExecStart = "${lib.getExe pkgs.bash} -c 'resolvectl dnsovertls kybe.xyz no; resolvectl dnssec kybe.xyz no; resolvectl domain kybe.xyz ~kybe.xyz ~black.void; resolvectl dns kybe.xyz 10.0.6.1;'";
          };
        };
      };

      networking =
        let
          mullvad-table = "mullvad";
          mullvad-endpoint = "193.32.248.66";

          kybe-table = "kybe";
          kybe-endpoint = "65.108.107.152";
        in
        {
          iproute2 = {
            enable = true;
            rttablesExtraConfig = ''
              100 ${kybe-table}
              200 ${mullvad-table}
            '';
          };
          localCommands = ''
            ip rule del pref 100 2>/dev/null || true
            ip rule add pref 100 to ${kybe-endpoint} lookup main

            ip rule del pref 101 2>/dev/null || true
            ip rule add pref 101 lookup kybe

            ip rule del pref 102 2>/dev/null || true
            ip rule add pref 102 lookup main suppress_prefixlength 0

            ip rule del pref 200 2>/dev/null || true
            ip rule add pref 200 to ${mullvad-endpoint} lookup main

            ip rule del pref 201 2>/dev/null || true
            ip rule add pref 201 lookup mullvad

            ip -6 rule del pref 101 2>/dev/null || true
            ip -6 rule add pref 101 lookup kybe

            ip -6 rule del pref 102 2>/dev/null || true
            ip -6 rule add pref 102 lookup main suppress_prefixlength 0

            ip -6 rule del pref 201 2>/dev/null || true
            ip -6 rule add pref 201 lookup mullvad
          '';
          wireguard.interfaces = {
            "kybe.xyz" = {
              table = "kybe";
              ips = [
                "10.0.6.5/32"
                "fd00:b00b::5/128"
              ];
              privateKeyFile = config.sops.secrets."kybe.xyz@wg-key".path;

              peers = [
                {
                  endpoint = "${kybe-endpoint}:51820";
                  publicKey = "Dumq+QBDIAmAzTC1lo+njEh5v1ZJ+epGfxCheGWOsxc=";
                  presharedKeyFile = config.sops.secrets."kybe.xyz@wg-pk".path;
                  allowedIPs = [
                    "10.0.4.0/23"
                    "10.0.6.0/24"
                    "10.0.8.0/24"
                    "fd00:b00b::0/64"
                    "2a01:4f9:6b:1f05::0/64"
                  ];
                  persistentKeepalive = 25;
                }
              ];

              postShutdown = ''
                resolvectl revert kybe.xyz || true
              '';
            };
            # cute buck
            "mullvad" = {
              table = "mullvad";
              ips = [
                "10.67.22.185/32"
                "fc00:bbbb:bbbb:bb01::4:16b8/128"
              ];
              privateKeyFile = config.sops.secrets."mullvad@wg-key".path;
              mtu = 1320;

              peers = [
                {
                  endpoint = "${mullvad-endpoint}:51820";
                  publicKey = "0qSP0VxoIhEhRK+fAHVvmfRdjPs2DmmpOCNLFP/7cGw=";

                  allowedIPs = [
                    "0.0.0.0/0"
                    "::0/0"
                  ];
                  persistentKeepalive = 15;
                }
              ];
            };
          };
        };
    };
}
