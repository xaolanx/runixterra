{sources ? import ./npins}: final: prev: {
  colloid-icon-rosepink = final.callPackage (sources.Colloid-icon-theme + "/colloid-icon-theme.nix") {
    schemeVariants = [ "rosepine" ];
    colorVariants = [ "pink" ];
  };
  quickshell = final.callPackage (sources.quickshell {pkgs = final;}) {
  	gitRev = sources.quickshell.revision;
    withJemalloc = true;
    withQtSvg = true;
    withWayland = true;
    withX11 = false;
    withPipewire = true;
    withPam = true;
    withHyprland = true;
    withI3 = false;  	
  };
  zen-browser = ((import sources.zen-browser-flake) { pkgs = final; }).zen-browser; 
  nh = final.callPackage "${sources.nh}/package.nix" {
    rev = sources.nh.revision;
  };  
}
