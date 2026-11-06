{ self, inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.stylix-patched = pkgs.applyPatches {
      name = "stylix-patched";
      src = inputs.stylix;
      patches = [
        ./patches/gtk.diff
        ./patches/qt.diff
      ];
    };
  };

  flake.nixosModules.system =
    {
      pkgs,
      system,
      basenix,
      ...
    }:
    {
      imports = [
        (import self.packages.${system}.stylix-patched).nixosModules.stylix
      ];

      stylix = {
        enable = true;
        base16Scheme = basenix.full;

        # disabled by default due too issues with non nixos distros
        targets.qt.enable = true;

        cursor = {
          name = "DMZ-Black";
          package = pkgs.vanilla-dmz;
          size = 12;
        };

        fonts = {
          monospace = {
            name = "FiraCode Nerd Font Mono";
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

  flake.homeModules.kybe = { pkgs, ... }: {
    stylix.targets.gtk.extraCss = ''
      window.background { border-radius: 0; }
    '';

    gtk.enable = true;
    qt.enable = true;

    home.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif

      nerd-fonts.code-new-roman

      corefonts
    ];

    fonts.fontconfig = {
      enable = true;
      antialiasing = true;
    };
  };
}
