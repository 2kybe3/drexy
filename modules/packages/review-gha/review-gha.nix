{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.review-gha = pkgs.lib.makeOverridable (
        {
          repo ? "kybe236/nixpkgs-review-gha",
        }:
        pkgs.writeShellApplication {
          name = "review-gha";

          runtimeInputs = with pkgs; [
            gh
          ];

          text = /* bash */ ''
            if [ -z "$1" ]; then
              echo "Error: Missing PR number."
              echo "Usage: review-gha <pr-number>"
              exit 1
            fi

            gh workflow run --repo "${repo}" review -f "pr=$1" -f "on-success=approve"
          '';
        }
      ) { };
    };
}
