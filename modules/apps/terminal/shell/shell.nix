{
  flake.nixosModules.system = { pkgs, ... }: {
    programs.zsh.enable = true;
    users.users.kybe.shell = pkgs.zsh;
  };

  flake.homeModules.kybe =
    {
      pkgs,
      basenix,
      config,
      ...
    }:
    {
      programs.zsh = {
        enable = true;
        oh-my-zsh.enable = true;
        dotDir = "${config.xdg.configHome}/zsh";
        initContent = basenix.substitute (builtins.readFile ./zshrc);
        profileExtra = builtins.readFile ./zshrc;
      };
    };
}
