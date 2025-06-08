{ llakaLib, localPackages, pkgs, ... }:

llakaLib.writeFishApplication
{
  name = "wip"; # `Git Kill Patch`

  runtimeInputs =
  [
    localPackages.fmbl

    pkgs.git
    pkgs.diff-so-fancy
  ];


  text = builtins.readFile ./wip.fish;
}
