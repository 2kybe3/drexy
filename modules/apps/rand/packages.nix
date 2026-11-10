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

          ansifilter
          calc
          cryptsetup
          ffmpeg
          gh
          gimp

          # keep-sorted end
        ]
        ++ (with self'.packages; [
          # keep-sorted start

          git-local-only
          greenfoot
          review-gha
          rotate
          status-code
          tetro-tui

          # keep-sorted end
        ]);
    };
}
