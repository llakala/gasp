{
  inputs.llakaLib =
  {
    url = "github:llakala/llakaLib";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... } @ inputs:
  let
    # My custom lib functions, declared in another repo so I can use them across projects
    llakaLib = inputs.llakaLib.lib;

  in
  {
    packages = llakaLib.forAllSystems
    (
      pkgs: llakaLib.collectDirectoryPackages
      {
        inherit pkgs;
        directory = ./packages;
      }
    );

    devShells = llakaLib.forAllSystems
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
