{ stdenv
, dpkg
, glibc
, ghostscript
, wrapGAppsHook
, fetchurl
, pango
, cairo
, libgit2
, libjpeg8
, libpng
, freetype
, fontconfig
, zlib
, openssl
, qt6
, curl
, autoPatchelfHook
, wrapQtAppsHook
}:
stdenv.mkDerivation rec {
  pname = "mogan-bin";
  version = "1.2.4";

  src = fetchurl {
    url = "https://github.com/XmacsLabs/mogan/releases/download/v${version}/mogan-research-v${version}-ubuntu22.04.deb";
    sha256 = "sha256-n5XMVyo7dfLz03V8JiVHfsl8E2G7o9vN313+EzcaAKM=";
  };

  nativeBuildInputs = [ dpkg autoPatchelfHook wrapQtAppsHook ];

  buildInputs = [
    curl
    glibc
    pango
    cairo
    zlib
    openssl
    qt6.qtbase
    qt6.qtsvg
    qt6.qtwayland
    libjpeg8
    libpng
    freetype
    fontconfig
    ghostscript
    wrapGAppsHook
    libgit2
  ];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin $out/share
    dpkg -x $src $out
    sed -i "s/Exec=MoganResearch/Exec=MoganResearch -platform wayland/" $out/usr/share/applications/MoganResearch.desktop

    patchShebangs $out/usr/
    cp -r $out/usr/bin $out/
    cp -r $out/usr/share $out/

    rm -r $out/usr
  '';

  meta = { platforms = [ "x86_64-linux" ]; };
}
