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
    hip
    fmbl
  ];

in llakaLib.writeFishApplication
{
  name = "gkp"; # `Git Kill Patch`

  runtimeInputs = pkgsInputs ++ selfInputs;

  text = builtins.readFile ./gkp.fish;
}
