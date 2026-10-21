{
  flake.homeModules.kybe =
    {

      pkgs,
      config,
      secrets,
      ...
    }:
    {
      home.packages = with pkgs; [
        supersonic
      ];

      services = {
        mpd-mpris.enable = true;
        mpd = {
          enable = true;
          network = {
            listenAddress = "any";
            startWhenNeeded = true;
          };
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
