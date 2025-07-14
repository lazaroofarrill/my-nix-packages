{ pkgs }:
let beeref = pkgs.callPackage ./beeref.nix { };

in { beeref = beeref; }

