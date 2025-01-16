{ pkgs, splitpatch, writeShellApplication, ... }:

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

in writeShellApplication
{
  name = "hip"; # `Hunks In Patch`

  runtimeInputs = pkgsInputs ++ selfInputs;

  bashOptions =
  [
    "nounset" # -u
    "errexit" # -e
    "pipefail"
    "errtrace" # -E
  ];

  text = builtins.readFile ./hip.sh;
}
