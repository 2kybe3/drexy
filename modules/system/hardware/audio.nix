{
  flake = {
    homeModules.kybe = { pkgs, ... }: {
      home.packages = with pkgs; [
        # equalizer
        jamesdsp

        playerctl

        pavucontrol
        qpwgraph
      ];
    };

    nixosModules.system.services.pipewire = {
      enable = true;
      wireplumber = {
        enable = true;
        # https://pipewire.pages.freedesktop.org/wireplumber/daemon/configuration/alsa.html
        extraConfig = {
          "100-bluetooth"."wireplumber.settings"."bluetooth.autoswitch-to-headset-profile" = false;
          "101-disable-unneeded"."monitor.alsa.rules" = [
            {
              matches = [
                {
                  "alsa.card_name" = "HDA Intel PCH";
                }
              ];
              actions.update-props."node.disabled" = true;
            }
          ];
        };
      };
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
  };
}
