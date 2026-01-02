{pkgs, ...}: {
  hj.packages = [
    pkgs.quickshell
    pkgs.material-symbols
  ];
  programs.dank-material-shell = {
    enable = true;
    dgop.package = pkgs.dgop;
  };
}
