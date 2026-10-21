{ secrets, ... }: {
  flake.nixosModules.system = { pkgs, config, ... }: {
    sops.secrets = {
      root = {
        sopsFile = "${secrets}/system/users/password.yaml";
        neededForUsers = true;
      };
      kybe = {
        sopsFile = "${secrets}/system/users/password.yaml";
        neededForUsers = true;
      };
    };

    users = {
      mutableUsers = false;

      users = {
        root.hashedPasswordFile = config.sops.secrets.root.path;

        kybe = {
          isNormalUser = true;
          extraGroups = [
            "wheel"
          ];
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM7irWuDZwx7ZvPSiUwBbxUxKL/7aMQmy/8oxput1bID kybe@khost"
          ];
          hashedPasswordFile = config.sops.secrets.kybe.path;
        };
      };
    };
  };
}
