{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  imports = [
    ./nix
    ./system
    ./graphics
    ./programs
    ./server
  ];

  options = {
    # basically used across the tree to disable certain modules that are enabled by default
    # which are unecesary for the tree
    ionia.data.headless = mkEnableOption "headless";
  };
}
