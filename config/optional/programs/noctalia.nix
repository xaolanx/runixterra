{
  self',
  pkgs,
  ...
}: {
  hj.packages = [
    self'.packages.noctalia
    pkgs.material-symbols
  ];
}
