{ secrets, ... }: {
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.i3status-rust = pkgs.i3status-rust.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          ./patches/hide-non-available-audio-devices.diff
        ];
      });
    };

  flake.homeModules.kybe =
    {
      lib,
      pkgs,
      self',
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
        package =
          let
            i3status-rust = self'.packages.i3status-rust;
          in
          pkgs.symlinkJoin {
            inherit (i3status-rust) pname version meta;

            paths = [ i3status-rust ];

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
              format = " $barchart ";
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
              format = " $name {$percentage |}";
              inherit mac;
            }
            {
              block = "sound";
              driver = "pipewire";
              name = "bluez_input.2C_BE_EE_4A_5B_32.0";
              format = " I {$volume.eng(w:2) |MUTE }";
            }
            {
              block = "sound";
              driver = "pipewire";
              device_kind = "sink";
              format = " S {$volume.eng(w:2) |MUTE }";
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
              idle_fg = base05;

              info_bg = base00;
              info_fg = base0D;

              good_bg = base00;
              good_fg = base0B;

              warning_bg = base00;
              warning_fg = base0F;

              critical_bg = base00;
              critical_fg = base08;

              alternating_tint_bg = base01;
              # none so the fg doesn't get added which ends up being pure white
              alternating_tint_fg = "none";
            };
          };
        };
      };
    };
}
