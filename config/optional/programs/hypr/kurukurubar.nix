{
  self',
  pkgs,
  ...
}: {
  hj.packages = [
    self'.packages.kurukurubar
    pkgs.rembg
    pkgs.material-symbols
  ];
}
