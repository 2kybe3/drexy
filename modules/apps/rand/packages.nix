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
          awscli2
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
