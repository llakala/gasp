{ pkgs, hip, llakaLib, ... }:

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
  ];

in llakaLib.writeFishApplication
{
  name = "gfp"; # `Git Fire Patch`

  runtimeInputs = pkgsInputs ++ selfInputs;

  text = builtins.readFile ./gfp.fish;
}
