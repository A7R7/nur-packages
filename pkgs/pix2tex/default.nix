{ lib
, python3
, fetchPypi
, fetchurl
}:
let
# 'x_transformers==0.15.0',
  entmax = python3.pkgs.buildPythonPackage rec {
    pname = "entmax";
    version = "1.1";
    format = "wheel";
    src = fetchPypi rec {
      inherit pname version format;
      sha256 = "sha256-CcLfDSM+iTw1us+iuBXFY5eU9QOKZkjjys8+toOG6x8=";
      dist = python;
      python = "py3";
    };
    doCheck = false;
  };
  x-transformers = python3.pkgs.buildPythonPackage rec {
    pname = "x-transformers";
    version = "0.15.0";
    src = fetchPypi rec {
      inherit pname version;
      sha256 = "sha256-loAhpd9AG0G2ymSaCgrOrdVvIyv62YgOoLGeFXHwsWg=";
    };
    propagatedBuildInputs = [entmax];
    doCheck = false;
  };

  image-resizer = fetchurl {
    url = "https://github.com/lukas-blecher/LaTeX-OCR/releases/download/v0.0.1/image_resizer.pth";
    sha256 = "sha256-HDggZZmFrRQrUmSQuyXCPZdxdqwgc1kbO92tppJxhFg=";
  };
  weights = fetchurl {
    url = "https://github.com/lukas-blecher/LaTeX-OCR/releases/download/v0.0.1/weights.pth";
    sha256 = "sha256-pj2RQcU9Jmy2gvtai9g71cvigxReDnjr3A+JUZWh36o=";
  };

  # 'timm==0.5.4',
  # timm = python3.pkgs.buildPythonPackage rec {
  #   pname = "timm";
  #   version = "0.5.4";
  #   src = fetchPypi rec {
  #     inherit pname version;
  #     sha256 = "sha256-XXuS5mp2xDIAmrqQ1RXqeogqrlc0FafFJp42F9+QHB8=";
  #   };
  #  doCheck = false;
  # };
in
with python3.pkgs;
buildPythonPackage rec{
  pname = "pix2tex";
  version = "0.1.2";
  format = "wheel";

  src = fetchPypi rec {
    inherit pname version format;
    sha256 = "sha256-3GRHxaijpW/I0NT3XKqI9GVsuGuI1qcVpE9gAFUv8Jc=";
    dist = python;
    python = "py3";
  };

  nativeBuildInputs = [ ];
  propagatedBuildInputs = (with pkgs.python3Packages; [
    tqdm munch torch opencv4 requests einops transformers
    tokenizers numpy pillow
    pyyaml pandas albumentations
     timm
  ]) ++ [x-transformers];
  doCheck = false;
  postInstall = ''
    ln -s ${image-resizer} $out/lib/python3.11/site-packages/pix2tex/model/checkpoints/image_resizer.pth
    ln -s ${weights} $out/lib/python3.11/site-packages/pix2tex/model/checkpoints/weights.pth
  '';
  meta = with lib; {
    description = "Using a ViT to convert images of equations into LaTeX code";
    homepage = "https://github.com/breezedeus/Pix2Text";
    license = licenses.mit;
  };
}
