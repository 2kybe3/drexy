{
  flake.nixosModules.system = { lib, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      curl
      dig
      fd
      file
      git
      home-manager
      lsof
      mtr
      ncdu
      openssl
      psmisc
      ripgrep
      tcpdump
      traceroute
      unzip
      wget
      whois
    ];
  };
}
