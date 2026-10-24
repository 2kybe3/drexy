{
  flake.nixosModules.system = {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };

    environment.persistence."/persistent".directories = [
      "/var/lib/docker"
    ];
  };
}
