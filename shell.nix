{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  buildInputs = with pkgs; [ (callPackage ./beeref/default.nix { }) ];

  shellHook = ''
    echo "Welcome to the BeeRef development shell!"
  '';
}
