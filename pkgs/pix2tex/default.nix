{ lib
, buildPythonPackage
, fetchPypi
, torch
}:
buildPythonPackage rec{
  pname = "pix2tex[gui]";
  version = "0.0.31";

  src = fetchPypi {
    inherit pname version;
    sha256 = "";  # Fill in the correct sha256 hash for the package.
  };

  nativeBuildInputs = [ ];

  propagatedBuildInputs = [
    torch  # Include PyTorch as a runtime dependency
  ];

  doCheck = false;

  meta = with lib; {
    description = "Using a ViT to convert images of equations into LaTeX code.";
    homepage = "https://github.com/lukas-blecher/LaTeX-OCR#pix2tex---latex-ocr";
    license = licenses.mit;
  };
}
