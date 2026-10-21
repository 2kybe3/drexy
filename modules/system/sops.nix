{ inputs, ... }: {
  flake.homeModules.kybe =
    {
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.sops-nix.homeManagerModules.sops
      ];

      home.packages = with pkgs; [
        sops
        age
      ];

      sops.age.keyFile = "/home/kybe/.keys/home-drexy";
    };

  flake.nixosModules.system =
    {
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.sops-nix.nixosModules.sops
      ];

      environment.systemPackages = with pkgs; [
        sops
        age
      ];

      sops.age.keyFile = "/nix/keys/system-drexy";
    };
}
