{
  flake.homeModules.kybe = { config, basenix, ... }: {
    programs.lazygit = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
