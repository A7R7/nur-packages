{ lib, stdenvNoCC, fetchurl, unzip}:

stdenvNoCC.mkDerivation rec {
  pname = "sarasa-gothic-nerd-font";
  version = "0.42.6";

  src = fetchurl {
    url = "https://github.com/jonz94/Sarasa-Gothic-Nerd-Fonts/releases/download/v${version}-0/sarasa-gothic-sc-nerd-font.zip";
    hash = "sha256-OQJNjPm1axJ7BbEN30eyeCdJqUy5p7fx0qYD5z4nhHc=";
  };

  buildInputs = [ unzip ];
  unpackPhase = ''
    unzip $src -d $out
  '';
  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    mv $out/*.ttf $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = with lib; {
    description = "Nerd fonts patched Sarasa Gothic font";
    homepage = "https://github.com/jonz94/Sarasa-Gothic-Nerd-Fonts";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
