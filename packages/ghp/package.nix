{ pkgs, hip, llakaLib, ... }:

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
  ];

in llakaLib.writeFishApplication
{
  name = "ghp"; # `Git Hire Patch`

  runtimeInputs = pkgsInputs ++ selfInputs;

  text = builtins.readFile ./ghp.fish;
}
