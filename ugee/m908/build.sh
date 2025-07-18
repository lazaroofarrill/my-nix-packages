#!/bin/sh

nix-build -E '
   with import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-25.05.tar.gz";
  }) {};
  callPackage ./default.nix {}
'
