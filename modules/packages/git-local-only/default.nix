{
  perSystem =
    {
      pkgs,
      config,
      inputs',
      ...
    }:
    {
      packages.git-local-only = pkgs.writeShellApplication {
        name = "git-local-only";

        runtimeInputs = with pkgs; [
          git
        ];

        text = builtins.readFile ./script.sh;
      };
    };
}
