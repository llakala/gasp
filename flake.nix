{
  inputs.myLib =
  {
    url = "github:llakala/llakaLib";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... } @ inputs:
  let
    # My custom lib functions, declared in another repo so I can use them across projects
    myLib = inputs.myLib.lib;

  in
  {
    packages = myLib.forAllSystems
    (
      pkgs: myLib.collectDirectoryPackages
      {
        inherit pkgs;
        directory = ./packages;
      }
    );

    devShells = myLib.forAllSystems
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
