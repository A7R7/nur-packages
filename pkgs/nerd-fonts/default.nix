{ pkgs, stdenv, nerd-font-patcher }:
let
  patchFont = font: stdenv.mkDerivation {
    name = "${font.name}-nerd-font";
    src = font;
    nativeBuildInputs = [ nerd-font-patcher ];
    buildPhase = ''
      find -name \*.ttf -o -name \*.otf -exec nerd-font-patcher -c {} \;
    '';
    installPhase = "cp -a . $out";
  };
in
{
  ibm-plex-nerd-font = patchFont(pkgs.ibm-plex);
}
