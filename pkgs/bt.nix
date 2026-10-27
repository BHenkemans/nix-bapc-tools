{
  python3,
  runCommand,
  installShellFiles,
}:

let
  inherit (python3.pkgs) bapctools argcomplete;
  env = python3.withPackages (ps: [ ps.bapctools ]);
  registerCompletion = "${argcomplete}/bin/register-python-argcomplete";
in
runCommand "bapctools-${bapctools.version}"
  {
    inherit (bapctools) version meta;
    nativeBuildInputs = [ installShellFiles ];
    passthru = {
      inherit env;
      unwrapped = bapctools;
    };
  }
  ''
    mkdir -p $out/bin
    ln -s ${env}/bin/bt $out/bin/bt
    installShellCompletion --cmd bt \
      --bash <(${registerCompletion} bt) \
      --zsh <(${registerCompletion} --shell zsh bt) \
      --fish <(${registerCompletion} --shell fish bt)
  ''
