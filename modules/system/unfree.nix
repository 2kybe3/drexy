{
  flake.nixosModules.system =
    {
      lib,
      ...
    }:
    {
      nixpkgs.config.allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "nvidia-kernel-modules"
          "nvidia-settings"
          "nvidia-x11"

          "intellij-idea"

          "steam-unwrapped"
          "steam"

          "obsidian"

          "corefonts"
        ];
    };
}
