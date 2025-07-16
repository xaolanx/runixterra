{
  systems = ["x86_64-linux"];
  perSystem = {pkgs, ...}: let
    customTidalNg = import ./tidal-dl-ng {
      inherit (pkgs) python3Packages stdenv makeWrapper fetchFromGitHub buildEnv writeShellApplication lib fetchPypi kdePackages;
    };
  in {
    packages = {
      repl = pkgs.callPackage ./repl {};
      bibata-hyprcursor = pkgs.callPackage ./bibata-hyprcursor {};
      wl-ocr = pkgs.callPackage ./wl-ocr {};
      fdm = pkgs.callPackage ./fdm {};
      tidal-dl-ng = customTidalNg.default;
      tdn = customTidalNg.tdn;
      tdng = customTidalNg.tdng;
    };
  };
}
