{
 inputs,
 ...
}: {
  hj.packages = [inputs.quickshell.packages.${pkgs.system}.default]; 	
}
