{ stdenv }:

stdenv.mkDerivation rec {
  pname = "xenlism-grub-4k-nixos";
  version = "1";
  src = ./.;
  installPhase = "cp -r ./Xenlism-Nixos $out";
}
