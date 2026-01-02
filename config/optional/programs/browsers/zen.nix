{
  pins,
  pkgs,
  ...
}: let
  inherit (pkgs) callPackage;
  zen-browser = (callPackage pins.zen {});
in {
  hj.packages = [
    zen-browser
  ];
}
