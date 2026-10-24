{
  flake = {
    homeModules.kybe = { pkgs, ... }: {
      home.packages = with pkgs; [
        playerctl
        qpwgraph
      ];
    };

    nixosModules.system.services.pipewire = {
      enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}
