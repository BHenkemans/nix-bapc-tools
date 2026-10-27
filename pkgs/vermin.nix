{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
}:

buildPythonPackage rec {
  pname = "vermin";
  version = "1.8.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-NiGVWsKilQF1xbSpsvw70kvUFtoDiIk8nraXEmTkyh8=";
  };

  build-system = [ setuptools ];

  pythonImportsCheck = [ "vermin" ];

  meta = {
    description = "Concurrently detect the minimum Python versions needed to run code";
    homepage = "https://github.com/netromdk/vermin";
    license = lib.licenses.mit;
    mainProgram = "vermin";
  };
}
