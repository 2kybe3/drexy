{
  perSystem = { self', pkgs, ... }: {
    packages.yt-audio = pkgs.writeShellApplication {
      name = "yt-audio";
      runtimeInputs = [ self'.packages.yt-dlp ];
      text = /* bash */ ''
        yt-dlp \
          --extract-audio \
          --audio-format mp3 \
          --audio-quality 0 \
          --format bestaudio \
          --embed-metadata \
          --embed-thumbnail \
          --output "%(title)s - %(artist)s - %(album)s.%(ext)s" \
          --paths "$HOME/Music" \
          "$@"
      '';
    };
  };
}
