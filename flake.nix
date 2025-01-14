{
  outputs = { self, nixpkgs }:
  let
    lib = nixpkgs.lib;
    forAllSystems = function:
      lib.genAttrs lib.systems.flakeExposed
      (system: function nixpkgs.legacyPackages.${system});

    selfPackagesFromDirectoryRecursive = { directory, pkgs }:
    lib.makeScope pkgs.newScope
    (
      self: lib.packagesFromDirectoryRecursive
      {
        inherit (self) callPackage;
        inherit directory;
      }
    );

  in
  {
    packages = forAllSystems
    (
      pkgs: selfPackagesFromDirectoryRecursive
      {
        inherit pkgs;
        directory = ./packages;
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
            ghp # Git Hire Patch
            gfp # Git Fire Patch
            gkp # Git Kill Patch
            splitpatch
            hip # For testing and QOL with running scripts
          ];
        };
      }
    );


  };
}
