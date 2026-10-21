{ secrets, ... }: {
  flake.homeModules.kybe =
    {
      pkgs,
      config,
      ...
    }:
    let
      hostName = "kybe.xyz";

      base = {
        User = "kybe";
        IdentitiesOnly = true;
        IdentityFile = "${config.home.homeDirectory}/.ssh/kybe";
      };
    in
    {
      home.file.".ssh/kybe.pub".source = "${secrets}/home/ssh/kybe.pub";

      sops.secrets.kybe-priv-ssh = {
        sopsFile = "${secrets}/home/ssh/kybe.key";
        path = ".ssh/kybe";
        format = "binary";
      };

      services.ssh-agent.enable = true;

      programs.ssh = {
        enable = true;

        settings = {
          "server" = base // {
            HostName = "ip.${hostName}";
          };
          "gitc.kybe.xyz" = base;
        };

        enableDefaultConfig = false;
      };
    };
}
