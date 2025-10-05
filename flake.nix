{
  inputs = {
    # If you want to use `follows`, make it follow your own unstable input
    # for access to new FZF versions
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  let
    lib = nixpkgs.lib;

    # The "normal" systems. If it ever doesn't work with one of these, or you want me
    # to add a system, let me know!
    supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

    forAllSystems = function: lib.genAttrs
      supportedSystems
      (system: function nixpkgs.legacyPackages.${system});
  in {
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
