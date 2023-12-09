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
  patchFont = font: pkgs.stdenv.mkDerivation {
    name = "${font.name}-nerd-font";
    src = font;
    nativeBuildInputs = [ pkgs.nerd-font-patcher ];
    buildPhase = ''
      find -name \*.ttf -o -name \*.otf -exec nerd-font-patcher -c {} \;
    '';
    installPhase = "cp -a . $out";
  };

in
rec {
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

  cnstd = callPackage ./pkgs/cnstd { };
  cnocr = callPackage ./pkgs/cnocr { inherit cnstd;  };
  pix2tex = callPackage ./pkgs/pix2tex { };
  pix2text = callPackage ./pkgs/pix2text { inherit cnstd cnocr pix2tex; };

  symbols-nerd-font = callPackage ./pkgs/symbols-nerd-font { };
  sarasa-gothic-nerd-font = callPackage ./pkgs/sarasa-gothic-nerd-font { };
  ibm-plex-nerd-font = patchFont(pkgs.ibm-plex);
  nerd-fonts = callPackage ./pkgs/nerd-fonts { };
  light = callPackage ./pkgs/lighttable { };
  # ...
}
