{ pkgs ? import <nixpkgs> { } }: {
  beeref = import ./beeref/default.nix { inherit pkgs; };
}
