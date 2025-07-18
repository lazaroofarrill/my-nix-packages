{ stdenv, qt5, libsForQt5, makeWrapper }:
stdenv.mkDerivation {
  pname = "m908";
  version = "4.3.4";
  src = builtins.fetchTarball {
    url =
      "https://ugeecom-download.oss-us-west-1.aliyuncs.com/file/2024/12/ugeeTablet-4.3.4-241031.tar.gz";
  };

  buildInputs = [
    libsForQt5.qt5.wrapQtAppsHook
    libsForQt5.qt5.qtxmlpatterns
    qt5.full
    makeWrapper
  ];
  dontWrapQtApps = true;

  installPhase = builtins.readFile ./install-script.sh;
}
