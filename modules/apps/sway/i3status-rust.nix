{ secrets, ... }: {
  flake.homeModules.kybe =
    {
      lib,
      pkgs,
      config,
      basenix,
      ...
    }:
    let
      #  busctl --user list | grep "org.mpris.MediaPlayer2." | cut -d' ' -f1
      musicPlayers = [
        "firefox"
        "Supersonic"
      ];
      mac = "2C:BE:EE:4A:5B:32";
    in
    {
      sops.secrets.i3status-github-notifications.sopsFile = "${secrets}/home/i3status-rust/github-notifications.yaml";

      wayland.windowManager.sway.config.bars = [
        {
          position = "top";
          workspaceButtons = false;
          workspaceNumbers = false;
          statusCommand = "${lib.getExe config.programs.i3status-rust.package} config-default.toml";
          trayOutput = "none";

          fonts = {
            names = [ "monospace" ];
            size = 8.0;
          };

          colors.background = "#000000";
        }
      ];

      programs.i3status-rust = {
        enable = true;
        package = pkgs.symlinkJoin {
          inherit (pkgs.i3status-rust) pname version meta;

          paths = [ pkgs.i3status-rust ];

          buildInputs = [ pkgs.makeWrapper ];

          postBuild = ''
            wrapProgram $out/bin/i3status-rs \
              --run 'export I3RS_GITHUB_TOKEN="$(cat ${config.sops.secrets.i3status-github-notifications.path})"'
          '';
        };

        bars.default = {
          blocks = [
            {
              block = "cpu";
              format = " $barchart";
              interval = 1;
            }
            {
              block = "memory";
              format = " $mem_used.eng(prefix:Mi)/$mem_total.eng(prefix:Mi) ";
              interval = 1;
            }
          ]
          ++ (map (source: {
            block = "music";
            player = source;
            format = "{ $play $combo.str(max_w:25,rot_interval:0.1) |}";
          }) musicPlayers)
          ++ [
            {
              block = "bluetooth";
              format = " $name{ $percentage|} ";
              inherit mac;
            }
            {
              block = "sound";
              format = "{ $volume.eng(w:2) | MUTE }";
            }
            {
              block = "time";
              format = " $timestamp.datetime(f:'%H:%M %d.%m') ";
              interval = 1;
            }
            {
              block = "github";
              hide_if_total_is_zero = true;
            }
          ];
          icons = "awesome6";
          settings.theme = {
            theme = "bad-wolf";
            overrides = with basenix.colors; {
              # BG
              idle_bg = base00;
              alternating_tint_bg = base01;

              good_bg = base0B;
              info_bg = base0D;
              warning_bg = base0F;

              # FG
              alternating_tint_fg = base05;
              good_fg = base05;
              idle_fg = base05;
              info_fg = base05;
              warning_fg = base05;
            };
          };
        };
      };
    };
}
