{
  flake.homeModules.kybe = { pkgs, ... }: {
    programs.prismlauncher = {
      enable = true;
      package = (
        pkgs.prismlauncher.override {
          jdks = [
            pkgs.jdk21
            pkgs.jdk25
          ];
        }
      );
    };
  };
}
