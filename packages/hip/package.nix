{ llakaLib, localPackages, ... }:

llakaLib.writeFishApplication
{
  name = "hip"; # `Hunks In Patch`

  # Other packages defined within repo
  runtimeInputs = with localPackages;
  [
    splitpatch
  ];

  text = builtins.readFile ./hip.fish;
}
