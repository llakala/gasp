{ llakaLib, localPackages, ... }:

llakaLib.writeFishApplication {
  name = "gkp"; # `Git Kill Patch`

  runtimeInputs = [
    localPackages.satod
  ];

  text = builtins.readFile ./gkp.fish;
}
