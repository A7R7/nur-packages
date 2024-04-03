{ fetchFromGitHub, tdlib }:

tdlib.overrideAttrs (old : rec{
  version = "1.8.24";

  src = fetchFromGitHub {
    owner = "tdlib";
    repo = "td";

    # The tdlib authors do not set tags for minor versions, but
    # external programs depending on tdlib constrain the minor
    # version, hence we set a specific commit with a known version.
    rev = "d7203eb719304866a7eb7033ef03d421459335b8";
    hash = "sha256-ahU/LPepEO6ZBfxtKy8iYtmWBuxYv4c26HdAHmUMDZg=";
  };
})

# { fetchFromGitHub, gperf, openssl, readline, zlib, cmake, lib, stdenv }:

# stdenv.mkDerivation rec {
#   pname = "tdlib";
#   version = "1.8.22";

#   src = fetchFromGitHub {
#     owner = "tdlib";
#     repo = "td";

#     # The tdlib authors do not set tags for minor versions, but
#     # external programs depending on tdlib constrain the minor
#     # version, hence we set a specific commit with a known version.
#     rev = "1a50ec474ce2c2c09017aa3ab9cc9e0c68f483fc";
#     hash = "sha256-kNe4olbOen3Wn6KaI32RwcqP0qhqS7MP36wY88iGy9w=";
#   };

#   buildInputs = [ gperf openssl readline zlib ];
#   nativeBuildInputs = [ cmake ];

#   # https://github.com/tdlib/td/issues/1974
#   postPatch = ''
#     substituteInPlace CMake/GeneratePkgConfig.cmake \
#       --replace 'function(generate_pkgconfig' \
#                 'include(GNUInstallDirs)
#                  function(generate_pkgconfig' \
#       --replace '\$'{prefix}/'$'{CMAKE_INSTALL_LIBDIR} '$'{CMAKE_INSTALL_FULL_LIBDIR} \
#       --replace '\$'{prefix}/'$'{CMAKE_INSTALL_INCLUDEDIR} '$'{CMAKE_INSTALL_FULL_INCLUDEDIR}
#   '' + lib.optionalString (stdenv.isDarwin && stdenv.isAarch64) ''
#     sed -i "/vptr/d" test/CMakeLists.txt
#   '';

#   meta = with lib; {
#     description = "Cross-platform library for building Telegram clients";
#     homepage = "https://core.telegram.org/tdlib/";
#     license = [ licenses.boost ];
#     platforms = platforms.unix;
#     maintainers = [ maintainers.vyorkin ];
#   };
# }
