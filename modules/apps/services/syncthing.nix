# 127.0.0.1:8384
{ secrets, ... }: {
  flake.homeModules.kybe =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      syncthingDir = "${config.home.homeDirectory}/.syncthing";

      knxDevice = "knx";
      phoneDevice = "phone";
      serverDevice = "server";

      allDevices = [
        knxDevice
        phoneDevice
        serverDevice
      ];

      base = {
        devices = allDevices;
      };

      folderDefs = {
        "phone/documents" = {
          id = "nbrf9-2w4wy";
          path = "phone/Documents";
        };
        "phone/dcim" = {
          id = "d7tbq-371tj";
          path = "phone/dcim";
        };
        "phone/pictures" = {
          id = "labpe-fxw3q";
          path = "phone/pictures";
        };
        "obsidian" = {
          id = "8amt5-szr4c";
          path = "obsidian";
        };
        "documents" = {
          id = "gqe7d-gqjr2";
          path = "documents";
        };
        "keepass" = {
          id = "zepjc-kbxe4";
          path = "keepass";
          versioning = {
            type = "staggered";
            params.maxAge = toString (60 * 60 * 24 * 7); # 7 days
          };
        };
      };
    in
    {
      sops.secrets = {
        syncthing-pass.sopsFile = "${secrets}/home/syncthing/syncthing.yaml";
        syncthing-key = {
          sopsFile = "${secrets}/home/syncthing/keys/key.pem";
          format = "binary";
        };
        syncthing-cert = {
          sopsFile = "${secrets}/home/syncthing/keys/cert.pem";
          format = "binary";
        };
      };

      home.file."Documents".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.syncthing/documents";

      services.syncthing = {
        enable = true;

        overrideDevices = true;
        overrideFolders = true;

        guiCredentials = {
          username = "kybe";
          passwordFile = config.sops.secrets.syncthing-pass.path;
        };

        cert = config.sops.secrets.syncthing-cert.path;
        key = config.sops.secrets.syncthing-key.path;

        settings = {
          gui = {
            theme = "black";
          };
          options = {
            urAccepted = -1;
            localAccounceEnabled = false;
            relaysEnabled = true;
          };
          devices = {
            ${serverDevice} = {
              id = "X2TZ44D-O26DTNM-WRPIFJP-M75HMBQ-3WH4KLQ-COS7E3P-FE2MJAR-WU2N6AH";
              introducer = true;
            };
            ${knxDevice} = {
              id = "PPZGUI7-QHAZ6O7-CGCOVXB-BWZ5LEN-Y5CEGES-TMJDILA-SKQLDPK-I4CDUAN";
            };
            ${phoneDevice} = {
              id = "P366B4T-SOUZTBV-G4G5IE2-7MXQ4DQ-DFKXKKM-WVBJMSZ-Q7ZPOAN-32MUFAY";
            };
          };

          folders = lib.mapAttrs (
            _: v:
            base
            // {
              inherit (v) id;
              path = "${syncthingDir}/${v.path}";
            }
            // lib.optionalAttrs (v ? versioning) {
              inherit (v) versioning;
            }
          ) folderDefs;
        };
      };
    };
}
