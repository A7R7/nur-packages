{ lib
, python3
, fetchPypi
, cnstd
}:
with python3.pkgs;
buildPythonPackage rec{
  pname = "cnocr";
  version = "2.2.4.2";


  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-lPVsx2XoskTMbps81xjWOwJsyf4EtR3PCbw+QD0gTw4=";  
  };

  nativeBuildInputs = [ ];
  propagatedBuildInputs = with pkgs.python311Packages; [ 
    click tqdm torch torchvision numpy pytorch-lightning wandb torchmetrics
    pillow onnx cnstd
  ];
  doCheck = false;

  meta = with lib; {
    description = "Awesome Chinese/English OCR toolkits based on PyTorch/MXNet";
    homepage = "https://github.com/breezedeus/CnOCR";
    license = licenses.mit;
  };
}
