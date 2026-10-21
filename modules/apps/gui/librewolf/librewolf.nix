{
  flake.homeModules.kybe =
    {
      pkgs,
      self',
      config,
      ...
    }:
    {
      programs.librewolf = {
        enable = true;
        package = pkgs.librewolf;

        nativeMessagingHosts = [
          pkgs.keepassxc
        ];

        languagePacks = [
          "de"
          "en-US"
        ];

        policies = {
          DisplayBookmarksToolbar = "newtab";

          ExtensionSettings = {
            "*".installation_mode = "blocked";
            "kybe@kybe.xyz" = {
              install_url = "file:${self'.packages.firefox-theme}/theme.xpi";
              installation_mode = "force_installed";
            };
            "addon@darkreader.org" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
              installation_mode = "force_installed";
            };
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
            };
            "jid1-MnnxcxisBPnSXQ@jetpack" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
              installation_mode = "force_installed";
            };
            "keepassxc-browser@keepassxc.org" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
              installation_mode = "force_installed";
            };
            "@testpilot-containers" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
              installation_mode = "force_installed";
            };
          };

          SearchEngines = {
            PreventInstalls = true;
            Default = "DuckDuckGo No-AI";
            Add = [
              {
                Alias = "@nix";
                Description = "Search MyNixOS";
                IconURL = "https://nixos.org/favicon.ico";
                Method = "GET";
                Name = "MyNixOS";
                URLTemplate = "https://mynixos.com/search?q={searchTerms}";
              }
              {
                Alias = "@nm";
                Description = "Search Nix Merge";
                Method = "GET";
                Name = "NixMerge";
                URLTemplate = "https://nixpk.gs/pr-tracker.html?pr={searchTerms}";
              }
              {
                Alias = "@hp";
                Description = "Search Hydra Package";
                Method = "GET";
                Name = "HydraPackage";
                URLTemplate = "https://hydra.nixos.org/job/nixpkgs/unstable/{searchTerms}.x86_64-linux";
              }
              {
                Alias = "@ym";
                Description = "Search Youtube Music";
                IconURL = "https://music.youtube.com/favicon.ico";
                Method = "GET";
                Name = "Youtube Music";
                URLTemplate = "https://music.youtube.com/search?q={searchTerms}";
              }
              {
                Alias = "@yt";
                Description = "Search YouTube";
                IconURL = "https://www.youtube.com/favicon.ico";
                Method = "GET";
                Name = "Youtube";
                URLTemplate = "https://www.youtube.com/results?search_query={searchTerms}";
              }
            ];
            Remove = [
              "Mojeek"
              "Startpage"
            ];
          };
        };

        settings = {
          "media.autoplay.blocking_policy" = 2;

          "privacy.fingerprintingProtection" = true;
          "privacy.resistFingerprinting.letterboxing" = true;

          "network.cookie.lifetimePolicy" = 0;

          "geo.enabled" = false;
          "dom.battery.enabled" = false;

          "xpinstall.signatures.required" = false;
        };
      };
    };
}
