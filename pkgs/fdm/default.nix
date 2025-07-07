# pkgs/fdm.nix
{pkgs}: let
  inherit
    (pkgs)
    lib
    stdenv
    fetchurl
    autoPatchelfHook
    dpkg
    openssl
    xdg-utils
    ffmpeg
    libtorrent
    gst_all_1
    xorg
    libxcrypt
    unixODBC
    postgresql
    mysql80
    gtk3
    gdk-pixbuf
    pango
    cairo
    atk
    pipewire
    ;
in
  stdenv.mkDerivation rec {
    pname = "free-download-manager";
    version = "6.28.0.6294";

    src = fetchurl {
      url = "http://debrepo.freedownloadmanager.org/pool/main/f/freedownloadmanager/freedownloadmanager_${version}_amd64.deb";
      sha256 = "080vd4z4igr7n9d599dvkjw8ma2jv49rjn8rafyyy2nb3j1b2igy";
    };

    nativeBuildInputs = [autoPatchelfHook dpkg];

    buildInputs = [
      openssl
      xdg-utils
      ffmpeg
      libtorrent
      pipewire
      gst_all_1.gst-plugins-base
      gst_all_1.gstreamer
      gtk3
      gdk-pixbuf
      pango
      cairo
      atk
      xorg.libxcb
      xorg.xcbutil
      xorg.xcbutilcursor
      xorg.xcbutilimage
      xorg.xcbutilkeysyms
      xorg.xcbutilrenderutil
      xorg.xcbutilwm
      xorg.libX11
      unixODBC
      postgresql.lib
      mysql80.client
      libxcrypt
    ];

    runtimeDependencies = [
      "${gst_all_1.gst-plugins-base}/lib"
      "${gst_all_1.gstreamer}/lib"
      "${xorg.xcbutilwm}/lib"
    ];

    dontBuild = true;
    dontConfigure = true;

    unpackPhase = ''
      dpkg-deb -x $src .
    '';

    installPhase = ''
      runHook preInstall

      substituteInPlace usr/share/applications/freedownloadmanager.desktop \
        --replace-fail '/opt/freedownloadmanager/icon.png' 'freedownloadmanager' \
        --replace-fail '/opt/freedownloadmanager/fdm' "$out/bin/fdm"
      sed -i '/^Exec=/i StartupWMClass=fdm' usr/share/applications/freedownloadmanager.desktop

      mkdir -p $out/opt
      cp -r opt/freedownloadmanager $out/opt/

      install -Dm644 opt/freedownloadmanager/icon.png \
        "$out/share/icons/hicolor/256x256/apps/freedownloadmanager.png"

      install -Dm644 usr/share/applications/freedownloadmanager.desktop \
        "$out/share/applications/freedownloadmanager.desktop"

      mkdir -p $out/bin
      ln -sf "$out/opt/freedownloadmanager/fdm" "$out/bin/fdm"

      runHook postInstall
    '';

    preFixup = ''
      patchelf --remove-needed libmimerapi.so $out/opt/freedownloadmanager/plugins/sqldrivers/libqsqlmimer.so || true
      patchelf --add-needed libodbc.so.2 $out/opt/freedownloadmanager/plugins/sqldrivers/libqsqlodbc.so || true
      find $out/opt/freedownloadmanager -type f -executable \
        -exec patchelf --add-needed libxcb-icccm.so.4 {} \; || true
    '';

    meta = with lib; {
      description = "FDM is a powerful modern download accelerator and organizer.";
      homepage = "https://www.freedownloadmanager.org/";
      license = licenses.free;
      mainProgram = "fdm";
      platforms = ["x86_64-linux"];
      maintainers = [];
    };
  }
