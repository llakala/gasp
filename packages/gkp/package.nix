{ pkgs, llakaLib, hip, fmbl, ... }:

let
  pkgsInputs = with pkgs;
  [
    git
    fzf
    diff-so-fancy
  ];

  selfInputs = # Collected packages defined within repo
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
