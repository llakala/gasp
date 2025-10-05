{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }:
  let
    inherit (nixpkgs) lib;

    forAllSystems = function: lib.genAttrs
      [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ]
      (system: function nixpkgs.legacyPackages.${system});
  in {
    # If you want a non-flake way of accessing these packages, just use this
    # file directly - flake is a simpler wrapper around it.
    legacyPackages = forAllSystems (pkgs: import ./packages/default.nix { inherit pkgs; });

    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShellNoCC {
        packages = with self.legacyPackages.${pkgs.system}; [
          ghp
          gfp
          gkp
          fmbl
          satod
          splitpatch
        ];
      };
    });
  };
}
