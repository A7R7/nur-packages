# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:
let
  callPackage = pkgs.lib.callPackageWith (pkgs);
in
{
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays
  # example-package = pkgs.callPackage ./pkgs/example-package { };
  # some-qt5-package = pkgs.libsForQt5.callPackage ./pkgs/some-qt5-package { };
  logisim-ita = callPackage ./pkgs/logisim-ita { };
  thorium-browser = callPackage ./pkgs/thorium-browser { };
  xenlism-grub-2k-nixos = callPackage ./pkgs/xenlism-grub-2k-nixos { };
  xenlism-grub-4k-nixos = callPackage ./pkgs/xenlism-grub-4k-nixos { };
  themix-gui = callPackage ./pkgs/themix-gui { };
  auctex = callPackage ./pkgs/auctex { };
  pix2text = callPackage ./pkgs/pix2text { };
  # ...
}
