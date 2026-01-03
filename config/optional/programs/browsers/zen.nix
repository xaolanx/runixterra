{
  pins,
  pkgs,
  ...
}: let
  inherit (pkgs) callPackage;
  zen-browser = (callPackage pins.zen {}).default;
in {
  hj.packages = [
    zen-browser
  ];
}
