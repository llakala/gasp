{ pkgs, localPackages }:

localPackages.writeFishApplication {
  name = "satod"; # Split a Type of Diff

  runtimeInputs = builtins.attrValues {
    inherit (pkgs) git fzf diff-so-fancy;
    inherit (localPackages) splitpatch;
  };

  text = builtins.readFile ./satod.fish;
}
