{pins, ...}: let
  nixdb = (import "${pins.nix-index}/nixos-module.nix") pins.nix-index;
in {
  imports = [nixdb];
  config = {
    programs.nix-index-database.comma.enable = true;
  };
}
