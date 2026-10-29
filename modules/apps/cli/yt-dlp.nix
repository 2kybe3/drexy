{
  flake.homeModules.kybe =
    {
      lib,
      pkgs,
      self',
      config,
      ...
    }:
    let
      librewolfVersion = lib.concatStringsSep "." (
        lib.take 2 (lib.splitString "." pkgs.librewolf.version)
      );
    in
    {
      home.packages = [
        self'.packages.yt-audio
        self'.packages.yt-playlist
      ];

      programs.yt-dlp = {
        enable = true;
        package = self'.packages.yt-dlp;
        settings = {
          downloader = "${lib.getExe pkgs.aria2}";
          downloader-args = "aria2c:'-c -x16 -s16'";
          cookies-from-browser = "firefox";
        };

        extraConfig = ''
          --user-agent "Mozilla/5.0 (X11; Linux x86_64; rv:${librewolfVersion}) Gecko/20100101 Firefox/${librewolfVersion}"
        '';
      };
    };
}
