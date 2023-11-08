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
    sha256 = "sha256-1wCej+eTNJeJR1umtih/KSgtwaJl06AK0CRjyo5Mqoo=";  
  };

  nativeBuildInputs = [ ];
  propagatedBuildInputs = with pkgs.python311Packages; [ 
    click tqdm pyyaml unidecode torch torchvision numpy scipy pandas 
    pytorch-lightning pillow opencv4 shapely Polygon3 pyclipper matplotlib seaborn onnx
    huggingface-hub
  ];

  doCheck = false;

  meta = with lib; {
    description = "Awesome Chinese/English OCR toolkits based on PyTorch/MXNet";
    homepage = "https://github.com/breezedeus/CnOCR";
    license = licenses.mit;
  };
}
