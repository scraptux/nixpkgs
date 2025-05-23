{
  lib,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
  coreutils,
  tcl-8_6,
  tclPackages,
  installShellFiles,
}:

stdenv.mkDerivation {
  pname = "xfs_undelete";
  version = "unstable-2023-04-12";

  src = fetchFromGitHub {
    repo = "xfs_undelete";
    owner = "ianka";
    rev = "9e2f7abf0d3a466328e335d251c567ce4194e473";
    hash = "sha256-ENa/r3+o7abW8iun6V/2LhTVmFVSwVM6v46KXBcKJ1g=";
  };

  buildInputs = [
    tcl-8_6
    tclPackages.tcllib
    coreutils
  ];
  nativeBuildInputs = [
    makeWrapper
    tcl-8_6.tclPackageHook
    installShellFiles
  ];

  tclWrapperArgs = [
    "--prefix"
    "PATH"
    ":"
    (lib.makeBinPath [ tcl-8_6 ])
  ];

  installPhase = ''
    runHook preInstall

    install -Dm555 xfs_undelete -t $out/bin
    mv xfs_undelete.man xfs_undelete.8
    installManPage xfs_undelete.8

    runHook postInstall
  '';

  meta = with lib; {
    description = "Undelete tool for the XFS filesystem";
    mainProgram = "xfs_undelete";
    homepage = "https://github.com/ianka/xfs_undelete";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = [ maintainers.deepfire ];
  };
}
