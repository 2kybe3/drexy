{ self, inputs, ... }: {
  flake.nixosConfigurations.drexy =
    let
      system = "x86_64-linux";
    in
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit system;
      };

      modules = [
        self.nixosModules.system
        self.nixosModules.networking
        ./_hardware.nix

        {
          nixpkgs.hostPlatform = system;
          networking.hostName = "drexy";
          system.stateVersion = "26.11";
        }
      ];
    };
}
