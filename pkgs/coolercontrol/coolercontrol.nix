{ appimageTools
, fetchurl
}:
appimageTools.wrapType2 rec { # or wrapType1
  name = "coolercontrol";
  src = fetchurl {
    url = "https://gitlab.com/coolercontrol/coolercontrol/-/releases/permalink/latest/downloads/packages/CoolerControl-x86_64.AppImage";
    hash = "sha256-OfwWuv4tVSBr/2QEZScPHYMDYmLgcD1EGSeqWoVbvQM=";
  };
  extraPkgs = pkgs: with pkgs; [ ];
}
