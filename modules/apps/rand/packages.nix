{
  flake.homeModules.kybe =
    {
      pkgs,
      self',
      ...
    }:
    {
      home.packages =
        with pkgs;
        [
          # keep-sorted start

          calc
          cryptsetup
          ffmpeg
          gimp
          jdk25
          jq
          just

          # keep-sorted end
        ]
        ++ (with self'.packages; [
          # keep-sorted start

          git-local-only
          greenfoot
          rotate
          status-code
          tetro-tui

          # keep-sorted end
        ]);
    };
}
