{ lib, stdenv, fetchurl, jre, makeWrapper, copyDesktopItems, makeDesktopItem, unzip }:

stdenv.mkDerivation rec {
  pname = "logisim-ita";
  version = "2.16.1.4";

  src = fetchurl {
    url = "https://github.com/Logisim-Ita/Logisim/releases/download/v${version}/Logisim-ITA.jar";
    sha256 = "d27b92e38188309be935e6355faef8689594537b8e280d79b84372e1f85a38d7";
  };

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper copyDesktopItems unzip ];

  desktopItems = [
    (makeDesktopItem {
      name = pname;
      desktopName = "Logisim-ITA";
      exec = "logisim-ita";
      icon = "logisim-ita";
      comment = meta.description;
      categories = [ "Education" ];
    })
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    makeWrapper ${jre}/bin/java $out/bin/${pname} --add-flags "-jar $src"

    # Create icons
    unzip $src "resources/logisim/img/*"
    for size in 16 20 24 48 64 128
    do
      install -D "./resources/logisim/img/logisim-icon-$size.png" "$out/share/icons/hicolor/''${size}x''${size}/apps/logisim-ita.png"
    done

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "logisim.altervista.org";
    description = "Logisim Italian Fork";
    maintainers = with maintainers; [ A7R7 ];
    sourceProvenance = with sourceTypes; [ binaryBytecode ];
    license = licenses.gpl3Plus;
    platforms = platforms.unix;
  };
}
