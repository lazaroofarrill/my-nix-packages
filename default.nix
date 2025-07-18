{ pkgs ? import <nixpkgs> { } }: {
  beeref = (import ./beeref/default.nix { inherit pkgs; }).beeref;

  # ugeePackages = (import ./ugee/default.nix { inherit pkgs; });
}
