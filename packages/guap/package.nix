{ pkgs, hip, ... }:

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

in pkgs.writeShellApplication
{
  name = "guap"; # `Git Unstage A Patch`

  runtimeInputs = pkgsInputs ++ selfInputs;

  bashOptions =
  [
    "nounset" # -u
    "errexit" # -e
    "pipefail"
    "errtrace" # -E
  ];

  text = builtins.readFile ./guap.sh;
}
