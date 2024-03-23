{ appimageTools
, fetchurl
, fuse
}:
appimageTools.wrapType2 rec { # or wrapType1
  name = "coolercontrold";
  src = fetchurl {
    url = "https://gitlab.com/coolercontrol/coolercontrol/-/releases/permalink/latest/downloads/packages/CoolerControlD-x86_64.AppImage";
    hash = "sha256-gL84ayopecBRuh13MYwnd+YuCsKKMjA2rnq/KpxhMf8=";
  };
  extraPkgs = pkgs: with pkgs; [ fuse ];
}
