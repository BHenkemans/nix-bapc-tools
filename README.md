# nix-bapc-tools

Nix flake packaging [BAPCtools](https://github.com/RagnarGrootKoerkamp/BAPCtools) (`bt`).

## Try it

```sh
nix run github:BHenkemans/nix-bapc-tools -- --version
```

## Binary cache

CI pushes builds for `x86_64-linux`, `aarch64-linux` and `aarch64-darwin` to
[bhenkemans.cachix.org](https://bhenkemans.cachix.org). To use it:

```sh
nix shell nixpkgs#cachix -c cachix use bhenkemans
```

or on NixOS:

```nix
{
  nix.settings = {
    extra-substituters = [ "https://bhenkemans.cachix.org" ];
    extra-trusted-public-keys = [ "bhenkemans.cachix.org-1:iKxZzIloelTP2nQ5hxb4wdkeLYn2qWws1xLzZlHY608=" ];
  };
}
```

The cache holds builds against this flake's pinned nixpkgs. The overlay builds against
your own nixpkgs, so to hit the cache use `bapctools.packages.${system}.default` instead.

## NixOS

```nix
{
  inputs.bapctools.url = "github:BHenkemans/nix-bapc-tools";

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
