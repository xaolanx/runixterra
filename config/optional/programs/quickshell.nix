{
  inputs',
  self',
  pkgs,
  ...
}: {
  hj.packages = [
    inputs'.quickshell.packages.default
    self'.packages.kurukurubar
    self'.packages.noctalia
    pkgs.rembg
    pkgs.material-symbols
  ];
}
