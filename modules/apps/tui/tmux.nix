{
  flake.homeModules.kybe =
    {
      lib,
      ...
    }:
    {
      programs.tmux = {
        enable = true;
        extraConfig = /* bash */ ''
          # remap prefix from 'C-b' to 'C-a'
          unbind C-b
          set-option -g prefix C-a
          bind-key C-a send-prefix

          # remove split command
          unbind '"'
          unbind %

          bind-key E kill-session

          set -g mouse off
          set -g mode-keys vi

          set -g history-limit 50000

          # Start windows and panes at 1, not 0
          set -g base-index 1
          setw -g pane-base-index 1

          # Set terminal with proper colors
          set -g status-style bg=default
          set -g status-justify centre

          # new window should have the current path
          bind c new-window -c "#{pane_current_path}"
        '';
      };

    };
}
