{
  outputs = { self, nixpkgs }:
  let
    lib = nixpkgs.lib;
    forAllSystems = function:
      lib.genAttrs lib.systems.flakeExposed
      (system: function nixpkgs.legacyPackages.${system});

  in
  {
    packages = forAllSystems
    (
      pkgs:
      {
        splitpatch = pkgs.callPackage ./packages/splitpatch.nix { inherit self; };
        gasp = pkgs.callPackage ./packages/gasp.nix { inherit self; };
      }
    );

    devShells = forAllSystems
    (
      pkgs:
      {
        default = pkgs.mkShell
        {
          packages = with self.packages.${pkgs.system};
          [
            gasp
            splitpatch
          ];
        };
      }
    );


  };
}
