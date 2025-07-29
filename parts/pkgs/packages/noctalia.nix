# Taken from https://github.com/Rexcrazy804/Zaphkiel/blob/master/pkgs/kurukurubar.nix
{
  lib,
  symlinkJoin,
  makeWrapper,
  runCommandLocal,
  quickshell,
  kdePackages,
  libsForQt5,
  qt6Packages,
  material-symbols,
  makeFontsConf,
  nerd-fonts,
  cava,
  gpu-screen-recorder,
  configPath ? null,
}: let
  qtDeps = [
    kdePackages.qtbase
    kdePackages.qtdeclarative
    kdePackages.qtmultimedia
    kdePackages.qtstyleplugin-kvantum
    qt6Packages.qt5compat
    libsForQt5.qt5.qtgraphicaleffects
  ];

  qmlPath = lib.pipe qtDeps [
    (builtins.map (lib: "${lib}/lib/qt-6/qml"))
    (builtins.concatStringsSep ":")
  ];

  fontconfig = makeFontsConf {
    fontDirectories = [
      material-symbols
      nerd-fonts.caskaydia-mono
    ];
  };

  qsConfig = runCommandLocal "noct" {} ''
    mkdir $out
    cd $out
    cp -r ${configPath}/* $out/
  '';
in
  symlinkJoin {
    pname = "noctalia";
    version = quickshell.version;

    paths = [quickshell gpu-screen-recorder cava];
    nativeBuildInputs = [makeWrapper];

    postBuild = ''
      makeWrapper $out/bin/quickshell $out/bin/noctalia \
        --set FONTCONFIG_FILE "${fontconfig}" \
        --set QML2_IMPORT_PATH "${qmlPath}" \
        --add-flags '-p ${qsConfig}' \
        --prefix PATH : "$out/bin"
    '';

    meta.mainProgram = "noctalia";
  }
