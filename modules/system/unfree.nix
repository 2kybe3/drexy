{
  flake.nixosModules.system =
    {
      lib,
      pkgs,
      ...
    }:
    {
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "nvidia-x11"

          "steam-unwrapped"
          "steam"
        ];
    };
}
