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
            gsap # Git Stage A Patch
            guap # Git Unstage A Patch
            gcap # Git Clean A Patch
            splitpatch
            hip # For testing and QOL with running scripts
          ];
        };
      }
    );


  };
}
