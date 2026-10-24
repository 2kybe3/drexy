{
  flake.homeModules.kybe =
    {
      lib,
      pkgs,
      self',
      config,
      inputs',
      basenix,
      ...
    }:
    let
      modifier = "Mod4"; # Super Key
    in
    {
      home.sessionVariables = {
        GTK_IM_MODULE = "gtk-im-context-simple";
        SWAY_UNSUPPORTED_GPU = "true";
        _JAVA_AWT_WM_NONREPARENTING = "1";
      };

      wayland.windowManager.sway = {
        enable = true;
        package = pkgs.swayfx;

        checkConfig = false;

        extraConfig = with basenix.colors; ''
          blur enable
          blur_xray disable
          blur_passes 3
          blur_radius 3

          default_dim_inactive 0.4

          smart_gaps on

          gaps outer 2
          gaps inner 2

          smart_borders on

          default_border pixel 1
          default_floating_border pixel 1

          client.focused_inactive ${base05} ${base02} ${base05}
          client.unfocused ${base05} ${base02} ${base05}
          client.focused ${base05} ${base05} ${base05}

          seat * hide_cursor 3000
        '';

        config = {
          inherit modifier;

          output.HDMI-A-1 = {
            mode = "1920x1080@75Hz";
            bg = "${./wallpapers/creation.png} fill";
          };

          defaultWorkspace = "workspace number 3";

          input."type:keyboard" = {
            repeat_delay = "300";
            repeat_rate = "40";
            xkb_layout = "us";
            xkb_options = "compose:caps";
          };

          window.titlebar = false;

          # TODO: stuff
          keybindings = {
            "${modifier}+p" = "exec ${lib.getExe self'.packages.kymenu-tmux-projects}";
            "${modifier}+Shift+p" = "exec ${lib.getExe self'.packages.kymenu-tmux-open}";

            "${modifier}+d" = "exec ${lib.getExe (inputs'.kymenu.packages.default)} --path-launcher";
            "${modifier}+Return" = "exec ${config.home.sessionVariables.TERMINAL}";

            # SS (Simple)
            "${modifier}+o" = "exec ${lib.getExe pkgs.grim} -g \"$(${lib.getExe pkgs.slurp})\" - | wl-copy";
            # SS (Swappy)
            "${modifier}+Shift+o" =
              "exec ${lib.getExe pkgs.grim} -g \"$(${lib.getExe pkgs.slurp})\" - | ${lib.getExe pkgs.swappy} -f - -o - | wl-copy";

            "${modifier}+Shift+b" = "exec ${lib.getExe pkgs.swaylock}";

            "${modifier}+Shift+e" = "exec swaymsg exit";

            "${modifier}+r" = "mode \"resize\"";
            "${modifier}+Shift+q" = "kill";

            "${modifier}+Shift+space" = "floating toggle";
            "${modifier}+f" = "fullscreen toggle";

            "${modifier}+v" = "split v";
            "${modifier}+c" = "split h";

            "${modifier}+h" = "focus left";
            "${modifier}+j" = "focus down";
            "${modifier}+k" = "focus up";
            "${modifier}+l" = "focus right";

            "${modifier}+Shift+h" = "move left";
            "${modifier}+Shift+j" = "move down";
            "${modifier}+Shift+k" = "move up";
            "${modifier}+Shift+l" = "move right";

            "${modifier}+1" = "workspace number 1";
            "${modifier}+2" = "workspace number 2";
            "${modifier}+3" = "workspace number 3";
            "${modifier}+4" = "workspace number 4";
            "${modifier}+5" = "workspace number 5";
            "${modifier}+6" = "workspace number 6";
            "${modifier}+7" = "workspace number 7";
            "${modifier}+8" = "workspace number 8";
            "${modifier}+9" = "workspace number 9";
            "${modifier}+0" = "workspace number 10";

            "${modifier}+Shift+1" = "move container to workspace number 1";
            "${modifier}+Shift+2" = "move container to workspace number 2";
            "${modifier}+Shift+3" = "move container to workspace number 3";
            "${modifier}+Shift+4" = "move container to workspace number 4";
            "${modifier}+Shift+5" = "move container to workspace number 5";
            "${modifier}+Shift+6" = "move container to workspace number 6";
            "${modifier}+Shift+7" = "move container to workspace number 7";
            "${modifier}+Shift+8" = "move container to workspace number 8";
            "${modifier}+Shift+9" = "move container to workspace number 9";
            "${modifier}+Shift+0" = "move container to workspace number 10";
          };
        };
      };
    };
}
