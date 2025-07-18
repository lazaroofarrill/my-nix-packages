{ pkgs ? import <nixpkgs> { } }:
let
  # myPkgs = import (builtins.fetchTarball {
  #   url =
  #     "https://github.com/lazaroofarrill/my-nix-packages/archive/refs/heads/main.tar.gz";
  # }) { };
  myPkgs = import ./default.nix { };
in pkgs.mkShell {

  buildInputs = with myPkgs; [
    beeref
    ugeePackages.m908

    pkgs.qt5.wrapQtAppsHook
    pkgs.qt5.full
    pkgs.makeWrapper
    pkgs.bashInteractive
    pkgs.glibc
  ];

  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.qt5.qtbase}/lib:${pkgs.qt5.qtx11extras}/lib:${pkgs.xorg.libX11}/lib:${pkgs.xorg.libXrandr}/lib:${pkgs.libGL}/lib:${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH"
    bashdir=$(mktemp -d)
    makeWrapper "$(type -p bash)" "$bashdir/bash" "''${qtWrapperArgs[@]}"
    exec "$bashdir/bash"
      
  '';
}

