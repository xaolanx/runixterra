let
  inherit (builtins) mapAttrs attrValues;

  src = import ./npins;
  pkgs = import src.nixpkgs {};
  sources = mapAttrs (_k: v: v {inherit pkgs;}) src;

  overlays = attrValues {
    internal = import ./overlays/default.nix {sources = src;};
    npins = import ./overlays/npins.nix; # temporary
  };

  nixosConfig = hostName:
    import (src.nixpkgs + "/nixos/lib/eval-config.nix") {
      system = null;
      specialArgs = {inherit sources;};
      modules = [
        {nixpkgs.overlays = overlays;}
        ./host/${hostName}/configuration.nix
        ./nixos
        ./hjem
        ./pkgs
        ./modules
      ];
    };
in {
  ionia = nixosConfig "ionia";
}
