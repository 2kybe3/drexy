{
  flake.nixosModules.system = {
    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        AllowUsers = [ "kybe" ];
        PermitRootLogin = "no";
      };
    };

    environment.persistence."/persistent".directories = [
      "/etc/ssh"
    ];
  };
}
