{
  flake.homeModules.kybe = { pkgs, ... }: {
    home.packages = [ pkgs.nerd-fonts.fira-code ];
    gtk = {
      enable = true;
      colorScheme = "dark";
      font.name = "FiraCode Nerd Font";
    };
  };
}
