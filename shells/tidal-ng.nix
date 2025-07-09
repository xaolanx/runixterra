# shells/tidal-ng.nix
{pkgs, ...}: let
  requests_2_32_4 = pkgs.python3Packages.requests.overridePythonAttrs (old: {
    version = "2.32.4";
    src = pkgs.python3Packages.fetchPypi {
      inherit (old) pname;
      version = "2.32.4";
      sha256 = "sha256-J9AxZoLIopg00yZIIAJLYqNpQgg9Usry8UwFkTNtNCI=";
    };
    patches = [];
  });

  pycryptodome_3_23_0 = pkgs.python3Packages.pycryptodome.overridePythonAttrs (old: {
    version = "3.23.0";
    src = pkgs.python3Packages.fetchPypi {
      inherit (old) pname;
      version = "3.23.0";
      sha256 = "sha256-RHcAplcYLWAzi6sJ/bJ1GPiFauzYCuTGvd22f/XaRO8=";
    };
  });

  pathvalidate_3_3_1 = pkgs.python3Packages.pathvalidate.overridePythonAttrs (old: {
    version = "3.3.1";
    src = pkgs.python3Packages.fetchPypi {
      inherit (old) pname;
      version = "3.3.1";
      sha256 = "sha256-sYwHISv+rWJDRbuOHWFBzc8Vo5c2mU6guUA1rSsboXc=";
    };
  });

  typer_0_16_0 = pkgs.python3Packages.typer.overridePythonAttrs (old: {
    version = "0.16.0";
    src = pkgs.python3Packages.fetchPypi {
      inherit (old) pname;
      version = "0.16.0";
      sha256 = "sha256-rzd/+u4dvjeulEDLTo8RaG6lzk6brgG4SufGO4fx3Ts=";
    };
  });

  tidalDlNgBase = pkgs.python3Packages.buildPythonPackage rec {
    pname = "tidal-dl-ng";
    version = "unstable";

    src = pkgs.fetchFromGitHub {
      owner = "exislow";
      repo = "tidal-dl-ng";
      rev = "0eaeed533fbdc8790413f178cadb73b0ac6949aa";
      sha256 = "sha256-wNcMW955sPtf9jQpCJLVbUho2KKwdYKcfdSw4wSdzC4=";
    };

    doCheck = false;
    format = "pyproject";

    nativeBuildInputs = with pkgs.python3Packages; [
      poetry-core
      setuptools
    ];

    propagatedBuildInputs = with pkgs.python3Packages; [
      requests_2_32_4
      coloredlogs
      dataclasses-json
      m3u8
      mpegdash
      mutagen
      pathvalidate_3_3_1
      pycryptodome_3_23_0
      python-ffmpeg
      rich
      tidalapi
      toml
      typer_0_16_0
      pyside6
      pyqtdarktheme
    ];
  };

  tidalDlNg = tidalDlNgBase.overrideAttrs (_old: {
    outputs = ["out"];
    pythonOutputDistPhase = ''
      echo "Skipping pythonOutputDistPhase (no 'dist' output)"
    '';
    pythonCatchConflictsPhase = ''
      echo "Skipping pythonCatchConflictsPhase (duplicate-dependency check)"
    '';
  });
in
  pkgs.mkShell {
    name = "tidal-ng";
    buildInputs = [
      tidalDlNg
      pkgs.python3Packages.pyside6
      pkgs.python3Packages.pyqtdarktheme
      pkgs.adwaita-icon-theme
      pkgs.hicolor-icon-theme
      pkgs.gtk3
      pkgs.ffmpeg
    ];

    shellHook = ''
      export QT_QPA_PLATFORMTHEME=gtk3
      export QT_STYLE_OVERRIDE=Fusion
      export XDG_DATA_DIRS="${pkgs.adwaita-icon-theme}/share:${pkgs.hicolor-icon-theme}/share:$XDG_DATA_DIRS"
    '';
  }
