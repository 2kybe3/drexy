{
  flake.homeModules.kybe = { pkgs, ... }: {
    programs.prismlauncher = {
      enable = true;
      package =
        with pkgs;
        (prismlauncher.override {
          jdks = [
            jdk21
            jdk25
          ];
        });
    };
  };
}
