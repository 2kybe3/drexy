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

          "steam-unwrapped"
          "steam"

          "obsidian"
        ];
    };
}
