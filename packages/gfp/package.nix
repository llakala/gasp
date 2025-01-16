{ pkgs, hip, writeShellApplication, ... }:

let
  pkgsInputs = with pkgs;
  [
    git
    fzf
  ];

  selfInputs = # Custom packages
  [
    hip
  ];

in writeShellApplication
{
  name = "gfp"; # `Git Fire Patch`

  runtimeInputs = pkgsInputs ++ selfInputs;

  bashOptions =
  [
    "nounset" # -u
    "errexit" # -e
    "pipefail"
    "errtrace" # -E
  ];

  text = builtins.readFile ./gfp.sh;
}
