{
  perSystem =
    {
      pkgs,
      config,
      inputs',
      ...
    }:
    {
      packages.kymenu-tmux-projects = pkgs.writeShellApplication {
        name = "kymenu-tmux-projects";

        derivationArgs = {
          strictDeps = true;
          __structuredAttrs = true;
        };

        runtimeInputs = with pkgs; [
          tmux
          jq

          (inputs'.kymenu.packages.default)
          (inputs'.kymenu-extras.packages.kymenu-dir)
        ];

        text = /* bash */ ''
          project_dir="''${PROJECTS:-$HOME/git}"
          json=$(jq -n "$(kymenu-dir "$project_dir" --max-depth 1 --file=false)" | kymenu --json-in --json-out)

          if [ -z "$json" ]; then
            exit 1
          fi

          display=$(echo "$json" | jq -r '.display')
          dir=$(echo "$json" | jq -r '.raw')

          if [ -z "$display" ] || [ -z "$dir" ]; then
            exit 1
          fi

          ''${TERMINAL:?\$TERMINAL not set} --command="exec tmux new-session -A -s '$display' -c '$dir'"
        '';
      };
    };
}
