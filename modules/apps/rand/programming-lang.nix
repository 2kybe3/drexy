{ inputs, ... }: {
  flake.homeModules.kybe =
    {
      pkgs,
      ...
    }:
    let
      pkgsWithRust = pkgs.extend inputs.rust-overlay.overlays.default;
    in
    {
      home.packages = with pkgsWithRust; [
        #keep-sorted start

        dotnet-sdk
        gcc
        go
        jdk25
        jq
        just
        python3
        rust-bin.nightly.latest.default

        #keep-sorted end
      ];
    };
}
