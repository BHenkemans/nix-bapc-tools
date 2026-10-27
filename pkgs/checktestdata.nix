{
  lib,
  buildPythonPackage,
  fetchPypi,
  hatchling,
  versioningit,
}:

buildPythonPackage rec {
  pname = "checktestdata";
  version = "2026.9.2";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-P39Z9epNZ1/yUg+TClBqxrUGPmp01zVum45hlgvUyrM=";
  };

  build-system = [
    hatchling
    versioningit
  ];

  pythonImportsCheck = [ "checktestdata" ];

  meta = {
    description = "Python reimplementation of DOMjudge's checktestdata";
    homepage = "https://github.com/mzuenni/pyctd";
    license = lib.licenses.mit;
    mainProgram = "pyctd";
  };
}
