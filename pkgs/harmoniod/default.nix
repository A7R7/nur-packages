{ pkgs, stdenv, fetchurl, lib }:

stdenv.mkDerivation rec {
  pname = "harmonoid";
  version = "0.3.8";
  rev = "2";

  src = fetchurl {
    url = "https://github.com/alexmercerind2/harmonoid-releases/releases/download/v${version}/harmonoid-linux-x86_64.tar.gz";
    sha256 = "9cb0a34cb1c3e2067a964613f0b75c8004690b17685e0defc43b23fc46e7164e";
  };

  nativeBuildInputs = [ ];

  buildInputs = [ ];

  propagatedBuildInputs = with pkgs; [
    mpv
    xdg-user-dirs
    xdg-utils
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    mv * $out
    runHook postInstall
  '';

  meta = with lib; {
    description = "Plays & manages your music library. Looks beautiful & juicy. Playlists, visuals, synced lyrics, pitch shift, volume boost & more.";
    homepage = "https://github.com/harmonoid/harmonoid";
    platforms = platforms.linux;
  };
}
