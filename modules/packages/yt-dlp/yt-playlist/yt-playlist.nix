{
  perSystem = { self', pkgs, ... }: {
    packages.yt-playlist = pkgs.writeShellApplication {
      name = "yt-playlist";
      runtimeInputs = [
        pkgs.findutils
        self'.packages.yt-dlp
        self'.packages.yt-audio
      ];
      text = /* bash */ ''
        yt-dlp "$1" --print url --flat-playlist | xargs -P 24 -I{} bash -c 'yt-audio "$@"' _ {} "''${@:2}"
      '';
    };
  };
}
