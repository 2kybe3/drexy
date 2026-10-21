{
  flake.nixosModules.system = { pkgs, ... }: {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    environment.systemPackages = with pkgs; [
      playerctl
      qpwgraph
    ];
  };
}
