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
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "A7R7";
    repo = "wayfire";
    rev = "prev-output";
    fetchSubmodules = true;
    hash = "1";
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
