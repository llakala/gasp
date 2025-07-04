{ pkgs, llakaLib, localPackages, ... }:

let
  pkgsInputs = with pkgs;
  [
    git
    fzf
    diff-so-fancy
  ];

  # Other packages defined within repo
  selfInputs = with localPackages;
  [
    fmbl
    splitpatch
  ];

in llakaLib.writeFishApplication
{
  name = "satod"; # Split a Type of Diff

  runtimeInputs = pkgsInputs ++ selfInputs;

  text = builtins.readFile ./satod.fish;
}
