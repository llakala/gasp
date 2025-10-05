{ llakaLib, localPackages }:

llakaLib.writeFishApplication {
  name = "gfp"; # `Git Fire Patch`

  runtimeInputs = [
    localPackages.satod
  ];

  text = builtins.readFile ./gfp.fish;
}
