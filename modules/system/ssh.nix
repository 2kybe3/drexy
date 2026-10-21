{
  flake.nixosModules.system = { lib, pkgs, ... }: {
    environment.persistence."/persistent".directories = [
      "/etc/ssh"
    ];

    networking.firewall.allowedTCPPorts = [ 22 ];
    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        AllowUsers = [ "kybe" ];
        PermitRootLogin = "no";
      };
    };
  };
}
