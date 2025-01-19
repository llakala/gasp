{ pkgs, llakaLib, hip, fmbl, ... }:

let
  pkgsInputs = with pkgs;
  [
    git
    fzf
    diff-so-fancy
  ];

  selfInputs =
  [
    hip
    fmbl
  ];

in llakaLib.writeFishApplication
{
  name = "ghp"; # `Git Hire Patch`

  runtimeInputs = pkgsInputs ++ selfInputs;

  text = builtins.readFile ./ghp.fish;
}
