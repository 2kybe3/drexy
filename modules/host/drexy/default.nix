{ self, inputs, ... }: {
  flake.nixosConfigurations.drexy = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.system
      self.nixosModules.networking
      ./_hardware.nix

      {
        networking.hostName = "drexy";
        system.stateVersion = "26.11";
      }
    ];
  };
}
