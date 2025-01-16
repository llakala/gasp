{ pkgs, splitpatch, llakaLib, ... }:

let
  pkgsInputs = with pkgs;
  [
    git
    fzf
  ];

  selfInputs = # Collected packages defined within repo
  [
    splitpatch
  ];

in llakaLib.writeFishApplication
{
  name = "hip"; # `Hunks In Patch`

  runtimeInputs = pkgsInputs ++ selfInputs;

  text = builtins.readFile ./hip.fish;
}
