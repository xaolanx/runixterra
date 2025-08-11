{...}: let
  sources = import ./parts/npins;

  flake = import sources.flake-compat {
    src = ./.;
    copySourceTreeToStore = false;
  };
in
  flake.defaultNix
