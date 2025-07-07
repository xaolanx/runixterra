{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  homeDir = config.home.homeDirectory;
  quickshellDir = "${homeDir}/Documents/code/runixterra/home/services/quickshell/qml";
  quickshellTarget = "${homeDir}/.config/quickshell";
  faceIconSource = "${homeDir}/nixos/assets/profile.gif";
  faceIconTarget = "${homeDir}/.face.icon";
  quickshell = inputs.quickshell.packages.${pkgs.system}.default;
in {
  home.packages = [quickshell];

  home.activation.symlinkUserChrome = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ln -sfn "${quickshellDir}" "${quickshellTarget}"
    ln -sfn "${faceIconSource}" "${faceIconTarget}"
  '';
}
