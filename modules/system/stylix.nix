{ inputs, ... }: {
  flake.nixosModules.system = { basenix, pkgs, ... }: {
    imports = [
      inputs.stylix.nixosModules.default
    ];

    stylix = {
      enable = true;
      targets.qt.enable = true;
      base16Scheme = basenix.yaml;
      fonts = {
        monospace = {
          name = "FiraCode Nerd Font";
          package = pkgs.nerd-fonts.fira-code;
        };

        sansSerif = {
          name = "Inter";
          package = pkgs.inter;
        };

        serif = {
          name = "Noto Serif 4";
          package = pkgs.source-serif;
        };

        emoji = {
          name = "Noto Color Emoji";
          package = pkgs.noto-fonts-color-emoji;
        };
      };
    };
  };

  flake.homeModules.kybe = { lib, pkgs, ... }: {
    gtk.enable = true;
    qt.enable = true;
  };
}
