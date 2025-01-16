{ pkgs, hip, writeShellApplication, ... }:

let
  pkgsInputs = with pkgs;
  [
    git
    fzf
  ];

  selfInputs =
  [
    hip
  ];

in writeShellApplication
{
  name = "ghp"; # `Git Hire Patch`

  runtimeInputs = pkgsInputs ++ selfInputs;

  bashOptions =
  [
    "nounset" # -u
    "errexit" # -e
    "pipefail"
    "errtrace" # -E
  ];

  text = builtins.readFile ./ghp.sh;
}
