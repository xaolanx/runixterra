{...}: let
  pins = import ./npins;
in {
  imports = [
    (pins.treefmt-nix + "/flake-module.nix")
  ];
  perSystem = _: {
    treefmt = {
      projectRootFile = "flake.lock";
      flakeCheck = false; # handled by git-hooks.nix
      programs = {
        alejandra.enable = true;
        deadnix.enable = true;
        deno.enable = true;
      };

      settings = {
        formatter.deno.excludes = ["*.css" "*.js"];
      };
    };
  };
}
