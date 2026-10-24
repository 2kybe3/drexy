{
  flake.nixosModules.system =
    {
      pkgs,
      ...
    }:
    let
      build =
        {
          name,
          suffix,
          text,
        }:
        pkgs.writeShellApplication {
          name = "${name}-${suffix}";
          inherit text;
        };

      off =
        name:
        build {
          inherit name;
          suffix = "off";
          text = ''
            sudo systemctl stop wireguard-${name}.service
          '';
        };

      on =
        name:
        build {
          inherit name;
          suffix = "on";
          text = ''
            sudo systemctl start wireguard-${name}.service
          '';
        };

      toggle =
        name:
        build {
          inherit name;
          suffix = "toggle";
          text = ''
            if systemctl is-active --quiet wireguard-kybe.xyz.service; then
                sudo systemctl stop wireguard-${name}.service
            else
                sudo systemctl start wireguard-${name}.service
            fi
          '';
        };

      all = name: [
        (toggle name)
        (off name)
        (on name)
      ];
    in
    {
      environment.systemPackages = (all "kybe.xyz") ++ (all "mullvad");
    };
}
