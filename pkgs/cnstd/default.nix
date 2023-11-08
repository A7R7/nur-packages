{ lib
, python3
, fetchPypi
}:
with python3.pkgs;
buildPythonPackage rec{
  pname = "cnstd";
  version = "1.2.3.5";


  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-lPVsx2XoskTMbps81xjWOwJsyf4EtR3PCbw+QD0gTw4=";  
  };

  nativeBuildInputs = [ ];

  doCheck = false;

  meta = with lib; {
    description = "Awesome Chinese/English OCR toolkits based on PyTorch/MXNet";
    homepage = "https://github.com/breezedeus/CnOCR";
    license = licenses.mit;
  };
}
