{
  flake.nixosModules.system = { pkgs, ... }: {
    services = {
      printing.enable = true;
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };
    hardware.printers = {
      ensurePrinters = [
        {
          name = "main";
          location = "Home";
          deviceUri = "ipp://192.168.2.170/ipp/print";
          model = "everywhere";
          ppdOptions.PageSize = "A4";
        }
      ];
      ensureDefaultPrinter = "main";
    };
  };
}
