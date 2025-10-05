{ llakaLib, localPackages }:

llakaLib.writeFishApplication {
  name = "ghp"; # `Git Hire Patch`

  runtimeInputs = [
    localPackages.satod
  ];

  text = builtins.readFile ./ghp.fish;
}
