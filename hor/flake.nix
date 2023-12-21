{
  inputs.horizon-platform.url = "git+https://gitlab.homotopic.tech/horizon/horizon-platform";
  inputs.nixpkgs.follows = "horizon-platform/nixpkgs";
  inputs.utils.url = "github:ursi/flake-utils";

  outputs = { self, utils, ... }@inputs:
    utils.apply-systems
      {
        inherit inputs;
        # TODO support additional systems on hor
        #  horizon-platform is only supporting linux
        systems = [ "x86_64-linux" ];
      }
      ({ pkgs, system, ... }:
        let
          hsPkgs =
            with pkgs.haskell.lib;
            inputs.horizon-platform.legacyPackages.${system}.extend (hfinal: hprev:
              {
                hor = disableLibraryProfiling (hprev.callCabal2nix "hor" ./. { });
              });
        in
        # Flake definition must follow hor.cabal
        {
          packages.default = hsPkgs.hor;
          devShells.default = hsPkgs.hor.env.overrideAttrs (attrs: {
            buildInputs = with hsPkgs; attrs.buildInputs ++ [
              pkgs.cabal-install
              haskell-language-server
              hlint
            ];
          });
          checks.output = pkgs.runCommand "hor-output" { }
            ''
              echo ${hsPkgs.hor} > $out
            '';
        });

  # --- Flake Local Nix Configuration ----------------------------
  nixConfig = {
    extra-experimental-features = "nix-command flakes";
    allow-import-from-derivation = "true";
    # This sets the flake to use nix cache.
    # Nix should ask for permission before using it,
    # but remove it here if you do not want it to.
    extra-substituters = [
      "https://cache.tcp4.me?priority=99"
      "https://horizon.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.tcp4.me:cmk2Iz81lQuX7FtTUcBgtqgI70E8p6SOamNAIcFDSew="
      "horizon.cachix.org-1:MeEEDRhRZTgv/FFGCv3479/dmJDfJ82G6kfUDxMSAw0="
    ];
  };
}
