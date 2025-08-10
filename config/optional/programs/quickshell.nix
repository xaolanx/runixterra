{
  self',
  pkgs,
  ...
}: {
  hj.packages = [
    pkgs.quickshell
    # self'.packages.kurukurubar
    self'.packages.noctalia
    self'.packages.caelestia-cli
    self'.packages.caelestia-shell
    pkgs.rembg
    pkgs.material-symbols
  ];
}
