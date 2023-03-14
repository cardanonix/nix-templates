# nix-templates

[![Test](https://github.com/LovelaceAcademy/nix-templates/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/LovelaceAcademy/nix-templates/actions/workflows/test.yml?query=branch%3Amain)

Minimal reproducible nix flake templates (some not so minimal)

### Templates
- [plutus-starter](./iog-plutus-starter): IOG's previous, WORKING plutus-starter template using flakes (nicolas/plutus-apps1.1 branch).
```bash
nix flake init -t github:cardanonix/nix-templates#plutus-starter
```
- [std-plutus-starter](./std-plutus): A plutus starter template using std/paisano (work in progress)
```bash
nix flake init -t github:cardanonix/nix-templates#std-plutus-starter
```
- [plutus](./plutus): A plutus template using haskell.nix  from LoveLace Academy
```bash
nix flake init -t github:LovelaceAcademy/nix-templates#plutus
```
- [gimbalabs-plutus-starter](./gimbalabs-plutus-starter): A hybrid plutus starter template using haskell.nix (very much a work in progress)
```bash
nix flake init -t github:cardanonix/nix-templates#gimbalabs-plutus-starter
```
- [gimbalabs-plutus-starter](./mlabs-tooling): A flake from mlabs to get their tooling working in one place. (Uses "flake-parts")
```bash
nix flake init -t github:cardanonix/nix-templates#mlabs-tooling
```

- [haskell-nix](./haskell-nix): A haskell.nix template using hix  from LoveLace Academy
```bash
nix flake init -t github:LovelaceAcademy/nix-templates#haskell-nix
```
- [purs-nix](./purs-nix): A purs-nix template from LoveLace Academy 
```bash
nix flake init -t github:LovelaceAcademy/nix-templates#purs-nix
```
- [ctl](./ctl): A minimal cardano-transaction-lib template using purs-nix from LoveLace Academy
```bash
nix flake init -t github:LovelaceAcademy/nix-templates#ctl 
```
- [ctl-full](./ctl-full): A optioned cardano-transaction-lib template using purs-nix from LoveLace Academy
```bash
nix flake init -t github:LovelaceAcademy/nix-templates#ctl-full 
```
     

## FAQ

### Why the templates have `flake.lock` files?

While I agree that storing lock files in templates is not ideal, there is no way to be sure the template is working if we do not store lock files. It's a trade-off, we prefer to have working templates than up-to-date dependencies. That said, we try to keep all templates here in sync with upstream / dependencies as far as possible.

### Why do you have other people's files?

Because I haven't figured out how to link my template to other flakes rather than just cloning them into my repo 🤙🏽.

### Will you support other systems?

It depends on upstream supporting it, and also our capacity to test in our CI. Right now only these systems are supported:

- x86_64-linux (all templates)
- aarch64-linux (haskell-nix and plutus)

### Minimal system requirements?

It depends on the template:

- haskell-nix, purs-nix: you'll need at least 8GB RAM and 10GB HDD
- plutus, ctl: you'll need at least 16GB RAM (for HDD) or 12GB RAM (for SSD). At least 20GB of available space.

### Why it take soo long to build?

- You should hit IOG/our cache (given that you have allowed nix to). [Check here for more info](https://input-output-hk.github.io/haskell.nix/troubleshooting.html).
- You should expect to download at least 10GB of data (from the caches)
- If you hardware is constrained it will take more time building, using a SSD will potentially speed-up things. **Remember to close everything in the first build to not be OOM killed**.

### I am getting `No such file or directory`

This is a know issue (NixOS/nix#6642). Be sure to initialize a git repo before (`git init`).
