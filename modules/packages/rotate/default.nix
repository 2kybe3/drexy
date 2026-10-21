{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.rotate = pkgs.writeShellApplication {
        name = "rotate";

        runtimeInputs = with pkgs; [
          ffmpeg
        ];

        text = builtins.readFile ./script.sh;
      };
    };
}
