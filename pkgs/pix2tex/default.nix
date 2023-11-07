{ lib
, python3
, fetchPypi
}:
with python3.pkgs;
buildPythonPackage rec{
  pname = "pix2text";
  version = "0.2.3.2";


  src = fetchPypi {
    inherit pname version;
    sha256 = "";  # Fill in the correct sha256 hash for the package.
  };

  nativeBuildInputs = [ ];

  doCheck = false;

  meta = with lib; {
    description = "Recognize Chinese, English Texts, and Math Formulas from Images.";
    homepage = "https://github.com/breezedeus/Pix2Text";
    license = licenses.mit;
  };
}
