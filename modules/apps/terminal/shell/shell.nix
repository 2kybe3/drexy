{
  flake.nixosModules.system = { pkgs, ... }: {
    programs.zsh.enable = true;
    users.users.kybe.shell = pkgs.zsh;
  };

  flake.homeModules.kybe =
    {
      basenix,
      config,
      ...
    }:
    {
      programs.zsh = {
        enable = true;
        oh-my-zsh.enable = true;
        enableCompletion = false; # old and broken completions
        dotDir = "${config.xdg.configHome}/zsh";
        initContent = basenix.substitute (builtins.readFile ./zshrc);
        profileExtra = builtins.readFile ./zshrc;
      };
    };
}
