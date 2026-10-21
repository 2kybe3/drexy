{
  perSystem =
    {
      pkgs,
      config,
      inputs',
      ...
    }:
    {
      packages.kymenu-tmux-open = pkgs.writeShellApplication {
        name = "kymenu-tmux-open";

        derivationArgs = {
          strictDeps = true;
          __structuredAttrs = true;
        };

        runtimeInputs = with pkgs; [
          findutils
          gnused
          tmux

          (inputs'.kymenu.packages.default)
        ];

        text = /* bash */ ''
          session=$(tmux list-sessions | sed 's/:.*//' | kymenu)

          if [ -z "$session" ]; then
            exit 1
          fi

          ''${TERMINAL:?\$TERMINAL not set} --command="sh -c \"tmux attach -t $session\""
        '';
      };
    };
}
