{lib, stdenvNoCC, fetchgit}:

stdenvNoCC.mkDerivation rec {
  pname = "symbols-nerd-font";
  version = "2.2.0";
  src = fetchgit {
    url = "https://github.com/ryanoasis/nerd-fonts.git";
    sha256 = "";
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
    install "patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFont-Regular.ttf" "$fontdir"

    runHook postInstall
  '';
}
