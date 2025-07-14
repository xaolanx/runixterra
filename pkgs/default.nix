{ config, lib, pkgs, ... }:

let
  inherit (pkgs) callPackage;

  wrappedPackages = {
    hyprlock = callPackage ./wrapped/hyprlock.nix { inherit pkgs config; };
    hyprpaper = callPackage ./wrapped/hyprpaper.nix { inherit pkgs config; };
    
  };
in {
  config = {
    environment.systemPackages = with pkgs; [
      telegram-desktop
      brave
      youtube-music
      micro
      git
      npins
      anyrun
      playerctl
      audacious
      nvd
      nix-output-monitor
    ] ++ (builtins.attrValues wrappedPackages);
  };
}
