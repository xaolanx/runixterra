{
  inputs',
  self',
  pkgs,
  ...
}: {
  hj.packages = [
    inputs'.quickshell.packages.default
    self'.packages.kurukurubar
    pkgs.rembg
    pkgs.material-symbols
  ];
}
