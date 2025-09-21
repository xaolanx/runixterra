{...}: let
  pins = import ./npins;
in {
  imports = [
    (pins.git-hooks + "/flake-module.nix")
  ];
  perSystem = {config, ...}: {
    pre-commit = {
      check.enable = true;
      settings.hooks = {
        treefmt = {
          enable = true;
          package = config.treefmt.build.wrapper;
        };
      };
    };
  };
}
