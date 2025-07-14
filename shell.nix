{ pkgs ? import <nixpkgs> { } }:
let myPkgs = import ./default.nix { };
in pkgs.mkShell {
  buildInputs = with myPkgs; [ beeref ];

  shellHook = ''
    echo "Welcome to the BeeRef development shell!"
  '';
}
