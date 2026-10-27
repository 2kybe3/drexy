{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.git-local-only = pkgs.writeShellApplication {
        name = "git-local-only";

        runtimeInputs = with pkgs; [
          git
        ];

        text = builtins.readFile ./git-local-only.sh;
      };
    };
}
