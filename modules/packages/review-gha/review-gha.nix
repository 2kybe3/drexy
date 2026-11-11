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
              echo "Usage: review-gha <pr-number> <action>"
              exit 1
            fi

            if [ -z "$2" ]; then
              echo "Error: Missing on-success action"
              echo "Usage: review-gha <pr-number> <action>"
              echo "Possible Values: nothing/mark_as_ready/approve/merge"
            fi

            # GitHub likes to disable the workflow randomly
            gh workflow enable --repo "${repo}" review || true
            gh workflow run --repo "${repo}" review -f "pr=$1" -f "on-success=$2"
          '';
        }
      ) { };
    };
}
