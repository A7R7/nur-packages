{ pkgs }:

with pkgs.lib; {
  patchFont = font: pkgs.stdenv.mkDerivation {
    name = "${font.name}-nerd-font";
    src = font;
    nativeBuildInputs = [ pkgs.nerd-font-patcher ];
    buildPhase = ''
      find -name \*.ttf -o -name \*.otf -exec nerd-font-patcher -c {} \;
    '';
    installPhase = "cp -a . $out";
  };
  # Add your library functions here
  #
  # hexint = x: hexvals.${toLower x};
}
