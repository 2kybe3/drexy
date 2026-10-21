{
  flake.nixosModules.system = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      pinentry-qt
    ];

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-qt;
    };
  };
}
