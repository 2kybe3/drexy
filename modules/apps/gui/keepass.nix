{
  flake.homeModules.kybe = { pkgs, config, ... }: {
    programs.keepassxc = {
      enable = true;
      settings = {
        General.LastActiveDatabase = "${config.home.homeDirectory}/.syncthing/keepass/vault.kdbx";
        SSHAgent.Enabled = true;

        Browser = {
          Enabled = true;
          UpdateBinaryPath = false;
        };

        Security = {
          LockDatabaseIdle = false;
          IconDownloadFallback = true;
        };

        GUI = {
          AdvancedSettings = true;
          ApplicationTheme = "dark";
          CompactMode = true;
          HidePasswords = true;
        };
      };
    };
  };
}
