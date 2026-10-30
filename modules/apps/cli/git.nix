{
  flake.homeModules.kybe = { pkgs, ... }: {
    home = {
      packages = with pkgs; [ delta ];
      shellAliases.g = "git";
    };

    programs.git = {
      enable = true;
      lfs.enable = true;
      signing = {
        signByDefault = true;
        key = "A96D0830396F4327";
      };
      settings = {
        interactive.diffFilter = "delta --color-only";
        merge.conflictStyle = "zdiff3";
        push.autoSetupRemote = true;
        init.defaultBranch = "main";
        core.pager = "delta";
        pull.rebase = true;
        delta = {
          line-numbers = true;
          navigate = true;
          dark = true;
        };
        user = {
          name = "2kybe3";
          email = "kybe@kybe.xyz";
        };
        alias = {
          a = "add";
          aa = "add .";
          p = "push";
          ra = "remote add";
          rh = "reset --hard";
          rs = "reset --soft";
          gdc = "diff --cached";
        };
      };
    };
  };
}
