{ lib, ... }:
let
  colors = {
    main = "#0A1026";
    main_alt = "#0E1631";

    selected = "#0f183b";
    bright = "#243885";

    outline = "#77767b";

    text = "#FFFFFF";
    text_alt = "#61708b";

    red = "#e01b24";
  };

  hexToDec = hexStr: offset: toString (lib.fromHexString (builtins.substring offset 2 hexStr));

  colorPairs = lib.mapAttrsToList (name: hex: {
    inherit name hex;
    r = hexToDec hex 1;
    g = hexToDec hex 3;
    b = hexToDec hex 5;
  }) colors;

  patterns = lib.concatMap (c: [
    "@${c.name}@"
    "@${c.name}_r@"
    "@${c.name}_g@"
    "@${c.name}_b@"
  ]) colorPairs;

  values = lib.concatMap (c: [
    c.hex
    c.r
    c.g
    c.b
  ]) colorPairs;
in
colors
// {
  lib = {
    stripHash = color: builtins.substring 1 6 color;
    substitute = str: builtins.replaceStrings patterns values str;
  };
}
