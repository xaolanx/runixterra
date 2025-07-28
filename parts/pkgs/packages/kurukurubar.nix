# Taken from https://github.com/Rexcrazy804/Zaphkiel/blob/master/pkgs/kurukurubar.nix
{
  lib,
  rembg,
  symlinkJoin,
  makeWrapper,
  runCommandLocal,
  quickshell,
  kdePackages,
  material-symbols,
  makeFontsConf,
  nerd-fonts,
  configPath ? null,
  asGreeter ? false,
  customColors ? null,
}: let
  qtDeps = [
    kdePackages.qtbase
    kdePackages.qtdeclarative
    kdePackages.qtmultimedia
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

  qsConfig = runCommandLocal "quick" {} (''
      mkdir $out
      cd $out
      cp -r ${configPath}/* $out/
    ''
    + (lib.optionalString asGreeter ''
      chmod u+w *.qml
      rm shell.qml
      mv greeter.qml shell.qml
    '')
    + (lib.optionalString (customColors != null) ''
      chmod u+rw ./Data/Colors.qml
      cp ${customColors} ./Data/Colors.qml
    ''));
in
  symlinkJoin {
    pname = "kurukurubar";
    version = quickshell.version;

    paths = [quickshell rembg];
    nativeBuildInputs = [makeWrapper];

    postBuild = ''
      makeWrapper $out/bin/quickshell $out/bin/kurukurubar \
        --set FONTCONFIG_FILE "${fontconfig}" \
        --set QML2_IMPORT_PATH "${qmlPath}" \
        --add-flags '-p ${qsConfig}' \
        --prefix PATH : "$out/bin"
    '';

    meta.mainProgram = "kurukurubar";
  }
