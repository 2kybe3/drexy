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
        # disabled by default due too issues with non nixos distros
        targets.qt.enable = true;
        base16Scheme = basenix.full;
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
        cursor = {
          name = "DMZ-Black";
          package = pkgs.vanilla-dmz;
          size = 12;
        };
      };
    };

  flake.homeModules.kybe = { lib, pkgs, ... }: {
    gtk.enable = true;
    qt.enable = true;
  };
}
