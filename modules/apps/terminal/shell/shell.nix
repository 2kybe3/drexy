{
  flake.nixosModules.system = { pkgs, ... }: {
    programs.zsh.enable = true;
    users.users.kybe.shell = pkgs.zsh;
  };

  flake.homeModules.kybe =
    {
      pkgs,
      kylib,
      config,
      ...
    }:
    {
      programs.zsh = {
        enable = true;
        oh-my-zsh.enable = true;
        dotDir = "${config.xdg.configHome}/zsh";
        initContent = kylib.colors.lib.substitute (builtins.readFile ./zshrc);
        profileExtra = builtins.readFile ./zshrc;
      };
    };
}
