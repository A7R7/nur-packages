{ lib
, formats
, stdenvNoCC
, fetchGit
, qtgraphicaleffects
  /* An example of how you can override the background on the NixOS logo
  *
  *  environment.systemPackages = [
  *    (pkgs.where-is-my-sddm-theme.override {
  *      themeConfig.General = {
  *        background = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
  *        backgroundMode = "none";
  *      };
  *    })
  *  ];
  */
, themeConfig ? null
}:
let
  user-cfg = (formats.ini { }).generate "theme.conf.user" themeConfig;
in
stdenvNoCC.mkDerivation rec {
  pname = "sddm-sugar-candy-theme";
  version = "1.1";
  src = fetchGit {
    url = "https://framagit.org/MarianArlt/sddm-sugar-candy";
    rev = "v.${version}";
    sha256 = "0gx0am7vq1ywaw2rm1p015x90b75ccqxnb1sz3wy8yjl27v82yhb";
  };
  propagatedUserEnvPkgs = [ qtgraphicaleffects ];
  dontBuild = true;
  installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/sugar-candy
      ln -sf ${user-cfg} $out/share/sddm/themes/sugar-candy/theme.conf.user
    '';
}
