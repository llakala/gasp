{ localPackages }:

localPackages.writeFishApplication {
  name = "gfp"; # `Git Fire Patch`

  runtimeInputs = [
    localPackages.satod
  ];

  text = builtins.readFile ./gfp.fish;
}
