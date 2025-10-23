{ pkgs }:

let
  # See https://nix.dev/tutorials/callpackage.html#interdependent-package-sets
  # Lets packages rely on each other easily
  callPackage = pkgs.lib.callPackageWith (pkgs // { localPackages = packages; });
  packages = {
    fmbl = callPackage ./fmbl/package.nix {};
    satod = callPackage ./satod/package.nix {};
    splitpatch = callPackage ./splitpatch/package.nix {};
    writeFishApplication = callPackage ./writeFishApplication/package.nix {};
  };

in packages
