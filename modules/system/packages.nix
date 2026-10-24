{
  flake.nixosModules.system = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # keep-sorted start

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
      wl-clipboard-rs

      # keep-sorted end
    ];
  };
}
