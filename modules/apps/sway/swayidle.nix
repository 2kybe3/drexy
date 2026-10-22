{
  perSystem =
    {
      lib,
      pkgs,
      ...
    }:
    {
      packages.swaylock = pkgs.writeShellApplication {
        name = "swaylock";

        derivationArgs = {
          strictDeps = true;
          __structuredAttrs = true;
        };

        runtimeInputs = with pkgs; [
          procps
          swaylock
        ];

        text = /* bash */ ''
          if ! pgrep -x swaylock > /dev/null; then
            exec swaylock
          fi
        '';
      };
    };

  flake.homeModules.kybe =
    {
      lib,
      pkgs,
      self',
      config,
      secrets,
      ...
    }:
    {
      services.swayidle = {
        enable = true;
        timeouts = [
          {
            timeout = 300;
            command = lib.getExe self'.packages.swaylock;
          }
        ];
        events.before-sleep = lib.getExe self'.packages.swaylock;
      };
    };
}
