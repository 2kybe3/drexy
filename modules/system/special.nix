# taken from https://github.com/hercules-ci/flake-parts/blob/024633cd702b10285db5cb19b40ad48d2399ba60/modules/perSystem.nix#L106
{
  self,
  config,
  ...
}:
{
  flake.homeModules.kybe = { lib, pkgs, ... }: {
    _module.args = {
      inputs' = lib.mapAttrs (
        inputName: input:
        builtins.addErrorContext
          "while retrieving system-dependent attributes for input ${lib.strings.escapeNixIdentifier inputName}"
          (
            if input._type or null == "flake" then
              config.perInput pkgs.stdenv.hostPlatform.system input
            else
              throw "Trying to retrieve system-dependent attributes for input ${lib.strings.escapeNixIdentifier inputName}, but this input is not a flake. Perhaps flake = false was added to the input declarations by mistake, or you meant to use a different input, or you meant to use plain old inputs, not inputs'."
          )
      ) self.inputs;
      self' = builtins.addErrorContext "while retrieving system-dependent attributes for a flake's own outputs" (
        config.perInput pkgs.stdenv.hostPlatform.system self
      );
    };
  };

  # flake.nixosModules.system =
  #   {
  #     lib,
  #     pkgs,
  #     ...
  #   }:
  #   {
  #     _module.args = {
  #       inputs' = lib.mapAttrs (
  #         inputName: input:
  #         builtins.addErrorContext
  #           "while retrieving system-dependent attributes for input ${lib.strings.escapeNixIdentifier inputName}"
  #           (
  #             if input._type or null == "flake" then
  #               config.perInput pkgs.stdenv.hostPlatform.system input
  #             else
  #               throw "Trying to retrieve system-dependent attributes for input ${lib.strings.escapeNixIdentifier inputName}, but this input is not a flake. Perhaps flake = false was added to the input declarations by mistake, or you meant to use a different input, or you meant to use plain old inputs, not inputs'."
  #           )
  #       ) self.inputs;
  #       self' = builtins.addErrorContext "while retrieving system-dependent attributes for a flake's own outputs" (
  #         config.perInput pkgs.stdenv.hostPlatform.system self
  #       );
  #     };
  #   };
}
