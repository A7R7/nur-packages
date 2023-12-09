{ lib
, stdenvNoCC
, fetchFromGitHub
, ibm-plex
, python3Packages
}:
stdenvNoCC.mkDerivation rec {
  pname = "ibm-plex-nerd-font";
  version = "2.1.0";

  src = fetchFromGitHub {
    owner = "ryanoasis";
    repo = "nerd-fonts";
    rev = "v${version}";
    sparseCheckout = [
      "font-patcher"
      "src/"
      "!src/unpatched-fonts/"
    ];
    sha256 = "sha256-RkaZ8IV51Eimxk5Q8CijwEHL5yqQJeJMuEqLh/CfC3k=";
  };

  nativeBuildInputs = with python3Packages; [
    python
    fontforge
  ];

  buildPhase = ''
    mkdir -p $out/share/fonts/opentype
    for f in ${ibm-plex}/share/fonts/opentype/*; do
      python font-patcher $f --complete --no-progressbars --outputdir $out/share/fonts/opentype
    done
  '';

  dontInstall = true;
  dontFixup = true;

  meta = with lib; {
    homepage = "https://github.com/ryanoasis/nerd-fonts";
    description = "Ligature-less Fantasque Sans Mono patched with Nerd Fonts icons";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
