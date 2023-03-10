{
  # This is a template created by `hix init`
  inputs = {
    nixpkgs.follows = "haskell-nix/nixpkgs-unstable";
    haskell-nix.url = "github:input-output-hk/haskell.nix";
    flake-utils.follows = "haskell-nix/flake-utils";
    CHaP = {
      url = "github:input-output-hk/cardano-haskell-packages?ref=repo";
      flake = false;
    };
  # to generate docs
    plutus.url = "github:input-output-hk/plutus";
    # utils.url = "github:ursi/flake-utils";
    iohk-nix = {
      url = "github:input-output-hk/iohk-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, haskell-nix, CHaP, iohk-nix, ... }:

    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          inherit (haskell-nix) config;
          overlays = [
            haskell-nix.overlay
            iohk-nix.overlays.crypto
          ];
        };

        inherit (pkgs) lib;

        hixProject = pkgs.haskell-nix.hix.project {
          src = ./.;
          evalSystem = "x86_64-linux";
          inputMap = { "https://input-output-hk.github.io/cardano-haskell-packages" = inputs.CHaP; };
          
          shell.tools = {
            cabal.version = "latest";
            hlint.version = "3.4.1";
            haskell-language-server.version = "1.8.0.0";
          };

          modules = [
            {
              packages = {
                # Broken due to haddock errors. Refer to https://github.com/input-output-hk/plutus/blob/master/nix/pkgs/haskell/haskell.nix
                plutus-ledger.doHaddock = false;
                plutus-use-cases.doHaddock = false;

                cardano-crypto-praos.components.library.pkgconfig = lib.mkForce [ [ pkgs.libsodium-vrf pkgs.secp256k1 ] ];
                cardano-crypto-class.components.library.pkgconfig = lib.mkForce [ [ pkgs.libsodium-vrf pkgs.secp256k1 ] ];
              };
            }
          ];
        };
          hixFlake = hixProject.flake { };
          serve-docs = import ./nix/serve-docs.nix inputs context {
            inherit hixProject;
            # TODO transform additionalPkgs in excludePkgs to reduce boilerplate
            #  we could collect all entries from cabal build-depends
            #  (maybe through hixProject.hsPkgs)
            additionalPkgs = [ "cardano-api" ];
          };
        in
        # Flake definition follows hello.cabal
        {
          inherit (hixFlake) apps checks;
          legacyPackages = pkgs;

          packages = hixFlake.packages // {
            inherit serve-docs;
          };

          # devShell = pkgs.mkShell {
          #   inputsFrom = [
          #     hixFlake.devShell
          #   ];
          #   buildInputs = [
          #     self.packages.x86_64-linux.serve-docs
          #   ];
          # };
        });

  # --- Flake Local Nix Configuration ----------------------------
  nixConfig = {
    # This sets the flake to use nix cache.
    # Nix should ask for permission before using it,
    # but remove it here if you do not want it to.
    extra-substituters = [
      "https://klarkc.cachix.org?priority=99"
      "https://cache.iog.io"
      "https://iohk.cachix.org"
      "https://cache.zw3rk.com"
      "https://cache.nixos.org"
      "https://public-plutonomicon.cachix.org"
    ];
    extra-trusted-public-keys = [
      "klarkc.cachix.org-1:R+z+m4Cq0hMgfZ7AQ42WRpGuHJumLLx3k0XhwpNFq9U="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
      "loony-tools:pr9m4BkM/5/eSTZlkQyRt57Jz7OMBxNSUiMC4FkcNfk="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "public-plutonomicon.cachix.org-1:3AKJMhCLn32gri1drGuaZmFrmnue+KkKrhhubQk/CWc="
    ];
    allow-import-from-derivation = "true";
  };
}
