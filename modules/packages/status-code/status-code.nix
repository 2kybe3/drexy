{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.status-code = pkgs.writeShellApplication {
        name = "status-code";

        runtimeInputs = with pkgs; [
          python3
          duckdb
        ];

        text = builtins.readFile ./status-code.sh;
      };
    };
}
