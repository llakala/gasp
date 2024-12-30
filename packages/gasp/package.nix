{ pkgs, splitpatch, ... }:

let
  pkgsInputs = with pkgs;
  [
    git
    fzf
  ];

  selfInputs = # Custom packages
  [
    splitpatch
  ];

in pkgs.writeShellApplication
{
  name = "gasp"; # `Git Add Specific Patch`

  runtimeInputs = pkgsInputs ++ selfInputs;

  bashOptions =
  [
    "nounset" # -u
    "errexit" # -e
    "pipefail"
    "errtrace" # -E
  ];

  text = builtins.readFile ./gasp.sh;
}
