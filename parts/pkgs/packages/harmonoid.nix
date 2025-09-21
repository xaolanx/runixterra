{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  makeWrapper,
  cairo,
  gdk-pixbuf,
  gtk3,
  libz,
  pango,
  harfbuzz,
  atkmm,
  libcxx,
  xdg-utils,
  zenity,
  xdg-user-dirs,
  gsettings-desktop-schemas,
  mpv,
}: let
  version = "0.3.10";
  url_base = "https://github.com/alexmercerind2/harmonoid-releases/releases/download/v${version}";
  url =
    rec {
      x86_64-linux = "${url_base}/harmonoid-linux-x86_64.tar.gz";
    }.${
      stdenv.hostPlatform.system
    } or (
      throw "${stdenv.hostPlatform.system} is an unsupported platform"
    );
  hash =
    rec {
      x86_64-linux = "sha256-GTF9KrcTolCc1w/WT0flwlBCBitskFPaJuNUdxCW9gs=";
    }.${
      stdenv.hostPlatform.system
    };

  xdg-data-dirs = "${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}";
in
  stdenv.mkDerivation (finalAttrs: {
    pname = "harmonoid";
    inherit version;

    src = fetchurl {
      inherit url hash;
    };

    nativeBuildInputs = [
      autoPatchelfHook
      makeWrapper
    ];

    buildInputs = [
      cairo
      gdk-pixbuf
      gtk3
      libz
      pango
      harfbuzz
      atkmm
      libcxx
      zenity
      xdg-utils
      mpv
    ];

    installPhase = ''
      runHook preInstall

      mkdir -p $out
      cp -r bin $out
      mkdir -p $out
      cp -r share $out
      wrapProgram $out/bin/harmonoid --prefix LD_LIBRARY_PATH : $out/share/harmonoid/lib:${lib.makeLibraryPath [mpv]} --prefix XDG_DATA_DIRS : ${xdg-data-dirs} --prefix PATH : ${lib.makeBinPath [zenity xdg-utils xdg-user-dirs]}


      runHook postInstall
    '';

    meta = {
      description = "Plays & manages your music library. Looks beautiful & juicy.";
      mainProgram = "harmonoid";
      homepage = "https://harmonoid.com/";
      changelog = "https://github.com/harmonoid/harmonoid/releases/tag/v${finalAttrs.version}";
      maintainers = with lib.maintainers; [ivyfanchiang];
      platforms = ["x86_64-linux"];
      license = {
        fullName = "PolyForm Strict License 1.0.0";
        url = "https://polyformproject.org/licenses/strict/1.0.0/";
        free = false;
      };
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
    };
  })
