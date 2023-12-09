{lib, stdenvNoCC, fetchFromGitHub}:

stdenvNoCC.mkDerivation rec {
  pname = "symbols-nerd-font";
  version = "2.2.0";
  src = fetchFromGitHub {
    owner = "ryanoasis";
    repo = "nerd-fonts";
    rev = "FontPatcher";
    sha256 = "ORQUN4oMxgf9y1K0cQqgiREefk6edbvmRFPQ5G4uKwo=";
    sparseCheckout = [
      "10-nerd-font-symbols.conf"
      "patched-fonts/NerdFontsSymbolsOnly"
    ];
  };
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    runHook preInstall

    fontconfigdir="$out/etc/fonts/conf.d"
    install -d "$fontconfigdir"
    install 10-nerd-font-symbols.conf "$fontconfigdir"

    fontdir="$out/share/fonts/truetype"
    install -d "$fontdir"
    install "patched-fonts/NerdFontsSymbolsOnly/complete/Symbols-2048-em Nerd Font Complete.ttf" "$fontdir"

    runHook postInstall
  '';
}
