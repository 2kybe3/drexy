{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.yt-dlp = pkgs.yt-dlp.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          ./librewolf-fix-cookie-detection.patch
        ];
      });
    };
}
