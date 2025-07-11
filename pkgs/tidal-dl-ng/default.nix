{
  python3Packages,
  fetchFromGitHub,
  buildEnv,
  writeShellApplication,
  lib,
  fetchPypi,
}: let
  # Custom pinned dependencies
  requests_2_32_4 = python3Packages.requests.overridePythonAttrs (old: {
    version = "2.32.4";
    src = fetchPypi {
      inherit (old) pname;
      version = "2.32.4";
      sha256 = "sha256-J9AxZoLIopg00yZIIAJLYqNpQgg9Usry8UwFkTNtNCI=";
    };
    patches =
      builtins.filter (
        p: !lib.strings.hasInfix "CVE-2024-47081" (toString p)
      )
      old.patches;
  });

  pycryptodome_3_23_0 = python3Packages.pycryptodome.overridePythonAttrs (old: {
    version = "3.23.0";
    src = fetchPypi {
      inherit (old) pname;
      version = "3.23.0";
      sha256 = "sha256-RHcAplcYLWAzi6sJ/bJ1GPiFauzYCuTGvd22f/XaRO8=";
    };
  });

  pathvalidate_3_3_1 = python3Packages.pathvalidate.overridePythonAttrs (old: {
    version = "3.3.1";
    src = fetchPypi {
      inherit (old) pname;
      version = "3.3.1";
      sha256 = "sha256-sYwHISv+rWJDRbuOHWFBzc8Vo5c2mU6guUA1rSsboXc=";
    };
  });

  typer_0_16_0 = python3Packages.typer.overridePythonAttrs (old: {
    version = "0.16.0";
    src = fetchPypi {
      inherit (old) pname;
      version = "0.16.0";
      sha256 = "sha256-rzd/+u4dvjeulEDLTo8RaG6lzk6brgG4SufGO4fx3Ts=";
    };
  });

  tidalDlNgBase = python3Packages.buildPythonPackage rec {
    pname = "tidal-dl-ng";
    version = "v0.26.2";
    src = fetchFromGitHub {
      owner = "exislow";
      repo = "tidal-dl-ng";
      rev = version;
      sha256 = "sha256-9C7IpLKeR08/nMbePltwGrzIgXfdaVfyOeFQnfCwMKg=";
    };

    doCheck = false;
    format = "pyproject";

    nativeBuildInputs = with python3Packages; [poetry-core setuptools];

    propagatedBuildInputs = with python3Packages; [
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

  tidalDlNg = tidalDlNgBase.overrideAttrs (_: {
    outputs = ["out"];
    pythonOutputDistPhase = ''echo "⚠️  Skipping pythonOutputDistPhase (no 'dist' output)"'';
    pythonCatchConflictsPhase = ''echo "🛑  Skipping pythonCatchConflictsPhase (duplicate-dependency check)"'';
  });

  tdn = writeShellApplication {
    name = "tdn";
    runtimeInputs = [tidalDlNg];
    text = ''exec tidal-dl-ng "$@"'';
  };

  tdng = writeShellApplication {
    name = "tdng";
    runtimeInputs = [tidalDlNg];
    text = ''
      export QT_QPA_PLATFORM=xcb
      exec tidal-dl-ng-gui "$@"
    '';
  };
in {
  default = buildEnv {
    name = "tidal-dl-ng";
    paths = [tdn tdng];
  };

  tdn = tdn;
  tdng = tdng;
}
