{
  pkgs,
  lib,
  # enable anime 4k shadders
  anime ? true,
}: let
  shadderConfig = pkgs.callPackage ./bindings.nix {};
  mpvconf = pkgs.linkFarm "mpvConfDir" (
    [
      {
        name = "mpv.conf";
        path = ./mpv.conf;
      }
    ]
    ++ (lib.optional anime {
      name = "input.conf";
      path = shadderConfig;
    })
  );
  mpvscripts = pkgs.mpv.override {
    scripts = with pkgs.mpvScripts; [
      uosc
      mpris
      thumbfast
      sponsorblock
      autoload
      smart-copy-paste-2
    ];
  };
in
  pkgs.symlinkJoin {
    name = "mpv";
    paths = [mpvscripts];

    buildInputs = [pkgs.makeWrapper];

    postBuild = ''
      wrapProgram $out/bin/mpv \
        --add-flags '--config-dir=${mpvconf}'
    '';

    meta.description = "A wrapped mpv package with support for anime 4k shadders";
  }
