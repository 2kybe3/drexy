{
  flake.homeModules.kybe.programs.direnv = {
    enable = true;
    silent = true;
    enableZshIntegration = true;
    enableGitIntegration = true;
    nix-direnv.enable = true;
  };
}
