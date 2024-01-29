{
lib,
stdenv,
fetchurl,
dpkg,
openssl,
libpng,
libjpeg,
fontconfig,
freetype,
gawk,
zlib,
curl,
libgit2,
glibc,
pango,
cairo,
qt6
}:

stdenv.mkDerivation rec {
  name = "mogan-research";
  version = "1.2.2";
  src = fetchurl {
    url = "https://github.com/XmacsLabs/mogan/releases/download/v${version}/mogan-research-v${version}-ubuntu22.04.deb";
    sha256 = "dc9f3d1e18afb4f27b598c8251815ad1082f14c58e6685e218965c63e6d19151";
  };

  nativeBuildInputs = [
    dpkg
  ];

  # buildInputs = [
  #   hicolor-icon-theme
  # ];

  runtimeDependencies = [
    openssl
    libpng
    libjpeg
    fontconfig
    freetype
    gawk
    zlib
    curl
    libgit2
    glibc
    pango
    cairo
    qt6.qtbase
    qt6.qtsvg
    qt6.qtwayland
  ];


  installPhase = ''
    runHook preInstall

    mkdir -p $out
    mv usr/* $out
    rmdir usr/

    runHook autoPatchelf

    runHook postInstall
  '';

  meta = with lib; {
    description = "A structured STEM suite delivered by Xmacs Labs";
    homepage = "https://mogan.app/";
    platforms = [ "x86_64-linux" ];
    license = licenses.gpl3Plus;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    mainProgram = "MoganResearch";
  };

}
