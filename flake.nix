{
  inputs.llakaLib =
  {
    url = "github:llakala/llakaLib";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... } @ inputs:
  let
    lib = nixpkgs.lib;

    # The "normal" systems. If it ever doesn't work with one of these, or you want me
    # to add a system, let me know!
    supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

    forAllSystems = function: lib.genAttrs
      supportedSystems
      (system: function nixpkgs.legacyPackages.${system});
  in
  {
    legacyPackages = forAllSystems
    (
      pkgs: let llakaLib = inputs.llakaLib.fullLib.${pkgs.system}; # My custom lib functions
      in
        llakaLib.collectDirectoryPackages
      {
        inherit pkgs;
        directory = ./packages;

        extras = { inherit llakaLib; }; # Lets the packages rely on llakaLib
      }
    );

    devShells = forAllSystems
    (
      pkgs:
      {
        default = pkgs.mkShell
        {
          packages = with self.legacyPackages.${pkgs.system};
          [
            ghp # Git Hire Patch
            gfp # Git Fire Patch
            gkp # Git Kill Patch

            splitpatch
            hip # For testing and QOL with running scripts
            fmbl
          ];
        };
      }
    );


  };
}
