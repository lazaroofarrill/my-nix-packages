{ pkgs }:
let
  pname = "beeref";
  version = "0.3.3";
  python = pkgs.python312;
  pythonPackages = python.pkgs;
in pkgs.python312Packages.buildPythonApplication {
  inherit pname version;

  src = pkgs.fetchFromGitHub {
    owner = "rbreu";
    repo = "beeref";
    rev = "v${version}";
    sha256 = "sha256-GtxiJKj3tlzI1kVXzJg0LNAUcodXSna17ZvAtsAEH4M=";
  };

  format = "pyproject";
  nativeBuildInputs = with pythonPackages; [
    pkgs.kdePackages.wrapQtAppsHook
    hatchling
    pip
    setuptools
    virtualenv
    qt6.qtbase
  ];
  propagatedBuildInputs = with pythonPackages; [
    pyqt6
    rectangle-packer
    exif
    lxml
    setuptools
  ];

  pythonImportsCheck = [ "beeref" ];

  dontCheckRuntimeDeps = true;

  meta = with pkgs.lib;
    {
      description = "Minimal reference image viewer for artists";
      homepage = "https://github.com/rbreu/beeref";
      license = licenses.gpl3;
      # maintainers = with maintainers; [ ];
    } // {
      desktopItems = [{
        name = "BeeRef";
        icon = "BeeRef";
        exec = "$out/bin/beeref";
        comment = "BeeRef image viewer";
        categoreis = [ "Graphics" ];
      }];
    };

  postInstall = ''
    mkdir -p $out/share/applications
    cat > $out/share/applications/beeref.desktop <<EOF
    [Desktop Entry]
    Name=BeeRef
    Exec=${placeholder "out"}/bin/beeref
    Icon=beeref
    Type=application
    Categories=Graphics;Viewer;
    EOF
  '';
}

