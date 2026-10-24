{ secrets, ... }: {
  flake.homeModules.kybe =
    {
      config,
      ...
    }:
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

        settings =
          let
            base = {
              User = "kybe";
              IdentitiesOnly = true;
              IdentityFile = "${config.home.homeDirectory}/.ssh/kybe";
            };
          in
          {
            "server" = base // {
              HostName = "ip.kybe.xyz";
            };
            "gitc.kybe.xyz" = base;
          };

        enableDefaultConfig = false;
      };
    };
}
