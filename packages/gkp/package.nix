{ pkgs, hip, writeShellApplication, ... }:

let
  pkgsInputs = with pkgs;
  [
    git
    fzf
  ];

  selfInputs = # Collected packages defined within repo
  [
    hip
  ];

in writeShellApplication
{
  name = "gkp"; # `Git Kill Patch`

  runtimeInputs = pkgsInputs ++ selfInputs;

  bashOptions =
  [
    "nounset" # -u
    "errexit" # -e
    "pipefail"
    "errtrace" # -E
  ];

  text = builtins.readFile ./gkp.sh;
}
