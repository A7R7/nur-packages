{ lib
, stdenv
, fetchFromGitHub
, cmake
, meson
, ninja
, pkg-config
, wf-config
, cairo
, doctest
, libGL
, libdrm
, libexecinfo
, libevdev
, libinput
, libjpeg
, libxkbcommon
, wayland
, wayland-protocols
, wayland-scanner
, wlroots
, pango
, nlohmann_json
, xorg
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "wayfire";
  version = "0.8.0-prev-output";

  src = fetchFromGitHub {
    owner = "A7R7";
    repo = "wayfire";
    rev = "6d6776df3d2510eecfbddd089be0a6eb56dad005";
    fetchSubmodules = true;
    hash = "sha256-/pf02rGcSiCynOyFBZwugXcAb758IHGEghAfsN4SNPQ=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    wayland-scanner
  ];

  buildInputs = [
    wf-config
    libGL
    libdrm
    libexecinfo
    libevdev
    libinput
    libjpeg
    libxkbcommon
    wayland-protocols
    xorg.xcbutilwm
    wayland
    cairo
    pango
    nlohmann_json
  ];

  propagatedBuildInputs = [
    wlroots
  ];

  nativeCheckInputs = [
    cmake
    doctest
  ];

  # CMake is just used for finding doctest.
  dontUseCmakeConfigure = true;

  doCheck = true;

  mesonFlags = [
    "--sysconfdir /etc"
    "-Duse_system_wlroots=enabled"
    "-Duse_system_wfconfig=enabled"
    (lib.mesonEnable "wf-touch:tests" (stdenv.buildPlatform.canExecute stdenv.hostPlatform))
  ];

  passthru.providedSessions = [ "wayfire" ];

  meta = {
    homepage = "https://wayfire.org/";
    description = "3D Wayland compositor";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ qyliss wucke13 rewine ];
    platforms = lib.platforms.unix;
    mainProgram = "wayfire";
  };
})
