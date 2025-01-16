{ splitpatch, llakaLib, ... }:

llakaLib.writeFishApplication
{
  name = "hip"; # `Hunks In Patch`

  runtimeInputs =
  [
    splitpatch # Collected packages defined within repo
  ];

  text = builtins.readFile ./hip.fish;
}
