{
  flake.nixosModules.system =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      nix = {
        enable = true;
        channel.enable = false;
        registry = {
          n.to = config.nix.registry.nixpkgs.to;
          # nus.to = {
          #   type = "path";
          #   path = inputs.nixpkgs-unstable-small;
          # };
        };
        settings = {
          warn-dirty = false;
          auto-optimise-store = true;
          experimental-features = [
            "pipe-operators"
            "nix-command"
            "flakes"
          ];
          substituters = [ "https://attic.kybe.xyz/main" ];
          trusted-public-keys = [ "main:cb7V485kGP0lG7LtQ/suOgKOgtVxNXrnD6i5yCtnaMQ=" ];
          trusted-substituters = [ "https://attic.kybe.xyz/main" ];
          trusted-users = [
            "root"
            "@wheel"
          ];
          use-xdg-base-directories = true;
        };
        gc.automatic = true;
      };

      environment.systemPackages = with pkgs; [
        nix-output-monitor
        attic-client
        nix-update
      ];
    };
}
