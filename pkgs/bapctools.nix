{
  lib,
  buildPythonPackage,
  fetchPypi,
  hatchling,
  versioningit,
  argcomplete,
  checktestdata,
  colorama,
  matplotlib,
  pygments,
  python-dateutil,
  questionary,
  requests,
  ruamel-yaml,
  typing-extensions,
  vermin,
}:

buildPythonPackage rec {
  pname = "bapctools";
  version = "2026.10.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-fSrc+KberPQQ+LknfQWRJvoyBhJskMdaF46BVHj0Jz4=";
  };

  build-system = [
    hatchling
    versioningit
  ];

  dependencies = [
    argcomplete
    checktestdata
    colorama
    matplotlib
    pygments
    python-dateutil
    questionary
    requests
    ruamel-yaml
    typing-extensions
    vermin
  ];

  pythonImportsCheck = [ "bapctools" ];

  meta = {
    description = "Tools for developing ICPC-style programming contest problems";
    homepage = "https://github.com/RagnarGrootKoerkamp/BAPCtools";
    changelog = "https://github.com/RagnarGrootKoerkamp/BAPCtools/releases/tag/${version}";
    license = lib.licenses.gpl3Only;
    mainProgram = "bt";
  };
}
