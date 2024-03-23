{ appimageTools
, fetchurl
}:
appimageTools.wrapType2 rec { # or wrapType1
  name = "jan";
  version = "0.4.6";
  src = fetchurl {
    url = "https://github.com/janhq/jan/releases/download/v${version}/jan-linux-x86_64-${version}.AppImage";
    hash = "sha256-/FYaFyp028CeEFfrxNnj67/z7FoOwU0wC2V56mACD5Q=";
  };
  extraPkgs = pkgs: with pkgs; [ ];
}
