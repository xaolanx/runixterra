{pkgs, ...}: {
  hj.packages = [
    pkgs.quickshell
    pkgs.material-symbols
  ];
  programs.dankMaterialShell.enable = true;
}
