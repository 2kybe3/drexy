{ secrets, ... }: {
  flake.homeModules.kybe =
    {
      lib,
      pkgs,
      kylib,
      config,
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
            overrides = with kylib.colors; {
              # BG
              idle_bg = main;
              alternating_tint_bg = main_alt;

              good_bg = selected;
              info_bg = selected;
              warning_bg = selected;

              # FG
              idle_fg = text;
              alternating_tint_fg = text;

              good_fg = text;
              info_fg = text;
              warning_fg = text;
            };
          };
        };
      };
    };
}
