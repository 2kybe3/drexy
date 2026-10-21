{
  flake.homeModules.kybe =
    {
      lib,
      pkgs,
      kylib,
      ...
    }:
    let
      headPhones = "2C:BE:EE:4A:5B:32";
      nixConfigPath = "~/git/drexy";
    in
    {
      home.shellAliases = {
        ls = "${lib.getExe pkgs.eza}";

        ears = "bluetoothctl connect ${headPhones}";

        lava = "${lib.getExe pkgs.lavat} -g -c ${kylib.colors.lib.stripHash kylib.colors.main} -k ${kylib.colors.lib.stripHash kylib.colors.main_alt}";
        clock = "${lib.getExe pkgs.clock-rs} --color \"${kylib.colors.bright}\"";

        tm = "tmux new-session -A -s main";
        tmc = "tmux new-session -A -s ";

        collect-garbage = "sudo nix-collect-garbage -d; nix-collect-garbage -d";

        flake-update = "nix flake update --flake .";
        switchy = "sudo nixos-rebuild switch --flake ${nixConfigPath}#$(hostname) --verbose";
      };
    };
}
