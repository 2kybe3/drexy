{
  flake.homeModules.kybe =
    {
      lib,
      pkgs,
      basenix,
      ...
    }:
    let
      nixConfigPath = "~/git/drexy";
    in
    {
      home.shellAliases = {
        lava = "${lib.getExe pkgs.lavat} -g -c ${basenix.stripHash basenix.colors.base00} -k ${basenix.stripHash basenix.colors.base01}";
        clock = "${lib.getExe pkgs.clock-rs} --color \"${basenix.colors.base05}\"";

        nd = "nix develop -c $SHELL";
        flake-update = "nix flake update --flake .";
        switchy = "sudo nixos-rebuild switch --flake ${nixConfigPath}#$(hostname) --verbose";
        collect-garbage = "sudo nix-collect-garbage -d; nix-collect-garbage -d";
      };
    };
}
