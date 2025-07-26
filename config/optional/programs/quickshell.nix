{
  inputs',
  pkgs,
  ...
}: {
  hj.packages = [
    inputs'.quickshell.packages.default
    pkgs.rembg
    pkgs.material-symbols
  ];
}
