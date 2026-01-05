{pkgs, inputs, self, ...}: 
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
	home.packages = [
      inputs.self.packages.${system}.helium-browser
	];
}
