{
  lib,
  utils,
  config,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    kernelModules = [ "kvm-intel" ];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ata_generic"
        "ehci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];

      systemd.services.wipe-root = {
        unitConfig.DefaultDependencies = false;
        serviceConfig.Type = "oneshot";
        wantedBy = [ "initrd.target" ];
        before = [ "sysroot.mount" ];

        requires = [ "${utils.escapeSystemdPath "/dev/mapper/crypted"}.device" ];
        after = [
          "${utils.escapeSystemdPath "/dev/mapper/crypted"}.device"
          "local-fs-pre.target"
        ];

        script = /* bash */ ''
          mkdir /btrfs_tmp
          mount -t btrfs -o subvolid=5 /dev/mapper/crypted /btrfs_tmp
          trap 'umount /btrfs_tmp' EXIT

          if [[ -e /btrfs_tmp/@ ]]; then
            mkdir -p /btrfs_tmp/@old_roots
            timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/@)" "+%Y-%m-%-d_%H:%M:%S")
            mv /btrfs_tmp/@ "/btrfs_tmp/@old_roots/$timestamp"
          fi

          if [[ -d /btrfs_tmp/@old_roots ]]; then
            for i in $(find /btrfs_tmp/@old_roots -mindepth 1 -maxdepth 1 -mtime +30); do
              btrfs subvolume delete --recursive "$i"
            done
          fi

          btrfs subvolume create /btrfs_tmp/@
        '';
      };
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
