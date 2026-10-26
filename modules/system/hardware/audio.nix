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
          "102-default-settings"."wireplumber.settings" = {
            "device.routes.default-source-volume" = 0.0;

            "device.routes.mute-on-alsa-playback-removed" = true;
            "device.routes.mute-on-bluetooth-playback-removed" = true;

            "bluetooth.autoswitch-to-headset-profile" = false;
          };
        };
      };
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
  };
}
