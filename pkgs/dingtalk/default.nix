{
  fetchurl,
  stdenv,
  autoPatchelfHook,
  makeWrapper,
  lib,
  makeDesktopItem,
  copyDesktopItems,
  # DingTalk dependencies
  alsa-lib,
  apr,
  aprutil,
  at-spi2-atk,
  at-spi2-core,
  cairo,
  cups,
  curl,
  dbus,
  e2fsprogs,
  fontconfig,
  freetype,
  fribidi,
  gdk-pixbuf,
  glib,
  gnome2,
  gnutls,
  graphite2,
  gtk3,
  harfbuzz,
  icu63,
  krb5,
  libdrm,
  libgcrypt,
  libGLU,
  libglvnd,
  libidn2,
  libinput,
  libjpeg,
  libpng,
  libpsl,
  libpulseaudio,
  libsForQt5,
  libssh2,
  libthai,
  libxcrypt-legacy,
  libxkbcommon,
  mesa,
  mtdev,
  nghttp2,
  nspr,
  nss,
  openldap,
  openssl_1_1,
  pango,
  pcre2,
  qt5,
  rtmpdump,
  udev,
  util-linux,
  xorg,
  ...
} @ args:
################################################################################
# Mostly based on dingtalk-bin package from AUR:
# https://aur.archlinux.org/packages/dingtalk-bin
################################################################################
let
  libraries = [
    alsa-lib
    apr
    aprutil
    at-spi2-atk
    at-spi2-core
    cairo
    cups
    curl
    dbus
    e2fsprogs
    fontconfig
    freetype
    fribidi
    gdk-pixbuf
    glib
    gnome2.gtkglext
    gnutls
    graphite2
    gtk3
    harfbuzz
    icu63
    krb5
    libdrm
    libgcrypt
    libGLU
    libglvnd
    libidn2
    libinput
    libjpeg
    libpng
    libpsl
    libpulseaudio
    libsForQt5.qtbase
    libssh2
    libthai
    libxcrypt-legacy
    libxkbcommon
    mesa.drivers
    mtdev
    nghttp2
    nspr
    nss
    openldap
    openssl_1_1
    pango
    pcre2
    qt5.qtbase
    qt5.qtmultimedia
    qt5.qtsvg
    qt5.qtx11extras
    rtmpdump
    udev
    util-linux
    xorg.libICE
    xorg.libSM
    xorg.libX11
    xorg.libxcb
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXinerama
    xorg.libXmu
    xorg.libXrandr
    xorg.libXrender
    xorg.libXScrnSaver
    xorg.libXt
    xorg.libXtst
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm
  ];
in
  stdenv.mkDerivation rec {

    pname = "dingtalk";
    version = "7.1.0.31120";
    src = fetchurl {
    url = "https://dtapp-pub.dingtalk.com/dingtalk-desktop/xc_dingtalk_update/linux_deb/Release/com.alibabainc.dingtalk_${version}_amd64.deb";
    hash = "sha256-klNX5igCfZ/1NyFqhJQfQ0P8Cp264+hk2PgQAnJVb+c=";
  };
    nativeBuildInputs = [autoPatchelfHook makeWrapper libsForQt5.wrapQtAppsHook copyDesktopItems];
    buildInputs = libraries;

    # We will append QT wrapper args to our own wrapper
    dontWrapQtApps = true;

    unpackPhase = ''
      ar x $src
      tar xf data.tar.xz

      mv opt/apps/com.alibabainc.dingtalk/files/version version
      mv opt/apps/com.alibabainc.dingtalk/files/*-Release.* release

      # Cleanup
      rm -f release/{*.a,*.la,*.prl}
      rm -f release/dingtalk_crash_report
      rm -f release/dingtalk_updater
      rm -f release/libapr*
      rm -f release/libcrypto.so.*
      rm -f release/libcurl.so.*
      rm -f release/libEGL*
      rm -f release/libfontconfig*
      rm -f release/libfreetype*
      rm -f release/libfribidi*
      rm -f release/libgdk*
      rm -f release/libGLES*
      rm -f release/libgtk*
      rm -f release/libgtk-x11-2.0.so.*
      rm -f release/libharfbuzz*
      rm -f release/libicu*
      rm -f release/libidn2*
      rm -f release/libjpeg*
      rm -f release/libm.so.*
      rm -f release/libnghttp2*
      rm -f release/libpango-1.0.*
      rm -f release/libpangocairo-1.0.*
      rm -f release/libpangoft2-1.0.*
      rm -f release/libpcre2*
      rm -f release/libpng*
      rm -f release/libpsl*
      rm -f release/libQt5*
      rm -f release/libssh2*
      rm -f release/libssl.*
      rm -f release/libstdc++.so.6
      rm -f release/libstdc++*
      rm -f release/libunistring*
      rm -f release/libz*
      rm -rf release/engines-1_1
      rm -rf release/imageformats
      rm -rf release/platform*
      rm -rf release/Resources/{i18n/tool/*.exe,qss/mac}
      rm -rf release/swiftshader
      rm -rf release/xcbglintegrations
    '';

    postInstall = ''
      mkdir -p $out
      mv version $out/

      # Move libraries
      # DingTalk relies on (some of) the exact libraries it ships with
      mv release $out/lib

      # Entrypoint
      mkdir -p $out/bin
      makeWrapper $out/lib/com.alibabainc.dingtalk $out/bin/dingtalk \
        "''${qtWrapperArgs[@]}" \
        --argv0 "com.alibabainc.dingtalk" \
        --set WAYLAND_DISPLAY "" \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath libraries}"

      # App Menu
      mkdir -p $out/share/pixmaps
    '';
    # ln -s ${./dingtalk.png} $out/share/pixmaps/dingtalk.png

    # desktopItems = [
    #   (makeDesktopItem {
    #     name = "dingtalk";
    #     desktopName = "Dingtalk";
    #     genericName = "dingtalk";
    #     categories = ["Chat"];
    #     exec = "dingtalk %u";
    #     icon = "dingtalk";
    #     keywords = ["dingtalk"];
    #     mimeTypes = ["x-scheme-handler/dingtalk"];
    #     extraConfig = {
    #       "Name[zh_CN]" = "钉钉";
    #       "Name[zh_TW]" = "钉钉";
    #     };
    #   })
    # ];

    meta = with lib; {
      description = "钉钉";
      homepage = "https://www.dingtalk.com/";
      platforms = ["x86_64-linux"];
      license = licenses.unfreeRedistributable;
    };
  }
