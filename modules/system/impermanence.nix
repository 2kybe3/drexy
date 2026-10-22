{ inputs, ... }: {
  flake.nixosModules.system = { pkgs, ... }: {
    imports = [
      inputs.impermanence.nixosModules.impermanence
    ];

    environment.persistence."/persistent" = {
      hideMounts = true;
      allowTrash = false;
      directories = [
        "/var/lib/nixos"
        "/var/lib/bluetooth"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
      ];
      files = [
        "/etc/machine-id"
      ];
    };
  };
}
