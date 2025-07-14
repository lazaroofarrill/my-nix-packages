{ pkgs ? import <nixpkgs> { } }:
let
  # myPkgs = import (builtins.fetchTarball {
  #   url =
  #     "https://github.com/lazaroofarrill/my-nix-packages/archive/refs/heads/main.tar.gz";
  # }) { };
  myPkgs = import ./default.nix { };
in pkgs.mkShell {

  buildInputs = with myPkgs; [ beeref ];

  shellHook = ''
    echo "Welcome to the BeeRef development shell!"
  '';
}

