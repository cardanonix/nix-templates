{
  description = "Nix flake templates";
  outputs = { self, inputs }:
    let
      starterWelcomeText = ''
        You have succesfully created a new plutus starter project.
        
        Development shell available on `nix develop`
        Build and run the project with `nix run .#hello:exe:hello`
      '';
      iogWelcomeText = ''
        You just created a haskell.nix template very similar to the current one that IOG is using with flakes. Read more about it here:
        https://input-output-hk.github.io/haskell.nix/tutorials/getting-started-flakes.html

        Development shell available on `nix develop`
        Build and run the project with `nix run .#hello:exe:hello`
      '';
      hsWelcomeText = ''
        You just created an haskell.nix template using hix. Read more about it here:
        https://input-output-hk.github.io/haskell.nix/tutorials/getting-started-flakes.html

        Development shell available on `nix develop`
        Build and run the project with `nix run .#hello:exe:hello`
      '';
      stdWelcomeText = ''
        You just created an experimental std/paisano plutus project. . Read more about it here:
        https://github.com/divnix/std

        Development shell with `nix develop`
        Build and run the project with `nix run .#hello:exe:hello`
      '';
      ctlWelcomeText = ''
        You just created an cardano-transaction-lib project.
        Read more about it here: https://github.com/Plutonomicon/cardano-transaction-lib

        Development shell with `nix develop`
        Build with `nix build`
      '';
    in
    {
      templates = {

        haskell-nix = {
          path = ./haskell-nix;
          description = "A haskell.nix template using hix";
          welcomeText = hsWelcomeText;
        };

        plutus = {
          path = ./plutus;
          description = "A plutus template using haskell.nix";
          welcomeText = ''
            ${iogWelcomeText}
            Plutus docs available with `nix run .#serve-docs`
          '';
        };

        plutus-starter = {
          path = ./iog-plutus-starter;
          description = "A flake-specifc, very bare-bones branch of the IOG plutus starter with working PAB";
          welcomeText = ''
            ${iogWelcomeText}
            Plutus docs available with `nix run .#serve-docs`
          '';
        };

        bizarro-plutus-starter  = {
          path = "github:input-output-hk/plutus-starter?rev=d077a79559bace5a6c79744ff01e90cae803b999"; 
          description = "A flake-specifc, very bare-bones branch of the IOG plutus starter with working PAB";
          welcomeText = ''
            ${iogWelcomeText}
            Plutus docs available with `nix run .#serve-docs`
          '';
        };

        gimbalabs-plutus-starter = {
          path = ./gimbalabs-plutus-starter;
          description = "A (currently broken) plutus template using haskell.nix the cabal file isn't connecting dependencies correctly";
          welcomeText = ''
            ${iogWelcomeText}
            Plutus docs available with `nix run .#serve-docs`
          '';
        };

        std-plutus = {
          path = ./std-plutus;
          description = "A broken and experimental plutus template using paisano/std";
          welcomeText = ''
            ${stdWelcomeText}
            Plutus docs available with `nix run .#serve-docs`
          '';
        };

        hix-plutus = {
          path = ./hix-plutus;
          description = "A clean plutus template from Lovelace Academy using hix and haskell.nix";
          welcomeText = ''
            ${hsWelcomeText}
            Plutus docs available with `nix run .#serve-docs`
          '';
        };
        
        purs-nix = {
          path = ./purs-nix;
          description = "A purs-nix template";
          welcomeText = ''
            You just created a purs-nix project.
            Read more about it here: https://github.com/purs-nix/purs-nix

            Development shell with `nix develop`
            Build with `nix build`
          '';
        };

        ctl = {
          path = ./ctl;
          description = "A minimal cardano-transaction-lib template using purs-nix";
          welcomeText = ctlWelcomeText;
        };

        ctl-full = {
          path = ./ctl-full;
          description = "A optioned cardano-transaction-lib template using purs-nix and webpack";
          welcomeText = ctlWelcomeText;
        };
      };
    };
}
