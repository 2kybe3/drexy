{
  inputs = {
    self.submodules = true;

    # core
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
      inputs = {
        nixpkgs.follows = "";
        home-manager.follows = "";
      };
    };

    # packages
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # dendritic
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:denful/import-tree";

    # secret management
    secrets = {
      url = "git+ssh://git@gitc.kybe.xyz/2kybe3/drexy-secrets.git";
      flake = false;
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # theming
    basenix = {
      url = "git+https://git.kybe.xyz/2kybe3/basenix.git";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "";
      };
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };

    black-metal = {
      url = "github:metalelf0/base16-black-metal-scheme";
      flake = false;
    };

    # personal tools

    kyvim = {
      url = "git+https://git.kybe.xyz/2kybe3/kyvim.git";
      inputs = {
        basenix.follows = "basenix";
        nixpkgs.follows = "nixpkgs";
        nixvim.inputs.flake-parts.follows = "flake-parts";
      };
    };

    kymenu = {
      url = "git+https://git.kybe.xyz/2kybe3/kymenu.git";
      inputs = {
        rust-overlay.follows = "rust-overlay";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "";
      };
    };
    kymenu-extras = {
      url = "git+https://git.kybe.xyz/2kybe3/kymenu-extras.git";
      inputs = {
        rust-overlay.follows = "rust-overlay";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "";
      };
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
