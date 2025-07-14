{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./nh.nix
    ./nixpkgs.nix
    ./substituters.nix
  ];

  # we need git for flakes
  environment.systemPackages = [pkgs.git];

  nix = {
    package = pkgs.lixPackageSets.latest.lix;

    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = ["nix-command" "flakes"];
      # cores = 2;
      # max-jobs = 2;
      # lazy-trees = true;

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;

      trusted-users = ["root" "@wheel"];

      accept-flake-config = true;
    };
  };
}
