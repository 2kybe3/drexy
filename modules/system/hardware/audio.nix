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
        # https://pipewire.pages.freedesktop.org/wireplumber/
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

          "102-device-profiles"."monitor.bluez.rules" = [
            {
              matches = [
                {
                  "api.bluez5.address" = "2C:BE:EE:4A:5B:32";
                }
              ];
              actions.update-props = {
                "api.bluez5.codec" = "ldac";
                "api.bluez5.profile" = "a2dp-sink";
              };
            }
          ];

          "103-default-settings"."wireplumber.settings" = {
            "device.routes.default-source-volume" = 0.0;

            "device.routes.mute-on-alsa-playback-removed" = true;
            "device.routes.mute-on-bluetooth-playback-removed" = true;

            "bluetooth.use-persistent-storage" = false;
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
