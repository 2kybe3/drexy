{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.yt-dlp = pkgs.yt-dlp.overrideAttrs (old: rec {
        version = "2026.11.23";
        src = pkgs.fetchFromGitHub {
          owner = "yt-dlp";
          repo = "yt-dlp";
          tag = version;
          hash = "sha256-BpxnzY9GOs9sTv/ZWAwYiiJS7VfaMtp5HHOtXDAGgc0=";
        };
        patches = (old.patches or [ ]) ++ [
          ./librewolf-fix-cookie-detection.patch
        ];
      });
    };
}
