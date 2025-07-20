{sources, ...}: {
  imports = [
    ./activation.nix
    ./substituters.nix
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.flake.source = sources.nixpkgs;
  nix = {
    channel.enable = false;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      trusted-users = ["root" "@wheel"];
      keep-derivations = true;
      keep-outputs = true;
      builders-use-substitutes = true;
    };
    gc = {
      persistent = true;
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  documentation.man = {
    man-db.enable = false;
    man-db.manualPages = false;
  };
}
