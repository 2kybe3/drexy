{ secrets, ... }: {
  flake.homeModules.kybe = { pkgs, config, ... }: {
    home.packages = with pkgs; [
      nix-output-monitor
      attic-client
      nix-update
    ];

    sops.secrets = {
      nix-extra-conf = {
        sopsFile = "${secrets}/home/nix/extra-conf.txt";
        format = "binary";
      };
      nix-netrc = {
        sopsFile = "${secrets}/home/nix/netrc.txt";
        format = "binary";
      };
    };

    nix.extraOptions = ''
      netrc-file = ${config.sops.secrets.nix-netrc.path}
      !include ${config.sops.secrets.nix-extra-conf.path}
    '';
  };
}
