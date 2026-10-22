{
  flake.nixosModules.system = { lib, pkgs, ... }: {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };

    environment.persistence."/persistent".directories = [
      "/var/lib/docker"
    ];
  };
}
