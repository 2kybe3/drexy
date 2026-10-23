{
  flake.homeModules.kybe =
    {
      pkgs,
      config,
      ...
    }:
    {
      # TODO: remove when home-manager updates there path (lbirewolf for some reason ignores ~/.librewolf/librewolf.overrides.cfg)
      home.file.".config/librewolf/librewolf/librewolf.overrides.cfg".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.librewolf/librewolf.overrides.cfg";

      stylix.targets.librewolf = {
        enable = true;
        profileNames = [ "main" ];
        colorTheme.enable = true;
      };

      programs.librewolf = {
        enable = true;

        nativeMessagingHosts = [
          pkgs.keepassxc
        ];

        languagePacks = [
          "de"
          "en-US"
        ];

        profiles.main = {
          isDefault = true;
          extensions = {
            force = true;
            settings = {
              "*".settings.installation_mode = "blocked";
              "addon@darkreader.org".settings = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
                installation_mode = "force_installed";
              };
              "uBlock0@raymondhill.net".settings = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                installation_mode = "force_installed";
              };
              "jid1-MnnxcxisBPnSXQ@jetpack".settings = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
                installation_mode = "force_installed";
              };
              "keepassxc-browser@keepassxc.org".settings = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
                installation_mode = "force_installed";
              };
              "@testpilot-containers".settings = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
                installation_mode = "force_installed";
              };
            };
          };
          search = {
            force = true;
            default = "ddg";
            engines = {
              "MyNixOS" = {
                definedAliases = [ "@nix" ];
                urls = [ { template = "https://mynixos.com/search?q={searchTerms}"; } ];
              };
              "NixMerge" = {
                definedAliases = [ "@nm" ];
                urls = [ { template = "https://nixpk.gs/pr-tracker.html?pr={searchTerms}"; } ];
              };
              "HydraPackage" = {
                definedAliases = [ "@hp" ];
                urls = [
                  { template = "https://hydra.nixos.org/job/nixpkgs/unstable/{searchTerms}.x86_64-linux"; }
                ];
              };
              "Youtube Music" = {
                definedAliases = [ "@ym" ];
                urls = [ { template = "https://music.youtube.com/search?q={searchTerms}"; } ];
              };
              "Youtube" = {
                definedAliases = [ "@yt" ];
                urls = [ { template = "https://www.youtube.com/results?search_query={searchTerms}"; } ];
              };
            };
          };
        };

        policies = {
          DisplayBookmarksToolbar = "newtab";

          SearchEngines = {
            PreventInstalls = true;
            Remove = [
              "Mojeek"
              "Startpage"
              "Wikipedia (en)"
            ];
          };
        };

        settings = {
          # anti fingerprinting
          "privacy.fingerprintingProtection" = true;
          "privacy.resistFingerprinting.letterboxing" = true;

          "geo.enabled" = false;
          "dom.battery.enabled" = false;

          # disable autoplay
          "media.autoplay.blocking_policy" = 2;

          # WebGL
          "librewolf.webgl.prompt" = true;

          # theme plugin
          "xpinstall.signatures.required" = false;
        };
      };
    };
}
