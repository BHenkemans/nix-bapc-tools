# nix-bapc-tools

Nix flake packaging [BAPCtools](https://github.com/RagnarGrootKoerkamp/BAPCtools) (`bt`).

## Try it

```sh
nix run github:<you>/nix-bapc-tools -- --version
```

## NixOS

```nix
{
  inputs.bapctools.url = "github:<you>/nix-bapc-tools";

  outputs = { nixpkgs, bapctools, ... }: {
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      modules = [
        { nixpkgs.overlays = [ bapctools.overlays.default ]; }
        ({ pkgs, ... }: { environment.systemPackages = [ pkgs.bapctools ]; })
      ];
    };
  };
}
```

## Toolchains

`bt` only wraps Python and its libraries (checktestdata included). Compilers and
other tools it calls are taken from `PATH`, so add what your problems need, e.g.
`gcc`, `pypy3`, `jdk`, `kotlin`, `rustc`, `texliveFull` (for `bt pdf`, needs `latexmk`), `asymptote`.

## Updating

Bump `version` and `hash` in `pkgs/*.nix` (hashes from
`nix store prefetch-file https://files.pythonhosted.org/packages/source/b/bapctools/bapctools-<version>.tar.gz`).
