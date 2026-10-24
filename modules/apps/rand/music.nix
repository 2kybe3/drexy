{
  flake.homeModules.kybe =
    {

      pkgs,
      ...
    }:
    {
      home.packages = [
        pkgs.supersonic
      ];

      services = {
        mpd-mpris.enable = true;
        mpd = {
          enable = true;
          network.startWhenNeeded = true;
          extraConfig = ''
            audio_output {
              type "pulse"
              name "PulseAudio"
            }
          '';
        };
      };
    };
}
