{
  description = "BAPCtools: tools for developing ICPC-style programming contest problems";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      pkgsFor = system: nixpkgs.legacyPackages.${system}.extend self.overlays.default;
    in
    {
      overlays.default = final: prev: {
        pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
          (pyfinal: pyprev: {
            bapctools = pyfinal.callPackage ./pkgs/bapctools.nix { };
            checktestdata = pyfinal.callPackage ./pkgs/checktestdata.nix { };
            vermin = pyfinal.callPackage ./pkgs/vermin.nix { };
          })
        ];

        bapctools = final.callPackage ./pkgs/bt.nix { };
      };

      packages = forAllSystems (
        system:
        let
          pkgs = pkgsFor system;
        in
        {
          inherit (pkgs) bapctools;
          default = pkgs.bapctools;
        }
      );

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = nixpkgs.lib.getExe self.packages.${system}.bapctools;
        };
      });

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}
