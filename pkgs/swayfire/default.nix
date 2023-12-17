{ stdenv
, lib
, fetchFromGitHub
, meson
, ninja
, pkg-config
, wayland
, wrapGAppsHook
, wayfire
, wf-shell
, wf-config
, wayland-scanner
, wayland-protocols
, gtk3
, gtkmm3
, libevdev
, libxml2
, libxkbcommon
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "swayfire";
  version = "0";

  src = fetchFromGitHub {
    owner = "Javyre";
    repo = "swayfire";
    rev = "df46b606ae67fa82262aebdc88311446439b1d35";
    fetchSubmodules = true;
    hash = "sha256-UwHJ4Wi83ATnA1CQKNSt8Qga7ooLnAY7QARz2FXvUIo=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    wayland-scanner
    wrapGAppsHook
  ];

  buildInputs = [
    wayfire
    wf-config
    wf-shell
    wayland
    wayland-protocols
    gtk3
    gtkmm3
    libevdev
    libxml2
    libxkbcommon
  ];

  mesonFlags = [
    "-Denable_wdisplays=false"
  ];

  meta = {
    homepage = "https://github.com/Javyre/swayfire";
    description = "Sway/I3 inspired tiling window manager for Wayfire";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    mainProgram = "swayfire";
  };
})
