{ pkgs, llakaLib, hip, fmbl, ... }:

let
  pkgsInputs = with pkgs;
  [
    git
    fzf
    diff-so-fancy
  ];

  selfInputs = # Custom packages
  [
    hip
    fmbl
  ];

in llakaLib.writeFishApplication
{
  name = "gfp"; # `Git Fire Patch`

  runtimeInputs = pkgsInputs ++ selfInputs;

  text = builtins.readFile ./gfp.fish;
}
