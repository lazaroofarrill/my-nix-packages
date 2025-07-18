{ pkgs }:
let m908 = pkgs.callPackage ./m908/default.nix { };

in { m908 = m908; }

