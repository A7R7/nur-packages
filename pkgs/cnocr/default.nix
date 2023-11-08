{ lib
, python3
, fetchPypi
}:
with python3.pkgs;
buildPythonPackage rec{
  pname = "cnocr";
  version = "2.2.4.2";


  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-bPzGYEfuLihkiS4Bw34hN/hVtjJYibZIRiJYCip1++M=";  
  };

  nativeBuildInputs = [ ];

  doCheck = false;

  meta = with lib; {
    description = "Awesome Chinese/English OCR toolkits based on PyTorch/MXNet";
    homepage = "https://github.com/breezedeus/CnOCR";
    license = licenses.mit;
  };
}
